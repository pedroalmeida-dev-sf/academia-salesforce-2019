trigger updateVendas on OrderItem (after update) {
//objectivo do trigger e atualizar a venda caso sejam efetuadas alteracoes aos produtos da encomenda, como quantidades por exemplo

    ID idEncomenda;
    Decimal precoTotal;
    ID idVenda;

    for(OrderItem o : trigger.new){
        idEncomenda = o.OrderId;
        precoTotal = o.TotalPrice;
    }

    List<Encomenda_Venda__c> vendaExistente = [SELECT Venda__c FROM Encomenda_Venda__c WHERE Encomenda__c = : idEncomenda];
    
    //se houver venda
    if(!vendaExistente.isEmpty()){
        
        idVenda = vendaExistente.get(0).Venda__c;
        List<Venda__c> vendaAntiga = [SELECT Cliente__c, Valor_total__c, Name FROM Venda__c WHERE Id = : idVenda];
        
        vendaAntiga.get(0).Valor_total__c = precoTotal; 
        
        System.debug('Dados Venda atualizados:'+precoTotal);
        update vendaAntiga; 

    }
}