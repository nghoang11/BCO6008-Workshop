library(tidyverse)
library(tidymodels)
library(skimr)
library(janitor)

muffin_cupcake_data_org <- read_csv("https://raw.githubusercontent.com/adashofdata/muffin-cupcake/master/recipes_muffins_cupcakes.csv")

muffin_cupcake_data_org %>% skim()

#clean variable names

muffin_cupcake <- muffin_cupcake_data_org %>% 
  clean_names()

#split data into training and testing sets

muffin_cupcake_split <- initial_split(muffin_cupcake)

muffin_cupcake_train <- training(muffin_cupcake_split)

muffin_cupcake_test <- testing(muffin_cupcake_split)

# define the recipe
model_recipe <- recipe(type~flour+milk+sugar+butter+egg+baking_powder+vanilla+salt,
                       data=muffin_cupcake_train)

summary(model_recipe)

model_recipe_steps <- model_recipe %>% 
  step_impute_mean(all_numeric()) %>% 
  step_center(all_numeric()) %>% 
  step_scale(all_numeric())

model_recipe_steps

# prep the recipe
prepped_recipe <- prep(model_recipe_steps, training=muffin_cupcake_train)

prepped_recipe

# bake the recipe
model_train_preprocessed <- bake(prepped_recipe,muffin_cupcake_train)
model_train_preprocessed

model_test_preprocessed <- bake(prepped_recipe,muffin_cupcake_test)
model_test_preprocessed

Take away notes
preprocessing data:
  split data 
create a recipe
add steps to the recipe
prep the recipe
bake the recipe 

ready to go to the model