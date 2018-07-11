package com.orangepump.jasper;


import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRField;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
public class JasperController {

    private static final Logger logger = LoggerFactory.getLogger(JasperController.class);

    @RequestMapping("/blankJasper.do")
  public ModelAndView helloworld(ModelAndView modelAndView) {

        Map<String,Object> parameterMap = new HashMap<String,Object>();
      parameterMap.put("datasource", new JREmptyDataSource());
      modelAndView = new ModelAndView("blank", parameterMap);

      return modelAndView;
  }
}
