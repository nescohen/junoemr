/**
 * Copyright (c) 2007-2009. CAISI, Toronto. All Rights Reserved.
 * This software is published under the GPL GNU General Public License. 
 * This program is free software; you can redistribute it and/or 
 * modify it under the terms of the GNU General Public License 
 * as published by the Free Software Foundation; either version 2 
 * of the License, or (at your option) any later version. * 
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
 * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License 
 * along with this program; if not, write to the Free Software 
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. * 
 * 
 * This software was written for 
 * CAISI, 
 * Toronto, Ontario, Canada 
 */

package org.oscarehr.common.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import org.oscarehr.common.model.OcanStaffForm;
import org.springframework.stereotype.Repository;

@Repository
public class OcanStaffFormDao extends AbstractDao<OcanStaffForm> {

	public OcanStaffFormDao() {
		super(OcanStaffForm.class);
	}
	
	public OcanStaffForm findLatestCompletedInitialOcan(Integer facilityId, Integer clientId) {

		String sqlCommand = "select * from OcanStaffForm where facilityId=?1 and clientId=?2 and assessmentStatus=?3 and reasonForAssessment=?4 order by created desc limit 1";

		Query query = entityManager.createNativeQuery(sqlCommand, modelClass);
		query.setParameter(1, facilityId);
		query.setParameter(2, clientId);
		query.setParameter(3, "Completed");
		query.setParameter(4, "IA");
				
		return getSingleResultOrNull(query);
	}

	
	
	public OcanStaffForm findLatestCompletedReassessment(Integer facilityId, Integer clientId) {

		String sqlCommand = "select * from OcanStaffForm where facilityId=?1 and clientId=?2 and assessmentStatus=?3 and reasonForAssessment=?4 order by created desc limit 1";

		Query query = entityManager.createNativeQuery(sqlCommand, modelClass);
		query.setParameter(1, facilityId);
		query.setParameter(2, clientId);
		query.setParameter(3, "Completed");
		query.setParameter(4, "RA");
				
		return getSingleResultOrNull(query);
	}
	
	public OcanStaffForm findLatestCompletedDischargedAssessment(Integer facilityId, Integer clientId) {

		String sqlCommand = "select * from OcanStaffForm where facilityId=?1 and clientId=?2 and assessmentStatus=?3 and reasonForAssessment=?4 order by created desc limit 1";

		Query query = entityManager.createNativeQuery(sqlCommand, modelClass);
		query.setParameter(1, facilityId);
		query.setParameter(2, clientId);
		query.setParameter(3, "Completed");
		query.setParameter(4, "DIS");
				
		return getSingleResultOrNull(query);
	}
	
	public OcanStaffForm findLatestByFacilityClient(Integer facilityId, Integer clientId, String ocanType) {

		String sqlCommand = "select * from OcanStaffForm where facilityId=?1 and clientId=?2 and ocanType=?4 order by created desc, id desc limit 1";

		Query query = entityManager.createNativeQuery(sqlCommand, modelClass);
		query.setParameter(1, facilityId);
		query.setParameter(2, clientId);
		//query.setParameter(3, "In Progress");
		query.setParameter(4, ocanType);
		
		return getSingleResultOrNull(query);
	}

	public OcanStaffForm getLastCompletedOcanForm(Integer facilityId, Integer clientId) {

		String sqlCommand = "select * from OcanStaffForm where facilityId=?1 and clientId=?2 and assessmentStatus=?3 order by created desc limit 1";

		Query query = entityManager.createNativeQuery(sqlCommand, modelClass);
		query.setParameter(1, facilityId);
		query.setParameter(2, clientId);
		query.setParameter(3, "Completed");
		//query.setParameter(4, ocanType);
		
		return getSingleResultOrNull(query);
	}

    public List<OcanStaffForm> findByFacilityClient(Integer facilityId, Integer clientId, String ocanType) {

		String sqlCommand = "select x from OcanStaffForm x where x.facilityId=?1 and x.clientId=?2 and x.ocanType=?3 order by x.created desc";

		Query query = entityManager.createQuery(sqlCommand);
		query.setParameter(1, facilityId);
		query.setParameter(2, clientId);
		query.setParameter(3, ocanType);
		
		@SuppressWarnings("unchecked")
		List<OcanStaffForm> results=query.getResultList();
		
		return (results);
	}

    public OcanStaffForm findOcanStaffFormById(Integer ocanStaffFormId) {
    	String sqlCommand = "select * from OcanStaffForm where id=?1 ";

		Query query = entityManager.createNativeQuery(sqlCommand, modelClass);
		query.setParameter(1, ocanStaffFormId);		
		
		return getSingleResultOrNull(query);
    }
    
    public List<OcanStaffForm> findLatestSignedOcanForms(Integer facilityId, String formVersion, Date startDate, Date endDate,String ocanType) {
		
		String sqlCommand="select x from OcanStaffForm x where x.facilityId=?1 and x.assessmentStatus=?2 and x.ocanFormVersion=?3 and x.startDate>=?4 and x.startDate<?5 and x.ocanType=?6 order by x.assessmentId ASC, x.created DESC";

		Query query = entityManager.createQuery(sqlCommand);
		query.setParameter(1, facilityId);
		query.setParameter(2, "Completed");
		query.setParameter(3, formVersion);
		query.setParameter(4, startDate);
		query.setParameter(5, endDate);
		query.setParameter(6, ocanType);
		
		@SuppressWarnings("unchecked")
		List<OcanStaffForm> results=query.getResultList();	
		
		//Because staff could modify completed assessment. So it one assessment ID could have multiple assessment records.
		//Only export the one with latest update.
		List<OcanStaffForm> list = new ArrayList<OcanStaffForm>();
		int assessmentId_0=0;
		for(OcanStaffForm res:results) {
			int assessmentId_1 = res.getAssessmentId().intValue();
			if(assessmentId_0!=assessmentId_1) {
				assessmentId_0 = assessmentId_1;
				list.add(res);
			}
		}
		return list;
	
    }
    
    public List<OcanStaffForm> findUnsubmittedOcanForms(Integer facilityId) {
		
		String sqlCommand="select x from OcanStaffForm x where x.facilityId=?1 and x.assessmentStatus=?2 and x.submissionId=0 order by x.created DESC";

		Query query = entityManager.createQuery(sqlCommand);
		query.setParameter(1, facilityId);
		query.setParameter(2, "Completed");
		
		@SuppressWarnings("unchecked")
		List<OcanStaffForm> results=query.getResultList();
		return(results);				
    }
    
    public List<OcanStaffForm> findAllByFacility(Integer facilityId) {

		String sqlCommand = "select x from OcanStaffForm x where x.facilityId=?1 order by x.created desc";

		Query query = entityManager.createQuery(sqlCommand);
		query.setParameter(1, facilityId);
				
		@SuppressWarnings("unchecked")
		List<OcanStaffForm> results=query.getResultList();
		
		return (results);
	}
    
    public List<OcanStaffForm> findBySubmissionId(Integer facilityId,Integer submissionId) {
    	String sqlCommand = "select x from OcanStaffForm x where x.facilityId=?1 and x.submissionId=?2 order by x.created desc";

		Query query = entityManager.createQuery(sqlCommand);
		query.setParameter(1, facilityId);		
		query.setParameter(2, submissionId);
				
		@SuppressWarnings("unchecked")
		List<OcanStaffForm> results=query.getResultList();
		
		return (results);
    }
    
    
}