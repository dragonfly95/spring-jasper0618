package com.orangepump.jasper;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TestMain {

	private static final Logger logger = LoggerFactory.getLogger(TestMain.class);
	
	public static void main(String args[]) {

		List<Address> adr = new ArrayList<Address>();
		adr.add(new Address("홍길동1","123","서울1","서빙고동1",1));
		adr.add(new Address("홍길동2","123","서울2","서빙고동1",2));
		adr.add(new Address("홍길동3","123","서울3","서빙고동1",3));
		adr.add(new Address("홍길동4","123","서울4","서빙고동1",4));
		adr.add(new Address("홍길동5","123","서울5","서빙고동1",5));
		
		int total = adr.size();
		ArrayList<SampleLabel> arrayList = new ArrayList<SampleLabel>();
		
		SampleLabel labels = null;
		Iterator<Address> iterator = adr.iterator();
		while(iterator.hasNext()) {
			Address nextAddr = iterator.next();
			if(nextAddr.get__rowNum__() % 2 == 1) {
			    labels = new SampleLabel(nextAddr);
			} else {
				labels.setNameRight(nextAddr.getName());
				labels.setPostNoRight(nextAddr.getPostNo());
				labels.setAddress01Right(nextAddr.getAddress01());
				labels.setAddress02Right(nextAddr.getAddress02());
				arrayList.add(labels);
			}
			
		    // 마지막은 그냥 더한다. 
		    if(total == nextAddr.get__rowNum__()) {
				labels.setNameRight("");
				labels.setPostNoRight("");
				labels.setAddress01Right("");
				labels.setAddress02Right("");
				arrayList.add(labels);
		    }
		}
		
		
		// 검증 
		logger.info("label arrayList = " + arrayList.size());
		Iterator<SampleLabel> iterator2 = arrayList.iterator();
		while(iterator2.hasNext()) {
			logger.info(iterator2.next().toString());
		}
	}
}
