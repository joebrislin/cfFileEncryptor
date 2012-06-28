This Library is designed to encrypt files being uploaded for server storage to enhance security. File Content, mime type, and original name are saved as serialized json within the actual file stored on the server. The library will handle all encryption/decryption of the file data. There are also attributes to handle specific mime types allowed for upload as well as encryption algorithms.  
  
#### Sample Code
var _file = variables.fileEncryptorService.uploadFile( "documentFile" );  
rc.fileData = variables.fileEncryptorService.readFile( _file.getDocumentFile() );  