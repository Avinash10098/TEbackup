public class PlottedAFSVirtualCompletionController {
public Id uId{get;set;}
    
    public List<Unit__c> ulist {get;set;}
    public Project__c prj{get;set;}
    Public Boolean isResidential{get;set;} 
    Public Boolean isCommercial{get;set;}
    Public String notoword{get;set;}
    Public String damountword{get;set;}
    Public String damountformat{get;set;}
    Public String tamountformat{get;set;}
    Public String unitownershiptext{get;set;} 
    Public String textforLandowner{get;set;} 
    public void AFSVirtualCompletionController(){
     
    }
    
    Public void getFindProject(){ 
        
        if(uId != null  ){
            ulist = [Select Id,name,Permitted_Use__c ,TE_Product__c,Default_Specification_new__c,Builtup_Area_Sub_Product__c,
                     Carpet_Area_Sub_Product__c,Outdoor_Area_Sub_Product__c,Floor__c,Unit_Ownership__c,TE_Product__r.Product_Type__c,Project__c,
                     Tower__c,Tower__r.cluster__c,Tower__r.cluster__r.name,Tower__r.cluster__r.Transfer_Fee__c,Tower__r.cluster__r.Transfer_Fee_Landowner__c from Unit__c where Id =:uId ];
            if(ulist[0].Permitted_Use__c == 'Residential'){
                isResidential = true;
                
            } else{
                isCommercial = True;
            }
            if(ulist[0].Tower__r.cluster__r.Transfer_Fee__c != null || ulist[0].Tower__r.cluster__r.Transfer_Fee_Landowner__c != null){
                if(ulist[0].Unit_Ownership__c == 'JD'){
                    notoword = S_NumberToWord.convertNumbertoWords(ulist[0].Tower__r.cluster__r.Transfer_Fee_Landowner__c);
                }else{
                    notoword = S_NumberToWord.convertNumbertoWords(ulist[0].Tower__r.cluster__r.Transfer_Fee__c);
                }
                tamountformat = InventoryCostServices.INFormat(ulist[0].Tower__r.cluster__r.Transfer_Fee__c);
            }
            prj = [SELECT Id, Name, Preamble_Details__c,Deduction_Amount__c,State__c FROM Project__c WHERE id=:ulist[0].Project__c];
            system.debug('iscommercial' +isCommercial);
            system.debug('isResidential' +isResidential);
            if(prj.Deduction_Amount__c != null){
                damountword = S_NumberToWord.convertNumbertoWords(prj.Deduction_Amount__c);
                damountformat = InventoryCostServices.INFormat(prj.Deduction_Amount__c);
            }
            if(ulist[0].Unit_Ownership__c == 'JD'){
                unitownershiptext = 'Developers';
                textforLandowner = 'Landowners';
            }else{
                unitownershiptext='Promoters';
                textforLandowner = 'Promoters';
            }
            
        }
    }
    
}