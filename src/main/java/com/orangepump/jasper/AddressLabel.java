package com.orangepump.jasper;

import java.util.List;

public class AddressLabel {
	
	private List<Label> list;


    public List<Label> getList() {
		return list;
	}


	public void setList(List<Label> list) {
		this.list = list;
	}

    
	@Override
	public String toString() {
		return "AddressLabel [list=" + list + "]";
	}


	//=======================================================
	public static class Label {

		private String name;
		private String postNo;
		private String address01;
		private String address02;

		
		public Label() {} 
		
		public Label(String name, String postNo, String address01, String address02) {
			this.name = name;
			this.postNo = postNo;
			this.address01 = address01;
			this.address02 = address02;
		}
		

		@Override
		public String toString() {
			return "AddressLabel [name=" + name + ", postNo=" + postNo + ", address01=" + address01 + ", address02="
					+ address02 + "]";
		}

		
		public String getName() {
			return name;
		}
		public String getPostNo() {
			return postNo;
		}
		public String getAddress01() {
			return address01;
		}
		public String getAddress02() {
			return address02;
		}

		
		public void setName(String name) {
			this.name = name;
		}

		public void setPostNo(String postNo) {
			this.postNo = postNo;
		}

		public void setAddress01(String address01) {
			this.address01 = address01;
		}

		public void setAddress02(String address02) {
			this.address02 = address02;
		}

	}
}
