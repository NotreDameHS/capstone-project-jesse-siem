# Autoloads

### What goes here?
Scripts that need to stay active regardless of which scene is currently running. Examples include `GameManager.gd`, `SaveSystem.gd`, or a `GlobalSignals.gd` bus.

### Why?
In Godot, when you change scenes, all nodes in the old scene are deleted. **Autoloads** are special nodes that sit outside the main scene tree. They are perfect for:
* **Global State:** Keeping track of total Gems or Player Score across different levels.
* **Audio Management:** Playing background music that doesn't restart when the level changes.
* **Communication:** Helping two scenes talk to each other without being directly connected.