trigger atribuiDesigner on Case (after insert, after update) {
    //List<sObject> pedidoMaquete = new List<sObject>();

    //pedidoMaquete = [SELECT CaseNumber, Type FROM Case WHERE Type = 'Pedido Maquete'];
    
    for(Case caso : trigger.new){//trigger.new ja e uma lista dos casos
        if(caso.Type == 'Pedido Maquete'){
              
        }
    }
        
}