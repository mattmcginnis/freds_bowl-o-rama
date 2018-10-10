Fred's Bowl-O-Rama
==================
Hi there! This is a simple (unfinished) Rails project, a score-keeping app for
a bowling alley, Fred's Bowl-O-Rama. When you've finished, this app must accept
POST requests to `/scores`, containing JSON-formatted bowling frames (each
player fills a frame each turn), and respond with a scoreboard containing each
player's name, their score, and the name of the winner of the game.

Some things to keep in mind for the coding challenge:

  * You should write tests for your code. You can use Test::Unit but RSpec is
    preferred.
  * We've provided some (failing) tests to get you started. Do _not_ assume
    these are the only tests that will be run against your code! We have more.
  * Test not only happy paths but also invalid requests, requests with
    improperly formatted data, etc. Your service should return errors for
    these.
  * You are very strongly encouraged to use the controller endpoint already
    written and expand on it to make it fit the API described here. Our tests
    are written assuming the endpoint will not change.
  * Comment your code more liberally than you normally would, so we can learn
    more about your thought process and decisions you made writing the code.
  * We say this should take 1-2 hours because we don't want to take up more of
    your time than that, but feel free to spend as much time on it as you need.
  * If you need to, add additional libraries to the Gemfile or more files to
    the project. Add more unit tests if you need them.

## Bowling scoring

In bowling, players roll a bowling ball towards 10 pins, attempting to knock
all of them down. For each of 10 frames on the score card, each bowler has two
chances to knock down all 10 pins.

If the player rolls a **strike** (knocks down all 10 pins on their first roll
of the frame), that frame is marked as 10 points and then the scores of the
next two frames are added—therefore the maximum number of points a player can
get per frame is actually _30_ points. Strikes are marked in the score card as
a `X`.

If the player rolls a **spare** (knocks down some pins the first roll, knocks
down the rest of them the second roll of a frame), the frame is marked 10
points and any pins knocked down on the next frame are also added, so the
maximum point value of a spare is _20_ points. Spares are marked in the score
card as a `/` optionally including the value of the first roll. So, if a player
rolls once and knocks down 7 pins, then rolls again and knocks down the
remaining 3, that could be written as `/`, `7/`, or `7/10`.

If the player knocks down pins, but doesn't roll a spare or a strike for a
frame, the total number of pins knocked down on that frame is the score for
that frame. Therefore the maximum non-strike, non-spare point value for a frame
is _9_ points.

If the player misses entirely, that frame is marked with a `-` to indicate a
miss, and no points are awarded.

If the player fouls, that frame is marked with a `F` and no points are awarded.

If a player rolls two strikes on the last frame, an additional roll is granted
so that the maximum value of the final frame is also 30 points.

## Input format

The JSON format for scoring requests can include any number of players and any
number of frames. Each frame is an object with the following shape:

```json
{
  "score": "6",
}
```

Games are lists of up to 10 frames, structured as a flat list of them:

```json
[
  { "score": "6" },
  { "score": "3/" },
  { "score": "8" },
  { "score": "X" },
  ...
]
```

A whole scoreboard request is a JSON object with player names as keys and games
as values. A scoreboard request is not valid unless each player has bowled the
same number of frames.

```json
{
  "Hannibal Smith": [{"score": "X"}, ...],
  "B. A. Baracus": [{"score": "7"}, ...],
  "Templeton Peck": [{"score": "2"}, ...],
  "H. M. Murdock": [{"score": "6/"}, ...],
}
```

## Output format

The response body should also be JSON-encoded, as an object with two keys:
`scores`, and `winner`. `scores` should be an object with player names as
keys and their _total_ score from all frames as values; `winner` should just be
a string, the winning player's name.

```json
{
  "scores": {
    "Hannibal Smith": 300,
    "B. A. Baracus": 276,
    "Templeton Peck": 190,
    "H. M. Murdock": 110
  },
  "winner": "Hannibal Smith"
}
```

_Note: the players do not have to be listed in any particular order._

## References

Here are some references about how to keep score in bowling:

  * [http://slocums.homestead.com/gamescore.html](http://slocums.homestead.com/gamescore.html)
