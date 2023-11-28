-- DROP
DROP TABLE UserType CASCADE CONSTRAINTS;
DROP TABLE UserInfo CASCADE CONSTRAINTS;
DROP TABLE UserAge CASCADE CONSTRAINTS;
DROP TABLE UserBMI CASCADE CONSTRAINTS;
DROP TABLE Recipe CASCADE CONSTRAINTS;
DROP TABLE Version CASCADE CONSTRAINTS;
DROP TABLE MealPlan CASCADE CONSTRAINTS;
DROP TABLE Meal CASCADE CONSTRAINTS;
DROP TABLE GroceryList CASCADE CONSTRAINTS;
DROP TABLE Ingredient CASCADE CONSTRAINTS;
DROP TABLE Feedback CASCADE CONSTRAINTS;
DROP TABLE Contains CASCADE CONSTRAINTS;
DROP TABLE Uses CASCADE CONSTRAINTS;
DROP TABLE References CASCADE CONSTRAINTS;

-- CREATE
CREATE TABLE UserType (
	userType	INTEGER,
	typeName	VARCHAR(30) NOT NULL,
	PRIMARY KEY (userType)
);

CREATE TABLE UserInfo (
	userID	    INTEGER,
	userType	INTEGER,
	email	    VARCHAR(30)	NOT NULL UNIQUE,
	name		VARCHAR(30)	NOT NULL,
	birthday	DATE,
	weight	    INTEGER,
	height	    INTEGER,
	FOREIGN KEY (userType)
		REFERENCES UserType(userType)
        ON DELETE CASCADE,
    PRIMARY KEY (userID)
);

CREATE TABLE UserAge (
	birthday	DATE,
	age			INTEGER,
	PRIMARY KEY (birthday)
);

CREATE TABLE UserBMI (
	weight	INTEGER,
	height	INTEGER,
	BMI		INTEGER,
	PRIMARY KEY (weight, height)
);

CREATE TABLE Recipe (
	recipeID		INTEGER,
	recipeName	    VARCHAR(30)	NOT NULL,
	recipeCategory	VARCHAR(20),
	PRIMARY KEY (recipeID)
);

CREATE TABLE Version (
	versionID		INTEGER,
	recipeID		INTEGER,
	instructions	VARCHAR(2000),
	versionDate	    DATE	NOT NULL,
	versionServing	INTEGER,
	calories		INTEGER,
	FOREIGN KEY (recipeID)
		REFERENCES Recipe(recipeID)
        ON DELETE CASCADE,
    PRIMARY KEY (versionID, recipeID)
);

CREATE TABLE MealPlan (
	mealplanID		    INTEGER	NOT NULL,
    userID			    INTEGER	NOT NULL,
    mealplanName		VARCHAR(30),
    mealplanCategory 	VARCHAR(30),
	PRIMARY KEY (mealplanID),
	FOREIGN KEY (userID)
        REFERENCES UserInfo(userID)
        ON DELETE CASCADE
);

CREATE TABLE Meal (
	mealID		INTEGER,
    mealplanID	INTEGER	NOT NULL,
    mealName		VARCHAR(30),
    mealCategory	VARCHAR(30),
    mealDay		DATE,
	PRIMARY KEY (mealID),
    FOREIGN KEY (mealplanID)
        REFERENCES MealPlan(mealplanID)
        ON DELETE CASCADE
);

CREATE TABLE GroceryList (
	grocerylistID	INTEGER,
    userID		    INTEGER	NOT NULL,
    createDate	    DATE    NOT NULL,
    fulfillDate	    DATE,
	PRIMARY KEY (grocerylistID),
	FOREIGN KEY (userID)
		REFERENCES UserInfo(userID)
        ON DELETE CASCADE
);

CREATE TABLE Ingredient (
	ingredientName		VARCHAR(30),
	unitOfMeasure		VARCHAR(10)	NOT NULL,
	ingredientCategory	VARCHAR(20),
	PRIMARY KEY (ingredientName)
);

CREATE TABLE Feedback (
	feedbackID	    INTEGER,
	versionID		INTEGER,
	recipeID		INTEGER,
    userID		    INTEGER,
	feedbackComment	VARCHAR(400),
    feedbackRating	INTEGER	NOT NULL,
    feedbackDate	DATE DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (feedbackID),
    FOREIGN KEY (versionID, recipeID)
		REFERENCES Version(versionID, recipeID)
			ON DELETE CASCADE,
	FOREIGN KEY (userID)
		REFERENCES UserInfo(userID)
        	ON DELETE CASCADE
);

