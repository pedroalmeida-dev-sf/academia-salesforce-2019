trigger atualizaStockDepoisVenda on Venda__c (after insert, after update) {

    //ir buscar encomenda da venda
    //ir buscar produtos da encomenda
    //ir buscar quantidade/s do/s produto/s na encomenda
    //descontar quantidade/s do/s produto/s na encomenda no stock do/s produto/s 

    ID idEncomenda;
    ID idVenda;
    Decimal stockExistente;
    Decimal quantidadeEncomendada;
    Decimal stockAtualizado;
   
    for(Venda__c v : trigger.new){
        idVenda = v.Id;
        System.debug('ID venda inserida: '+v.Id);
    }

    //id encomenda da venda se for update
    if(trigger.isUpdate){
        List<Encomenda_Venda__c> encomendaVenda = [SELECT Encomenda__c FROM Encomenda_Venda__c WHERE Venda__c = : idVenda ];
        for(Encomenda_Venda__c e : encomendaVenda){
            idEncomenda = e.Encomenda__c;
            System.debug('ID encomenda da venda: '+idEncomenda);
        }
    }
    
    //id encomenda da venda se for insert, tem que se ir buscar a campo auxiliar porque ainda nao foi criado um registo no objeto encomenda_venda
    if(trigger.isInsert){
        List<Venda__c> encomendaVenda = [SELECT aux_IdEncomenda__c FROM Venda__c WHERE Id = : idVenda ];
        for(Venda__c v : encomendaVenda){
            idEncomenda = v.aux_IdEncomenda__c;
            System.debug('ID encomenda da venda: '+idEncomenda);
        }
    }
    
    //dados produto/s presentes na encomenda
    //ID idEncomenda = '8011r000002wumaAAA';
    List<OrderItem> produtoEncomenda = [SELECT OrderId, Product2Id, Quantity FROM OrderItem WHERE OrderId = : idEncomenda];
    List<Product2> produtos = [SELECT Id, Quantidade_em_Stock__c FROM Product2];
    map<id, OrderItem> mapaProdutosEncomenda = new Map<id, OrderItem>(produtoEncomenda);
    map<id,Product2> mapaProdutos = new Map<id,Product2>(produtos);

    for (Id id : mapaProdutosEncomenda.keySet())
    {
        System.debug(id);
        System.debug(mapaProdutosEncomenda.get(id));
        for(Id idproduto : mapaProdutos.keySet()){
            if(idproduto == mapaProdutosEncomenda.get(id).Product2Id ){
                System.debug('ID produto encomenda= '+mapaProdutosEncomenda.get(id).Product2Id+' '+'ID Produto= '+idproduto);
                System.debug('Quantidade stock existente: '+mapaProdutos.get(idproduto).Quantidade_em_Stock__c+' Quantidade encomendada: '+mapaProdutosEncomenda.get(id).Quantity);
                stockExistente = decimal.valueof(mapaProdutos.get(idproduto).Quantidade_em_Stock__c);
                //System.debug('stockExistente: '+stockExistente);
                quantidadeEncomendada = mapaProdutosEncomenda.get(id).Quantity;
                //System.debug('QuantidadeEncomenda: '+quantidadeEncomendada);                
                stockAtualizado = stockExistente - quantidadeEncomendada;
                System.debug('stockAtualizado: '+stockAtualizado);
                //mapaProdutos.get(idproduto).Quantidade_em_Stock__c -= mapaProdutosEncomenda.get(id).Quantity;
                if(stockAtualizado > 0){
                    mapaProdutos.get(idproduto).Quantidade_em_Stock__c = string.valueof(stockAtualizado);
                    System.debug('stockAtualizado mapa: '+mapaProdutos.get(idproduto).Quantidade_em_Stock__c);
                }
                else{
                    mapaProdutos.get(idproduto).Quantidade_em_Stock__c = '0';
                    //mapaProdutos.addError('Produto sem stock suficiente! ');
                }
            }
        }
    }
    update mapaProdutos.values();
    
    //problema: - sempre que faz update decrementa stock
    //            
    
    //ideia: criar campo para variavel auxiliar, sempre que se faz update ao objecto, atualizar variavel e saber se e necessario atualizar stock ou nao
    
    
}