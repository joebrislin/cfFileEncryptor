component accessors="true" {
	/**
	 * @hint Directory Path to upload files to. Needs to be the absolute path. i.e. "/Library/WebServer/Documents/cfFileEncryptor/uploads"
	 */
	property name="directoryPath"; 

	property name="key";

	property name="algorithm" default="a"; // Optional Parameters for encryptBinary

	property name="IVorSalt" default="b"; // Optional Parameters for encryptBinary

	property name="iterations" default="c"; // Optional Parameters for encryptBinary

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
		variables.key = hash( application.getApplicationSettings()["name"] );

		for(var i=1; i <= arrayLen(props); ++i ){
			if( structKeyExists(config,props[i].name) ){
				_setProperty(props[i].name,arguments.config[props[i].name]);
			}
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