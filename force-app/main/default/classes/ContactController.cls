public class ContactController {
    public ContactController() {

    }

    @AuraEnabled
    public static List<Contact> contactList(){
        return [SELECT id, Name, Email FROM Contact];
    }
}
