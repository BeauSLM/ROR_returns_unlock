# ROR returns unlock stuff

A program that unlocks stuff per what's detailed in [this
article](https://gameplay.tips/guides/risk-of-rain-returns-how-to-get-infinite-items-legitimately.html)

## Unlocks (as of the time of this writing):

- [x] characters
- [x] character abilities
- [ ] items

# Usage

TODO

My plan is to automate building the latest code (gh actions?) and adding the
executable to the repository so people can download it and run it.

The usage I've imagined (though this may be terrible) is people place the exe
and unlocked.json in the same dir as their save.json and just double click it
to run it.

Also I've added the file `json/unlock.json` which has all the flags that can be
put in your own `save.json`'s `flags` field to unlock stuff so just use that if
you want to copy-paste instead.

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

1. json parser
2. set (one of each element) data structure

I'm not interested in writing these myself cause I want this to be quick, and
if I was to depend on libraries I'd have to make sure they build on my
development platform and windows which is more pain than I'm willing to deal
with. If someone points out decent cross-platform easy-to-build c for the two
dependencies then I'll go ahead and rewrite in c. (No c++ please).

The stb-style single header approach generally works well but I didn't want to
hunt for libs that are like this and cross-platform.
