public class VisualizacaoContato {
    
    public contact selectedContact{get;}
    public List<Contact> lstContactsUpdate {get; set;}
    //public List<Contact> lstContactsInsert {get; set;}
    public List<string> lstText {get; set;}
    public List<string> lstAlunos {get; set;}
    
    public string nome{
        get{
            system.debug('teste get nome');
            return 'zé';
        }
        
        set{
            if (nome == 'pilinha')
                nome = 'palavrao';
            
        }
    }
    
    public class aluno{
        public string nome {get;set;}
        public integer idade {get;set;}
        public decimal peso {get;set;}
        public date aniversario {get;set;}

    }

    
    private void VisualizacaoContato(){
        /*      opcao1
List<Contact> lstContactsInsert;
lstContactsInsert = new List<Contact>();
contact newContact = new contact(lastname = 'test');
lstContactsInsert.add(newContact);
insert lstContactsInsert;

opcao2
List<Contact> lstContactsInsert= new List<Contact>();
lstContactsInsert.add(newContact(new contact(lastname = 'test')));
insert lstContactsInsert;*/
        
        lstText = new List<string>();
        lstText.add('test contact 2');
        lstText.add('test contact 4');
        
        lstContactsUpdate = new List<Contact>();
        List<Contact> lstContactsInsert = new List<Contact>();
        
        lstContactsInsert = new List<Contact>();
        contact newContact = new contact(lastname = 'test contact');
        
        //insert lstContactsInsert;
        
        //lstContactsUpdate = [Select ID, Department FROM Contact WHERE CreatedDate = today and lastname = 'carvalhinho'];
        lstContactsUpdate = [Select ID, Department FROM Contact WHERE CreatedDate = today and lastname in : lstText];
        
        
        for(contact selectedContact:lstContactsUpdate){
            system.debug('Contact name (1) = '+selectedContact.LastName);
            if (selectedContact.Name == 'test contact')
                
                selectedContact.Department = 'Apex'; 
            system.debug('Contact name  (2) = '+selectedContact.LastName);
             
            
        }
        if(!lstContactsUpdate.isEmpty())
            update lstContactsUpdate;
        chamada();
        resposta();
    }
    
    private void chamada(){
        system.debug('alô...');
    }
    
    public void resposta(){
        system.debug('....tô xim...');
    }

    //chamar o metodo chamada num metodo publico para correr nos testes
    public void callChamada(){
        chamada();
    }
    
}