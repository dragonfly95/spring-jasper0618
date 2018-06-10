package com.orangepump.jasper;

//--------------------------------------------------
public class Address {
	
	private String name;
	private String postNo;
	private String address01;
	private String address02;
	
	public Address() {}
	
	
	public Address(String name, String postNo, String address01, String address02) {
		super();
		this.name = name;
		this.postNo = postNo;
		this.address01 = address01;
		this.address02 = address02;
	}


	@Override
	public String toString() {
		return "Address [name=" + name + ", postNo=" + postNo + ", address01=" + address01 + ", address02="
				+ address02 + "]";
	}


	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPostNo() {
		return postNo;
	}
	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}
	public String getAddress01() {
		return address01;
	}
	public void setAddress01(String address01) {
		this.address01 = address01;
	}
	public String getAddress02() {
		return address02;
	}
	public void setAddress02(String address02) {
		this.address02 = address02;
    }
}