package org.oscarehr.eyeform.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.validator.DynaValidatorForm;
import org.oscarehr.eyeform.dao.TestBookRecordDao;
import org.oscarehr.eyeform.model.TestBookRecord;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.SpringUtils;

public class TestBookAction extends DispatchAction {

	public ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        return form(mapping, form, request, response);
    }

    public ActionForward cancel(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        return form(mapping, form, request, response);
    }

    public ActionForward form(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
    	TestBookRecordDao dao = (TestBookRecordDao)SpringUtils.getBean("TestBookDAO");
    	
    	
    	DynaValidatorForm f = (DynaValidatorForm)form;
    	TestBookRecord data = (TestBookRecord)f.get("data");
    	if(data.getId() != null && data.getId().intValue()>0) {
    		data = dao.find(data.getId()); 
    	}
    	
    	f.set("data", data);
    	        
        return mapping.findForward("form");
    }
    
    public ActionForward save(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {    	
    	DynaValidatorForm f = (DynaValidatorForm)form;
    	TestBookRecord data = (TestBookRecord)f.get("data");
    	if(data.getId()!=null && data.getId()==0) {
    		data.setId(null);
    	}
    	TestBookRecordDao dao = (TestBookRecordDao)SpringUtils.getBean("TestBookDAO");
    	data.setProvider(LoggedInInfo.loggedInInfo.get().loggedInProvider.getProviderNo());	
    	dao.save(data);
    	
    	return mapping.findForward("success");
    }
}