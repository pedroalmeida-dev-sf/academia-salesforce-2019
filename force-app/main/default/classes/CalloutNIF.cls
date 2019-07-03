public with sharing class CalloutNIF {
    @future(callout=true)
    public static void makeGetCallout(String Nif_t){//HttpResponse
        nif_pt__c cs = nif_pt__c.getOrgDefaults();
        String endpoint = cs.Endpoint__c;
        String nif = cs.nif__c;
        String chave = cs.chave__c;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //request.setEndpoint('https://www.nif.pt/?json=1&q=249610280&key=918710436c69a44134712a5a35056f31');
        request.setEndpoint(endpoint+'?json=1&q='+Nif_t+'&key='+chave);
        
        request.setMethod('GET'); 

        HttpResponse response = http.send(request);
        Boolean nifvalido = false;

        if(response.getStatusCode() == 200){
            System.debug('response '+response.getBody());
            Map<String,Object> resp = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            nifvalido = (Boolean) resp.get('is_nif');
            System.debug('nifvalido: '+nifvalido);
        }
        //return response
        //return nifvalido;
    }
}