trigger verificarStock on OrderItem (before insert, before update) {
//quando insere produtos na encomenda, verifica o stock desse produto e da uma mensagem de erro

    Double quantidade;
    String stockProduto;
    Decimal decimalStock;
    ID idencomenda;
    String nomeProduto;
    
    for(OrderItem o : trigger.new){
        idencomenda = o.OrderId;
    }


    List<Product2> produto = [SELECT Id, Name, Quantidade_em_Stock__c FROM Product2];
    map<id,Product2> mapaProdutos = new Map<id,Product2>(produto);  
    FeedItem post = new FeedItem();
    //percorre os produtos todos que estao a ser inseridos
    for (integer i=0; i<trigger.new.size();i++){
        //system.debug('sadasd'+i);
        system.debug('ID produto:'+Trigger.new[i].Product2Id);
        system.debug('Quantidade:'+Trigger.new[i].Quantity);
        quantidade = Trigger.new[i].Quantity;
        //percorre os produtos que existem 
        for(Id idProduto : mapaProdutos.keySet()){
            //se produto inserido for igual a um existente
            if(idproduto == trigger.new[i].Product2Id){
                stockProduto = mapaProdutos.get(idProduto).Quantidade_em_Stock__c;
                decimalStock =  decimal.valueOf(stockProduto);
                //se quantidade pedida maior que stock 
                if(quantidade > decimalStock){
                        system.debug('Quantidade pedida: '+quantidade+' Stock: '+decimalStock);
                        Trigger.new[i].Quantity.addError('Produto sem stock suficiente!');
                        //post.RelatedRecordId = ''+idencomenda;
                        //post.ParentId =''+idencomenda;
                        //post.Title = 'Produto sem stock';
                        //post.Body = 'Produto'+mapaProdutos.get(idProduto).Name+' sem stock';
                        //Database.insert(post);
                }
            }          
        }  
    }
   
}