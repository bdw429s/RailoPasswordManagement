/*
	I am a utility for managing Lucee or Railo passwords for the administrator and data sources.
	Normally, you won't need me, but sometimes you need to edit the config files directly.
*/
component {

        // Salts from the Lucee or Railo java source
        variables.administratorSalt = 'tpwisgh';
        variables.dataSourceSalt = 'sdfsdfs';

        // Administrator passwords (server and web)
        
		// Use this for pw and default-pw.
        public string function hashAdministrator(required string pass, string salt='') {

				// If this is a salted hash, append the salt
				if( len( arguments.salt) ) {
					arguments.pass &= ':' & arguments.salt;
				}
				
                MessageDigest = createObject('java','java.security.MessageDigest');

                for(i=1; i<=5; i++) {
                        md = MessageDigest.getInstance('SHA-256');
                        md.update(pass.getBytes('UTF-8'));
                        pass = enc(md.digest());
                }
                return pass;
        }
        
        // This is deprecated. Use hasAdminstrator instead.
        public string function encryptAdministrator(required string pass) {
                return _encrypt(arguments.pass,variables.administratorSalt);
        }

        // This is deprecated. 
        public string function decryptAdministrator(required string pass) {
                return _decrypt(arguments.pass,variables.administratorSalt);
        }

        // Data source passwords
        public string function encryptDataSource(required string pass) {
                return _encrypt(arguments.pass,variables.dataSourceSalt);
        }

        public string function decryptDataSource(required string pass) {
                return _decrypt(arguments.pass,variables.dataSourceSalt);
        }

		// **************************************************************************************************************
        // Internal private methods
		// **************************************************************************************************************
		
        private string function _encrypt(required string pass, required string salt) {
                var cypher = createobject("java", "lucee.runtime.crypt.BlowfishEasy").init(arguments.salt);
                return cypher.encryptString(arguments.pass);
        }

        private string function _decrypt(required string pass, required string salt) {
                var cypher = createobject("java", "lucee.runtime.crypt.BlowfishEasy").init(arguments.salt);
                return cypher.decryptString(arguments.pass);
        }
        
		// Encode a string as lowercase hex
        private string function enc(strArr) {
                //local.strArr = str.getBytes('UTF-8');
                local.hex = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'];

                savecontent variable="local.out" {
                        for (local.item in strArr) {
                                writeOutput(hex[bitshrn(bitAnd(240,local.item),4)+1]);
                                writeOutput(hex[bitAnd(15,local.item)+1]);
                        }
                };
                return local.out;
        }


}


