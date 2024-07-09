#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    MATCH_SEARCH_W=$($PSQL "select name from teams where name='$WINNER'")
    MATCH_SEARCH_O=$($PSQL "select name from teams where name='$OPPONENT'")
    if [[ -z $MATCH_SEARCH_W ]]
    then
      echo $($PSQL "INSERT INTO teams(name) values('$WINNER')")
    else
      echo "YO"
    fi
    echo "done"
    if [[ -z $MATCH_SEARCH_O ]]
    then
      echo $($PSQL "INSERT INTO teams(name) values('$OPPONENT')")
    else
      echo "YO"
    fi
    echo "COMPLETELY DONE"
    # AFTER NUMERICAL INSERTION
    
    # GRAB ID OF TEAMS AND PUT INTO GAMES

    MATCH_SEARCH_WID=$($PSQL "select team_id from teams where name='$WINNER'")
    MATCH_SEARCH_OID=$($PSQL "select team_id from teams where name='$OPPONENT'")
    
    # INSERT INTO GAMES WINNER_ID OPPONENT_ID
    echo $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $MATCH_SEARCH_WID, $MATCH_SEARCH_OID, $WINNER_GOALS, $OPPONENT_GOALS)")

  fi
done
