# BaronOfPortswood
Baron of Portswood - Interactive Story 2D Game

How does the Story Engine work? 

The narrative itself is coded and contained as a .ink file. Ink is a narrative scripting language for games, which allows for elegant syntax, variable definitions, logic operations, and “knot” (branch) management. This tool, combined with its integration for unity, made writing the narrative much simpler than just coding a series of nested if statements into unity.

The main story engine is contained within a C# script, as part of a story engine object. All relevant game world objects are referenced through this object. This script runs through the .ink file line-by-line, displaying each content text of the narrative through a UI text object. At the same time, the script reads in tags for each line and the available choices where applicable. 

Tags are used to translate narrative components to game world components:
    • Enabling text input at a point in the narrative
    • Waiting for the player to interact with a certain game world object before continuing
    • Enabling a game world object once it is mentioned in the narrative
    • Applying a time delay between lines in the narrative
    • Beginning a scripted event at a certain point in the narrative
    • Spawning/De-spawning a character once they are mentioned in the narrative
    • Changing the background audio to tense music at tense points in the narrative

When the narrative prompts for a choice, the choices are presented to the user through clickable UI components. Clicking a button will select that choice, progressing the narrative.

One of the core components of the narrative is allowing the player to speak with multiple characters (NPCs) in whatever order they choose. Because of this, the game world has to ensure that all characters are spoken to before progressing the narrative, with each character sparking their own flow of conversation. It must also ensure that the player can only talk to characters that have story branches at any given time.

Each NPC has unique character traits that are identifiable in the narrative they provide e.g. loyal, narcissistic, impatient. The player will associate the narrative aspects of each character with their game world counterparts.

The fact that the user has to move their player around to interact with a certain character or object in the scene adds further agency and involvement. It separates the game from a simple point-and-click game.

Global variables in the narrative help to keep track of the player’s position and progress in the story. Player name is a variable set through a UI input field. When the player enters a name, they will be referred to by that name in the narrative. Food, gold and wellbeing are attributes that are updated with relevant actions in the narrative, and every time they are updated, their new value is reflected in the UI components of the book object. When any of these attributes hit zero, the narrative ends. Each NPC in the game world is linked to one of these attributes. When the player talks to a given NPC and makes decisions, this will update the corresponding attribute. The ant and grasshopper variables are updated based on the type of decision made – cautious decision or lazy decision. This is queried in the narrative itself to decide the story branches or specific sections of text. 

Feedback and Response

The feedback I received was on a version of the game that leaned more heavily on the food, gold, and wellbeing attributes for narrative branches. The criticism was that the game added another goal/mechanic that separated it further from the original Aesop fable inspiration. To address this, I changed every important player decision to be that of the ant (hard working, cautious) or of the grasshopper (lazy, not cautious) in the fable, which involved rewriting the narrative. At this stage, every important decision in the game is obviously one or the other.

Narrative Structure

![Screenshot_20231022_205035](https://github.com/reptm001/BaronOfPortswood/assets/7481414/fa35f256-c636-42a5-a35e-d87f3d8b71d8)
