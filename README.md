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
| Insert | Insert Feedback (foreign key is versionID) | Eric |
| Delete | Delete Recipe (cacade to delete Versions) | Eric |
| Update | Modify Feedback (date/time are 2 non-primary keys. Will have a "versionID" to choose as foreign key) | Eric |
| Selection | Query Versions' by calories / name / categories | Eric |
| Projection | | Kiara |
| Join | Version/Feedback versions with at least 1 feedback | Kiara |
| Aggregation - Group By | Count of feedback / versions by users | Kiara |
| Aggregation - Having | Versions of any recipes having rating > certain score | Justin |
| Nested Aggregation | | Justin |
| Division | Find all recipes that have specific ingredient(s) | Justin |

## Challenges
n/a

## Setup (deploy ugrad server)
- Navigate to project folder directory
  - Run script: `sh ./remote-start.sh`
  - Note down the port number to use for next step
  - Open new terminal, run script: `sh ./scripts/mac/server-tunnel.sh`