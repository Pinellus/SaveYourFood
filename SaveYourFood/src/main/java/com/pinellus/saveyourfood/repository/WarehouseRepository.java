package com.pinellus.saveyourfood.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pinellus.saveyourfood.model.Warehouse;

public interface WarehouseRepository extends JpaRepository<Warehouse, Long>  {
	
	List<Warehouse> findByDataScadenzaLessThanEqual (Date date);
	
	List<Warehouse> findByDataScadenzaBetween (Date from, Date to);

}
