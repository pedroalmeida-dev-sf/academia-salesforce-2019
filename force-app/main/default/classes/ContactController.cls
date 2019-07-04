public class ContactController {
    public ContactController() {

    }

    @AuraEnabled
    public static List<Contact> contactList(){
        return [SELECT id, Name, Email FROM Contact];
    }

    @AuraEnabled
    public static Contact createNewContact(String firstName, String lastName, String email){
        System.debug('firstname: '+firstName);
        System.debug('lastName: '+lastName);
        System.debug('email: '+email);
        
        Contact c = new Contact();
        c.firstName = firstName;
        c.lastName = lastName;
        c.email = email;
        insert c;
        System.debug('contacto inserido: '+c);
        return c;
    }

}
