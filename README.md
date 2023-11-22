# ROR returns unlock stuff

A program that unlocks stuff per what's detailed in [this
article](https://gameplay.tips/guides/risk-of-rain-returns-how-to-get-infinite-items-legitimately.html)

## Unlocks (as of the time of this writing):

- [x] characters
- [x] character abilities
- [x] items

# Usage

Read the article linked above to find where your `save.json` file is.

Once that's done, using this tool is very simple:

1. Download `ror_unlocks.exe` and `unlocked.json`
2. Place them in the same folder as `save.json` (can drag and drop in file explorer).
3. Double click `ror_unlocks.exe` to run it, and it will update your `save.json`,
    backing up the previous version to `save_old.json`.

That's it! You should have all the characters and abilities unlocked!

## Unplanned

- logbooks
- other stuff that doesn't really impact gameplay

## Disclaimers

TODO: add disclaimer here

until I do: I'm not responsible for you messing stuff up if you use this and it
borks something.

BACKUP YOUR OLD `save.json` FILE - I intentionally write the new json file to
save_new.json so it doesn't overwrite the old save.json file

I haven't really tested this but I'll write a couple at some point I think.

# Why in jai?

I really like programming it, anyone can run the compiled executable (vs some
kind of script where the user needs the scripting language installed and the
prerequisite knowledge to run the scripts), and its really easy to build.

I considered c but building c is grossly overcomplicated, which is exacerbated
by the fact that I'm writing this on MacOS, while it's meant to be used on
windows. If I was to write this in c I'd need two principle dependencies:

1. json utils (deserialize, modify, and serialize)
2. set (one of each element) data structure

I'm not interested in writing these myself cause I want this to be quick, and
if I was to depend on libraries I'd have to make sure they build on my
development platform and windows which is more pain than I'm willing to deal
with. If someone points out decent cross-platform easy-to-build c for the two
dependencies then I'll go ahead and rewrite in c. (No c++ please).

The stb-style single header approach generally works well but I didn't want to
hunt for libs that are like this and cross-platform.