CREATE TABLE Contains (
	grocerylistID	INTEGER,
	ingredientName	VARCHAR(30),
	quantity		INTEGER	NOT NULL,
	PRIMARY KEY (grocerylistID, ingredientName),
	FOREIGN KEY (grocerylistID)
		REFERENCES GroceryList(grocerylistID)
			ON DELETE CASCADE,
	FOREIGN KEY (ingredientName)
		REFERENCES Ingredient(ingredientName)
			ON DELETE CASCADE
);

CREATE TABLE Uses (
	versionID		INTEGER,
	recipeID		INTEGER,
	ingredientName	VARCHAR(30),
    measure		    INTEGER	NOT NULL,
	PRIMARY KEY (versionID, recipeID, ingredientName),
    FOREIGN KEY (versionID, recipeID)
		REFERENCES Version(versionID, recipeID)
			ON DELETE CASCADE,
	FOREIGN KEY (ingredientName)
		REFERENCES Ingredient(ingredientName)
			ON DELETE CASCADE
);

CREATE TABLE References (
	versionID   INTEGER,
    recipeID   INTEGER,
    mealID		INTEGER,
    serving		INTEGER	NOT NULL,
	PRIMARY KEY (versionID, recipeID, mealID),
	FOREIGN KEY (versionID, recipeID)
		REFERENCES Version(versionID, recipeID)
			ON DELETE CASCADE,
	FOREIGN KEY (mealID)
		REFERENCES Meal(mealID)
			ON DELETE CASCADE
);

-- INSERT
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

INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (1, 'Spaghetti Bolognese', 'Italian');
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
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (16, 'Chocolate Fudge Cake', 'Dessert');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (17, 'Apple Pie', 'Dessert');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (18, 'Cheesecake', 'Dessert');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (19, 'Tiramisu', 'Dessert');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (20, 'Lemon Tart', 'Dessert');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (21, 'Grilled Salmon', 'Seafood');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (22, 'Shrimp Scampi', 'Seafood');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (23, 'Fish Tacos', 'Seafood');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (24, 'Lobster Bisque', 'Seafood');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (25, 'Crab Cakes', 'Seafood');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (26, 'Vegetable Stir-Fry', 'Vegetarian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (27, 'Mushroom Stroganoff', 'Vegetarian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (28, 'Eggplant Parmesan', 'Vegetarian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (29, 'Veggie Burger', 'Vegetarian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (30, 'Spinach and Ricotta Lasagna', 'Vegetarian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (31, 'Chicken Enchiladas', 'Mexican');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (32, 'Caesar Salad', 'Salad');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (33, 'Greek Salad', 'Salad');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (34, 'Quinoa Salad', 'Salad');

INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 2, 'Heat oil in a wok. Add chicken and stir-fry for 5 minutes. Add vegetables and sauce. Stir-fry for an additional 3 minutes.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 350);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (2, 2, 'Marinate chicken in soy sauce and garlic for 30 minutes before stir-frying. Add broccoli and peppers for added flavor.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 370);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (3, 2, 'For a spicier version, add chili flakes and ginger while stir-frying the chicken. Serve with steamed rice.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 400);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (4, 2, 'Use low-sodium soy sauce and olive oil for a healthier option. Include sliced carrots and snap peas for added crunch.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 330);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (5, 2, 'Make it gluten-free by using tamari sauce. Add water chestnuts and baby corn for a unique twist.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 3, 'Add a variety of colorful bell peppers for enhanced flavor and presentation.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 4, 350);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (2, 3, 'Include cherry tomatoes and cucumbers for a refreshing crunch.', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 4, 330);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (3, 3, 'Try a balsamic vinaigrette dressing for a tangy twist.', TO_DATE('2023-11-21', 'YYYY-MM-DD'), 4, 340);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (4, 3, 'Incorporate roasted nuts or seeds for added texture.', TO_DATE('2023-11-22', 'YYYY-MM-DD'), 4, 365);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (5, 3, 'Mix in some grilled chicken or shrimp for a protein boost.', TO_DATE('2023-11-23', 'YYYY-MM-DD'), 4, 380);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (6, 3, 'For a crunchy texture, top the finished dish with roasted cashews or almonds just before serving.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (7, 3, 'Boost the nutritional value by incorporating a mix of kale and spinach into the stir-fry during the last two minutes of cooking.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (8, 3, 'Introduce a sweet element by including pineapple chunks and a dash of honey along with the vegetables.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (9, 3, 'Enhance the flavors by adding a tablespoon of oyster sauce and a teaspoon of sesame oil to the stir-fry sauce.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (10, 3, 'For a vegetarian twist, replace chicken with firm tofu cubes and marinate in teriyaki sauce before stir-frying.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 10, 'Vegetarian - remove meat.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 1, 360);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (2, 10, 'Spicy - Additional pepper sauce.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 1, 360);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 1, 'Start by boiling water and cooking pasta until al dente.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 4, 500);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 4, 'Season beef and cook until browned. Serve with tortillas and toppings.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 4, 450);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 5, 'Slowly stir broth into arborio rice for a creamy risotto.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 2, 600);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 7, 'Fry rice noodles until soft, then add sauce and protein of choice.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 3, 550);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 9, 'Marinate chicken in teriyaki sauce, then grill until fully cooked.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 3, 400);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 11, 'Simmer coconut milk with green curry paste, adding vegetables and protein as desired.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 4, 500);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 13, 'Combine miso paste with dashi broth, adding tofu and seaweed.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 2, 300);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 14, 'Stir-fry chicken with chili sauce and bell peppers.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 4, 450);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 15, 'Mix beef with broccoli in a savory stir-fry sauce.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 4, 500);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (2, 1, 'Add a pinch of basil and oregano for enhanced flavor.', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 4, 520);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (3, 1, 'Try with whole wheat pasta for a healthier alternative.', TO_DATE('2023-11-21', 'YYYY-MM-DD'), 4, 500);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (2, 4, 'Use corn tortillas and top with fresh cilantro.', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 4, 460);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (3, 4, 'Try a spicy variant with jalapeños and hot salsa.', TO_DATE('2023-11-21', 'YYYY-MM-DD'), 4, 470);

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

INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (1, 1, 2, 1, 'Great recipe! I loved it.', 5, TO_DATE('2023-10-24', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (2, 2, 2, 2, 'The added broccoli was a nice touch.', 4, TO_DATE('2023-10-25', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (3, 3, 2, 3, 'A bit too spicy for me.', 2, TO_DATE('2023-10-26', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (4, 4, 2, 1, 'Loved the healthier take on this!', 5, TO_DATE('2023-10-27', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (5, 5, 2, 2, 'The gluten-free version is excellent.', 4, TO_DATE('2023-10-28', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (6, 1, 3, 3, 'The bell peppers added great color.', 3, TO_DATE('2023-10-29', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (7, 2, 3, 1, 'Refreshing taste with the tomatoes.', 4, TO_DATE('2023-10-30', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (8, 3, 3, 2, 'Loved the tangy balsamic dressing.', 5, TO_DATE('2023-10-31', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (9, 4, 3, 3, 'Roasted nuts were a great addition.', 4, TO_DATE('2023-11-01', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (10, 5, 3, 1, 'Chicken made it more filling.', 5, TO_DATE('2023-11-02', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (11, 1, 4, 2, 'Beef was a bit overcooked.', 2, TO_DATE('2023-11-03', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (12, 1, 5, 3, 'Risotto was too salty for my taste.', 1, TO_DATE('2023-11-04', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (13, 2, 4, 1, 'Needed more seasoning.', 3, TO_DATE('2023-11-05', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (14, 2, 4, 2, 'Texture was not quite right.', 2, TO_DATE('2023-11-06', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (15, 1, 7, 3, 'Noodles were undercooked.', 1, TO_DATE('2023-11-07', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (16, 1, 9, 1, 'Chicken was dry.', 2, TO_DATE('2023-11-08', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (17, 2, 2, 2, 'Lacked flavor.', 3, TO_DATE('2023-11-09', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (18, 2, 3, 3, 'Sauce was too sweet.', 2, TO_DATE('2023-11-10', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (19, 1, 11, 1, 'Curry was too mild.', 3, TO_DATE('2023-11-11', 'YYYY-MM-DD'));
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (20, 1, 13, 2, 'Soup lacked depth in flavor.', 1, TO_DATE('2023-11-12', 'YYYY-MM-DD'));

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
