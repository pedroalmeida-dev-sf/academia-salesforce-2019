trigger AtualizaStockEncomenda on Order (after insert, after update) {
    
    ID idEncomenda;
    Decimal stockExistente;
    Decimal quantidadeEncomendada;
    Decimal stockAtualizado;
    String estadoEncomenda;
    Boolean jaFoiActiva;
    Boolean atualizar = false;

    for(Order o : trigger.new){
        idEncomenda = o.Id;
        estadoEncomenda = o.Status;
        jaFoiActiva = o.encomendaAtivada__c ;
    }

    //se for update, tem que se comparar os campos old com os new, so atualiza se forem diferentes
    if(trigger.isUpdate){
        for( Id id : Trigger.newMap.keySet() )
        {
            if( Trigger.oldMap.get(id).Status != Trigger.newMap.get(id).Status)
            {
                System.debug('Estado da encomenda old = '+Trigger.oldMap.get(id).Status);
                System.debug('Estado da encomenda new = '+Trigger.newMap.get(id).Status);
                atualizar = true;
            }
        }
    }

    List<OrderItem> produtoEncomenda = [SELECT OrderId, Product2Id, Quantity FROM OrderItem WHERE OrderId = : idEncomenda];
    List<Product2> produtos = [SELECT Id, Quantidade_em_Stock__c FROM Product2];
    map<id, OrderItem> mapaProdutosEncomenda = new Map<id, OrderItem>(produtoEncomenda);
    map<id,Product2> mapaProdutos = new Map<id,Product2>(produtos);

    //se a encomenda ja foi ativa e é um update, entao repoe o stock
    if(estadoEncomenda == 'Anulada' && jaFoiActiva == true && atualizar == true){
        System.debug('Estado da encomenda = '+estadoEncomenda);
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
                    stockAtualizado = stockExistente + quantidadeEncomendada;
                    System.debug('stockAtualizado: '+stockAtualizado);
                    //mapaProdutos.get(idproduto).Quantidade_em_Stock__c -= mapaProdutosEncomenda.get(id).Quantity;
                    
                    if(stockAtualizado >= 0){
                        mapaProdutos.get(idproduto).Quantidade_em_Stock__c = string.valueof(stockAtualizado);
                        System.debug('stockAtualizado mapa: '+mapaProdutos.get(idproduto).Quantidade_em_Stock__c);
                    }
                }
            }
        }
        update mapaProdutos.values();
    }

    //se a encomenda ficar ativa e for update entao atualiza o stock
    if(estadoEncomenda == 'Activated' && atualizar == true){
        System.debug('Estado da encomenda = '+estadoEncomenda);
        if (trigger.isUpdate){
            System.debug('Update');
        }
        if (trigger.isInsert){
            System.debug('Insert');
        }
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
                    
                    if(stockAtualizado <= stockExistente){
                        mapaProdutos.get(idproduto).Quantidade_em_Stock__c = string.valueof(stockAtualizado);
                        System.debug('stockAtualizado mapa: '+mapaProdutos.get(idproduto).Quantidade_em_Stock__c);
                    }
                    else{                 
                        for(Order o : trigger.new){
                            o.addError('Produto sem Stock!');
                        }
                    }
                }
            }
        }
        update mapaProdutos.values();
    }
}