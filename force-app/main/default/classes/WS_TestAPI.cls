@RestResource(urlMapping='/opportunities')

global with sharing class WS_TestAPI{

    @httpGet
    global static ResponseMessage getOp(){
        RestRequest req = RestContext.request;
        RestResponse response = RestContext.response;

        response.addHeader('Content-Type','text/plain');
        String aid = req.params.get('id');

        ResponseMessage responseMsg = new ResponseMessage();

        String xclient = req.headers.get('teste-api');
        String xkey = req.headers.get('1E674B6AD64432F3974CF7AFC5742');
        String csclient = null;
        String cskey = null;

        try{

            APITeste__c cs = APITeste__c.getInstance();
            csclient = cs.Client__c;
            cskey = cs.Key__c;

        }catch(Exception e){

            response.statusCode = 500;
            responseMsg.setCode(-11);
            responseMsg.setMessage('Error:'+e.getMessage());
            return responseMsg;

        }
        if (xclient == null || xkey == null || xclient != csclient || xkey != cskey){
            response.statusCode = 401;
            responseMsg.setCode(-11);
            responseMsg.setMessage('Bad credentials');
            return responseMsg;
        }

        if(aid == null || aid !=''){
            response.statusCode = 401;
            responseMsg.setCode(-3);
            responseMsg.setMessage('Missing Mandatory fields');
            return responseMsg;
        }
        

        try{
            List<Opportunity> op_List = [Select Id, Amount, ExpectedRevenue 
                                        from Opportunity 
                                        where AccountId = :aid];
            if(op_List.isEmpty()){
                response.statusCode = 404;
                responseMsg.setCode(-5);
                responseMsg.setMessage('No results found');
                responseMsg.setBody(op_List);
                return responseMsg;
            }
            else{
                response.statusCode = 200;
                responseMsg.setCode(0);
                responseMsg.setMessage('Success');
                responseMsg.setBody(op_List);
                return responseMsg;
            }
        }
        catch(Exception e){
            response.statusCode = 404;
            responseMsg.setCode(-5);
            responseMsg.setMessage('No results found');
            return responseMsg;
        }
        
    }

    global class Op{
        String name{get;set;}
        Integer orderNumber{get;set;}
        Decimal amount{get;set;}
    }

    global class ResponseMessage{

        Integer code = 0;
        String message;
        List<ErrorMessage> ErrorList = new List<ErrorMessage>();
        List<Opportunity> op;

    public ResponseMessage(){}

        public void setCode(integer code){
            this.code = code;
        }

        public void setMessage(String message){
            this.message = message;
        }

        public void setBody(List<Opportunity> o){
            this.op = o;
        }

        public void addError(String message){
            ErrorList.add(new ErrorMessage(message));
        }
    }

    global class ErrorMessage{
        
        String Message;

        public ErrorMessage(string message){
            this.Message = message;
        }
    }
}