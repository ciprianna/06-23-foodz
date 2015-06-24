# Meals I Could Make
This program takes a user's current food inventory and matches it to potential meals a user could make. If a user wanted to eat food of a particular type, they could sort available recipes by food-type (e.g., Italian, Mexican).

## Description
In order to track this information, a "food database" of sorts will be needed. This will allow users to select what food they actually have in their cupboards. The food could be sorted by food-group, so it's easier for users to find what food items they have.

The program will also need a list of recipes. The table to store this will need to have a recipe, then a food-type associated with a given recipe, perhaps the amount of time it takes to make the recipe, and a way to list all foods needed to make this recipe.

A recipe-types table will store possible categories of recipes.
A categories table will store ids and names of food categories.

## "Should" Cases
The program should be able to:
- Select food items
- Provide a list of recipes based on user selection of current foods
- Sort recipes by food-type
- View all recipes
- View all food needed for one recipe
- View all foods
- Sort food by food-group
- View all food-types
- View all recipes in a food type

## "Should Not" Cases
The program should not:
- Populate recipes without all food items selected as available by user
- Create recipes without food-type associated
- Delete all recipes
- Delete the food database
- Enter a food-type without a name

## Requirements
- At least three models
  - At least one one-to-many relationship
  - At least one many-to-many relationship
- Unit tests for all business logic
- Ability to fully interact with the application from the browser

## Stretches
Only if there's time to create, the program will (in order of importance):
- Sort recipes by time to make
- What am I missing to make this recipe?
- Store the food a user has in a user inventory with quantities
- Subtract food from the current food inventory if a meal was made
