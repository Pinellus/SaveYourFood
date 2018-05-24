package com.pinellus.saveyourfood.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Product implements Comparable<Product> {
	
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
	private String name;
	@Column(unique=true)
	private String ean;
	
	
	
	
	public Long getId() {
		return id;
	}




	public void setId(Long id) {
		this.id = id;
	}




	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}




	public String getEan() {
		return ean;
	}




	public void setEan(String ean) {
		this.ean = ean;
	}




	@Override
	public int compareTo(Product product) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	
	
}
