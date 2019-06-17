trigger testingTrigger on Order (after insert, after update) {
   /*
   //Variaveis a guardar para a criacao da nova venda
   Id encomenda_id;
   Decimal quantia_encomenda;
   String id_cliente;
   String estado;
   String nome_cliente; 

   //guardar valores da encomenda para serem passados para a venda 
   for(Order o : trigger.new){
       encomenda_id = o.Id;
       quantia_encomenda = o.TotalAmount;
       id_cliente = o.AccountId;
       estado = o.Status;
       
   }

   //Guardar o nome do cliente da encomenda 
   List<Account> cliente = [SELECT Id, Name FROM Account WHERE Id = : id_cliente];
   for(Account a : cliente){
        nome_cliente = a.Name;  
   } 

   //List<Order> encomenda = [SELECT Id, TotalAmount FROM Order WHERE Order.Id = : encomenda_id];
   
   List<Venda__c> novaVenda = new List<Venda__c>();

   //se o estado da variavel status mudar para activated, criar nova venda
   if (estado == 'Activated'){
       novaVenda.add(new Venda__c(Name = 'Venda a '+nome_cliente,
                                Cliente__c = id_cliente,
                                Valor_total__c = quantia_encomenda,
                                Data_Venda__c = System.Today()
                            ));
       
   }

    //Se a lista tiver algo entao inserir venda
    if (novaVenda != null && novaVenda.size() > 0){
       insert novaVenda;
       System.System.debug('ID NOVA VENDA:'+novaVenda.get(0).id);
       Id venda_id ;
       venda_id = novaVenda.get(0).id;
    }

    */

}