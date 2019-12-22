
Create User database 'UDB'
Execute 'UDBScript20191027.sql'
then 'UDBData20191027.sql'

create Database name 'MyDB'
execute 'MyDbScript20191027.sql'
then 'MyDbData20191027.sql'

then create view using 'Create_view_V_Hirings.sql' (find this query in views folder)

Change web config file from DB names 


Hash for 'a'=ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb

UserRoles
Add these Funactions to UserRole table in user DB allow this to user roles
Create User role and assign it to users.
add these functions inside [] 
	ex-: [MNG_VEHICLE]

MNG_VEHICLE	Manage vehicels>> Allow user to add or edit vehicle
MNG_HIRE	Manage Hirings>> Allow users to add or edit hirings
ALL_HIRES	All hires>> to view all hires including online, offline,deleted hires only for admins
USER_HIRES	User's hires only

ALL_VEHICLES	Get all vehicles