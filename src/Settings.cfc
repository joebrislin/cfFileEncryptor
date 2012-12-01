component accessors="true" {
	/**
	 * @hint Directory Path to upload files to. Needs to be the absolute path. i.e. "/Library/WebServer/Documents/cfFileEncryptor/uploads"
	 */
	property name="directoryPath"; 

	property name="binaryEncoding";

	property name="allowableExtensions";

	/**
	 * The constructor dynamically handles setting any params passed
	 * in the config struct. If the parameter is not passed into the
	 * constructor we will use the property default upon instantation
	 * 
	 * NOTE: Courtesy of Dan Vega and the Hyrule Validation Framework
	 */
	public Settings function init(Struct config){
		var props = getMetaData(this).properties;

		variables.directoryPath = expandPath("./uploads");
		variables.binaryEncoding = "Base64";
		variables.allowableExtensions = [
			"image/bmp",
			"image/x-windows-bmp",
			"image/gif",
			"image/jpeg",
			"image/pjpeg",
			"image/x-portable-bitmap",
			"image/pict",
			"image/png",
			"image/tiff",
			"image/x-tiff",
			"application/pdf",
			"application/x-real",
			"application/vnd.adobe.xfdf",
			"application/vnd.fdf",
			"application/x-pdf",
			"application/download",
			"application/x-download",
			"application/postscript",
			"application/msword",
			"application/vnd.ms-word",
			"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
			"application/vnd.ms-excel",
			"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
			"application/vnd.openxmlformats-officedocument.spreadsheetml.template",
			"application/vnd.ms-excel.sheet.macroEnabled.12",
			"application/vnd.ms-excel.template.macroEnabled.12",
			"application/vnd.ms-powerpoint",
			"application/vnd.openxmlformats-officedocument.presentationml.presentation",
			"application/vnd.openxmlformats-officedocument.presentationml.template",
			"application/vnd.openxmlformats-officedocument.presentationml.slideshow",
			"text/plain",
			"text/csv",
			"application/rtf"
		];

		/*
		A string that specifies the encoding method to use to represent the data; one of the following:

		Hex: use the characters 0-9 and A-F to represent the hexadecimal value of each byte; for example, 3A.
		UU: use the UNIX UUencode algorithm to convert the data.
		Base64: use the Base64 algorithm to convert the data, as specified by IETF RFC 2045, at www.ietf.org/rfc/rfc2045.txt.
		*/

		for(var i=1; i <= arrayLen(props); ++i ){
			if( structKeyExists(config,props[i].name) ){
				_setProperty(props[i].name,arguments.config[props[i].name]);
			}
		}

		// create directory if it does not exist
		if( !directoryExists( this.getDirectoryPath() ) ){
			directoryCreate( this.getDirectoryPath() );
		}

		return this;
	}

	/**
	 * Dynamic setter
	 */
	private void function _setProperty(required any name, any value){
		local.theMethod = this["set" & arguments.name];

		if (isNull(arguments.value)) {
			theMethod(javacast('NULL', ''));
		} else {
			theMethod(arguments.value);
		}
	}

	/**
	 * Dynamic getter
	 */
	private string function _getProperty(required any name){
		return evaluate("get#arguments.name#()");
	}
}