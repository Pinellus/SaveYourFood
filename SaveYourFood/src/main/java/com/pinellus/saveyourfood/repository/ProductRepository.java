package com.pinellus.saveyourfood.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pinellus.saveyourfood.model.Product;

public interface ProductRepository extends JpaRepository<Product, Long>{
	
	Product findByEan (String ean);

}
