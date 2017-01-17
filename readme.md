# Lucee/Railo Password Manager

I am a utility for managing Lucee or Railo passwords for the administrator and data sources.

All you need is the `passwordManager.cfc` file in the model directory, but if you want you can run this entire directory as a small ColdBox LITE app that will allow you 

# hashAdministrator()
Use this to mimic the same SHA-256 hashing that the Lucee or Railo administrator uses for server and web context passwords. You can't duplicate this with the CFML hash() function.  

* *lucee-server.xml*
 * In the root `<lucee-configuration>` tag as the `pw` attribute.  Applies to the web administrator for the entire server
 * In the root `<lucee-configuration>` tag as the `default-pw` attribute.  Set's the default password for any new web contexts
 * In the root `<lucee-configuration>` tag as the `salt` attribute.  Set's the salt to be used for any hashed passwords
* *lucee-web.xml.cfm*
 * In the root `<lucee-configuration>` tag as the `pw` attribute.  Applies to the web administrator for that context.
 * In the root `<lucee-configuration>` tag as the `salt` attribute.  Set's the salt to be used for any hashed passwords

```xml
<cfLuceeConfiguration hspw="eb93137093b23f3230657d1f8cad7bfe0c00975805fb017f608448bbda3f33a0" salt="4BD328D9-9471-49FE-BFCC96C8C1949BEC">
```
 
# encryptAdministrator() / decryptAdministrator()
*[DEPRECATED, use hash instead]* Used to encrypt a string using the BlowFish algorithm with the same salt used for the Lucee or Railo administrator.  

* *lucee-server.xml*
 * In the root `<lucee-configuration>` tag as the `password` attribute.  Applies to the web administrator for the entire server
 * In the root `<lucee-configuration>` tag as the `default-password` attribute.  Set's the default password for any new web contexts
* *lucee-web.xml.cfm*
 * In the root `<lucee-configuration>` tag as the `password` attribute.  Applies to the web administrator for that context.

```xml
<cfLuceeConfiguration password="e38a144b46552ecf4e9ffb40bfe1217bffe8c19676959800f02e78ddc6c7d372">
```

# encryptDataSource() / decryptDataSource()
Used to decrypt a string using the BlowFish algorithm with the same salt used for data source passwords in the Lucee or Railo administrator.

Values created by this method would go in one of the following files:

* *lucee-server.xml*
 * In a `<data-source>` tag's `password` attribute, preceded by the string `encrypted:`

```xml
<data-source 
	username="root"
	name="myDS" 
	dsn="jdbc:mysql://localhost:3306/myDB" 
	class="org.gjt.mm.mysql.Driver"
	password="encrypted:3448cf390fa78e1cbb7745607a68ff6e282d60c044ad09ed" />
```
			  	
* *lucee-web.xml.cfm*
 * In a `<data-source>` tag same as above
* *Application.cfc*
 * In the datasources struct like so:
 
```js
this.datasources.myDS={
	class:"org.gjt.mm.mysql.Driver",
	connectionString:"jdbc:mysql://localhost:3306/myDB",
	username:"root",
	password:"encrypted:3448cf390fa78e1cbb7745607a68ff6e282d60c044ad09ed"
```        

# mail server passwords

Mail server passwords use the same scheme as data source passwords.  You can encrypt and decrypt them with the `encryptDataSource()` and `decryptDataSource()` methods.


```xml
<server
	idle="10000"
	life="60000"
	password="encrypted:1593a32df0e867fbdb72401d9e6b551f1b06d3a58b14f6258295b757da9aadd2"
	port="587"
	smtp="smtp.server.com"
	ssl="false"
	tls="false"
	username="brad" />
```
