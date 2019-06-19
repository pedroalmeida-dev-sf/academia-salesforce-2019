@RestResource(urlMapping='/ContactDemo/*')
global without sharing class RESTContact {


    @httpGet
    global static ResponseMsg getContact(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Contact c = new Contact();

        ResponseMsg rspMsg = new ResponseMsg();

        try{
            rspMsg.c = [SELECT Id, Name, Email 
                        FROM Contact 
                        WHERE Id =: contactId];
            
            rspMsg.message = 'Sucesso';
        }
        catch(Exception e){
            response.statusCode = 404;
            rspMsg.message = 'Erro: Id não existe - '+e.getMessage()+' line: '+e.getLineNumber()+' Cause: '+e.getCause();
        }

        //return c;
        return rspMsg;
    }

    global class ResponseMsg{
       public String message;
       public Contact c;

       global ResponseMsg(){
           c= null;
           message = '';
       }
    }

    @httpPost
    global static Contact createContact(String name, String email, String AccountName){
       
        Account newAcc = new Account();
        Account acc = null;
        Contact c = new Contact();
        

        try{
            acc = [SELECT Id FROM Account WHERE Name =: AccountName LIMIT 1];
           
        }
        catch(DMLException e){

            acc.Name = name;
            insert acc;
            
        }
        catch(Exception e){
            return null;
        }
        c.LastName = name;
        c.Email = email;
        c.AccountId = acc.Id;
        insert c;

        return c;
    }
    
}
