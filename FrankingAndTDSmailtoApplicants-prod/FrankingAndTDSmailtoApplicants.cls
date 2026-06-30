//Test Class: Test_FrankingAndTDSmailtoApplicants
public class FrankingAndTDSmailtoApplicants {
	@InvocableMethod(label='Franking and TDS mail To Applicants' description='Sends Franking and TDS Mail To all the applicants' category='Other')
    
    public static void frankingTDSMail(List<Id> BookingId){
        System.debug('Inside frankingTDSMail method');
        List<Booking__c> blist = new  List<Booking__c>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<Applicant_Details__c> appList = new List<Applicant_Details__c>();
        List<String> toaddress = new List<String>();
        List<String> ccaddress = new List<String>();
        
        if(BookingId != Null){
            blist = [select Id,Name,Project__r.Name,Flat_No__c,Sales_Managers__r.Name,Sales_Managers__r.MobilePhone,Sales_Managers__r.Email,
                     Project_Sales_TL__r.Name,Project_Sales_TL__r.Email,Unit__r.Permitted_Use__c,Relationship_Manager__r.Name,Franking_Charges__c from Booking__c where Id =: BookingId];
        }
        String frankingCharge = InventoryCostServices.INFormat(blist[0].Franking_Charges__c);
        System.debug('blist size::'+blist.size());
        System.debug('blist::'+blist);
        if(blist != Null){
            oppList = [select Id,Name from Opportunity where Booking__c =: blist[0].id];
        }
        System.debug('oppList size::'+oppList.size());
        System.debug('oppList::'+oppList);
        if(blist != Null){
            appList = [select Id,Name,Email_Address__c,Salutation__c from Applicant_Details__c where Booking__c =: blist[0].id];
        }
        System.debug('appList size::'+appList.size());
        System.debug('appList::'+appList);
        String allApplicantNames = '';
        if(appList.size() == 1){
                allApplicantNames = appList[0].Salutation__c+''+appList[0].Name; 
            }
            else if(appList.size() == 2){
               allApplicantNames = appList[0].Salutation__c+''+appList[0].Name+' & '+appList[1].Salutation__c+''+appList[1].Name;
            }
        	else if(appList.size() == 3){
               allApplicantNames = appList[0].Salutation__c+''+appList[0].Name+' & '+appList[1].Salutation__c+''+appList[1].Name+' & '+appList[2].Salutation__c+''+appList[2].Name;
            }
        	else if(appList.size() == 4){
               allApplicantNames = appList[0].Salutation__c+''+appList[0].Name+' & '+appList[1].Salutation__c+''+appList[1].Name+' & '+appList[2].Salutation__c+''+appList[2].Name+' & '+appList[3].Salutation__c+''+appList[3].Name;
            }
            else if(appList.size() == 5){
               allApplicantNames = appList[0].Salutation__c+''+appList[0].Name+' & '+appList[1].Salutation__c+''+appList[1].Name+' & '+appList[2].Salutation__c+''+appList[2].Name+' & '+appList[3].Salutation__c+''+appList[3].Name+' & '+appList[4].Salutation__c+''+appList[4].Name;
            }
        
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'customer.contracts@total-environment.com'];
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        for(Applicant_Details__c a:appList){
            toaddress.add(a.Email_Address__c);
        }
        ccaddress.add('customer.contracts@total-environment.com');
        if(blist[0].Unit__r.Permitted_Use__c == 'Residential'){
            ccaddress.add(blist[0].Sales_Managers__r.Email);  
        }
        
        
        email.setOrgWideEmailAddressId(owea.get(0).Id);
        email.setToAddresses(toaddress);
        email.setCcAddresses(ccaddress);
        
        email.setSubject(blist[0].Project__r.Name+' | '+blist[0].Flat_No__c+' | '+'Franking Charges.');
        
