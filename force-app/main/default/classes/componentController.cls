public class componentController {
	


@AuraEnabled
public static List<Contact> getContacts(String accountId){
    if (accountId != null){
        return [SELECT Name FROM Contact WHERE accountId = :accountId];
    }else{
        return [SELECT Name FROM Contact];
    }
}

@AuraEnabled
public static List<Account> getAccounts(String accountId){
    return [SELECT Name FROM Account];
}
}