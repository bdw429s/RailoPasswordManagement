I am a utility for managing Railo passwords for the administrator and data sources.
Normally, you won't need me, but sometimes you need to edit the config files directly.

All you need is the passwordManager.cfc file in the model directory, but if you want you can run this entire directory as a small ColdBox LITE app that will allow you 
to punch in your passwords into a field field to have them encrypted/decrypted for you.

hashAdministrator - Use this to mimic the same SHA-256 hashing that the Railo administrator uses for server and web context passwords. You can't duplicate this
with the CFML hash() function.  
Values created by this method would go in one of the following XML files:
railo-server.xml
	In the root <railo-configuration> tag as the "pw" attribute.  Applies to the web administrator for the entire server
	In the root <railo-configuration> tag as the "default-pw" attribute.  Set's the default password for any new web contexts
railo-web.xml.cfm
	In the root <railo-configuration> tag as the "pw" attribute.  Applies to the web administrator for that context.
						
encryptAdministrator - [DEPRECATED, use hash instead] Used to encrypt a string using the BlowFish algorithm with the same salt used for the Railo administrator.  
decryptAdministrator - [DEPRECATED, use hash instead] Used to decrypt a string using the BlowFish algorithm with the same salt used for the Railo administrator.  
railo-server.xml
	In the root <railo-configuration> tag as the "password" attribute.  Applies to the web administrator for the entire server
	In the root <railo-configuration> tag as the "default-password" attribute.  Set's the default password for any new web contexts
railo-web.xml.cfm
	In the root <railo-configuration> tag as the "password" attribute.  Applies to the web administrator for that context.

encryptDataSource - Used to encrypt a string using the BlowFish algorithm with the same salt used for data source passwords in the Railo administrator.
decryptDataSource - Used to decrypt a string using the BlowFish algorithm with the same salt used for data source passwords in the Railo administrator.
Values created by this method would go in one of the following files:
railo-server.xml
	In a <data-source> tag's password attribute, preceded by the string "encrypted:"

	<data-source 
		username="root"
		name="myDS" 
		dsn="jdbc:mysql://localhost:3306/myDB" 
		class="org.gjt.mm.mysql.Driver"
		password="encrypted:3448cf390fa78e1cbb7745607a68ff6e282d60c044ad09ed" />
				  	
railo-web.xml.cfm
	In a <data-source> tag same as above
Application.cfc
	In the datasources struct like so:

	this.datasources.myDS={
		class:"org.gjt.mm.mysql.Driver",
            	connectionString:"jdbc:mysql://localhost:3306/myDB",
            	username:"root",
            	password:"encrypted:3448cf390fa78e1cbb7745607a68ff6e282d60c044ad09ed"
            		
