public class addOrderProducts{

 private final OrderItem weborderitem;

    public addOrderProducts(ApexPages.StandardController
                                stdController) {
       weborderitem = (OrderItem)stdController.getRecord();
    }

     public PageReference saveOrderItem() {
       try {
       insert(weborderitem);
       }
       catch(System.DMLException e) {
           ApexPages.addMessages(e);
           return null;
       }
       PageReference p = Page.ThankYou;
       p.setRedirect(true);
       return p;
     }


}