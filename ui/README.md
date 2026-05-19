# User Interface (UI)

### What goes here?
Anything that sits on the "glass" of the screen rather than in the game world.
* **Contents:** The HUD (Heads-Up Display), Health Bars, Gem Counters, Main Menus, and Pause Screens.

### Why?
UI in Godot usually uses `Control` nodes rather than `Node2D`. By separating the UI from the gameplay entities, you ensure that your "Health Bar" logic doesn't get tangled up with your "Ship Movement" logic. This is a key part of **Composition**: the UI layer sits on top of the game layer, reflecting data without interfering with the physics.