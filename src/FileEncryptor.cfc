component accessors="true" {

	/**
	 * @hint cfFileEncryptor Settings Bean
	 */
	property name="settingsBean";


	public FileEncryptor function init( Struct config={} ){
		this.setSettingsBean( new Settings( arguments.config ) );

		return this;
	}

	public String function uploadFile( required String fileField, String acceptTypes = arrayToList( getSettingsBean().getAllowableExtensions() ) ){
		// upload file to server and save in memory
		var _file = fileUpload( destination="ram://", fileField=arguments.fileField, nameConflict="makeUnique" );
		var _serverFile = "ram://" & _file.serverFile;

		// check file for acceptable mime type
		var _fileMimeType = getPageContext().getServletContext().getMimeType(_serverFile);
		if( !isDefined("_fileMimeType") || listFindNoCase( arguments.acceptTypes, _fileMimeType ) lte 0 ){
			// Cleanup File Memory - remove from RAM
			fileDelete( _serverFile );
			throw(message="The MIME type of the uploaded file was not accepted by the server",detail="The file type uploaded to the server was not an acceptable MIME type.");
		}

		var fileData = {};
		// encrypt file currently stored in memory
		fileData.content = encryptFile( _serverFile );
		fileData.mimeType = _file.contentType & "/" & _file.contentSubType;
		fileData.fileName = _file.clientFile;

		// write encrypted data to file
		var newFile = getUniqueFileName();
		fileWrite( newFile, serializeJSON(fileData) );

		// Cleanup File Memory - remove from RAM
		fileDelete( _serverFile );

		return newFile;
	}

	public Struct function readFile( required String filePath ){
		var _file = DeserializeJSON( fileRead( arguments.filePath ) );
		_file.content = decryptFile( _file.content );

		return _file;
	}

	private Binary function decryptFile( required String fileContent ){
		try{
			return binaryDecode( arguments.fileContent, getSettingsBean().getBinaryEncoding());
		}catch(Any e){
			throw(type="cfFileEncryptor.error.FileDecryptionError", message=e.detail);
		}
	}

	private String function encryptFile(required String localFile){
		try{
			// encrypt data
			var _bytes = fileReadBinary( arguments.localFile ); // convert file to binary data
			return BinaryEncode( _bytes, getSettingsBean().getBinaryEncoding() );
		}catch(Any e){
			throw(type="cfFileEncryptor.error.FileEncryptionError", message=e.detail);
		}
	}

	private String function getUniqueFileName(){
		var _fileName = this.getSettingsBean().getDirectoryPath() & "/" & createUUID();
		
		// check to see if file name previously exists
		if( fileExists( _fileName ) ){
			_fileName = getUniqueFileName(); // recursively try until unique file name is found
		}

		return _fileName;
	}
}