        String body = '';
            if(blist[0].Unit__r.Permitted_Use__c != Null){
                if(blist[0].Unit__r.Permitted_Use__c == 'Residential'){
                    body += 'Dear '+allApplicantNames+','+'<br/> '+
                        'Greetings from Total Environment !! <br/><br/>'+
                        'We write to inform you about the charges towards franking of Agreement for Sale (AFS) for your unit. We request you to please transfer the franking charges of '+frankingCharge+' to below mentioned account  <br/><br/>'+
                        '<b>Account Name :</b> Total EnvironmentTax Account<br/>'+
                        '<b>Bank Name :</b> RBL Bank<br/>'+
                        '<b>Account No :</b> 409000789456<br/>'+
                        '<b>IFSC :</b> RATN0000156<br/>'+
                        '<b>Branch Name :</b> BANGALORE-PRESTIGE TOWERS<br/>'+
                        '<b>SWIFT :</b> RATNINBB<br/><br/>'+
                        'Kindly note, the franking of AFS is scheduled on receipt of the signed agreements. Hence, request you to kindly transfer the charges, in order for us to get the Demand Draft for franking executed in a timely manner.<br/><br/>'+
                        'For any query, you can write back to us at <a href="mailto:customer.contracts@total-environment.com">customer.contracts@total-environment.com</a> or speak to your respective sales consultant, for an immediate response.<br/><br/>'+
                        
                        '<table>'+
                        '<tr><td style="font-size:15px;border:none;padding: 1px;margin: 1px;">Warm Regards,</td></tr>'+
                        '<tr><td style="font-size:15px;border:none;padding: 1px;margin: 1px;">Sales Operations team</td></tr>'+
                        '</table>'+
                   //     '<b><img src="https://totalenvironment--sbdev--c.documentforce.com/servlet/servlet.ImageServer?id=015p0000000f6Mt&oid=00Dp00000009ioT&lastMod=1624527034000"/></b><br/>'+  	//Url for sandbox
                      '<b><img src="https://totalenvironment--c.documentforce.com/servlet/servlet.ImageServer?id=0159C000000BSwk&oid=00D2v000002H08a&lastMod=1668497618000"/></b><br/>'+			//Url for Production
                        '<a href="https://www.total-environment.com">www.total-environment.com</a>'+' | '+'<a href="https://www.facebook.com/TotalEnv/">Facebook</a><br/>'+
                        'The Total Environment Story, Click <a href="https://www.youtube.com/watch?v=3VlafRMdM70&feature=youtu.be">here</a> to watch.';
                }
            }
        
            body = '<p style="font-family:Neo Sans Pro Light;font-size:13px">' + body + '</p>';
        email.setSaveAsActivity(true);
        email.setWhatId(blist[0].id);
        email.setHtmlBody(body);
        
