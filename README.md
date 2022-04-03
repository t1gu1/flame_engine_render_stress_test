# render_stress_test

A stress test example for Flame DEVs

## Controls

- **Space Bar**: Reset/Restart the game
- **Arrows Up and Down**: Move the player up or down

## What feels wrong

- It takes a lots of resources (30fps max when the blocks are there)
- After something like 15sec of constant run (without die) a **lag spike** could be feel

## How to test it

- Test it on a PC/Laptop in a web browser in dev mode (Not the flame debug mode)
- 1920w 1080h

## What are the current system / How it works

- The block are destroy when they are out of the LEFT camera
- The block are generated one column before the camera (To the right)
- I try to make a parent for a vertical column of block

## Disclaimer

P.S.

- I may be doing something wrong but I try before to send that example.
- Please don't hurt me if it's the case <3
- For the purpose of that test, I don't do the best beautiful way to code it. I just make it works.
