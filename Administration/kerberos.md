## Kerberos

It is a protocol for authentication which uses tickets nd avoid sending credentials over the network.
You have a ticket which is encrypted using secret key for particular service. And the service should be within Kerberos realm.
Your ticket is refreshed when you sign on or do _knit USER_.
It takes third-party (KDC - Key Distribution Center) to authenticate between client and service.

#### Kerberos Realm

It defines what kerberos manages in terms of who can access what. It reliance on symmetric-key cryptography.
The Client, lives within this realm, as well as the service or host you want to request and KDC.
![kerberos real](https://www.evernote.com/shard/s310/sh/06b0fd03-8e51-40bc-929d-f09973ed5554/12440995b3d5d83f/res/3feadc00-b525-4f4c-bb93-61714877900e.png?resizeSmall&width=832)

When requesting access to a service or host, three interactions take place between you and:
  * the Authentication Server
  * the Ticket Granting Server
  * the Service or host machine that you’re wanting access to. 

At each interaction, two message will be recieved, one can be decrypted and one cannot.
Services we are requesting never communicate KDC. 
KDC stores all the secret keys for users and services in db.
KDC itself is encrypted with master key so other cant access the db.
There are Kerberos configurations and implementations that use public-key(asymmetric) cryptography instead of symmetrical key encryption.

#### Example

__If i want to access my wages details through HTTP__

  1. You must first authenticate yourself to Authentication Server. For instance, _logging in_ or _kinit USERNAME_.
  ![Image of authemtication](https://www.evernote.com/shard/s310/sh/06b0fd03-8e51-40bc-929d-f09973ed5554/12440995b3d5d83f/res/b5818408-9db3-44fe-b322-ce1bba95aaa7.png?resizeSmall&width=832)
  2. Authentication Server check if you are in the KDC database.
  3. Authentication Server then send two messages back, one is __TGT__ is ecrypted by TGS Secret Key & Ticket Granting Server Session Key__ is encrypted with Client Secret Key.
  4. Client Secret Key as asked to decrypt the _TGS Session Key_, which can be used to obtain TGS Session Key. One cannot decrypt TGT as we dont have TGS secret key, this will be stored in our credential cache.
  
  5. Now we use TGS session key containing your name and timestamp with unencryptd message of requested service and lifetime of the ticket, along with TGT.
  ![Image of return message](https://www.evernote.com/shard/s310/sh/06b0fd03-8e51-40bc-929d-f09973ed5554/12440995b3d5d83f/res/c4e1e4ad-1c43-4dd0-81dc-80884b59bafe.png?resizeSmall&width=832)
  6. If the service we rquested is present then, TGS decrypt the TGT sent back by us to get session key, which is used to decrypt out message.

  7. TGS sends two message, one is encrypted HTTP service ticket, and second have service ID, session key, lifetime & timestamp which is encrypted with TGS session key.
  8. Later message can be decryptrd using TGS session key cache in our system and get Service session key.

  9. To access service, our machine prepare authenticator message that contain our name and timestamp encrypted with service session key.
  ![Message to service](https://www.evernote.com/shard/s310/sh/06b0fd03-8e51-40bc-929d-f09973ed5554/12440995b3d5d83f/res/6d9e31af-d679-477e-9fd0-412dba0ba577.png?resizeSmall&width=832)
  10. Service uses its secret key to obtain its session key to decrypt the authenticator.
  11. It will compare our ID and other paramters from Ticket and authenticator.
  12. Service then sends back its authenticator using service session key and as we have that in our cache we can decrypt it. 
  ![Service to client](https://www.evernote.com/shard/s310/sh/06b0fd03-8e51-40bc-929d-f09973ed5554/12440995b3d5d83f/res/db2fa4be-88bf-488d-a927-947f7e9b8f12.png?resizeSmall&width=832)
