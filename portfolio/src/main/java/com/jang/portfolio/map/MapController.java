package com.jang.portfolio.map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/map")
public class MapController {

	//@Autowired
	
	@RequestMapping(value="/map" , method = RequestMethod.GET)
	public String map() {
		
		return "map/map";
	}
}
