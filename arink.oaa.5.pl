%++++++++++++++++++++++++++++++++++++++++++++++++++++
% PSS − Homework assignment 5
% Tutor group A
% Owen Arink, Bachelor Programme in AI, 1st year 
% owen.arink@student.uva.nl
  /*
   * I hereby declare I have actively participated 
   * in solving every exercise. All solutions are 
   * entirely my own work and no part has been 
   * copied from other sources. 
   */
% no. of hours in lab: 4
% no. of hours spent on homework assignment: 25
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 

% Question 1

% City Coordinates Longitude/Latitude
% website used to retrieve coordinates
% https://graphhopper.com/maps/
/*
city(amsterdam, 52.373134/4.899873).
city(breda, 51.5719149/4.768323).
city(eindhoven, 51.434619/5.486011).
city(groningen, 53.2190652/6.5680077).
city(haarlem, 52.3812134/4.6336076).
city(hertogenbosch, 51.6978162/5.3036748).
city(leeuwarden, 53.24056438/5.800690896).
city(maastricht, 50.8585456/5.697226524).
city(rotterdam, 51.92457863/4.479289055).
city(utrecht, 52.09569693/5.10881424).
city(zwolle, 52.5137137/6.098012924).
*/

% RD coordinates (using 5600 points in the Netherlands) in kilometers
/* Why RD?:
It's better to use the coordinates of the cities in km
to calculate the distance between the cities.
*/
% website used to convert to RD coordinates:
% https://www.gpscoordinaten.nl/converteer-rd-coordinaten.php
city(amsterdam, 121.813/487.362).
city(breda, 112.095/398.291).
city(eindhoven, 161.871/382.839).
city(groningen, 233.871/582.030).
city(haarlem, 103.690/488.416).
city(hertogenbosch, 149.225/412.119).
city(leeuwarden, 182.605/583.855).
city(maastricht, 176.830/318.793).
city(rotterdam, 92.548/437.734).
city(utrecht, 135.923/456.419).
city(zwolle, 203.252/503.130).

% City Connections  
% from amsterdam
connection(amsterdam, utrecht, 43.62).
connection(amsterdam, haarlem, 19.85).
connection(amsterdam, rotterdam, 76.85).
connection(amsterdam, groningen, 183).
connection(amsterdam, leeuwarden, 134).
connection(amsterdam, zwolle, 107).
% from utrecht
connection(utrecht, rotterdam, 57.16).
connection(utrecht, hertogenbosch, 52.93).
connection(utrecht, breda, 70.62).
connection(utrecht, zwolle, 89.52).
connection(utrecht, amsterdam, 43.62).
connection(utrecht, groningen, 188).
connection(utrecht, leeuwarden, 161).
% from hertogenbosch
connection(hertogenbosch, eindhoven, 36.06).
connection(hertogenbosch, breda, 51.69).
connection(hertogenbosch, rotterdam, 81.3).
connection(hertogenbosch, utrecht, 52.93).
connection(hertogenbosch, zwolle, 130).
% from rotterdam
connection(rotterdam, amsterdam, 76.85).
connection(rotterdam, utrecht, 57.16).
connection(rotterdam, hertogenbosch, 81.3).
connection(rotterdam, haarlem, 71.92).
connection(rotterdam, breda, 48.34).
% from breda
connection(breda, utrecht, 70.62).
connection(breda, hertogenbosch, 51.69).
connection(breda, rotterdam, 48.34).
connection(breda, eindhoven, 64.03).
% from eindhoven
connection(eindhoven, hertogenbosch, 36.06).
connection(eindhoven, breda, 64.03).
connection(eindhoven, maastricht, 88.43).
connection(eindhoven, zwolle, 148).
% from groningen
connection(groningen, amsterdam, 183).
connection(groningen, utrecht, 188).
connection(groningen, leeuwarden, 64.01).
connection(groningen, zwolle, 106).
% from haarlem
connection(haarlem, amsterdam, 19.85).
connection(haarlem, rotterdam, 71.92).
% from leeuwarden
connection(leeuwarden, amsterdam, 134).
connection(leeuwarden, utrecht, 161).
connection(leeuwarden, groningen, 64.01).
connection(leeuwarden, zwolle, 96.73).
% from maastricht
connection(maastricht, eindhoven, 88.43).
connection(maastricht, zwolle, 231).
% from zwolle
connection(zwolle, amsterdam, 107).
connection(zwolle, utrecht, 89.52).
connection(zwolle, hertogenbosch, 130).
connection(zwolle, eindhoven, 148).
connection(zwolle, leeuwarden, 96.73).
connection(zwolle, maastricht, 231).

