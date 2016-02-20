#NinjaVoiceCommandExample

BACKGROUND:

First off I have never made a game. I haven't even used Apple's SpriteKit/SceneKit to create a basic game.
Since I had no experience with any of the technologies I had to go to a site and follow along the
tutorials. My game is based on http://www.raywenderlich.com/42699/spritekit-tutorial-for-beginners.
I have obtained permission from the authors that I can use this game.

Second and most importantly I have no experience in voice recognitition. I did a crash course by doing
lots of searches and seeing what worked in my work environment. I came across Carnegie 
Mellon University's (CMU) sphinx library and from there it made the work a lot easier. They pretty 
much pointed me to http://www.politepix.com/openears/ to have a fast integration of all
their libraries which are built in C to have it integrated with my platform as soon as possible.

TO RUN:

You could run this app on an iphone simulator provided that you have the latest version of Mac OS X (10.11) 
and Xcode (7.1) installed on your machine. You will need the CMU libraries to build.

LIBRARIES/FRAMEWORKS:

CMU-Sphinxbase     --- C library for basic speech recognition
CMU-Pocketsphinx   --- C library built on top of the Sphinxbase focused on mobile devices
OpenEars           --- Objective C Framework built on top of Pocketsphinx to allow simpler iOS integration
SpriteKit          --- Apple Inc's 2D game engine

TO PLAY:

Say UP to move the player up
Say DOWN to move the player down
Tap on the location you want to fire a projectile. Say FIRE to shoot a projectile at the tapped location.

GAME DESIGN:

I have chosen a simple game based on the tutorial and the objective of the game is to shoot the 
"monsters" with the projectile. 

The player could control the character up and down with voice commands.

DESIGN DECISIONS:

I decided to go with SpriteKit on iOS because I had no experience with Unreal and some small
Unity experience and never designed a game. SpriteKit allowed me to build a game with 
relative ease so I can spend most of my time researching speech recognition. 

I also decided to use SpriteKit because you can integrate C/C++ classes and libraries with minimal
effort. Since Objective C/Objective C++ is a superset of C/C++ I had no trouble with integration.

A lot of my time spent was trying to install multiple third party libraries and integrate into my game.
There were lots of libraries that had sparse documentation and were very hard to integrate. Even
trying to integrate Sphinxbase and Pocketsphinx was pretty tough. On Pocketsphinx's site it referred to
OpenEars (http://www.politepix.com/openears/) to have a simpler integration. Also due to my use
of OpenEars framework, majority of the work is done in Objective C. And since Objective C is a
superset of C and adds a SmallTalk message passing to the C language I decided to stick with mainly 
using Objective C. Since a good number of people submitted their responses using C# via Unity, I 
figured I could make the  argument that Objective C is an extension of C and therefore meets the
criteria of being written in C/C++. Also Objective C is object oriented with memory allocation features
and pointers and access to low level memory like C/C++. 

I used the MVC and encapsulation to make the game. 

GameScene object inherited from the SKScene class and contained all the objects that were related 
to the game such as the player, monsters, and projectiles. This class was also the delegate for the
Apple's physics kit so that if there were any objects that collided, the class would be notified and
the registered method would be called.

GameViewController inherited from the UIViewController and contains the GameScene object, the objects
from the OpenEars framework and any other UI elements. This handled any user inputs and responded to
the GameScene object.


PROMPT:
You're required to build a voice activated control within a game.

Use one of the popular game engines like Unity, Unreal, etc.
Pick a game of your choice from the free resources provided by the popular game engines. Implement a
simple and intuitive voice activated control to complete an action in your game.

Implement this using C/C++ and any other supporting frameworks/ technologies you may need.

Explain the choices and assumptions you make in a 1-page design and functional spec document and
include a README.md along with your code base.

KEDAR'S ANNOTATIONS:
Thanks for asking. 
Using a programming language (C#, Javascript or Boo) that is compatible with Unity's free version is fine.

Best,
Kedar @GapJumpers.

Sorry about the delay. Yes, of course. Using the SpriteKit engine is fine :)

Good luck!

You may use supporting frameworks if you like, but the core implementation of 
your voice activated control is required in C/ C++.

