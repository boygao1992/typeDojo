typing exercises

character sets 
- Numeric characters (`0123456789`)
- Special characters (`~!@#$%^&()_+-={}[];\',.`, `*|` missing)
- Alphabet
  - `a - z`
  - `A - Z`
    - left hand `shift` + right hand `a - z`
    - right hand `shift` + left hand `a - z`
    

`yarn start`

# Dojo Web (alpha)

- `cd dojo-web-server`
- `yarn start`
- page is available at `localhost:8080`

# Design

Instant Feedback
- error on current key
- repeated errors for the same key

Configuration
- accept correction or not
- able to see the next few letters or not
- automatically remove wrong characters or not (especially for training, typing backspace in-between adds up mental noises)
- set of keys
- difficulty (definition? cue: finger distance between neighbors, repeated keys in a sequence (lower the difficulty), randomness, ...)

Mode
- training with visual cue (virtual keyboard with keys highlighted)
- test session (strict config)
- review session (replay, statistics, annotation)
- RPG (against imaginary boss, life point, attack, levels, etc.)
  - dungeon explore
    - people sharing the same world map
    - pairing active users by effort (time investment, improvement, playbook, etc.)
  - `#` of corrects - `#` of errors = `#` of steps available
  
similar idea ~ make data labeling fun to play
- feedback: users' own effort improves AI-powered system that directly affects the user experience
  - users will be divided into isolated groups to test out multiple configurations / evolution tracks
  - dialogue bot (NLP), NPC strategies (reinforcement learning), player pairing/recommendation
  
picture bounding box labeling
- memory game: recall the position
  
