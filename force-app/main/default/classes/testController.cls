public class testController {
	
    public String myVar{get;set;}
    public integer myVarInteger{get;set;}
    
    //outra alternativa na declaracao do construtor
    public integer myVarInteger2{
        get{return 999;}
        set{myVarInteger = 0;}  
    }

    public String myVar2= 'myVar2NULL';
    
	public testController(){

		System.debug('Mensagem do system debug');
        myVarInteger = 0;
		myVar = 'VARIAVEL';

        //vai buscar o id ao url da pagina
		String sid = ApexPages.currentPage().getParameters().get('id');
		
        if(sid != null)
			myVar+= ' and ID is'+sid;
        	setMyVar2('setMyVar2');
		
	}
    
    //myVar2 fica com o valor setMyVar2
    public void setMyVar2(String myVar){
        this.myVar2 = myVar;
        
    }
    
    public String getMyVar2(){
        Cookie cookie = ApexPages.currentPage().getCookies().get('myVarInteger');
        if (cookie != null){  
            String fieldValueToBeStoredAsCookie = cookie.getValue(); 
            myVarInteger = integer.valueOf(fieldValueToBeStoredAsCookie);
            return myVarInteger+'';
        }
        else{
            return myVar2;
        }
            
    }
    
    //na visualforce page, ao carregar no botão incrementa +1 e mostra
    public String fieldValueToBeStoredAsCookie ='';
    public PageReference save(){
        integer valor = 0;
        Cookie cookie = ApexPages.currentPage().getCookies().get('myVarInteger');
        if (cookie != null) {
            String fieldValueToBeStoredAsCookie = cookie.getValue(); 
            myVarInteger = integer.valueOf(fieldValueToBeStoredAsCookie);
            System.debug('valor'+myVarInteger);
            myVarInteger+=1;
            setMyVar2('setMyVar2 '+myVarInteger);  
        }
        else{
            myVarInteger+=1;
            setMyVar2('setMyVar2 '+myVarInteger);
        }

        setCookie();

        return null;
    }

    //Setting Cookie
    public void setCookie() {
        Cookie userCookie = new Cookie('myVarInteger', string.valueOf(myVarInteger), null, 315569260, false); //Here 315569260 represents cookie expiry date = 10 years. You can set this to what ever expiry date you want. Read apex docs for more details.
        ApexPages.currentPage().setCookies(new Cookie[] {userCookie});
    }

    public PageReference contact(){

    // create case, etc.

    //PageReference pr = new PageReference('www.google.com');
    PageReference p = Page.ContactUs;
    p.setRedirect(true);
    return p;
    }

    



}