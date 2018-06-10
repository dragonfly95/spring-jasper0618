package com.orangepump.jasper;

public class SampleLabel {

	private String name;
	private String postNo;
	private String address01;
	private String address02;
	
	private String nameRight;
	private String postNoRight;
	private String address01Right;
	private String address02Right;
	
	public SampleLabel() {}
	
	public SampleLabel(Address addr) {
		this.name = addr.getName();
		this.postNo = addr.getPostNo();
		this.address01 = addr.getAddress01();
		this.address02 = addr.getAddress02();
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
	public String getNameRight() {
		return nameRight;
	}
	public void setNameRight(String nameRight) {
		this.nameRight = nameRight;
	}
	public String getPostNoRight() {
		return postNoRight;
	}
	public void setPostNoRight(String postNoRight) {
		this.postNoRight = postNoRight;
	}
	public String getAddress01Right() {
		return address01Right;
	}
	public void setAddress01Right(String address01Right) {
		this.address01Right = address01Right;
	}
	public String getAddress02Right() {
		return address02Right;
	}
	public void setAddress02Right(String address02Right) {
		this.address02Right = address02Right;
	}

	@Override
	public String toString() {
		return "SampleLabel [name=" + name + ", postNo=" + postNo + ", address01=" + address01 + ", address02="
				+ address02 + ", nameRight=" + nameRight + ", postNoRight=" + postNoRight + ", address01Right="
				+ address01Right + ", address02Right=" + address02Right + "]";
	}
	
	
}
