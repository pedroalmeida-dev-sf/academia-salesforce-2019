trigger corrigirContato on Contact (before insert) {
    for(contact selCont : trigger.new){
        if(selCont.name == 'Chora'){
            selCont.title = 'The Best';
        }
    }

    
}