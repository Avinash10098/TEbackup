public class PlottedAFSContentTableController {
 public Id bId{get;set;}
    public string stDate{get;set;}
    public string stDate1{get;set;}
    public Booking__c bk {get;set;}
    public Project__c prj{get;set;}
    public Unit__c Unt{get;set;}
    public Tower__c tw{get;set;}
    public Cluster__c phase{get;set;}
    public Opportunity opp {get;set;}
    public Annexure_01__c ann {get;set;}
    public List<Annexure_Approval__c> approval {get;set;}
	public Promoter__c promo {get;set;}    
    
    public void PlottedAFSContentTableController(){
        approval = new List<Annexure_Approval__c>();
    }
    
    public void getprojectdetails(){
        bk = [SELECT  Id,No_of_Earmarked_Parking__c,Unit__c,Unit__r.Tower__r.Cluster__c,Opportunity__c, No_of_Additional_Parking__c, Quotation__c, Project__c FROM Booking__c WHERE id =:bId];
        opp = [Select Id,Name,Booking__c,Date_of_Agreement__c,Relationship_Manager__c From opportunity Where id=: bk.Opportunity__c];
        prj = [SELECT Id,Name, Address__c,Color_Code__c,State__c,Promoter__r.Name,Project_Short_Code__c FROM Project__c WHERE id=:bk.Project__c];
        Unt = [Select Id,Name,Tower__c,Default_Specification_new__c,Floor__c,Builtup_Area_Sub_Product__c,Carpet_Area_Sub_Product__c,Outdoor_Area_Sub_Product__c,Unit_Ownership__c from Unit__c where id=:bk.Unit__c];
        tw = [select Id, Name,Cluster__c from Tower__c where id=: Unt.Tower__c];
        promo = [select Id, name, PAN__c, Registered_office__c, Authorised_Signatory__c, Photograph__c from Promoter__c where id=:prj.Promoter__c];
        phase = [Select Id,Name,Annexure_01__c from Cluster__c where id=: tw.Cluster__c];
        System.debug('Phase---' +phase);
        ann = [Select Id,Name,Heading_A__c,Heading_B__c,Heading_c__c,Heading_D__c,Heading_A_Name__c,Heading_B_Name__c,Heading_C_Name__c,Sub_Heading_1__c,Annexure_Description__c,
               Heading_D_Name__c,Heading_E_Name__c,Heading_E_Description__c,Heading_F_Description__c,
               Heading_F_Name__c,Annexure_Description_Landowner__c,Heading_A_Name_Landowner__c,Heading_B_Name_Landowner__c,Heading_C_Name_Landowner__c,
               Heading_D_Name_Landowner__c,Heading_E_Name_Landowner__c,Heading_F_Name_Landowner__c,Heading_A_Description_Landowner__c,Heading_B_Description_Landowner__c,
               Heading_C_Description_Landowner__c,Heading_D_Description_Landowner__c,Heading_E_Description_Landowner__c,Heading_F_Description_Landowner__c 
               from Annexure_01__c where id=: phase.Annexure_01__c];
        approval = [Select Id, Name,Approval_No__c, Authority__c, Sr_No__c,Date__c from Annexure_Approval__c where Phase__c=: phase.id order by Sr_No__c ASC ];
        system.debug('approval' +approval);
        system.debug('ann' +ann.Heading_F_Name__c +'---'+ann.Heading_F_Description__c);
        if( opp.Date_of_Agreement__c != null){
        DateTime dt = opp.Date_of_Agreement__c;
        Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
                    string stDate = DocumentGenerationServices.customDateFormat(myDate);
        }
        
       
        
    }

}