component accessors="true" {

	/**
	 * @hint cfFileEncryptor Settings Bean
	 */
	property name="settingsBean";


	public FileEncryptor function init( Struct config={} ){
		this.setSettingsBean( new Settings( arguments.config ) );

		return this;
	}

	public struct function uploadFile( required String newFile ){
		// upload file to server and save in memory
		var _file = fileUpload( "ram://", arguments.newFile, "* ", "makeUnique" );
	
		var fileData = _file;
		// encrypt file currently stored in memory
		fileData.content = encryptFile( "ram://" & _file.serverFile );

		// TODO: write encrypted data to file

		// TODO: save encrypted file to server path (include MetaData for MIME Type, Original Filename, etc. for rendering out later)

		return fileData;
	}

	private Binary function encryptFile(required String localFile){
		// encrypt data
		var enc = {};
		enc.bytes = fileReadBinary( arguments.localFile ); // convert file to binary data
		enc.key = getSettingsBean().getKey(); // set key
		enc.algorithm = getSettingsBean().getAlgorithm(); // optional
		if( len( trim( getSettingsBean().getIVorSalt() ) ) ) enc.IVorSalt = getSettingsBean().getIVorSalt(); // optional
		if( len( trim( getSettingsBean().getIterations() ) ) ) enc.iterations = getSettingsBean().getIterations(); // optional

		// TODO: Pass ArgumentCollection to encryptBinary method to allow for multiple configurations
		//var ret = encryptBinary( argumentCollection = enc );
		var ret = encryptBinary( enc.bytes, enc.key, enc.algorithm );
		return ret;
	}

	private string function decryptFile(){
		return "";
	}
}