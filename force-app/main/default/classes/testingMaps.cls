//testes utilizando mapas para atualizar stocks dos produtos 
public class testingMaps {
	public testingMaps() {
		
	}

	Decimal stockExistente;
	Decimal quantidadeEncomendada;
	Decimal stockAtualizado;

	public void mapa(){
		ID idEncomenda = '8011r000002wumaAAA';
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
					quantidadeEncomendada = mapaProdutosEncomenda.get(id).Quantity;
					stockAtualizado = stockExistente - quantidadeEncomendada;
					System.debug('stockAtualizado: '+stockAtualizado);
					//mapaProdutos.get(idproduto).Quantidade_em_Stock__c -= mapaProdutosEncomenda.get(id).Quantity;
					mapaProdutos.get(idproduto).Quantidade_em_Stock__c = string.valueof(stockAtualizado);
					System.debug('stockAtualizado mapa: '+mapaProdutos.get(idproduto).Quantidade_em_Stock__c);
				}
			}
		}
		update mapaProdutos.values();
	}


}