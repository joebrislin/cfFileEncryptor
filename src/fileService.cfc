component{
	public void function init( required string dirPath, required string key ){
		variables.dirPath = expandPath( arguments.dirPath ); // directory path to which encrypted files will be saved. pass relative path to init
		// check to ensure directory exists
		if( !directoryExists( variables.dirPath ) ){
			directoryCreate( variables.dirPath );
		}

		variables.key = arguments.key;
	}

	/*
	* @hint returns file path where encrypted file was saved
	*/
	public string function uploadFile(){

	}

	private string function encryptFile(){

	}
}