        if(blist[0].Unit__r.Permitted_Use__c == 'Residential'){
            if(blist[0].Project__r.Name != 'Songs from the Wood'){
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            }
         //   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            TDSMail(BookingId);
        }    
        
    }
    
    
    //*************************************************************************************************************************************************************************************
    //Second Method to send TDS Mail
    public static void TDSMail(List<Id> BookingId){
        List<Booking__c> blist = new  List<Booking__c>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<Applicant_Details__c> appList = new List<Applicant_Details__c>();
        List<String> toaddress = new List<String>();
        List<String> ccaddress = new List<String>();
        
        if(BookingId != Null){
            blist = [select Id,Name,Project__r.Name,Flat_No__c,Sales_Managers__r.Name,Sales_Managers__r.MobilePhone,Sales_Managers__r.Email,Project__r.Promoter__r.PAN__c,
                     Project__r.Address__c,Project__r.State__c,Project__r.City__c,Project__r.Pincode__c,
                     Project_Sales_TL__r.Name,Project_Sales_TL__r.Email,Unit__r.Permitted_Use__c,Relationship_Manager__r.Name,Franking_Charges__c,Unit__r.Unit_Ownership__c from Booking__c where Id =: BookingId];
        }
        System.debug('blist size::'+blist.size());
        System.debug('blist::'+blist);
        if(blist != Null){
            oppList = [select Id,Name from Opportunity where Booking__c =: blist[0].id];
        }
        System.debug('oppList size::'+oppList.size());
        System.debug('oppList::'+oppList);
        if(blist != Null){
            appList = [select Id,Name,Email_Address__c,Salutation__c from Applicant_Details__c where Booking__c =: blist[0].id];
        }
        System.debug('appList size::'+appList.size());
        System.debug('appList::'+appList);
        String allApplicantNames = '';
        if(appList.size() == 1){
            allApplicantNames = appList[0].Salutation__c+''+appList[0].Name; 
        }
        else if(appList.size() == 2){
            allApplicantNames = appList[0].Salutation__c+''+appList[0].Name+' & '+appList[1].Salutation__c+''+appList[1].Name;
        }
        else if(appList.size() == 3){
            allApplicantNames = appList[0].Salutation__c+''+appList[0].Name+' & '+appList[1].Salutation__c+''+appList[1].Name+' & '+appList[2].Salutation__c+''+appList[2].Name;
        }
        else if(appList.size() == 4){
            allApplicantNames = appList[0].Salutation__c+''+appList[0].Name+' & '+appList[1].Salutation__c+''+appList[1].Name+' & '+appList[2].Salutation__c+''+appList[2].Name+' & '+appList[3].Salutation__c+''+appList[3].Name;
        }
        else if(appList.size() == 5){
            allApplicantNames = appList[0].Salutation__c+''+appList[0].Name+' & '+appList[1].Salutation__c+''+appList[1].Name+' & '+appList[2].Salutation__c+''+appList[2].Name+' & '+appList[3].Salutation__c+''+appList[3].Name+' & '+appList[4].Salutation__c+''+appList[4].Name;
        }
        
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'customer.contracts@total-environment.com'];
        
            Document doc = [Select Id, Name, Body, ContentType, DeveloperName, Type From Document Where Name = 'TDS on Purchase of Immovable Property in India'];
        
        
        
        //Create Email file attachment from document
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType(doc.ContentType);
        attach.setFileName(doc.DeveloperName+'.'+doc.Type);
        attach.setInline(false);
        attach.Body = doc.Body;
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        for(Applicant_Details__c a:appList){
            toaddress.add(a.Email_Address__c);
        }
        ccaddress.add('customer.contracts@total-environment.com');
        if(blist[0].Unit__r.Permitted_Use__c == 'Residential'){
            ccaddress.add(blist[0].Sales_Managers__r.Email);  
        }
        
        email.setOrgWideEmailAddressId(owea.get(0).Id);
        email.setToAddresses(toaddress);
        email.setCcAddresses(ccaddress);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
        
        email.setSubject(blist[0].Project__r.Name+' | '+blist[0].Flat_No__c+' | '+'Important Notification on TDS.');
        
        String body = '';
            if(blist[0].Unit__r.Permitted_Use__c != Null){
                if(blist[0].Unit__r.Permitted_Use__c == 'Residential'){
                    body += 'Dear '+allApplicantNames+','+'<br/><br/> '+
                        'Greetings from Total Environment ! <br/><br/>'+
                        'This is an important communication regarding TDS payable towards your unit.  <br/><br/>'+
                        'As per Sec 194 IA of the Income Tax Act, the purchaser of an immovable property which is worth Rs. 50 Lac or more, has to deduct 1% TDS on sale consideration value. Hence, we request you to kindly deduct 1% TDS on all payments made towards your unit and furnish this TDS payment by submitting Form 26QB online as per the attached file.  <br/><br/>'+
                        'We request you to share the signed From 16B with us, for all such TDS payments made towards your unit. You can download Form 16B from traces website as mentioned in the attachment.  <br/>'+
                        '<p style="font-family:Neo Sans Pro Light;font-size:13px">Request to please follow the instructions in the attachment for making your TDS payments.</p>'+
                        
                        'Please find below the details that you may require for filing your TDS payment online. <br/><br/>'+ 
                        
                        
                        '<table style="width:100%">'+
                        '<tr><td style="text-align:center;font-size:18px;border:1px solid grey;padding: 1px;margin: 1px;background-color: #cccccc;color:#000000;height:32px"colspan="2"><b>'+blist[0].Project__r.Name+'</b></td></tr>'+
                        '<tr><td style="text-align:center;font-size:13px;border:1px solid grey;padding: 1px;margin: 1px;background-color: #cccccc;color:#000000;height:25px"colspan="2"><b>Details required for filing TDS online-26QB</b></td></tr>'+
                        '<tr><td style="text-align:center;font-size:13px;border:1px solid grey;border-top:none;padding:1px;margin: 1px;width:45%;height:25px" colspan="1"><b>Requisites</b></td><td style="text-align:center;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:1px;margin: 1px;width:55%;height:25px" colspan="1"><b>Information to be filled</b></td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Status</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px" colspan="1"><b>Resident</b></td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Financial Year</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Once date of payment is entered, this will auto generate</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Assessment Year</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Once date of payment is entered, this will auto generate</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Permanent Account No. (PAN) of Transferee(Payer/Buyer)</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Please enter  your PAN</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Permanent Account No. (PAN) of Transferor (Payee/Seller)*</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">'+blist[0].Project__r.Promoter__r.PAN__c+'</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Category of PAN of Transferee</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;;" colspan="1">Individual/Company as the case may be</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Category of PAN of Transferor</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">Company</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Complete Address of the Transferee </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Please provide your Permanent address</td></tr>'+
                        
                        '<tr><td style="text-align:center;font-size:13px;border:1px solid grey;padding: 1px;margin: 1px;height:25px"colspan="2"><b>Complete Address of the Transferor</b></td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Flat | Door | Building</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">Imagine No. 78</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Road | Street | Lane</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">ITPL Road, EPIP Zone, Whitefield</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">City | District*</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">Bangalore</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">State*</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">Karnataka</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Pin Code *</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">560066</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Email ID</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">Taxes.TE@totalenvmt.onmicrosoft.com</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Mobile No.</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">+91 9880001364</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Whether more than one Transferor | Seller*</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">No</td></tr>'+
                        
                        '<tr><td style="text-align:center;font-size:13px;border:1px solid grey;padding: 1px;margin: 1px;height:25px"colspan="2"><b>Property Details</b></td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Type of Property</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">Buildings</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Flat | Door | Building</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Your Unit number,'+blist[0].Project__r.Name+'</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Road | Street | Lane</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">'+blist[0].Project__r.Address__c+'</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">City | District*</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">'+blist[0].Project__r.City__c+'</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">State*</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">'+blist[0].Project__r.State__c+'</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Pin Code *</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">'+blist[0].Project__r.Pincode__c+'</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Date of Agreement | Booking</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Please provide your Agreement date</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Total Value of Consideration (property value)</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Please provide total consideration value (Excluding GST)</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Stamp Duty Value (Property value)</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Please provide total consideration value (excluding taxes )</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Date of payment </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Date of Payment (made to Total Environment)</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Date of tax deduction </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;background-color:#ffd1b3;" colspan="1">Same as Date of payment (made to TE)</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Payment Type </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">If paid as part payment select Instalment</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Whether it is last instalment </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Select Yes/No (only if you are paying last instalment select Yes or else No)</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Whether stamp duty value is higher than sale consideration </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">If the payment is made as last instalment, then please select Yes or else it will disabled</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Stamp Duty Value (Property value) </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Please provide total consideration value (Excluding GST)</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Total amount paid/credited in previous instalments, if any (A) </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">Please mention only Consideration amount on which TDS amount was paid till last instalment.</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Amount Paid/Credited (B) </td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Please key in the total instalment amount including the TDS amount excluding GST</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Total Stamp duty value of the property (C)</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">This will only be enabled if you have chosen Yes for Last Instalment</td></tr>'+
                        
                    /*    '<tr><td style="text-align:center;font-size:13px;border:1px solid grey;padding: 1px;margin: 1px;height:25px"colspan="2"><b>Amount Paid | Credited</b></td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Total Amount Paid/Credited</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Please mention the total installment amount </td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Please enter TDS rate (in %)</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">1.00%</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Basic Tax (TDS Amount to be paid)</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;" colspan="1">Amount will be calculated Automatically based on the above details</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Interest</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">Applicable only if you delayed in making the TDS payment</td></tr>'+
                        '<tr><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;padding-left:5px;margin: 1px;width:45%;height:25px" colspan="1">Penalty</td><td style="text-align:left;font-size:13px;border:1px solid grey;border-top:none;border-left:none;padding-left:5px;margin: 1px;width:55%;height:25px;background-color:#ffd1b3;" colspan="1">In case of delay, Rs. 200 per day applicable from 7th of following month</td></tr>'+  */
                        '</table><br/>'+
                        
                         'For any TDS related query, you can write back to us at <a href="mailto:customer.contracts@total-environment.com">customer.contracts@total-environment.com</a> or speak to your respective sales consultant for immediate response.  <br/>'+
                        '<p style="font-style: italic;">“The content herein is provided only with an intent to assist you and give you quick and easy access to information and does not purport to be a legal document. Though it is our earnest endeavour to offer accurate information, please understand that we shall not be responsible for any sort of discrepancies or change in statutory processes etc.”</p> <br/>'+
                        
                        '<table>'+
                        '<tr><td style="font-size:15px;border:none;padding: 1px;margin: 1px;">Thanks and Regards,</td></tr>'+
                        '<tr><td style="font-size:15px;border:none;padding: 1px;margin: 1px;">Sales Operations team</td></tr>'+
                        '</table>'+
                   //     '<b><img src="https://totalenvironment--sbdev--c.documentforce.com/servlet/servlet.ImageServer?id=015p0000000f6Mt&oid=00Dp00000009ioT&lastMod=1624527034000"/></b><br/>'+  	//Url for sandbox
                      '<b><img src="https://totalenvironment--c.documentforce.com/servlet/servlet.ImageServer?id=0159C000000BSwk&oid=00D2v000002H08a&lastMod=1668497618000"/></b><br/>'+			//Url for Production
                        '<a href="https://www.total-environment.com">www.total-environment.com</a>'+' | '+'<a href="https://www.facebook.com/TotalEnv/">Facebook</a><br/>'+
                        'The Total Environment Story, Click <a href="https://www.youtube.com/watch?v=3VlafRMdM70&feature=youtu.be">here</a> to watch.';
                }
            }
        body = '<p style="font-family:Neo Sans Pro Light;font-size:13px">' + body + '</p>';
        email.setSaveAsActivity(true);
        email.setWhatId(blist[0].id);
        email.setHtmlBody(body); 
        if(blist[0].Unit__r.Unit_Ownership__c != 'JD' && blist[0].Unit__r.Permitted_Use__c != 'Plotted Development'){
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }
         //   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}