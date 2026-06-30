public class PlottedCommercialTermController {

    //public Id recordId;
    public Id QId{get;set;}
    Public String virtualcompdate {get;set;}
    Public String Split {get;set;}
    Public String Split2 {get;set;}
    Public String Split3 {get;set;}
    public Boolean spec1 {get;set;}
    public Boolean spec2 {get;set;}
    public Boolean spec3 {get;set;}
    public Quotation__c Quote{get;set;}
    public String dte{get;set;}
    public Boolean Onlinecheck{get;set;}
    public Boolean Personalizecheck{get;set;}
    public Unit__c unit{get;set;}
    List<Applicant_Details__c> adc{get;set;}
    public string andSepratedList{get;set;}
    public List<Payment_Milestones__c> pmList {get;set;}
    public List<PMWrapper> pmwList {get;set;} 
    //public List<specialWrapper> specList {get;set;} 
    //public List<OCWrapper> ocwList {get;set;}    
    public Project__c prj{get;set;}
    List<Payment_Milestones__c> pmstone{get;set;}
    List<String> Spec{get;set;}
    public List<Booking__c> bklist{get;set;}
    Public List<Unit__c> ulist{get;set;}
    public List<Quotation__c> quotlist{get;set;}
    Public Cluster__c ph {get;set;}
    Public List<String> splitted{get;set;}
    Public List<String> splitted2{get;set;}
    Public List<String> splitted3{get;set;}
    Public List<String> splitted4{get;set;}
    Public List<String> splitted5{get;set;}
    Public List<String> totalsplit{get;set;}
    public String ConsiderationValue{get;set;}
    public String totalAmtstr{get;set;}
    public String TotalAmtwithtax{get;set;}
    public String strConsiderationValue {get;set;} 
      Public String ConsiderationValueword{get;set;}
    public String stradditionoftax {get;set;} 
    public String strTotalAmtwithtax {get;set;} 
    Public Boolean isResidential{get;set;} 
    Public Boolean isCommercial{get;set;} 
    Public Boolean customizationcredit{get;set;} 
    Public String  DateLinked {get;set;}
    public String Stringcheck1{get;set;}
    public String Stringcheck2{get;set;}
    public String Stringcheck3{get;set;}
    public String gtotalstr{get;set;}
    Public String Customizationcreditstr{get;set;}
    Public String Customizationcreditnotoword{get;set;}
    Public String totalTaxstr{get;set;}
    public List<Payment_Milestones__c> pmListold {get;set;}
    public List<Quotation__c> qlist {get;set;}
    public Decimal amountraised{get;set;}
    public Booking__c book {get;set;}
    public Integer a {get;set;}
    Public integer i {get;set;}
     public Boolean see {get;set;}
    public Integer b {get;set;}
    Public Boolean NewPhase{get;set;}
    public List < T_C_Category__c > tcCategoryList {get;set;}
    public List<T_C_Sub_Category__c> tccList {get;set;}
    public String Stringcheck5{get;set;}
    public String grandTotalInWords{get;set;}
    
    	public static string customDateFormat(Date dt){
         system.debug('inside CusomDateFormat Method:: '+dt);
        string stDate = '';
        if(dt != Null){
            string stMonth = '';
            string stDay = '';
            Integer day = dt.Day();
            Integer month = dt.month();
            Integer year = dt.year();
            string stYear = string.valueof(year);
            
            stDay = day+'-';
            
            if(month == 1){ stMonth = 'Jan';}
            else if(month == 2) { stMonth = 'Feb'; }
            else if(month == 3) { stMonth = 'Mar'; }
            else if(month == 4) { stMonth = 'Apr'; }
            else if(month == 5) { stMonth = 'May'; }
            else if(month == 6) { stMonth = 'Jun'; }
            else if(month == 7) { stMonth = 'Jul'; }
            else if(month == 8) { stMonth = 'Aug'; }
            else if(month == 9) { stMonth = 'Sep'; }
            else if(month == 10) { stMonth = 'Oct'; }
            else if(month == 11) { stMonth = 'Nov'; }
            else if(month == 12) { stMonth = 'Dec'; }
            
            stDate = stDay + '' + stMonth + '-' + stYear; 
            
        }
        return stDate;
    }
      
      
      public class PMWrapper {
        public String milestoneName  {get;set;}
        public string amount        {get;set;}
        public string tax           {get;set;}
        public string grandtotal    {get;set;}
        public string mdate         {get;set;}
        public Integer srno         {get;set;}
        Public String milestonetype {get;set;}
        public Boolean Datetoprint         {get;set;}
        public PMWrapper(String msName,Boolean Datetoprint, string amt, string tAmt, string gtotal, Date pdate, Integer serial, String mstype) {
            this.milestoneName = msName;
            this.Datetoprint   = Datetoprint;
            this.amount        = amt;                     //InventoryCostServices.InFormatR(amt);
            this.tax           = tAmt;                     //InventoryCostServices.InFormatR();
            this.grandtotal    = gtotal;
            if(pdate != null)
                this.mdate         = customDateFormat(pdate);
            this.srno          = serial;
            this.milestonetype = mstype;
       }
    }
   /* public class specialWrapper {
        public String quotspecial     {get;set;}
        public String bookspecial     {get;set;}
        public String afsbookspecial  {get;set;}
        
        
        public specialWrapper(String qtspec, String bkspec, String afsspec) {
            this.quotspecial = qtspec;
            this.bookspecial = bkspec;                     
            this.afsbookspecial = afsspec;                     
            
       }
    }*/
   /* public class OCWrapper{
        public String milestoneName  {get;set;}
        public String amount        {get;set;}
        public String tax           {get;set;}
        public String grandtotal    {get;set;}
        public string mdate         {get;set;}
        public Integer srno         {get;set;}
        
        
       public OCWrapper(String msName, Decimal amt, Decimal tAmt, Decimal gtotal, Date pdate, Integer serial) {
            this.milestoneName = msName;
            this.amount        = InventoryCostServices.InFormat(amt);
            this.tax           = InventoryCostServices.InFormat(tAmt);
            this.grandtotal    = InventoryCostServices.InFormat(gtotal);
            if(pdate != null)
            this.mdate         = customDateFormat(pdate);
           
            this.srno          = serial;
       }
    }*/
      
 
      public PlottedCommercialTermController()
      {
         // recordId = apexpages.currentpage().getparameters().get('id');  
   //ulist = [Select Id,name,Permitted_Use__c ,Parent_Unit__c,Parent_Carpet_Area__c,Parent_Saleable_Area__c,Total_No_Of_Car_Park__c,TE_Product__c,Default_Specification_new__c,Builtup_Area_Sub_Product__c,Carpet_Area_Sub_Product__c,Outdoor_Area_Sub_Product__c,Floor__c,Unit_Ownership__c,TE_Product__r.Product_Type__c,Project__c,Tower__c,Tower__r.cluster__c,Tower__r.cluster__r.name from Unit__c where Id =:recordId ];
	//system.debug('Unit List 1' +ulist);
           //pmwList= new List<PMWrapper>(); 
           //ocwList= new List<OCWrapper>();
           bklist = new List<Booking__c>();
           spec1 = false; 
          spec2 = false; 
          spec3 = false; 
          splitted = new List<String>();
          splitted2 = new List<String>();
          splitted3 = new List<String>();
          totalsplit = new List<String>();
          pmListold = new List<Payment_Milestones__c>(); 
          qlist = new List<Quotation__c>();
          amountraised=0;
          b=1;
          ph = new Cluster__c();
      }
    public void getCreatePayment(){ 
        Onlinecheck = false;
        Personalizecheck = false;
        quotlist = [Select Id,Name,Selected_Customisation__c,Booking__c,Unit__r.Permitted_Use__c,Customization_Credit__c,Unit__r.Tower__r.Cluster__c
					,Specific_Terms_and_Condition__c,Booking__r.Specific_Terms_and_Condition__c,Booking__r.Specific_Terms_and_Condition_AFS__c,Final_Customisation__c
					 from Quotation__c where id=: QId];
        bklist = [SELECT Id,Specific_Terms_and_Condition__c,Specific_Terms_and_Condition_AFS__c,Approval_Status_SP__c,
                  Opportunity__r.Freebies_Selected__c FROM Booking__c WHERE id =:quotlist[0].Booking__r.id];
         system.debug('bklist :'+bklist);
        ph = [Select id,name,New_Phase__c from Cluster__c where id =:quotlist[0].Unit__r.Tower__r.Cluster__c];
        //**********************************************************************************************************************************
        ulist = [select id,Unit_Ownership__c,Land_Owner__c,Project__c from Unit__c where id =:quotlist[0].Unit__c];  
        if(ulist[0].Unit_Ownership__c == 'JD' && ulist[0].Land_Owner__c != Null){
            tcCategoryList = [Select Id, name, Project__c from T_C_Category__c where 
                              Project__c =:ulist[0].Project__c and Land_Owner__c =: ulist[0].Land_Owner__c order by Sequence_Number__c];
            
            if(tcCategoryList != null && !tcCategoryList.isEmpty()){
                tccList = [select Id,name,Sequence_Number__c,Description__c from T_C_Sub_Category__c where T_C_Category__c IN:tcCategoryList 
                           order by  Sequence_Number__c, T_C_Category__r.Sequence_Number__c];
      }
        }
        //***********************************************************************************************************************************
     /*   if(quotlist[0].Selected_Customisation__c == 'Online'){
            Onlinecheck = true;
        } */
        if(quotlist[0].Final_Customisation__c == 'Online'){
            Onlinecheck = true;
        }
        else if(quotlist[0].Final_Customisation__c == 'Personallized'){
            Personalizecheck = true;
        }
        
        
        if(quotlist[0].Customization_Credit__c != null){
            customizationcredit =true;
        }
        //system.debug('SPecific t and c ' +quotlist[0].Booking__r.Specific_Terms_and_Condition__c);
        pmwList= new List<PMWrapper>(); 
        //specList = new List<specialWrapper>();
        //ocwList= new List<OCWrapper>();
        system.debug('Commercialqid:'+QId);
      		termsheetmethod(QId);
           dte= customDateFormat(Date.today());
        if(quotlist[0].Unit__r.Permitted_Use__c == 'Residential'){
              isResidential = true;
              
          } else{
              isCommercial = True;
          }
        if(quotlist[0].Specific_Terms_and_Condition__c != null){
            Stringcheck1 = quotlist[0].Specific_Terms_and_Condition__c;
            string sString = Stringcheck1;
             
             splitted = sString.split('\\#');
           // Split = splitted[2];
        }
        if(bklist[0].Specific_Terms_and_Condition__c != null){
            Stringcheck2 = bklist[0].Specific_Terms_and_Condition__c;
            string sString2 = Stringcheck2;
            splitted2 = sString2.split('\\#');
            //Split2 = splitted2[2];
        }
        if(bklist[0].Specific_Terms_and_Condition_AFS__c != null && bklist[0].Approval_Status_SP__c == 'Accepted'){
            Stringcheck3 = bklist[0].Specific_Terms_and_Condition_AFS__c;
            string sString3 = Stringcheck3;
            splitted3 = sString3.split('\\#');
            //Split3 = splitted3[2];
        }
        if(bklist[0].Opportunity__r.Freebies_Selected__c != null){
            splitted4 = bklist[0].Opportunity__r.Freebies_Selected__c.split(',');
            //string sString3 = Stringcheck3;
            //splitted3 = sString3.split(',');
            //Split3 = splitted3[2];
        }
        if(tccList != Null){
            if(tccList[0].Description__c != null && ulist[0].Unit_Ownership__c == 'JD'){
            Stringcheck5 = '#';
            Stringcheck5 += tccList[0].Description__c;
            string sString5 = Stringcheck5;
             
             splitted5 = sString5.split('\\#');
        }
        }
        
        i=0;
       
        
        for(String str : splitted){
            system.debug('str'+str);
            if(str != ''){
            totalsplit.add(str);
            }
            system.debug('Totalsplit'+totalsplit);
        }
        
        for(String str : splitted2){
            if(str != ''){
            totalsplit.add(str);
            }
            system.debug('Totalsplit'+totalsplit);
        }
        
        for(String str : splitted3){
            if(str != ''){
            totalsplit.add(str);
            }
            
            system.debug('TotalsplitAFS'+totalsplit);
        }
        if(bklist[0].Opportunity__r.Freebies_Selected__c != null){
        for(String str : splitted4){
            if(str != ''){
            totalsplit.add(str);
            }
            system.debug('TotalsplitAFS'+totalsplit);
        }
        }
        //--------------------------------------------------------------------------------------------------------------------
        if(splitted5 != Null){
            for(String str : splitted5){
                system.debug('str'+str);
                if(str != ''){
                    totalsplit.add(str);
                }
                system.debug('Totalsplit'+totalsplit);
            }
        }
        //--------------------------------------------------------------------------------------------------------------------
        String br= '\n';
        for(integer i=0; i<totalsplit.size(); i++){
            system.debug('Totalsplit:::::'+totalsplit[i]);
        }
        if(totalsplit.size()>0 || quotlist[0].Customization_Credit__c != null){
            spec1 = true;
        }else{
            spec2 = true;
        }
        if(quotlist[0].Customization_Credit__c != null){
       Customizationcreditstr = InventoryCostServices.INFormatR(quotlist[0].Customization_Credit__c);
       Customizationcreditnotoword = S_NumberToWord.convertNumbertoWords(quotlist[0].Customization_Credit__c); 
        }
        
        if(ph.New_Phase__c == true){
            NewPhase = true;
        }else{
            NewPhase = false;
        }
    }
    
      //From Booking.
      public void termsheetmethod(Id BookingId)
      { 
          
          
          //Total car park
		 
          //prj = [SELECT Id, Address__c, Project_Logo__c FROM Project__c WHERE id=:bk.Project__c];
          
          String queryString1 = '';
                    for(Integer i = 1; i<=17; i++) {
                        queryString1 += 'Charge' + i + 'Bucket__c'   + ',';
                        queryString1 += 'Charge' + i + 'Name__c'  + ',';
                       }
                    
            queryString1 = 'Select ' + queryString1  + 'Total_of_Amount_Taxes_Agreement_Value__c, CGST_on_Total_Agreement_Value_Bucket__c, SGST_on_Total_Agreement_Value_Bucket__c, Selected_Specification__c,Total_Agreement_Value_Bucket__c, Unit__c, Selected_Customisation__c,Specification_Id__c,Scheme__c,Final_Customisation__c From Quotation__c where id = \'' + QId + '\'' ;
            system.debug('Query String :'+queryString1);
            Quote = Database.Query(queryString1);

           Map<String,Integer> AVChargesSeqMap = new Map<String, Integer>();
           //Map<String,Integer> OCSeqMap        = new Map<String, Integer>();
           Integer Seq = 1;
           String chgName = '';
            
           //creating a list of all charges that are part of the agreement value their field location, to identify whether they are stored in Charge1, Charge2, Charge3, etc.,
           for(Integer i=1;i<=17;i++)
            {
                   if((string)Quote.get('charge'+i+'Name__c') != null){  
                      if((string)Quote.get('charge'+i+'Bucket__c') == 'agreement value'){
                           AVChargesSeqMap.put((string)Quote.get('charge'+i+'Name__c'),seq);
                       }
                      //if((string)Quote.get('charge'+i+'Bucket__c') == 'Other Charges'){
                          //OCSeqMap.put((string)Quote.get('charge'+i+'Name__c'),seq);
                   //}
            }

             seq++;
            }
          
          
           // String to query all charges on that payment milestone.
            String queryString2 = '';
                    for(Integer i = 1; i<=15; i++) {
                        queryString2 += 'Charge' + i + 'Name__c'   + ',';
                        queryString2 += 'Charge' + i + 'Percentage__c'  + ',';
                        queryString2 += 'C' + i + '_Amount__c' + ',';                    
                        queryString2 += 'C' + i + '_CGST__c'   + ','; 
                        queryString2 += 'C' + i + '_SGST__c'   + ','; 
                    }
                    
            queryString2 = 'Select ' + queryString2  + ' Id,Total_Milestone_CGST__c,Total_Milestone_SGST__c, Milestone_Due_Date__c, Name,Milestone_Name__c,Milestone_Date_to_be_Print_On_Documents__c, Milestone_Complete_At_Booking__c,Demand_Raised__c,Milestone_Type_edit__c from Payment_Milestones__c where Quotation__c = \'' + QId + '\'ORDER BY Name ASC' ;
            system.debug('Query String :'+queryString2);
            pmList = Database.Query(queryString2); 
            
          System.debug('Payment Plan Milestone : '+pmList[0].Milestone_Type_edit__c);
            Integer serialno = 1;
           
            Decimal addTotalAmt = 0;
            Decimal addTotalTax  = 0;
            Decimal addGtotal  = 0;
            Decimal octotalAmt = 0;
            Decimal octotalTax = 0;
            Decimal ocgtotal = 0;
            for(Payment_Milestones__c pm : pmList) 
            {
                system.debug('pmmm::'+pm.Milestone_Name__c);
            //    if(!pm.Milestone_Name__c.contains('Development Charges') && !pm.Milestone_Name__c.contains('Club House')){
                   
                    // check all the values in Agreement value bucket and sum total its amount and taxes
                    Decimal totalAmt = 0;
                    Decimal totalTax = 0;
                    Decimal gtotal = 0;
                  
                    
                    system.debug('AVChargesSeqMap'+AVChargesSeqMap.values());
                Boolean addPMtoSchedule = False;     
                    // For Agreement Value
                     for(Integer i : AVChargesSeqMap.values()) 
            {
                if((Decimal)pm.get('C' +i + '_Amount__c' ) != null && pm.get('Charge' +i + 'Name__c' ) != 'Development Charges' && pm.get('Charge' +i + 'Name__c' ) != 'Club House Membership'){
                    addPMtoSchedule = true;
                    totalAmt += (Decimal)pm.get('C' +i + '_Amount__c' );                      
                    system.debug('charge name::'+pm.get('Charge' +i + 'Name__c' ));
                    system.debug('addTotalAmt::'+i+':'+addTotalAmt );
                }
                
                if((Decimal)pm.get('C' + i + '_CGST__c' ) != null && (Decimal)pm.get('C' + i + '_SGST__c' ) != null &&  pm.get('Charge' +i + 'Name__c' ) != 'Development Charges' && pm.get('Charge' +i + 'Name__c' ) != 'Club House Membership'){
                    totalTax += (Decimal)pm.get('C' + i + '_CGST__c' ) + (Decimal)pm.get('C' + i + '_SGST__c' );
                    system.debug('totalTax::'+totalTax);
                    system.debug('addTotalTax ::'+i+':'+addTotalTax );
                }
                
            }
            if(pm.Milestone_Name__c == 'Virtual Completion' || pm.Milestone_Name__c == 'On Virtual Completion' || 
               pm.Milestone_Name__c == 'Virtual Completion [on or before]'){
                   virtualcompdate = PreambleController.customDateFormat(pm.Milestone_Due_Date__c);
               }
            if(pm.Milestone_Name__c == 'Ready for Fit-Outs'){
                virtualcompdate = PreambleController.customDateFormat(pm.Milestone_Due_Date__c);
            }
            
                    totalAmt = totalAmt.setscale(2,RoundingMode.HALF_UP);
                    //totalTax = totalTax.setscale(2);
                 //   totalTax = pm.Total_Milestone_CGST__c.setscale(0,RoundingMode.HALF_UP) + pm.Total_Milestone_SGST__c.setscale(0,RoundingMode.HALF_UP);
                	totalTaxstr = InventoryCostServices.INFormatForDecimal(totalTax);
                    gtotal = gtotal.setscale(2,RoundingMode.HALF_UP);
                    gtotal = totalAmt + totalTax; 
                    gtotalstr = InventoryCostServices.INFormatForDecimal(gtotal);
                    addTotalAmt += totalAmt; 
                    addTotalTax += totalTax ;                   
                    addGtotal +=gtotal; 
                    
                    system.debug('addGtotal ::'+addGtotal );
                	totalAmtstr = InventoryCostServices.INFormatForDecimal(totalAmt);
                if(addPMtoSchedule){
                    pmWrapper pmw = new pmWrapper(pm.Milestone_Name__c,pm.Milestone_Date_to_be_Print_On_Documents__c, totalAmtstr, totalTaxstr, gtotalstr, pm.Milestone_Due_Date__c, serialno, pm.Milestone_Type_edit__c);
                     System.debug(pmw);
                    pmwList.add(pmw);
                    system.debug(pmwList);
                    ocgtotal = octotalAmt + octotalTax;
                    serialno++;
                }
                    
                    //For Other Chanrges
                 /*   Decimal octotalAmt = 0;
                    Decimal octotalTax = 0;
                    Decimal ocgtotal = 0;*/
                    
                    //system.debug('OCSeqMap'+OCSeqMap.values());

                        
                    /*for(Integer i : OCSeqMap.values()) 
                    {
                        
                        octotalAmt += (Decimal)pm.get('C' +i + '_Amount__c' );
                        octotalTax += (Decimal)pm.get('C' + i + '_CGST__c' ) + (Decimal)pm.get('C' + i + '_SGST__c' );
                    }*/
                    
                  //  ocgtotal = octotalAmt + octotalTax;
                    //OCWrapper ocw = new OCWrapper(pm.Milestone_Name__c, octotalAmt, octotalTax, ocgtotal, pm.Milestone_Due_Date__c, serialno);
                     //System.debug(ocw);
                    //ocwList.add(ocw);
                    //system.debug(ocwList);   
                    
                  //  serialno++;
         //   }    
            }
          /**********************************************************************/
         
            if(QId != null){
        qlist = [Select id , name,Opportunity__r.Old_Booking__c,Quotation_Type__c,Booking__r.Is_Tranferred__c from Quotation__c where id =: QId];
            }
        System.debug('qlist::'+qlist);
            if(!qlist.isEmpty() && qlist[0].Opportunity__r.Old_Booking__c != null){
         book = [select id , name, Quotation__c,Booking_Date__c,TotalAmountDemanded__c from Booking__c where id =: qlist[0].Opportunity__r.Old_Booking__c];
            
        system.debug('Book::'+book);
        pmListold = [Select id , name ,Milestone_Name__c,Milestone_Due_Date__c,Milestone_Type_edit__c,Total_Amount_in_Milestone__c,TotalMilestoneTax__c,
                     TotalMilestoneAmountWIthTax__c,Milestone_Date_to_be_Print_On_Documents__c from Payment_Milestones__c
                     where Quotation__c =: book.Quotation__c And is_demand_raised__c = true ];
            system.debug('pmlistold::'+pmListold);
            }
             if((qlist[0].Quotation_Type__c == 'Unit Transfer Quotation' && book.TotalAmountDemanded__c != 0) ||
               (qlist[0].Quotation_Type__c == 'Unit Transfer Quotation' && qlist[0].Booking__r.Is_Tranferred__c == true)){
                b = 1;
                see = true;
            }else{
                b=0;
            }
        
        /**********************************************************************/
        amountraised = 0;
        for(Payment_Milestones__c p : pmListold){
            
                addTotalAmt += p.Total_Amount_in_Milestone__c;
                amountraised += p.Total_Amount_in_Milestone__c;
         }
          if(amountraised == 0 ){
              b = 0;
              see = false;
          }
             strConsiderationValue = InventoryCostServices.InFormat(addTotalAmt.setscale(0,RoundingMode.HALF_UP) );
             stradditionoftax = InventoryCostServices.InFormat(addTotalTax);
             strTotalAmtwithtax = InventoryCostServices.InFormat(addGtotal.setscale(0,RoundingMode.HALF_UP));
                      ConsiderationValueword=S_NumberToWord.convertNumbertoWords(addTotalAmt.setscale(0,RoundingMode.HALF_UP));
            grandTotalInWords = S_NumberToWord.convertNumbertoWords(addGtotal.setscale(0,RoundingMode.HALF_UP));
			system.debug('grandTotalInWords ::'+ grandTotalInWords );
            system.debug('strConsiderationValue ::'+ strConsiderationValue );
            system.debug('stradditionoftax ::'+ stradditionoftax );
            system.debug('strTotalAmtwithtax  ::'+ strTotalAmtwithtax );
  
          //For Specification Page
           //system.debug('Specification : '+Quote.Specification_Id__c);
           //specificationPage = new PageReference('/apex/SpecificationPage?specId='+Quote.Specification_Id__c);
         
         //For Terms and Condition Page
         
           //termsandconditionPage = new PageReference('/apex/TermsAndConditionsPDF?unitId='+unit.id+'&phaseId='+unit.Tower__r.Cluster__c+'&ProjectId='+prj.id); 
           
      }

}