% Question 2
/* 
Explanation:
predicate move/3 returns the distance in kilometers between two cities
if the connection between those two cities is possible
For this it looks up the connections between City and other cities
in the facts listed above. When City is given move/3 will return
the connections with other cities in 'City2' and the corresponding
'Distance' in kilometers between them. If one presses the semicolon
after the result of the query (enforced backtracking),
it will return alternative solutions, which in this case
it returns more connections from City to other cities
and the 'Distance' in kilometers between them.
*/
move(City, City2, Distance) :-
    connection(City, City2, Distance).

% Question 3
/*
Explanation estimate(City, Estimate)
estimate/2 returns the estimation of the distance in kilometers
from one city to another GoalCity in a straight line using pythagoras' 
theorem. When 'City' is given it will get the RD 
(Rijksdriehoekscoordinaten)-Coordinates (X/Y), from the facts listed
above. It does this with city(City, X/Y)
After this it does the same thing with the next city
(GoalCity) for which you want to estimate the distance to from
'City'. It gets the goal city with goal(GoalCity) and then
grabs the corresponding RD-coordinates with city(GoalCity, X1/Y1).
Lastly it has to calculate the straight line distance between the
two cities(City and GoalCity). It does this by using the pythagoras'
theorem in which 'Estimate' is c^2 in the a^2 + b^2 = c^2 formula
to calculate the shortest straight line distance between
City and GoalCity. 
*/

estimate(City, Estimate) :-
    city(City, X/Y),
    goal(GoalCity),
    city(GoalCity, X1/Y1),
    Estimate is sqrt((X1 - X)^2 +(Y1-Y)^2).

% Question 4
/*
Explanation:
:- dynamic round/1, goal/1 makes round/1,
which is being used in question 6 and goal/1
dynamic which means the value can be changed
according to the query which is being executed.
Because the value that has to be rounded and 
the value that has to be the goal is not always the same
*/

:- dynamic round/1, goal/1.

/* 
Explanation:
goal(_) has an anonymous variable(_) because
this makes it so that the goal can be changed 
during the execution of the query.
This is because the A star algorithm uses multiple different cities
during execution to find the most optimal (shortest) route.
So the GoalCity in goal keeps changing to estimate the distance.
*/

goal(_).

% A Star Heuristic Algorithm
solve_astar(Node, Path/Cost) :-
    estimate(Node, Estimate),
    astar([[Node]/0/Estimate], RevPath/Cost/_),
    reverse(RevPath, Path).

move_astar([Node|Path]/Cost/_, [NextNode, Node|Path]/NewCost/Est) :-
    move(Node, NextNode, StepCost),
    \+ member(NextNode, Path),
    NewCost is Cost + StepCost,
    estimate(NextNode, Est).

expand_astar(Path, ExpPaths) :-
    findall(NewPath, move_astar(Path, NewPath), ExpPaths).

get_best([Path], Path) :- !.

get_best([Path1/Cost1/Est1, _/Cost2/Est2 | Paths], BestPath) :-
    Cost1 + Est1 =< Cost2 + Est2, !,
    get_best([Path1/Cost1/Est1 | Paths], BestPath).

get_best([_ | Paths], BestPath) :-
    get_best(Paths, BestPath).

astar(Paths, Path) :-
    get_best(Paths, Path),
    Path = [Node|_]/_/_,
    goal(Node).

astar(Paths, SolutionPath) :-
    get_best(Paths, BestPath),
    select(BestPath, Paths, OtherPaths),
    expand_astar(BestPath, ExpPaths),
    append(OtherPaths, ExpPaths, NewPaths),
    astar(NewPaths, SolutionPath).


