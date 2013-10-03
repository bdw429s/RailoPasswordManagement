component{
	property name="passwordManager" inject="passwordManager";
				
	function index(event,rc,prc){
		event.setView("main/index");
	}	
		local.action = event.getValue('action','');
	
		// Encrypt admin pass
		if(local.action == 'adminEnc') {
			rc.adminEncBlowFish = passwordManager.encryptAdministrator(event.getValue('adminPlainBlowFish',''));
		// Decrypt admin pass
		} else if(local.action == 'adminDec') {
			rc.adminPlainBlowFish = passwordManager.decryptAdministrator(event.getValue('adminEncBlowFish',''));
		// Hash admin pass				
		} else if(local.action == 'adminHash') {
			rc.adminEncHash = passwordManager.hashAdministrator(event.getValue('adminPlainHash',''));
		// Encrypt data source pass
		} else if(local.action == 'datasourceEnc') {
			rc.datasourceEncBlowFish = passwordManager.encryptDataSource(event.getValue('datasourcePlainBlowFish',''));
		// Decrypt data source pass
		} else if(local.action == 'datasourceDec') {
			rc.datasourcePlainBlowFish = passwordManager.decryptDataSource(event.getValue('datasourceEncBlowFish',''));				
		}	
		
		// re-include the same form
		runEvent("main.index");
	}	
	
}