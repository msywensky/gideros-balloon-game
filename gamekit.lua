GameCenter = gideros.class(Sprite)
 
require "gamekit"
 
local myScore=0
local myID=0
local leaderboardID
 
local function onAuthenticateComplete(event)
   if event.errorCode ~= nil then
      print("error while authentication: "..event.errorDescription)
   else
      print("authentication successful. now loading friends...")
	  print(event.localPlayer.playerID)
	  myID = event.localPlayer.playerID
	  gamekit:loadFriends()
   end
end
 
local function onLoadFriendsComplete(event)
	if event.errorCode ~= nil then
	  print("error while loading friends: "..event.errorDescription)
	else
	  print("here are the friends:")
	  for i=1, #event.friends do
		 print(event.friends[i])
	  end
	  gamekit:loadPlayers(event.friends)
	end
end
 
local function onLoadPlayersComplete(event)
	if event.errorCode ~= nil then
	  print("error while loading players: "..event.errorDescription)
	else
	  print("here are the details of friends:")
	  for i=1, #event.players do
		 print(event.players[i].playerID, event.players[i].alias, event.players[i].isFriend)
	  end
	end
end
 
local function onLoadScoreComplete(event)
	if event.errorCode ~= nil then
	  print("error while loading players: "..event.errorDescription)
	else
		print("here are the details of scores:")
		for i=1, #event.scores do
			print(event.scores[i].playerID, event.scores[i].value)
			if (event.scores[i].playerID == myID) then
				myScore = event.scores[i].value
			end
		end
	end
end
 
--////////////////////Extern functions///////////////////////--
function GameCenter:Login()
	gamekit:authenticate()
end
 
function GameCenter:ShowLeaderBoard()
	gamekit:showLeaderboard(leaderboardID)
end
 
function GameCenter:PostScore(score)
	gamekit:reportScore(score,leaderboardID)
end
 
function GameCenter:LoadScore()
	gamekit:loadScores(leaderboardID)
end
 
function GameCenter:getMyScore()
	return(myScore)
end
 
function GameCenter:setLeaderboardID(id)
	leaderboardID = id
end
 
gamekit:addEventListener("authenticateComplete", onAuthenticateComplete)
gamekit:addEventListener("loadFriendsComplete", onLoadFriendsComplete)
gamekit:addEventListener("loadPlayersComplete", onLoadPlayersComplete)
gamekit:addEventListener("loadScoresComplete", onLoadScoreComplete)