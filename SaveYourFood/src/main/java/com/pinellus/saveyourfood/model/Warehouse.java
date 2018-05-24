package com.pinellus.saveyourfood.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Warehouse implements Comparable<Warehouse> {
	
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    private String eanCode;
    private Date dataScadenza;
    private Date dataIngresso;
    private Date dataUsciata;
    private boolean attivo;
    private Date dataUltimaModifica;
	
	
	
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



	public String getEanCode() {
		return eanCode;
	}



	public void setEanCode(String eanCode) {
		this.eanCode = eanCode;
	}



	public Date getDataScadenza() {
		return dataScadenza;
	}



	public void setDataScadenza(Date dataScadenza) {
		this.dataScadenza = dataScadenza;
	}



	public Date getDataIngresso() {
		return dataIngresso;
	}



	public void setDataIngresso(Date dataIngresso) {
		this.dataIngresso = dataIngresso;
	}



	public Date getDataUsciata() {
		return dataUsciata;
	}



	public void setDataUsciata(Date dataUsciata) {
		this.dataUsciata = dataUsciata;
	}



	public boolean isAttivo() {
		return attivo;
	}



	public void setAttivo(boolean attivo) {
		this.attivo = attivo;
	}



	public Date getDataUltimaModifica() {
		return dataUltimaModifica;
	}



	public void setDataUltimaModifica(Date dataUltimaModifica) {
		this.dataUltimaModifica = dataUltimaModifica;
	}



	@Override
	public int compareTo(Warehouse warehouse) {
		return this.getId().compareTo(warehouse.getId());
	}
	
	

}
