public class MyOrderExtension{

    private final Order weborder;

    public MyOrderExtension(ApexPages.StandardController
                                stdController) {
       weborder = (Order)stdController.getRecord();
    }

     public PageReference saveOrder() {
       try {
       insert(weborder);
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