/*
Explanation: 
Route/4 returns the Route used and the straight line distance
between two different cities.
It does this by retracting goal(_) with retract/1
This will get rid of the anonymous variable inside
the goal/1 predicate, and places the city 
which has to be the goal (filled in as City2 into the query)
via assert/1. 
It then uses the A star algorithm to calculate the shortest
straight line distance between the two cities (City and City2)
with solve_astar(City, Route/Distance)
It does this by using estimate/2 to estimate the shortest
straight line distance between City and City2 from the the query route/4
estimate/2 uses the goal/1, which is the City2 from the query route/4
to estimate the Distance. 
It also uses move/3 in order to calculate different connections
between different cities have with eachother and makes a sum out of 
those connections and estimates between them in order to find 
the shortest path, it does this with:
    move(Node, NextNode, StepCost),
    \+ member(NextNode, Path),
    NewCost is Cost + StepCost,
    estimate(NextNode, Est).

and then checks if another path of connections is shorter with:
    get_best([Path1/Cost1/Est1, _/Cost2/Est2 | Paths], BestPath) :-
    Cost1 + Est1 =< Cost2 + Est2, !,
    get_best([Path1/Cost1/Est1 | Paths], BestPath).
if  one path (Path1) Cost1 + Est1 is shorter than Cost2 + Est2
it continues using Path1.

It continues checking various possible distances and chooses
the shortest straight line path, which are connections via
various cities to return in Route and return the straight line 
distance in Distance.
*/
route(City, City2, Route, Distance) :-
    retract(goal(_)),
    assert(goal(City2)),
    solve_astar(City, Route/Distance).

% Question 5
/* 
Breda to Haarlem
route(breda, haarlem, Route, Distance).
Route = [breda, rotterdam, haarlem],
Distance = 120.26 ;
Route = [breda, utrecht, amsterdam, haarlem],
Distance = 134.09 ;
Route = [breda, rotterdam, amsterdam, haarlem],
Distance = 145.04 

Amsterdam to Groningen
route(amsterdam, groningen, Route, Distance).
Route = [amsterdam, groningen],
Distance = 183 ;
Route = [amsterdam, leeuwarden, groningen],
Distance = 198.01 ;
Route = [amsterdam, utrecht, groningen],
Distance = 231.62 
*/

% Question 6
/* 
For Question 6 my idea was to display the straight line distance
from two cities using the A* algorithm on an LCD connected to
an Arduino (microcontroller). Following what is stated in 
the question, which is that it 'could be absolutely anything'.
I attachted a video and the code I use to receive the message
from prolog to the Arduino (C++), with some explanation.
Since I assume you don't have this at hand I tried to show 
the program working with the LCD in this little video:
https://youtu.be/efBbUspbV2c
*/

/* Explanation:
routeArduino(City, City2, _, X) to isolate Distance in X
Predicate is the same as route/4,
but instead it only returns the distance in km
in X, because that is all I need for the Arduino LCD
to display.
*/
routeArduino(City, City2, _, X) :-
    retract(goal(_)),
    assert(goal(City2)),
    solve_astar(City, _/X).

/*
Explanation:
msg(City, City2):-:
Sends the result of routeArduino as a message to the Arduino

routeArduino(City, City2, _, X),:
uses the A* algorithm to estimate the distance between two cities
stores the Distance value in X

RoundedX is round(X),:
Rounds the Distance in km, because Arduino can display only
a set amount of characters
is dynamic because X changes according to the msg query

open('/dev/ttyACM0', write,Stream,[]),:
Opens the Arduino (/dev/ttyACM0)
Writes to the Stream to the Arduino

format(Stream, "~w",["Distance: "]),
format(Stream, "~w",[RoundedX]),
format(Stream, "~w",["km"]),
Sends message to the Stream
in which the distance is being sent as RoundedX
with some additional elements

close(Stream).
% closes the Stream when done sending message
*/ 

msg(City, City2):-
    routeArduino(City, City2, _, X),
    RoundedX is round(X),
    open('/dev/ttyACM0', write,Stream,[]),
    format(Stream, "~w",["Distance: "]),
    format(Stream, "~w",[RoundedX]),
    format(Stream, "~w",["km"]),
    close(Stream).

%Self-Check Passed!