[Dungeons TOME](https://www.dungeonstome.com/)

[sightreading.training — A tool for learning to sight-read sheet music](https://github.com/leafo/sightreading.training)

connection to music streaming services

## Statistics

Global
- total number of errors
- sorting keys by number of errors
- sorting keys by reflex time
- trend diagram over a period of time


Local
1. record all key strokes
  - characters
    - "A"-"Z", "a"-"z", "!@#$%^&*()-_=+\|"
    - "Backspace", "Shift"
    - the rest are grouped into "Other"
      - "Space", modifiers, function keys (Arrow keys? depends on Mode)
  - reflex time
  - errors (~ matching)
2. group key strokes into clusters (to determine "hard" snippets) by
  - time-related
    - average speed over a window
    - below a threshold of average speed
    - below a threshold of reflex time
  - accuracy-related
    - below a threshold of errors
  - user annotated

# Guideline

### 2018-08-10 4min

pain points
1. alternate between little finger and ring finger
e.g. `[]`, `09`,`de pl oy`
2. double strike with the same finger, especially little finger and ring finger
e.g. `dep lo y`

### 2018-07-24 4min 10s

### 2018-07-04 4min 40s
Note taking in latex is smoother but missing `*` and `|` in training.

Need a better symbol generator.

TODO
- build a composable random number generator
  - Linear cogruential generator (LCG)
- build common distributions on top of that
- generate from customized set of symbols

### 2018-06-29 5min
Performance kind of stabilized.
Need to target the poorly-handled subset of symbols.

No enough data collected during the exercises.
One way is to build a web app for this.

By mental statistics, `%^&` was mistyped most frequently.
For `23@#`, sometimes not using the optimal finger.

Left `shift` and right `shift` switching needs some work.

Current strategy is to switch hand when the other one is "busy".
An exception: `6` or `^` is right in the middle of left and right hands.
When typing a sequence like `^6^`, there is no need to switch hands but press and release `shift` by the same hand.

# Records

## dojo-web with full charset (# = 500)

2019-05-15-1 3min 29s

2019-04-30-1 3min 31s

2019-04-24-1 3min 38s

2019-04-19-1 3min 33s

2019-04-16-1 3min 22s

2019-04-10-1 3min 32s

2019-04-04-1 3min 32s

2019-03-26-1 3min 27s

2019-03-21-1 3min 24s

2019-03-20-1 3min 27s

2019-03-14-1 3min 34s

2019-03-08-1 3min 27s

2019-03-07-1 3min 28s

2019-03-06-1 3min 29s

2019-03-05-1 3min 44s

2019-03-04-1 3min 27s

2019-03-01-1 3min 25s

2019-02-28-2 3min 28s

2019-02-28-1 3min 42s

2019-02-27-2 3min 32s

2019-02-27-1 3min 35s

2019-02-26-2 3min 36s

2019-02-25-1 3min 32s

2019-02-24-1 3min 34s

2019-02-23-1 3min 43s

2019-02-22-1 3min 36s

2019-02-21-1 3min 32s

2019-02-20-1 3min 26s

2019-02-19-1 3min 33s

2019-02-15-1 3min 38s

2019-02-13-1 3min 32s

2019-02-12-1 3min 41s

2019-02-11-1 3min 58s

2019-02-10-1 3min 28s

2019-02-09-1 3min 28s

2019-02-08-1 3min 30s

2019-02-07-1 3min 28s

2019-02-06-1 3min 25s

2019-02-05-1 3min 44s

2019-02-03-1 3min 25s

2019-02-02-1 3min 27s

2019-02-01-1 3min 45s

2019-01-31-1 3min 21s

2019-01-30-1 4min 07s

2019-01-29-1 4min 09s

2019-01-28-1 3min 23s

2019-01-26-1 3min 36s

2019-01-25-1 3min 26s

2019-01-16-1 3min 28s

2019-01-15-1 3min 16s

2019-01-14-1 3min 24s

2019-01-13-1 3min 33s

2019-01-12-1 3min 31s

2019-01-11-1 3min 37s

2019-01-10-1 3min 31s

2019-01-09-1 3min 42s

2019-01-08-1 3min 32s

2019-01-07-1 3min 29s

2019-01-06-1 3min 24s

2019-01-05-1 3min 22s

2019-01-04-1 3min 30s

2019-01-03-1 3min 21s

2019-01-02-1 3min 30s

2019-01-01-1 3min 30s

2018-12-31-1 3min 28s

2018-12-30-1 3min 27s

2018-12-29-2 3min 29s

2018-12-29-1 3min 40s

2018-12-28-2 3min 46s

2018-12-28-1 3min 43s

2018-12-27-2 3min 29s

2018-12-27-1 3min 26s

2018-12-26-2 3min 26s

2018-12-26-1 3min 29s

2018-12-25-2 3min 43s

2018-12-25-1 3min 38s

2018-12-24-2 3min 41s

2018-12-24-1 3min 26s

2018-12-23-2 3min 48s

2018-12-23-1 3min 38s

2018-12-22-2 3min 16s

2018-12-22-1 3min 43s

2018-12-21-1 3min 25s

2018-12-20-2 3min 39s

2018-12-20-1 3min 33s

2018-12-19-2 3min 33s

2018-12-19-1 3min 29s

2018-12-18-1 3min 37s

2018-12-17-1 3min 32s

2018-12-16-2 3min 39s

2018-12-16-1 3min 37s

2018-12-15-2 3min 35s

2018-12-15-1 3min 40s

2018-12-14-1 3min 42s

2018-12-13-1 3min 43s

2018-12-12-1 3min 55s

2018-12-10-1 3min 35s

2018-12-09-2 3min 47s

2018-12-09-1 3min 50s

2018-12-08-2 3min 50s

2018-12-08-1 3min 46s

2018-12-07-1 3min 50s

2018-12-06-1 3min 49s

2018-12-04-1 3min 42s

2018-12-03-1 3min 45s

2018-12-02-1 3min 46s

2018-12-01-1 3min 48s

2018-11-30-1 3min 29s

2018-11-29-1 4min 03s

2018-11-27-2 3min 48s

2018-11-27-1 3min 49s

2018-11-26-2 3min 39s

2018-11-26-1 3min 58s

2018-11-25-1 3min 53s

2018-11-24-2 3min 41s

2018-11-24-1 4min 04s

2018-11-23-1 3min 50s

2018-11-22-2 4min 06s

2018-11-22-1 4min 00s

2018-11-21-1 4min 06s

2018-11-20-1 4min 04s

2018-11-19-2 4min 17s

2018-11-19-1 4min 05s

2018-11-17-1 4min 49s

## Archive

2018-11-15-1 3min 33s

2018-11-14-1 3min 49s

2018-11-13-2 3min 32s

2018-11-13-1 3min 31s

2018-11-12-2 3min 39s

2018-11-12-1 3min 13s

2018-11-11-1 3min 38s

2018-11-09-1 3min 26s

2018-11-08-2 3min 28s

2018-11-08-1 3min 25s

2018-11-07-1 3min 12s

2018-11-06-1 3min 39s

2018-11-05-2 3min 23s

2018-11-05-1 3min 24s

2018-11-04-2 3min 33s

2018-11-04-1 3min 35s

2018-11-03-2 3min 23s

2018-11-03-1 3min 19s

2018-11-02-2 3min 21s

2018-11-02-1 3min 31s

2018-11-01-1 3min 38s

2018-10-31-1 3min 38s

2018-10-30-3 3min 34s

2018-10-30-2 3min 33s

2018-10-30-1 3min 26s

2018-10-29-2 3min 25s

2018-10-29-1 3min 28s

2018-10-28-2 3min 24s

2018-10-28-1 3min 29s

2018-10-27-2 3min 25s

2018-10-27-1 3min 23s

2018-10-26-3 3min 20s

2018-10-26-2 3min 22s

2018-10-26-1 3min 29s

2018-10-25-1 3min 19s

2018-10-24-2 3min 23s

2018-10-24-1 3min 22s

2018-10-23-1 3min 35s

2018-10-22-1 3min 40s

2018-10-21-2 3min 21s

2018-10-21-1 3min 26s

2018-10-20-2 3min 42s

2018-10-20-1 3min 29s

2018-10-19-2 3min 26s

2018-10-19-1 3min 23s

2018-10-18-2 3min 29s

2018-10-18-1 3min 39s

2018-10-17-1 3min 25s

2018-10-16-2 3min 26s

2018-10-16-1 3min 20s

2018-10-15-1 3min 22s

2018-10-14-2 3min 23s

2018-10-14-1 3min 28s

2018-10-13-2 3min 28s

2018-10-13-1 3min 19s

2018-10-12-2 3min 27s

2018-10-12-1 3min 17s

2018-10-11-2 3min 33s

2018-10-11-1 3min 34s

2018-10-10-1 3min 16s

2018-10-09-1 3min 29s

2018-10-08-2 3min 29s

2018-10-08-1 3min 39s

2018-10-07-2 3min 25s

2018-10-07-1 3min 42s

2018-10-06-2 3min 33s

2018-10-06-1 3min 19s

2018-10-05-2 3min 32s

2018-10-05-1 3min 33s

2018-10-04-2 3min 24s

2018-10-04-1 3min 34s

2018-10-03-2 3min 24s

2018-10-03-1 3min 19s

2018-10-02-1 3min 32s

2018-10-01-1 3min 29s

2018-09-30-2 3min 25s

2018-09-30-1 3min 34s

2018-09-29-2 3min 29s

2018-09-29-1 3min 31s

2018-09-28-1 3min 38s

2018-09-27-1 3min 31s

2018-09-26-2 3min 30s

2018-09-26-1 3min 29s

2018-09-25-2 3min 33s

2018-09-25-1 3min 31s

2018-09-24-2 3min 41s

2018-09-24-1 3min 38s

2018-09-23-2 3min 33s

2018-09-23-1 3min 19s

2018-09-22-2 3min 39s

2018-09-22-1 3min 36s

2018-09-21-2 3min 52s

2018-09-21-1 3min 29s

2018-09-20-2 3min 41s

2018-09-20-1 4min 07s

2018-09-19-1 3min 29s

2018-09-18-1 3min 35s

2018-09-17-2 3min 34s

2018-09-17-1 3min 45s

2018-09-16-1 3min 44s

2018-09-15-2 3min 39s

2018-09-15-1 3min 40s

2018-09-14-2 3min 33s

2018-09-14-1 3min 43s

2018-09-13-2 3min 46s

2018-09-13-1 3min 41s

2018-09-12-2 3min 36s

2018-09-12-1 3min 44s

2018-09-11-2 4min 08s

2018-09-11-1 3min 32s

2018-09-10-2 3min 35s

2018-09-10-1 3min 54s

2018-09-09-2 3min 36s

2018-09-09-1 3min 42s

2018-09-08-2 3min 48s

2018-09-08-1 4min 01s

2018-09-07-2 3min 46s

2018-09-07-1 3min 38s

2018-09-06-2 3min 38s

2018-09-06-1 3min 37s

2018-09-05-2 3min 45s

2018-09-05-1 3min 45s

2018-09-04-2 3min 43s

2018-09-04-1 3min 39s

2018-09-03-2 3min 48s

2018-09-03-1 3min 45s

2018-09-02-1 3min 57s

2018-09-01-2 3min 45s

2018-09-01-1 3min 33s

2018-08-31-2 3min 39s

2018-08-31-1 3min 57s

2018-08-30-2 3min 41s

2018-08-30-1 4min 16s

2018-08-29-2 3min 57s

2018-08-29-1 3min 43s

2018-08-28-1 3min 57s

2018-08-27-2 3min 42s

2018-08-27-1 3min 39s

2018-08-26-2 3min 52s

2018-08-26-1 3min 46s

2018-08-25-2 4min 05s

2018-08-25-1 3min 53s

2018-08-24-2 4min 07s

2018-08-24-1 3min 51s

2018-08-23-2 3min 50s

2018-08-23-1 3min 55s

2018-08-22-2 3min 57s

2018-08-22-1 3min 57s

2018-08-21-2 3min 55s

2018-08-21-1 3min 42s

2018-08-20-2 4min 04s

2018-08-20-1 3min 52s

2018-08-19-2 4min 00s

2018-08-19-1 3min 39s

2018-08-18-2 4min 06s

2018-08-18-1 4min 04s

2018-08-17-2 4min 03s

2018-08-17-1 3min 50s

2018-08-16-2 3min 55s

2018-08-16-1 3min 52s

2018-08-15-2 4min 07s

2018-08-15-1 3min 56s

2018-08-14-2 3min 57s

2018-08-14-1 3min 41s

2018-08-13-1 4min 03s

2018-08-12-2 3min 59s

2018-08-12-1 3min 45s

2018-08-11-2 3min 58s

2018-08-11-1 3min 56s

2018-08-10-2 4min 04s

2018-08-10-1 3min 53s

2018-08-09-2 3min 44s

2018-08-09-1 4min 02s

2018-08-08-2 3min 59s

2018-08-08-1 4min 08s

2018-08-07-2 3min 49s

2018-08-07-1 3min 57s

2018-08-06-2 3min 56s

2018-08-06-1 4min 13s

2018-08-05-2 4min 03s

2018-08-05-1 4min 12s

2018-08-03-2 3min 48s

2018-08-03-1 4min 00s

2018-08-02-2 4min 01s

2018-08-02-1 3min 52s

2018-08-01-1 4min 12s

2018-07-31-2 3min 54s

2018-07-31-1 3min 48s

2018-07-30-2 4min 01s

2018-07-30-1 4min 07s

2018-07-29-2 3min 53s

2018-07-29-1 4min 29s

2018-07-28-2 4min 14s

2018-07-28-1 4min 11s

2018-07-27-2 4min 05s

2018-07-27-1 4min 01s

2018-07-26-2 4min 04s

2018-07-26-1 4min 16s

2018-07-25-1 3min 58s

2018-07-24-2 4min 24s

2018-07-24-1 4min 13s

2018-07-23-2 4min 10s

2018-07-23-1 4min 09s

2018-07-22-1 4min 10s

2018-07-21-2 4min 11s

2018-07-21-1 4min 43s

2018-07-20-2 4min 18s

2018-07-20-1 4min 04s

2018-07-19-2 4min 38s

2018-07-19-1 4min 34s

2018-07-18-2 4min 18s

2018-07-18-1 4min 24s

2018-07-17-2 4min 02s

2018-07-17-1 4min 04s

2018-07-16-1 4min 17s

2018-07-15-2 4min 24s

2018-07-15-1 4min 59s

2018-07-14-2 4min 26s

2018-07-14-1 4min 32s

2018-07-13-2 4min 14s

2018-07-13-1 4min 43s

2018-07-11-2 4min 31s

2018-07-11-1 4min 46s

2018-07-10-2 4min 34s

2018-07-10-1 4min 53s

2018-07-09-2 4min 14s

2018-07-09-1 4min 52s

2018-07-08-2 4min 27s

2018-07-08-1 4min 30s

2018-07-07-1 4min 16s

2018-07-06-2 4min 35s

2018-07-06-1 4min 14s

2018-07-05-2 4min 26s

2018-07-05-1 4min 41s

2018-07-04-1 4min 47s

2018-07-03-2 4min 37s

2018-07-03-1 4min 28s

2018-07-02-2 4min 38s

2018-07-02-1 4min 31s

2018-07-01-2 4min 29s

2018-07-01-1 4min 50s

2018-06-30-2 4min 31s

2018-06-30-1 4min 39s

2018-06-29-2 4min 36s

2018-06-29-1 5min 08s

2018-06-28-1 5min 03s

2018-06-27-2 5min 01s

2018-06-27-1 4min 54s

2018-06-26-2 5min 06s

2018-06-26-1 5min 08s

2018-06-25-2 4min 59s

2018-06-25-1 5min 31s

2018-06-24-2 5min 22s

2018-06-24-1 6min 21s

2018-06-23-1 6min 27s

2018-06-22-2 7min 11s

2018-06-22-1 7min 36s


# Bug

Partially Fixed, edge case: `\\\\`, only one `\` got removed.  ~~Fixed, 2018-12-09~~
~~2018-12-08
Parsed response string from `purescript-affjax` contains quotes and escape token (`\`).~~
