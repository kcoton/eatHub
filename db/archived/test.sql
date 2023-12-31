-- DROP
DROP TABLE UserInfo CASCADE CONSTRAINTS;
DROP TABLE UserAge CASCADE CONSTRAINTS;
DROP TABLE UserBMI CASCADE CONSTRAINTS;
DROP TABLE Recipe CASCADE CONSTRAINTS;
DROP TABLE Version CASCADE CONSTRAINTS;
DROP TABLE MealPlan CASCADE CONSTRAINTS;
DROP TABLE Meal CASCADE CONSTRAINTS;
DROP TABLE GroceryList CASCADE CONSTRAINTS;
DROP TABLE Ingredient CASCADE CONSTRAINTS;
DROP TABLE Comments CASCADE CONSTRAINTS;
DROP TABLE Rating CASCADE CONSTRAINTS;
DROP TABLE Contains CASCADE CONSTRAINTS;
DROP TABLE Uses CASCADE CONSTRAINTS;
DROP TABLE References CASCADE CONSTRAINTS;

-- CREATE
CREATE TABLE UserInfo (
	userID	    INTEGER,
	email	    VARCHAR(30)	NOT NULL UNIQUE,
	name		VARCHAR(30)	NOT NULL,
	birthday	DATE,
	weight	    INTEGER,
	height	    INTEGER,
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
	recipeID		INTEGER,
	versionID		INTEGER,
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

CREATE TABLE Comments (
	feedbackID	    INTEGER,
    userID		    INTEGER	NOT NULL,
    feedbackDate	DATE,
    feedbackTime	TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    feedbackText	VARCHAR(400),
	PRIMARY KEY     (feedbackID),
    FOREIGN KEY (userID)
		REFERENCES UserInfo(userID)
        ON DELETE CASCADE
);

CREATE TABLE Rating (
	feedbackID	    INTEGER,
    userID		    INTEGER,
    feedbackDate	DATE,
    feedbackTime	TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    feedbackNumber	INTEGER	NOT NULL,
	PRIMARY KEY     (feedbackID),
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

-- INSERT EXAMPLES
INSERT INTO UserInfo (userID, email, name, birthday, weight, height) VALUES (1, 'tony.stark@gmail.com', 'Tony Stark', TO_DATE('1980-02-28', 'YYYY-MM-DD'), 220, 190);
INSERT INTO UserInfo (userID, email, name, birthday, weight, height) VALUES (2, 'diana.prince@gmail.com', 'Diana Prince', TO_DATE('1985-10-25', 'YYYY-MM-DD'), 150, 180);
INSERT INTO UserInfo (userID, email, name, birthday, weight, height) VALUES (3, 'bruce.wayne@gmail.com', 'Bruce Wayne', TO_DATE('1975-03-30', 'YYYY-MM-DD'), 180, 188);
INSERT INTO UserInfo (userID, email, name, birthday, weight, height) VALUES (4, 'peter.parker@gmail.com', 'Peter Parker', TO_DATE('1995-08-15', 'YYYY-MM-DD'), 167, 178);
INSERT INTO UserInfo (userID, email, name, birthday, weight, height) VALUES (5, 'miles.morales@gmail.com', 'Miles Morales', TO_DATE('2001-11-12', 'YYYY-MM-DD'), 160, 175);

INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1980-02-28', 'YYYY-MM-DD'), 53);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1985-10-25', 'YYYY-MM-DD'), 38);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1975-03-30', 'YYYY-MM-DD'), 48);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('1995-08-15', 'YYYY-MM-DD'), 28);
INSERT INTO UserAge (birthday, age) VALUES (TO_DATE('2001-11-12', 'YYYY-MM-DD'), 22);

INSERT INTO UserBMI (weight, height, BMI) VALUES (220, 190, 24);
INSERT INTO UserBMI (weight, height, BMI) VALUES (150, 180, 21);
INSERT INTO UserBMI (weight, height, BMI) VALUES (180, 188, 27);
INSERT INTO UserBMI (weight, height, BMI) VALUES (167, 178, 24);
INSERT INTO UserBMI (weight, height, BMI) VALUES (160, 175, 25);

INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (1, 'Spaghetti Bolognese', 'Pasta');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (2, 'Chicken Stir-Fry', 'Asian');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (3, 'Caprese Salad', 'Salad');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (4, 'Beef Tacos', 'Mexican');
INSERT INTO Recipe (recipeID, recipeName, recipeCategory) VALUES (5, 'Mushroom Risotto', 'Italian');

INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 1, 'Heat oil in a wok. Add chicken and stir-fry for 5 minutes. Add vegetables and sauce. Stir-fry for an additional 3 minutes.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 350);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 2, 'Marinate chicken in soy sauce and garlic for 30 minutes before stir-frying. Add broccoli and peppers for added flavor.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 370);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 3, 'For a spicier version, add chili flakes and ginger while stir-frying the chicken. Serve with steamed rice.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 400);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 4, 'Use low-sodium soy sauce and olive oil for a healthier option. Include sliced carrots and snap peas for added crunch.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 330);
INSERT INTO Version (recipeID, versionID, instructions, versionDate, versionServing, calories) VALUES (2, 5, 'Make it gluten-free by using tamari sauce. Add water chestnuts and baby corn for a unique twist.', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 360);

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

INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackText) VALUES (1, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_TIMESTAMP('14:30:00', 'HH24:MI:SS'), 'Great recipe! I loved it.');
INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackText) VALUES (2, 1, TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_TIMESTAMP('09:45:00', 'HH24:MI:SS'), 'This meal plan is fantastic.');
INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackText) VALUES (3, 1, TO_DATE('2023-10-22', 'YYYY-MM-DD'), TO_TIMESTAMP('18:15:00', 'HH24:MI:SS'), 'It tasted kind of bland.');
INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackText) VALUES (4, 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_TIMESTAMP('12:20:00', 'HH24:MI:SS'), 'The grocery list was very helpful.');
INSERT INTO Comments (feedbackID, userID, feedbackDate, feedbackTime, feedbackText) VALUES (5, 1, TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_TIMESTAMP('15:55:00', 'HH24:MI:SS'), 'The Chicken Stir-Fry was amazing.');

INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackNumber) VALUES (6, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_TIMESTAMP('14:30:00', 'HH24:MI:SS'), 5);
INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackNumber) VALUES (7, 2, TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_TIMESTAMP('09:45:00', 'HH24:MI:SS'), 4);
INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackNumber) VALUES (8, 1, TO_DATE('2023-10-22', 'YYYY-MM-DD'), TO_TIMESTAMP('18:15:00', 'HH24:MI:SS'), 3);
INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackNumber) VALUES (9, 2, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_TIMESTAMP('12:20:00', 'HH24:MI:SS'), 4);
INSERT INTO Rating (feedbackID, userID, feedbackDate, feedbackTime, feedbackNumber) VALUES (10, 1, TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_TIMESTAMP('15:55:00', 'HH24:MI:SS'), 5);

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