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
	PRIMARY KEY (feedbackID, userID),
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
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 6, 'Prepare sushi rice and roll with your favorite fillings.', '2023-11-19', 4, 300);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 8, 'Fry kimchi and rice together, then add a fried egg on top.', '2023-11-19', 2, 450);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 12, 'Steam a variety of dim sum in a bamboo steamer.', '2023-11-19', 4, 500);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 16, 'Mix chocolate, butter, and sugar for the fudge base.', '2023-11-19', 8, 600);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 17, 'Prepare the pie crust and fill with spiced apple mixture.', '2023-11-19', 8, 450);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 18, 'Blend cream cheese and sugar, then bake over a graham cracker crust.', '2023-11-19', 10, 500);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 19, 'Layer coffee-soaked ladyfingers with mascarpone cream.', '2023-11-19', 6, 550);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 20, 'Prepare a tangy lemon curd and fill a prebaked tart shell.', '2023-11-19', 8, 450);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 21, 'Grill salmon fillets and serve with a lemon butter sauce.', '2023-11-19', 4, 400);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 22, 'Sauté shrimp in garlic butter and serve over pasta.', '2023-11-19', 4, 500);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 23, 'Assemble fish tacos with cabbage slaw and a creamy sauce.', '2023-11-19', 4, 350);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 24, 'Simmer lobster shells in a rich and creamy broth.', '2023-11-19', 4, 550);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 25, 'Combine crab meat with spices and fry until golden.', '2023-11-19', 4, 400);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 26, 'Stir-fry a mix of fresh vegetables with soy sauce and garlic.', '2023-11-19', 4, 250);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 27, 'Cook mushrooms and onions in a creamy sauce, then mix with pasta.', '2023-11-19', 4, 600);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 28, 'Layer fried eggplant with marinara sauce and cheese, then bake.', '2023-11-19', 6, 550);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 29, 'Grill veggie patties and serve on buns with your choice of toppings.', '2023-11-19', 4, 350);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 30, 'Layer lasagna sheets with spinach, ricotta, and tomato sauce.', '2023-11-19', 6, 700);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 31, 'Wrap chicken and cheese in tortillas and bake with enchilada sauce.', '2023-11-19', 4, 550);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 32, 'Toss romaine lettuce with Caesar dressing, croutons, and Parmesan.', '2023-11-19', 4, 300);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 33, 'Combine tomatoes, cucumbers, olives, and feta for a Greek salad.', '2023-11-19', 4, 250);
INSERT INTO Version (versionID, recipeID, instructions, versionDate, versionServing, calories) VALUES (1, 34, 'Mix cooked quinoa with vegetables and a lemon vinaigrette.', '2023-11-19', 4, 350);

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
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (21, 1, 1, 1, 'Really enjoyed the flavors in this dish.', 4, '2023-01-15');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (22, 1, 5, 1, 'Mushroom Risotto was a bit bland for my taste.', 2, '2023-02-10');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (23, 1, 6, 1, 'Sushi Rolls were perfect, just like at a restaurant!', 5, '2023-03-21');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (24, 1, 7, 1, 'Pad Thai was too spicy for me.', 1, '2023-04-05');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (25, 1, 8, 1, 'Kimchi Fried Rice lacked flavor.', 2, '2023-05-18');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (26, 1, 10, 1, 'Bibimbap was just amazing! Will make it again.', 5, '2023-06-22');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (27, 1, 12, 1, 'Dim Sum Platter was good, but not exceptional.', 3, '2023-07-30');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (28, 1, 13, 1, 'Miso Soup was too salty.', 2, '2023-08-15');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (29, 1, 14, 1, 'Chilli Chicken had a great balance of spices.', 4, '2023-09-07');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (30, 1, 15, 1, 'Beef and Broccoli Stir-Fry lacked seasoning.', 2, '2023-10-12');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (31, 1, 16, 1, 'Chocolate Fudge Cake was absolutely delicious.', 5, '2023-11-02');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (32, 1, 17, 1, 'Apple Pie crust was too hard.', 1, '2023-12-20');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (33, 1, 18, 1, 'Cheesecake was creamy and just perfect.', 5, '2023-02-28');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (34, 1, 19, 1, 'Tiramisu lacked the coffee flavor I was expecting.', 3, '2023-04-14');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (35, 1, 20, 1, 'Lemon Tart was too sour for my liking.', 2, '2023-05-06');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (36, 1, 21, 1, 'Grilled Salmon was cooked to perfection.', 4, '2023-06-19');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (37, 1, 22, 1, 'Shrimp Scampi was a bit too greasy.', 2, '2023-07-12');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (38, 1, 23, 1, 'Fish Tacos were okay, nothing special.', 3, '2023-08-23');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (39, 1, 24, 1, 'Lobster Bisque had a fantastic depth of flavor.', 5, '2023-09-17');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (40, 1, 25, 1, 'Crab Cakes fell apart while cooking.', 2, '2023-10-29');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (41, 1, 26, 1, 'Vegetable Stir-Fry was surprisingly good.', 4, '2023-11-11');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (42, 1, 27, 1, 'Mushroom Stroganoff needed more seasoning.', 3, '2023-01-22');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (43, 1, 28, 1, 'Eggplant Parmesan was a hit in my family.', 5, '2023-03-05');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (44, 1, 29, 1, 'Veggie Burger lacked flavor.', 1, '2023-04-18');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (45, 1, 30, 1, 'Spinach and Ricotta Lasagna was just okay.', 3, '2023-06-08');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (46, 1, 31, 1, 'Chicken Enchiladas were too dry.', 2, '2023-07-21');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (47, 1, 32, 1, 'Caesar Salad dressing was spot on.', 4, '2023-08-30');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (48, 1, 33, 1, 'Greek Salad was fresh and tasty.', 4, '2023-09-25');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (49, 1, 34, 1, 'Quinoa Salad lacked a punch of flavor.', 2, '2023-10-15');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (50, 1, 1, 2, 'Too salty.', 2, '2023-01-07');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (51, 1, 5, 2, 'Loved it.', 5, '2023-02-13');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (52, 1, 6, 2, 'Not my taste.', 1, '2023-03-22');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (53, 1, 7, 2, 'Delightful!', 4, '2023-04-18');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (54, 1, 8, 2, 'Just okay.', 3, '2023-05-25');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (55, 1, 9, 2, 'Amazing flavor!', 5, '2023-06-09');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (56, 1, 10, 2, 'Bit bland.', 2, '2023-07-14');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (57, 1, 11, 2, 'Too spicy.', 1, '2023-08-06');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (58, 1, 12, 2, 'Really good.', 4, '2023-09-10');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (59, 1, 13, 2, 'Lacks flavor.', 2, '2023-10-03');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (60, 1, 14, 2, 'Perfect!', 5, '2023-11-11');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (61, 1, 15, 2, 'Too greasy.', 2, '2023-12-15');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (62, 1, 16, 2, 'Yummy!', 5, '2023-01-28');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (63, 1, 17, 2, 'Undercooked.', 1, '2023-02-19');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (64, 1, 18, 2, 'Great texture.', 4, '2023-03-21');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (65, 1, 19, 2, 'Needs more coffee.', 3, '2023-04-12');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (66, 1, 20, 2, 'Too tart.', 2, '2023-05-17');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (67, 1, 21, 2, 'Well cooked.', 4, '2023-06-23');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (68, 1, 22, 2, 'Lacking seasoning.', 2, '2023-07-29');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (69, 1, 23, 2, 'Fair enough.', 3, '2023-08-15');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (70, 1, 24, 2, 'Rich and creamy.', 5, '2023-09-18');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (71, 1, 25, 2, 'Not fresh.', 1, '2023-10-21');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (72, 1, 26, 2, 'Quite good.', 4, '2023-11-07');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (73, 1, 27, 2, 'Mushy texture.', 2, '2023-12-09');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (74, 1, 28, 2, 'Delicious!', 5, '2023-01-15');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (75, 1, 29, 2, 'Very dry.', 1, '2023-02-22');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (76, 1, 30, 2, 'Not bad.', 3, '2023-03-18');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (77, 1, 31, 2, 'Overcooked.', 2, '2023-04-20');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (78, 1, 32, 2, 'Enjoyed it.', 4, '2023-05-28');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (79, 1, 33, 2, 'Too plain.', 2, '2023-06-16');
INSERT INTO Feedback (feedbackID, versionID, recipeID, userID, feedbackComment, feedbackRating, feedbackDate) VALUES (80, 1, 34, 2, 'Fresh and tasty.', 4, '2023-07-24');


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
