# Meals I Could Make
This program takes a user's current food inventory and matches it to potential meals a user could make. If a user wanted to eat food of a particular type, they could sort available recipes by food-type (e.g., Italian, Mexican).

## Description
In order to track this information, a "food database" of sorts will be needed. This will allow users to select what food they actually have in their cupboards. The food could be sorted by food-group, so it's easier for users to find what food items they have.

This program should store selected food in a location to indicate what the user currently has available to make. It could track quantities. Maybe it also has a "did you make this meal?" option that removes those foods if the meal was made.

The program will also need a list of recipes. The table to store this will need to have a recipe, then a food-type associated with a given recipe, perhaps the amount of time it takes to make the recipe, and a way to list all foods needed to make this recipe. Maybe the "did you make this meal?" could go here, time dependent.

## "Should" Cases
The program should be able to:
- Select food items they have and store those somewhere
- Provide a list of recipes based on the current food inventory
- Sort recipes by food-type
- View all recipes
- View all food needed for one recipe
- View all foods
- View all foods in current food inventory
- Sort food by food-group


## "Should Not" Cases
The program should not:
- Populate recipes without food in the current food inventory
- Populate recipes with only partial food items in the current food inventory
- Create recipes without food-type associated
- Delete an entire current food inventory
- Delete all recipes
- Delete the food database

## Requirements
- At least three models
  - At least one one-to-many relationship
  - At least one many-to-many relationship
- Unit tests for all business logic
- Ability to fully interact with the application from the browser

## Stretches
Only if there's time to create, the program will (in order of importance):
- Sort recipes by time to make
- Subtract food from the current food inventory if a meal was made
- What am I missing to make this recipe?
