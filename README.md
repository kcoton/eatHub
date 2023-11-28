# EatHub
## Summary
"EatHub" is an application that will allow users to easily track their recipes and manage all aspects of the recipe creation process. The application will model recipe information, collaboration and version control, and ingredient management. The database will allow users to create, edit, clone, fork, and share, and access past versions of recipes.

## Timeline
- **10.28 - 11.01:**
  - Agree on the functionality of front end _(Eric, Justin, Kiara)_
  - Make sure everyone can access the server / db
- **11.01 - 11.03:**
  - CREATE Tables _(Eric)_
  - INSERT Tables _(Eric)_
- **11.03 - 11.06:**
  - Set up basic queries functioning through console _(Kiara)_
- **11.06 - 11.10:**
  - Set up basic HTML that shows the queries _(Justin)_
- **11.10 - 11.17:**  _Broad delegation - to be finalized closer to date._
  - **Front End**: Userfriendliness _(Justin)_
  - **Back End**: Oracle DB connects properly with Server _(Eric)_
  - **Server**: Query is functinoing across the required functions _(Kiara, Justin, Eric)_
- **11.17 - 12.01:**
  - Final debugging/testing
  - Integrate front end / back end

## Tasks for Core Functionalities
| Item | Demo | Owner | 
|-|-|-|
| [x] Insert | Insert Meal (foreign key is mealPlanID) | Eric |
| [x] Delete | Delete Recipe (cacade to delete Versions) | Eric |
| [x] Update | Update Feedback (versionID, feedbackComment, feedbackRating are non-primary keys. Foreign key is versionID) | Eric |
| [x] Selection | Select Recipe using OR for recipeCategory | Eric |
| [x] Projection | Select any columns from any table as the admin | Kiara |
| [x] Join | Join Version, Feedback, Recipe. Filter for feedbackRating > X | Kiara |
| [x] Aggregation - Group By | Group by userID, counts number of contributions in Feedback | Kiara |
| [x] Aggregation - Having | Shows recipes with # of versions > X | Justin |
| [x] Nested Aggregation | Average feedbackRating grouped by recipeName, where user age is < X | Justin |
| [] Division | Find all recipes that have specific ingredient(s) | Justin |

## Challenges
n/a

## Setup (deploy ugrad server)
- SSH into `remote.students.cs.ubc.ca`, navigate to project folder directory:
  - Run script: `sh ./remote-start.sh`
  - Note down the port number to use for next step
  - Open new terminal, run script: `sh ./scripts/mac/server-tunnel.sh`

## References:
- Sample Code from CPSC 304: 
  - https://www.students.cs.ubc.ca/~cs-304/resources/javascript-oracle-resources/node-setup.html
- CSS Sidebar: 
  - https://www.w3schools.com/howto/howto_css_sidebar_responsive.asp
