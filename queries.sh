#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) AS total_number_goals FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) AS average_goals_winner_teams FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) AS average_goals_winner_teams FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) AS average_goals_both_teams FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) AS max_score_single_game FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(winner_goals) AS count_score_more_two FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM games LEFT JOIN teams ON teams.team_id = games.winner_id WHERE round = 'Final' AND year = 2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT t1.name FROM teams t1 INNER JOIN games g1 ON t1.team_id = g1.winner_id WHERE g1.round = 'Eighth-Final' AND g1.year = 2014 UNION SELECT t2.name FROM teams t2 INNER JOIN games g2 ON t2.team_id = g2.opponent_id WHERE g2.round = 'Eighth-Final' and g2.year = 2014 ORDER BY name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT name AS unique_win_team FROM teams LEFT JOIN games ON teams.team_id = games.winner_id WHERE games.winner_id != games.opponent_id group by name order by name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM teams RIGHT JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' ORDER BY year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name like 'Co%'")"