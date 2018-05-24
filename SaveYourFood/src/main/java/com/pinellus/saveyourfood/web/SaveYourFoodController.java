package com.pinellus.saveyourfood.web;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinellus.saveyourfood.model.Product;
import com.pinellus.saveyourfood.model.Warehouse;
import com.pinellus.saveyourfood.repository.ProductRepository;
import com.pinellus.saveyourfood.repository.WarehouseRepository;

@Controller
public class SaveYourFoodController {
	
	public static final String INDEX_PAGE = "index";
	
	@Autowired
	WarehouseRepository warehouseRepository;
	@Autowired
	ProductRepository productRepository;
	
	
	
	
	@RequestMapping("/")
    public String index(){
        return "redirect:/all";
    }
	
	@RequestMapping(value = "/all", method = RequestMethod.GET)
    public String allItems(Model model) {
        
		getProductModel(model);
        
		List<Warehouse> items = warehouseRepository.findAll();
		model.addAttribute("items", items);
		model.addAttribute("filter", "all");
		
        return INDEX_PAGE;
    }
	
	@RequestMapping(value = "/scaduti", method = RequestMethod.GET)
    public String scadenzaItems(Model model) {
        
		getProductModel(model);
        
		List<Warehouse> scaduti = warehouseRepository.findByDataScadenzaLessThanEqual(new Date());
		model.addAttribute("items", scaduti);
		model.addAttribute("filter", "scaduti");
		
        return INDEX_PAGE;
    }
	
	
	@RequestMapping(value = "/scadenza", method = RequestMethod.GET)
    public String scadutiItems(Model model) {
        
		getProductModel(model);
        
		Date to = getDateTo();
		
        Date from = new Date();
		
        List<Warehouse> inScadenza = warehouseRepository.findByDataScadenzaBetween(from, to);
		model.addAttribute("items", inScadenza);
		model.addAttribute("filter", "scadenza");
		
        return INDEX_PAGE;
    }
	
	private void getProductModel(Model model) {
		
		Date to = getDateTo();
		
        Date from = new Date();
        
		List<Warehouse> items = warehouseRepository.findAll();
        
        List<Warehouse> scaduti = warehouseRepository.findByDataScadenzaLessThanEqual(from);
        
        List<Warehouse> inScadenza = warehouseRepository.findByDataScadenzaBetween(from, to);
        
        
        model.addAttribute("scaduti", scaduti.size());
        model.addAttribute("inscadenza", inScadenza.size());
        model.addAttribute("prodotti", items.size());
	}

	private Date getDateTo() {
		//Dieci giorni da oggi
        Calendar c=new GregorianCalendar();
        c.add(Calendar.DATE, 10);
        Date to=c.getTime();
		return to;
	}
	
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
    public String insertItem(@RequestParam String name, @RequestParam String filter, @RequestParam String ean, @RequestParam String datascadenza) throws ParseException {
		
		Warehouse warehouse = new Warehouse();
		warehouse.setEanCode(ean);
		warehouse.setName(name);
		
		//Data Scadenza
		DateFormat sourceFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date = sourceFormat.parse(datascadenza);
		
		warehouse.setDataScadenza(date);
		
		try {
		
			warehouseRepository.save(warehouse);
		
		} catch (Exception e) {
			e.printStackTrace();
		}	
			
		//Cerca l'EAN
		Product prodotto = productRepository.findByEan(ean);
		
		try {
			
			
			//Se l'EAN non esiste, inserisci il prodotto in catalogo
			if (prodotto == null) {
				
				Product pNew = new Product();
				pNew.setEan(ean);
				pNew.setName(name);
				
				productRepository.save(pNew);
				
			} else {
			
			//Se l'EAN esiste possiamo aggiornare la descrizione
				
				prodotto.setName(name);
				productRepository.save(prodotto);
				
					
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
        return "redirect:" + filter;
    }
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String deleteItem(@RequestParam Long id, @RequestParam String filter) {
		Warehouse warehouse = warehouseRepository.findOne(id);

        if(warehouse != null) {
        	warehouseRepository.delete(warehouse);
        }

        return "redirect:" + filter;
    }
	
	@RequestMapping("/getProductName")
	public @ResponseBody String getProductName(@RequestParam("ean") String ean) {
		
		Product prodotto = productRepository.findByEan(ean);

		if (prodotto != null) {
			return prodotto.getName();
			
		} else {
			
			return "";
			
		}
			
		
	}
	
	
}
