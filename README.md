# Exercise 4.4-Enemies

Exercise for MSCH-C220

This exercise is designed to continue exploring a 2D Platformer, by demonstrating some different types of enemies.

The expectations for this exercise are that you will

 - [ ] Fork and clone this repository
 - [ ] Import the project into Godot
 - [ ] Create the animations for the Golem's AnimatedSprite and connect them to the behaviors in the state machine
 - [ ] Using a NavigationRegion2D node, create a navigable area for the bat to travers
 - [ ] Create a state machine (with behaviors) for the bat
 - [ ] Test the game, attacking the enemies using the space bar
 - [ ] Edit the LICENSE and README.md
 - [ ] Commit and push your changes back to GitHub. Turn in the URL of your repository on Canvas.
---
A demonstration of the exercise is available at [https://youtu.be/nfAeY1uZaGk](https://youtu.be/nfAeY1uZaGk)
---
## Instructions

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-4-4-Enemies. Edit the LICENSE and replace BL-MSCH-C220 with your full name. Commit your changes.

Clone the repository to a Local Path on your computer.

Open Godot. Navigate to this folder. Import the project.godot file and open the "Enemies" project.

Open `res://Game.tscn`. You will see a tilemap node laying out the level. Inside the Enemy_Container node, there are three different enemy types and we will be implementing distinct behaviors for each.

Right-click on the Game node and Add Child Node. Select NavigationRegion2D. In the Inspector, creaet a new NavigationPolygon, and then use the polygon tools in the toolbar to enclose all the open space in the level (excluding any terrain/platforms). Turing on the Grid in the toolbar might help. Avoid the edges and the platforms, and try to create enough margin that the bat won't get stuck.

Open `res://Enemies/Golem.tscn`. The Golem scene has been created, with a state machine describing its behavior, but we need to add animations to correspond with its possible states. Select the AnimatedSprite node and create a new SpriteFrames. Using the corresponding sprite sheets in res://Assets, create animations for "Moving", "Attacking", and "Dying". Moving and Dying should be set at 5 FPS and Move should be looping. Attacking should be set at 15 FPS. Moving can be set as the AnimationSprite's default animation. In the Golem's scripts, play those animations at the appropriate times. A few lines have been commented out in res://Enemies/Golem.gd. They account for the additional width of the animation when the Golem is attacking.

Open `res://Enemies/Bat.tscn`. Right-click on the Bat node and Add Child Node: NavigationAgent2D. Then, attach a script to the Bat node: `res://Enemies/Bat.gd`. The beginning of that script should be as follows:
```
extends CharacterBody2D

var player = null
@onready var ray = $See
@export var speed = 800
@export var looking_speed = 100
var nav_ready = false

var mode = ""


var points = []
const margin = 1.5

func _ready():
	$AnimatedSprite2D.play("Moving")
	call_deferred("nav_setup")

func nav_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	$NavigationAgent2D.target_position = global_position
	nav_ready = true
```

It is possible to implement a simple state machine in a single file using flags (or a variable) to maintain the current state. That is the purpose of the mode variable. The modes should correspond with the three animations: Attacking, Moving, Dying. The bat should use the NavigationAgent2D node to find a path to the player. If the bat can currently see the player (using the $See RayCast2D), its velocity should be "speed". Otherwise, it should use "looking_speed". Once you have found the player node, you can use the NavigationAgent2D node as follows:
```
		$NavigationAgent2D.target_position = player.global_position
		points = $NavigationAgent2D.get_next_path_position()
		$See.target_position = to_local(player.global_position)
		var c = $See.get_collider()
		if c == player:
			s = speed
	if points != Vector2.ZERO:
		print(points)
		var distance = points - global_position
		var direction = distance.normalized()
		$AnimatedSprite2D.flip_h = direction.x < 0
		if distance.length() > margin:
			velocity = direction*s
		else:
			velocity = Vector2.ZERO
		move_and_slide()
```

I will leave the rest of the implementation to you (or as you follow my demonstration).

Once you have completed the bat script, test the game. See if you can avoid and attack each of the enemies (the player attacks with the space bar).

Quit Godot. In GitHub desktop, add a summary message, commit your changes and push them back to GitHub. If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-4-4-Enemies) on Canvas.

The final state of the file should be as follows (replacing the "Created by" information with your name):

```
# Exercise 4.4—Enemies

Exercise for MSCH-C220

An exercise for the 2D Platformer project, exploring attacking and three different enemy types.

## Implementation

Built using Godot 4.1.1

The player sprite is an adaptation of [MV Platformer Male](https://opengameart.org/content/mv-platformer-male-32x64) by MoikMellah. CC0 Licensed.

The [tilemap](https://kenney.nl/assets/abstract-platformer) is provided by Kenney.nl.

The enemies are from the [Medieval Fantasy Character Pack by OcO](https://oco.itch.io/medieval-fantasy-character-pack). CC0 Licensed

## References

None

## Future Development

None

## Created by 

Jason Francis
```
