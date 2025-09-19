local Header = [[

	____ ____ ____ ____ ___     _   _ ___
	[__  |    |__/ |__| |__] __  \_/   | 
	___] |___ |  \ |  | |         |    | 
	
	___  _ _ . _  _ ____ ___ ___ _  _ ____ _  _   _    ____ _  _ ____ _    _    ____
	|==]  Y  . |\/| |--|  |   |  |--| |=== |/\|   |___ |--|  \/  |=== |___ |___ |===

]]
print(Header)

io.write("Please Enter your channel tag, it starts @. please enter: ")
local userPlaylists   = {}
local userInput = io.read()
local data = io.popen("yt-dlp -q --flat-playlist --print \"%(title)s - %(webpage_url)s\" \"https://www.youtube.com/"..userInput.."/playlists\"")
print("command execution complete")
local processedData = data:read("*a") 
print(processedData)
data:close()
for line in string.gmatch(processedData, '([^\n]+)' ) do
	local title, url = line:match("^(.-)-(.*)$")
	--print("T:"..title)
	--print("U:"..url)
	if title and url then
		userPlaylists[string.sub(title,1,#title - 1)] = string.sub(url,2)
	end
end

if userPlaylist ~= nil then
	print("Playlist Data Set Creation Failed")
else
	print("Playlist Data Set Created successfully!!!")
end
--for debuging the object
--for key, value in pairs(userPlaylists) do
--	print("key:"..'"'..key..'"',"val:"..'"'..value..'"')
--end
io.write("please enter the name of the playlist you want to play :")
userInput = io.read()
print("searching for " .. userInput)
local desiredURL = userPlaylists[tostring(userInput)]
print(desiredURL)
print("attempting to run playlist " .. userInput .. " against URL:" .. desiredURL)
os.execute("yt-dlp -q  --flat-playlist --print url "..desiredURL .." | mpv --no-video --playlist=-")



