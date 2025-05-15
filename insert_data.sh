#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
while IFS="," read -r year round winner opponent wg og; do
  if [[ $year != "year" ]]; then
    #echo "$year $round $winner $opponent $wg $og"
    $PSQL "insert into teams(name) values('$winner')"
    $PSQL "insert into teams(name) values('$opponent')"
    wi=$($PSQL "select team_id from teams where name='$winner';")
    oi=$($PSQL "select team_id from teams where name='$opponent';")
    $PSQL "insert into games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) values('$year','$round','$wi','$oi','$wg','$og')"
  fi
done < games.csv