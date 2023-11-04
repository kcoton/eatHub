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