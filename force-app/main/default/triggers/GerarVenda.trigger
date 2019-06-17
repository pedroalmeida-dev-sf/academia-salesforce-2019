trigger GerarVenda on Order (after insert, after update) {
//gerar uma venda, quando uma encomenda muda o status para activada, gera a venda com os dados da encomenda, se a encomenda sofrer alteracoes, a venda e alterada tambem


   //Variaveis a guardar para a criacao da nova venda
   Id encomenda_id;
   Decimal quantia_encomenda;
   String id_cliente;
   String estado;
   String nome_cliente; 
   ID vendaexiste;

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

   //lista para ir buscar as encomendas já existentes em vendas 
   List<Encomenda_Venda__c> encomendasExistentes = [SELECT Encomenda__c FROM Encomenda_Venda__c WHERE Encomenda__c = : encomenda_id ];

   //guardar valores antigos da encomenda para comparar com os novos
   if(trigger.IsUpdate){ 
       System.debug('UPDATE TRUE');
        for(order old : trigger.old){
            if(old.Id == encomenda_id){
                if(quantia_encomenda != old.TotalAmount){
                    quantia_encomenda = old.TotalAmount;
                }
                if(id_cliente != old.AccountId){
                    id_cliente = old.AccountId;
                }
            }
        }

        System.debug('ENCOMENDA ID do update '+encomenda_id);
        //se for um update, atualizar venda
        List<Encomenda_Venda__c> vendaExistente = [SELECT Venda__c FROM Encomenda_Venda__c WHERE Encomenda__c = : encomenda_id ];
        
        if(vendaExistente.isEmpty()){
            System.debug('nao ha vendas com esta encomenda'); 
        }
        else{
            System.debug('esta encomenda esta numa venda');
            vendaexiste = vendaExistente.get(0).Venda__c;
            List<Venda__c> vendaAntiga = [SELECT Cliente__c, Valor_total__c, Name FROM Venda__c WHERE Id = : vendaexiste];  
            
            if(estado == 'Activated' && !encomendasExistentes.isEmpty()){
                vendaAntiga.get(0).Cliente__c = id_cliente;
                vendaAntiga.get(0).Valor_total__c = quantia_encomenda; 
                vendaAntiga.get(0).Name = nome_cliente;
                System.debug('Dados Venda atualizados:'+nome_cliente+' '+id_cliente+' '+quantia_encomenda);
                update vendaAntiga;
            }        
            
        }          
                
   }
    
   
   if(encomendasExistentes.isEmpty()){
        System.debug('nao ha encomendas'); 
   }
   else{
        System.debug('Encomendas Existentes: '+ encomendasExistentes); 
   }


   //lista para guardar dados da nova venda
   List<Venda__c> novaVenda = new List<Venda__c>();
   
   //se o estado da variavel status mudar para activated e não houver uma venda já com esta encomenda, criar nova venda
   if (estado == 'Activated' && encomendasExistentes.isEmpty()){// && encomendasExistentes == null){
       novaVenda.add(new Venda__c(Name = ''+nome_cliente,
                                Cliente__c = id_cliente,
                                Valor_total__c = quantia_encomenda,
                                Data_Venda__c = System.Today(),
                                aux_IdEncomenda__c = encomenda_id
                            ));
       System.debug('Dados Venda Inseridos:'+nome_cliente+' '+id_cliente+' '+quantia_encomenda+' '+System.Today());
   }

    //Se a lista tiver algo entao inserir venda
    if (novaVenda != null && novaVenda.size() > 0){
       insert novaVenda;
       System.debug('ID NOVA VENDA:'+novaVenda.get(0).id);
       System.debug('ID ENCOMENDA:'+encomenda_id);
       Id venda_id ;
       venda_id = novaVenda.get(0).id;

       
       List<Encomenda_Venda__c> novaEncomendaVenda = new List<Encomenda_Venda__c>();
       //inserir a ligacao entre a encomenda e a venda 
       if(venda_id != null && encomenda_id != null){
           novaEncomendaVenda.add(new Encomenda_Venda__c(Name = 'Encomenda da Venda '+ nome_cliente,
                                                         Encomenda__c = encomenda_id,
                                                         Venda__c = venda_id  

           ));
           
           insert novaEncomendaVenda;
           System.debug('Dados Inseridos Encomenda Venda:'+encomenda_id+' '+venda_id+' '+nome_cliente);
       }
       
    }   
    
}