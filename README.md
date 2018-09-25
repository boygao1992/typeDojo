typing exercises

character sets 
- Numeric characters (`0123456789`)
- Special characters (`~!@#$%^&()_+-={}[];\',.`, `*|` missing)

`yarn start`

# Design

Instant Feedback
- error on current key
- repeated errors for the same key

Statistics
- total number of errors
- sorting keys by number of errors
- sorting keys by reflex time
- trend diagram over a period of time

Configuration
- accept correction or not
- able to see the next few letters or not
- automatically remove wrong characters or not (especially for training, typing backspace in-between adds up mental noises)
- set of keys
- difficulty (definition? cue: finger distance between neighbors, repeated keys in a sequence (lower the difficulty), randomness, ...)

Mode
- training with visual cue (virtual keyboard with keys highlighted)
- test session (strict config)
- RPG (against imaginary boss, life point, attack, levels, etc.)
  - dungeon explore
  - # of corrects - # of errors = # of steps available
  
[Dungeons TOME](https://www.dungeonstome.com/)

[sightreading.training — A tool for learning to sight-read sheet music](https://github.com/leafo/sightreading.training)

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

