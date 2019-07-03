trigger ContactTrigger on Contact (before insert, before update) {
    /* List<Contact> lstCont = new List<Contact>();
    lstCont = Trigger.new;
    Map<Id, Contact> mapContact = new Map<Id, Contact>();
    mapContact = Trigger.newMap;
    System.debug('Lista Contactos trigger New: '+lstCont);
    
    Set<Id> lstIds = new Set<Id>();
    List<Account> lstAccount = new List<Account>();
    for(Contact selCont : lstCont){
        if(!selCont.Validado__c && String.isBlank(selCont.NIF__c)){
            //CalloutNIF.makeGetCallout();
        }
        System.debug('NIF: '+selCont.NIF__c);
        lstIds.add(selCont.AccountId);

    }
    Map<Id, Account> mapAccount = new Map<Id, Account>([SELECT Id FROM Account Where Id IN: lstIds]);
    for(Contact selCont : lstCont){
        Account acc = mapAccount.get(selCont.AccountId);
        System.debug('Account: '+acc);
    } */

    for(Contact selCont : Trigger.new){
        if(!String.isBlank(selCont.NIF__c)){
            CalloutNIF.makeGetCallout(selCont.NIF__c);
        }
        
    }

}