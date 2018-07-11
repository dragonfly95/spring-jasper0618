package com.orangepump.jasper;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.util.*;

import com.google.gson.Gson;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

//	String firstPrint2 = "firstPrint2";

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );

		return "home";
	}

	// 되는 소스 - 베열로 받기 
	@RequestMapping(value = "/print.do", method = RequestMethod.POST)
	public ModelAndView print(@RequestBody AddressLabel dto, ModelAndView modelAndView) {

		logger.info(dto.toString());
		List<Address> addresses = dto.getList();
		logger.info("addresses.size():::" + addresses.size());
		if(addresses.size() == 0) {
			modelAndView = new ModelAndView("print", null);
		}
		JRDataSource JRdataSource = new JRBeanCollectionDataSource(addresses);

		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("datasource", JRdataSource);
		modelAndView = new ModelAndView("pdfReport2", parameterMap);

		return modelAndView;
	}

    // 1개 컬럼으로 출력
	@RequestMapping(value ="/print2.do", method = RequestMethod.POST)
	public ModelAndView print2(HttpServletRequest request, ModelAndView modelAndView) {

		String json = request.getParameter("list");
		String param1 = request.getParameter("param1");
		String param2 = request.getParameter("param2");

		Gson gson = new Gson();
		AddressLabel dto = gson.fromJson(json, AddressLabel.class);

		List<Address> addresses = dto.getList();
		if(addresses.size() == 0) {
			modelAndView = new ModelAndView("print", null);
		}
		JRDataSource JRdataSource = new JRBeanCollectionDataSource(addresses);

		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("param1", param1);
		parameterMap.put("param2", param2);
		parameterMap.put("datasource", JRdataSource);
		modelAndView = new ModelAndView("firstPrint2", parameterMap);


		return modelAndView;
	}


    // 2개 컬럼으로 출력
	@RequestMapping(value ="/printLabel.do", method = RequestMethod.POST)
	public ModelAndView printLabel(HttpServletRequest request, ModelAndView modelAndView) {

		String json = request.getParameter("list");
		String param1 = request.getParameter("param1");
		String param2 = request.getParameter("param2");

		Gson gson = new Gson();
		AddressLabel dto = gson.fromJson(json, AddressLabel.class);

		List<Address> addresses = dto.getList();
		if(addresses.size() == 0) {
			modelAndView = new ModelAndView("print", null);
		}

		List<SampleLabel> sampleLabels = new ArrayList<SampleLabel>();
		SampleLabel label = null;
		Iterator<Address> iterator = addresses.iterator();
		for (int i = 0; iterator.hasNext(); i++) {
			Address address = (Address) iterator.next();
			if(i % 2 == 0) {
				label = new SampleLabel(address);
				if(addresses.size() == i) {
					sampleLabels.add(label);
				}
			} else {
				label.setNameRight(address.getName());
				label.setPostNoRight(address.getPostNo());
				label.setAddress01Right(address.getAddress01());
				label.setAddress02Right(address.getAddress02());

				sampleLabels.add(label);
			}
		}

		logger.info(sampleLabels.toString());

		JRDataSource JRdataSource = new JRBeanCollectionDataSource(sampleLabels);

		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("param1", param1);
		parameterMap.put("param2", param2);
		parameterMap.put("datasource", JRdataSource);
		modelAndView = new ModelAndView("printLabel", parameterMap);


		return modelAndView;
	}




	// 하드코딩
	@RequestMapping(value = "/pdf.do", method = RequestMethod.GET)
	public ModelAndView generatePDFreport(ModelAndView modelAndView) {

		List<Address> usersList = new ArrayList<Address>();
		usersList.add(new Address("홍길동1","12345","서울 용산구 ", "이촌1동"));
		usersList.add(new Address("홍길동2","12345","서울 용산구 ", "이촌2동"));
		usersList.add(new Address("kildong3","12345","seoul3 ", "이촌2동"));
		usersList.add(new Address("kildong4","12345","seoul4 ", "이촌2동"));

		JRDataSource JRdataSource = new JRBeanCollectionDataSource(usersList);

		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("param1", getDothomeMessage());
		parameterMap.put("param2", "jasper Report");
		parameterMap.put("datasource", JRdataSource);
		modelAndView = new ModelAndView("firstPrint2", parameterMap);

		logger.info("Jasper ============= hello.do");
		logger.info("parameterMap.get(\"param1\")::::" + parameterMap.get("param1"));

		return modelAndView;
	}



	@RequestMapping(value = "/helloworld.do", method = RequestMethod.GET)
	public ModelAndView helloworld(ModelAndView modelAndView) {

		List<Address> usersList = new ArrayList<Address>();
		usersList.add(new Address("홍길동1","12345","서울 용산구 ", "이촌1동"));


		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("param1", getDothomeMessage());
		parameterMap.put("param2", "");
		parameterMap.put("datasource", new JRBeanCollectionDataSource(usersList));
		modelAndView = new ModelAndView("helloworld", parameterMap);

		logger.info("Jasper ============= hello.do");
		logger.info("parameterMap.get(\"param1\")::::" + parameterMap.get("param1"));


		return modelAndView;
	}


	// hello world 가져오기
	private String getDothomeMessage() {
		String str = "";

		try {
			URL url = new URL("http://ahhoinn.dothome.co.kr/myData/hello.txt");
			HttpURLConnection http = (HttpURLConnection)url.openConnection();

			http.setDefaultUseCaches(false);
			http.setDoInput(true);
			http.setDoOutput(true);
			http.setRequestMethod("GET");

			StringBuffer buffer = new StringBuffer();

			OutputStreamWriter outStream = new OutputStreamWriter(http.getOutputStream(), "utf-8");
			PrintWriter writer = new PrintWriter(outStream);
			writer.write(buffer.toString());
			writer.flush();

			// 서버에서내용받기
			InputStreamReader tmp = new InputStreamReader(http.getInputStream(),"utf-8");
			BufferedReader reader = new BufferedReader(tmp);

			str = reader.readLine();

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return str;
	}

}
