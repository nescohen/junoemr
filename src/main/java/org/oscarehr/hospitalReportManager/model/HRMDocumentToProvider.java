package org.oscarehr.hospitalReportManager.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.oscarehr.common.model.AbstractModel;

@Entity
public class HRMDocumentToProvider extends AbstractModel<Integer>  {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	private String providerNo;
	private String hrmDocumentId;
	private Integer signedOff;
	private Date signedOffTimestamp;
	
	@Override
    public Integer getId() {
	    return id;
    }

	public String getProviderNo() {
    	return providerNo;
    }

	public void setProviderNo(String providerNo) {
    	this.providerNo = providerNo;
    }

	public Integer getSignedOff() {
    	return signedOff;
    }

	public void setSignedOff(Integer signedOff) {
    	this.signedOff = signedOff;
    }

	public Date getSignedOffTimestamp() {
    	return signedOffTimestamp;
    }

	public void setSignedOffTimestamp(Date signedOffTimestamp) {
    	this.signedOffTimestamp = signedOffTimestamp;
    }

	public String getHrmDocumentId() {
    	return hrmDocumentId;
    }

	public void setHrmDocumentId(String hrmDocumentId) {
    	this.hrmDocumentId = hrmDocumentId;
    }
	
	
}