public class exemploCallouts {

//significa que este metodo vai ser lancado no futuro
@future(callout = true)
    public static void getCustomer(String numberAccount) {
        if ( numberAccount != null && numberAccount != '' ){
            
            //userData response = new userData();

            string endPoint = 'https://unuat-directel.cs87.force.com/services/apexrest/getCustomerDetail/'+numberAccount;       
            // -----------> make request
            HttpRequest req = new HttpRequest();
            Http http = new Http();
            HttpResponse res;

            try {
                //Blob headerValue = Blob.valueOf(yapilySettings.application_uuid__c + ':' + yapilySettings.application_secret__c);
                //String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
                System.debug('endPoint: ' + endPoint);
                //System.debug('Header: ' + authorizationHeader);
                req.setEndpoint(endPoint);
                req.setMethod('GET');            
                //req.setHeader('Authorization', authorizationHeader);
                req.setHeader('Content-Type', 'application/json');
                req.setHeader('token','D52xAWXkYR4PjYp01GBuXE/YfFhddgFGcr58Q8Z5cmo=');
                //req.setbody('{"appUserId": "' + appUserId + '"}');
                req.setTimeout(30 * 1000); // 30 seconds
                res = http.send(req);
                system.debug('response::'+res.getBody());
            } catch (Exception e) {
                System.debug(LoggingLevel.ERROR, e.getStackTraceString() + ': ' + e.getMessage());
            }

            // -----------> parse response
            if ( res.getStatusCode() == 201 ) {
               /* try {
                    String responseBody = res.getBody();
                    system.debug('antes conversão');
                    JSONParser parser = JSON.createParser(responseBody);
                    userData receivedUser = (userData)parser.readValueAs(userData.class);
                    System.debug('receivedUser : '+receivedUser); 
                } catch (Exception e) {
                    System.debug(LoggingLevel.ERROR, e.getStackTraceString() + ': ' + e.getMessage());
                }*/
            } else {
                System.debug('ERROR: createUserData - Status ' + res.getStatusCode() + ' : ' + res.getStatus() ); 
            }
            // return response;
        } else {
             System.debug('ERROR: tem que definir o número de conta!'); 
        }
    }


}