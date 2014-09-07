--- === mjolnir.lb.itunes ===
--
-- Controls for itunes music player
--
-- Usage: local itunes = require "mjolnir.lb.itunes"

local itunes = {}

local alert = require "mjolnir.alert"

-- Internal function to pass a command to Applescript.
local function tell(cmd)
  return os.execute('osascript -e \'tell application "iTunes" to ' .. cmd .. "'")
end

--- mjolnir.lb.itunes.play() -> nil
--- Function
--- Toggles play/pause of current itunes track
function itunes.play()
  tell('playpause')
  alert.show(' ▶', 0.5)
end
--- mjolnir.lb.itunes.pause() -> nil
--- Function
--- Pauses of current itunes track
function itunes.pause()
  tell('pause')
  alert.show(' ◼', 0.5)
end
--- mjolnir.lb.itunes.next() -> nil
--- Function
--- Skips to the next itunes track
function itunes.next()
  tell('next track')
end
--- mjolnir.lb.itunes.previous() -> nil
--- Function
--- Skips to previous itunes track
function itunes.previous()
  tell('previous track')
end

-- Internal command used to pass a command and get back output from the command.
local function get(cmd)
  local handle = io.popen('osascript -e \'tell application "itunes" to ' .. cmd .. "'")
  local result = handle:read("*a")
  handle:close()
  return result
end

--- mjolnir.lb.itunes.displayCurrentTrack() -> nil
--- Function
--- Displays information for current track
function itunes.displayCurrentTrack()
  artist = get('artist of the current track as string')
  album  = get('album of the current track as string')
  track  = get('name of the current track as string')
  alert.show(track .. album .. artist, 1.75)
end

return itunes
