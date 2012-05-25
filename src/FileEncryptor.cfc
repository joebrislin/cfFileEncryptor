component accessors="true" {

	/**
	 * @hint cfFileEncryptor Settings Bean
	 */
	property name="settingsBean";


	public FileEncryptor function init( Struct config={} ){
		this.setSettingsBean( new Settings( arguments.config ) );

		return this;
	}

	public struct function uploadFile(){

		return {};
	}

	private string function encryptFile(){

		return "";
	}
}