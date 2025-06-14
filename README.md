# 🛢️ PlumJob Database Model

+ ER diagram
+ Initializing script

## How to set up local database for your project? - instructions for devs ##

### Download MySQL ###
https://www.mysql.com/
### Set up your local server, remember username and password ###
Create the database in it using the initializing script and sample data
### Initialize environmental variables referrenced in application.properties: ###
spring.datasource.url=${DB_URL} <br>
spring.datasource.username=${DB_USER} <br>
spring.datasource.password=${DB_PASSWORD} <br>
**DB_URL** is your database's URL, for example: jdbc:mysql://localhost:3306/plum <br>
**DB_USER** is your database's admin username, for example: admin <br>
**DB_PASSWORD** is your database's admin password, for example: admin1234 <br>
<br>
More on how to set up those: https://www.jetbrains.com/help/objc/add-environment-variables-and-program-arguments.html <br> <br>

TLDR: Create a file called .env in your project directory, **DO NOT ADD IT TO GIT** and add it to run configurations. <br> <br>
Contents of the .env file: <br>
DB_URL=jdbc:mysql://localhost:3306/plumjob_logintester <br>
DB_USER=admin <br>
DB_PASSWORD=admin1234 <br> <br>

This is for testing purposes only, before we set up and integrate global database. <br> **NEVER commit with real, hard coded credentials in application.properties or the .env file to the repository.** If you use git add . when committing, be sure to **exclude the .env** using git rm.

### Run the application ###
Check running logs if the set up is successful

## Major workflow update - online database ##
From now on we will be using one database deployed using AWS. The instructions regarding .env file remain the same but new credentials were sent to each developer using secure channel. Please update your .env accordingly and make sure your local cloned project is running correctly.

