# Entities (Features)

### What goes here?
Everything that "does something" in your game world. Each entity (Player, Enemy, Gem) should have its own sub-folder.
* **Example:** `entities/player/` contains `player.tscn`, `player.gd`, and `player_sprite.png`.

### Why?
We use **Feature-Based Organization**. By keeping the Scene, Script, and Local Assets together, we follow the principle of **Encapsulation**. 
* **Portability:** If you want to move the "Ship" to a different project, you just grab the `player/` folder and go. 
* **Focus:** You don't have to hunt through three different top-level folders just to fix one bug on the player.