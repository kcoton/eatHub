INSERT INTO UserType (userType, typeName) VALUES (1, 'admin');
INSERT INTO UserType (userType, typeName) VALUES (2, 'contributor');

INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (1, 1, 'tony.stark@gmail.com', 'Tony Stark', TO_DATE('1980-02-28', 'YYYY-MM-DD'), 220, 190);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (2, 2, 'diana.prince@gmail.com', 'Diana Prince', TO_DATE('1985-10-25', 'YYYY-MM-DD'), 150, 180);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (3, 2, 'bruce.wayne@gmail.com', 'Bruce Wayne', TO_DATE('1975-03-30', 'YYYY-MM-DD'), 180, 188);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (4, 2, 'peter.parker@gmail.com', 'Peter Parker', TO_DATE('1995-08-15', 'YYYY-MM-DD'), 167, 178);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (5, 2, 'miles.morales@gmail.com', 'Miles Morales', TO_DATE('2001-11-12', 'YYYY-MM-DD'), 160, 175);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (6, 2, 'jiyoung.lee@gmail.com', 'Jiyoung Lee', TO_DATE('1990-05-20', 'YYYY-MM-DD'), 140, 165);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (7, 2, 'hiroshi.tanaka@gmail.com', 'Hiroshi Tanaka', TO_DATE('1988-09-10', 'YYYY-MM-DD'), 170, 175);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (8, 2, 'aisha.kumar@gmail.com', 'Aisha Kumar', TO_DATE('1993-12-05', 'YYYY-MM-DD'), 155, 160);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (9, 2, 'rajesh.singh@gmail.com', 'Rajesh Singh', TO_DATE('1982-07-18', 'YYYY-MM-DD'), 180, 175);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (10, 2, 'sakura.yamamoto@gmail.com', 'Sakura Yamamoto', TO_DATE('1998-03-15', 'YYYY-MM-DD'), 120, 155);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (11, 2, 'jung-hoon.kim@gmail.com', 'Jung-Hoon Kim', TO_DATE('1987-11-08', 'YYYY-MM-DD'), 160, 170);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (12, 2, 'mei.lin@gmail.com', 'Mei Lin', TO_DATE('1995-06-22', 'YYYY-MM-DD'), 130, 160);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (13, 2, 'suresh.sharma@gmail.com', 'Suresh Sharma', TO_DATE('1984-04-30', 'YYYY-MM-DD'), 175, 178);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (14, 2, 'xiaoming.chen@gmail.com', 'Xiaoming Chen', TO_DATE('1991-08-12', 'YYYY-MM-DD'), 155, 165);
INSERT INTO UserInfo (userID, userType, email, name, birthday, weight, height) VALUES (15, 2, 'natsuki.takahashi@gmail.com', 'Natsuki Takahashi', TO_DATE('1996-01-25', 'YYYY-MM-DD'), 140, 162);

INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1980-02-28', 'YYYY-MM-DD'), 53);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1985-10-25', 'YYYY-MM-DD'), 38);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1975-03-30', 'YYYY-MM-DD'), 48);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1995-08-15', 'YYYY-MM-DD'), 28);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('2001-11-12', 'YYYY-MM-DD'), 22);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1990-05-20', 'YYYY-MM-DD'), 32);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1988-09-10', 'YYYY-MM-DD'), 34);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1993-12-05', 'YYYY-MM-DD'), 28);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1982-07-18', 'YYYY-MM-DD'), 41);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1998-03-15', 'YYYY-MM-DD'), 25);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1987-11-08', 'YYYY-MM-DD'), 36);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1995-06-22', 'YYYY-MM-DD'), 26);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1984-04-30', 'YYYY-MM-DD'), 38);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1991-08-12', 'YYYY-MM-DD'), 31);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1996-01-25', 'YYYY-MM-DD'), 27);

INSERT INTO UserBMI (weight, height, BMI) VALUES (220, 190, 24);
INSERT INTO UserBMI (weight, height, BMI) VALUES (150, 180, 21);
INSERT INTO UserBMI (weight, height, BMI) VALUES (180, 188, 27);
INSERT INTO UserBMI (weight, height, BMI) VALUES (167, 178, 24);
INSERT INTO UserBMI (weight, height, BMI) VALUES (160, 175, 25);
INSERT INTO UserBMI (weight, height, BMI) VALUES (140, 165, 20.6);
INSERT INTO UserBMI (weight, height, BMI) VALUES (170, 175, 55.1);
INSERT INTO UserBMI (weight, height, BMI) VALUES (155, 160, 35.2);
INSERT INTO UserBMI (weight, height, BMI) VALUES (180, 175, 58.8);
INSERT INTO UserBMI (weight, height, BMI) VALUES (120, 155, 24.9);
INSERT INTO UserBMI (weight, height, BMI) VALUES (160, 170, 55.3);
INSERT INTO UserBMI (weight, height, BMI) VALUES (130, 160, 30.5);
INSERT INTO UserBMI (weight, height, BMI) VALUES (175, 178, 55.3);
INSERT INTO UserBMI (weight, height, BMI) VALUES (155, 165, 38.2);
INSERT INTO UserBMI (weight, height, BMI) VALUES (140, 162, 26.7);

INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (1, 'Spaghetti Bolognese', 'Pasta');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (2, 'Chicken Stir-Fry', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (3, 'Caprese Salad', 'Salad');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (4, 'Beef Tacos', 'Mexican');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (5, 'Mushroom Risotto', 'Italian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (6, 'Sushi Rolls', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (7, 'Pad Thai', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (8, 'Kimchi Fried Rice', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (9, 'Teriyaki Chicken', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (10, 'Bibimbap', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (11, 'Green Curry', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (12, 'Dim Sum Platter', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (13, 'Miso Soup', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (14, 'Chilli Chicken', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (15, 'Beef and Broccoli Stir-Fry', 'Asian');

INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 1, 'Heat oil in a wok. Add chicken and stir-fry for 5 minutes. Add vegetables and sauce. Stir-fry for an additional 3 minutes.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 350);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 2, 'Marinate chicken in soy sauce and garlic for 30 minutes before stir-frying. Add broccoli and peppers for added flavor.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 370);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 3, 'For a spicier version, add chili flakes and ginger while stir-frying the chicken. Serve with steamed rice.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 400);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 4, 'Use low-sodium soy sauce and olive oil for a healthier option. Include sliced carrots and snap peas for added crunch.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 330);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 5, 'Make it gluten-free by using tamari sauce. Add water chestnuts and baby corn for a unique twist.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (3, 6, 'Make it gluten-free by using tamari sauce. Add water chestnuts and baby corn for a unique twist.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (3, 7, 'Make it gluten-free by using tamari sauce. Add water chestnuts and baby corn for a unique twist.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (3, 8, 'Make it gluten-free by using tamari sauce. Add water chestnuts and baby corn for a unique twist.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (3, 9, 'Make it gluten-free by using tamari sauce. Add water chestnuts and baby corn for a unique twist.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (3, 10, 'Make it gluten-free by using tamari sauce. Add water chestnuts and baby corn for a unique twist.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (10, 1, 'Vegetarian - remove meat.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 1, 360);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (10, 2, 'Spicy - Additional pepper sauce.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 1, 360);

INSERT INTO MealPlan (mealplanID, userID, mealplanName, mealplanCategory) VALUES (3, 1, 'Family Dinners', 'Homestyle');
INSERT INTO MealPlan (mealplanID, userID, mealplanName, mealplanCategory) VALUES (4, 2, 'Gluten-Free Week', 'Gluten-Free');
INSERT INTO MealPlan (mealplanID, userID, mealplanName, mealplanCategory) VALUES (5, 1, 'Mediterranean Feast', 'Mediterranean');
INSERT INTO MealPlan (mealplanID, userID, mealplanName, mealplanCategory) VALUES (6, 2, 'Vegan Challenge', 'Vegan');
INSERT INTO MealPlan (mealplanID, userID, mealplanName, mealplanCategory) VALUES (7, 1, 'Asian Fusion', 'Asian');

INSERT INTO Meal (mealID, mealplanID, mealName, mealCategory, mealDay) VALUES (1, 6, 'Breakfast Burrito', 'Breakfast', TO_DATE('2023-10-21', 'YYYY-MM-DD'));
INSERT INTO Meal (mealID, mealplanID, mealName, mealCategory, mealDay) VALUES (2, 6, 'Quinoa Salad', 'Salad', TO_DATE('2023-10-22', 'YYYY-MM-DD'));
INSERT INTO Meal (mealID, mealplanID, mealName, mealCategory, mealDay) VALUES (3, 6, 'Veggie Stir-Fry', 'Asian', TO_DATE('2023-10-23', 'YYYY-MM-DD'));
INSERT INTO Meal (mealID, mealplanID, mealName, mealCategory, mealDay) VALUES (4, 6, 'Tofu Scramble', 'Breakfast', TO_DATE('2023-10-24', 'YYYY-MM-DD'));
INSERT INTO Meal (mealID, mealplanID, mealName, mealCategory, mealDay) VALUES (5, 3, 'Sushi Rolls', 'Asian', TO_DATE('2023-10-25', 'YYYY-MM-DD'));

INSERT INTO GroceryList (grocerylistID, userID, createDate, fulfillDate) VALUES (1, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-27', 'YYYY-MM-DD'));
INSERT INTO GroceryList (grocerylistID, userID, createDate, fulfillDate) VALUES (2, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-31', 'YYYY-MM-DD'));
INSERT INTO GroceryList (grocerylistID, userID, createDate, fulfillDate) VALUES (3, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-11-03', 'YYYY-MM-DD'));
INSERT INTO GroceryList (grocerylistID, userID, createDate, fulfillDate) VALUES (4, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-11-07', 'YYYY-MM-DD'));
INSERT INTO GroceryList (grocerylistID, userID, createDate, fulfillDate) VALUES (5, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-11-10', 'YYYY-MM-DD'));

INSERT INTO Ingredient (ingredientName, unitOfMeasure, ingredientCategory) VALUES ('Chicken', 'Pound', 'Meat');
INSERT INTO Ingredient (ingredientName, unitOfMeasure, ingredientCategory) VALUES ('Broccoli', 'Ounce', 'Vegetable');
INSERT INTO Ingredient (ingredientName, unitOfMeasure, ingredientCategory) VALUES ('Soy Sauce', 'Tablespoon', 'Sauce');
INSERT INTO Ingredient (ingredientName, unitOfMeasure, ingredientCategory) VALUES ('Rice', 'Cup', 'Grain');
INSERT INTO Ingredient (ingredientName, unitOfMeasure, ingredientCategory) VALUES ('Garlic', 'Cloves', 'Vegetable');

INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackComment) VALUES (1, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_TIMESTAMP('14:30:00', 'HH24:MI:SS'), 'Great recipe! I loved it.');
INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackComment) VALUES (2, 1, TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_TIMESTAMP('09:45:00', 'HH24:MI:SS'), 'This meal plan is fantastic.');
INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackComment) VALUES (3, 1, TO_DATE('2023-10-22', 'YYYY-MM-DD'), TO_TIMESTAMP('18:15:00', 'HH24:MI:SS'), 'It tasted kind of bland.');
INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackComment) VALUES (4, 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_TIMESTAMP('12:20:00', 'HH24:MI:SS'), 'The grocery list was very helpful.');
INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackComment) VALUES (5, 1, TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_TIMESTAMP('15:55:00', 'HH24:MI:SS'), 'The Chicken Stir-Fry was amazing.');

INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackRating) VALUES (6, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_TIMESTAMP('14:30:00', 'HH24:MI:SS'), 5);
INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackRating) VALUES (7, 2, TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_TIMESTAMP('09:45:00', 'HH24:MI:SS'), 4);
INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackRating) VALUES (8, 1, TO_DATE('2023-10-22', 'YYYY-MM-DD'), TO_TIMESTAMP('18:15:00', 'HH24:MI:SS'), 3);
INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackRating) VALUES (9, 2, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_TIMESTAMP('12:20:00', 'HH24:MI:SS'), 4);
INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackRating) VALUES (10, 1, TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_TIMESTAMP('15:55:00', 'HH24:MI:SS'), 5);

INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (1, 1, 2, 1, 'Great recipe! I loved it.', 5, TO_DATE('2023-10-24', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (2, 2, 2, 1, 'This meal plan was alright.', 3, TO_DATE('2023-10-24', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (3, 6, 3, 1, 'It tasted kind of bland.', 1, TO_DATE('2023-10-24', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (4, 6, 3, 1, 'Much improved version!', 4, TO_DATE('2023-10-24', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (5, 6, 3, 1, 'Would love to see a spicier version.', 4, TO_DATE('2023-10-24', 'YYYY-MM-DD'));

INSERT INTO Contains (grocerylistID, ingredientName, quantity) VALUES (1, 'Chicken', 1);
INSERT INTO Contains (grocerylistID, ingredientName, quantity) VALUES (1, 'Broccoli', 2);
INSERT INTO Contains (grocerylistID, ingredientName, quantity) VALUES (1, 'Soy Sauce', 1);
INSERT INTO Contains (grocerylistID, ingredientName, quantity) VALUES (1, 'Rice', 2);
INSERT INTO Contains (grocerylistID, ingredientName, quantity) VALUES (1, 'Garlic', 1);

INSERT INTO Uses (versionID, recipeID, ingredientName, measure) VALUES (1, 2, 'Chicken', 1);
INSERT INTO Uses (versionID, recipeID, ingredientName, measure) VALUES (2, 2, 'Broccoli', 8);
INSERT INTO Uses (versionID, recipeID, ingredientName, measure) VALUES (3, 2, 'Rice', 1);
INSERT INTO Uses (versionID, recipeID, ingredientName, measure) VALUES (4, 2, 'Garlic', 1);
INSERT INTO Uses (versionID, recipeID, ingredientName, measure) VALUES (5, 2, 'Soy Sauce', 1);

INSERT INTO References (versionID, recipeID, mealID, serving) VALUES (1, 2, 5, 1);
INSERT INTO References (versionID, recipeID, mealID, serving) VALUES (2, 2, 4, 4);
INSERT INTO References (versionID, recipeID, mealID, serving) VALUES (3, 2, 3, 3);
INSERT INTO References (versionID, recipeID, mealID, serving) VALUES (4, 2, 2, 2);
INSERT INTO References (versionID, recipeID, mealID, serving) VALUES (5, 2, 1, 1);

COMMIT;