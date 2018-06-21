package com.orangepump.jasper;

import java.util.List;

public class AddressLabel {
	
	private List<Address> list;

    public List<Address> getList() {
		return list;
	}

	public void setList(List<Address> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "AddressLabel [list=" + list + "]";
	}
}
