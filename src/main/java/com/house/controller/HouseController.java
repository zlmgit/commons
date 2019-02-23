package com.house.controller;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jws.WebParam.Mode;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.house.bean.House;
import com.house.bean.HouseQuery;
import com.house.bean.Housetype;
import com.house.service.HouseService;
import com.house.service.HousetypeService;
import com.house.util.Pager;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zlm
 * @since 2019-02-15
 */
@Controller
@RequestMapping("/house")
public class HouseController {
	
	@Autowired
	private HouseService houseService;
	
	@Autowired
	private HousetypeService housetypeService;
	/**显示全部*/
	@RequestMapping("/list")
	public String list(Model model) {
		
		List<House> list = houseService.selectList(null);
		model.addAttribute("houses", list);
		return "/list.jsp";
	}
	/**新增之查询房屋类型*/
	@RequestMapping("/add")
	public String add(Model model) {
		List<Housetype> selectList = housetypeService.selectList(null);
		
		model.addAttribute("types", selectList);
		
		return "/add.jsp";
	}
	/**新增房屋*/
	@RequestMapping("/inserthouse")
	public void inserthouse(House house,HttpServletResponse response)throws Exception {
		response.setContentType("text/html;charset=utf-8");
		house.setCreatedate(new Date());
		boolean b = houseService.insert(house);
		if(b) {
			response.getWriter().write("<script>alert('添加成功');location.href='/house/list'</script>");
		}else {
			response.getWriter().write("<script>alert('添加失败');location.href='/house/add'</script>");
		}				
	}
	/**显示全部分页显示*/
	@RequestMapping("/show/{pageNum}/{pageSize}")
	public String showHouses(HouseQuery houseQuery,
			@PathVariable("pageNum")Integer pageNum,
			@PathVariable("pageSize")Integer pageSize,Model model) {
		Page<House> page= new Page<House>(pageNum,pageSize);
		EntityWrapper<House> entityWrapper =new EntityWrapper<>();
		if(houseQuery!=null&&houseQuery.getTitle()!=null&&!houseQuery.getTitle().equals("")) {
			entityWrapper.like("title", houseQuery.getTitle());
		}
		if(houseQuery!=null&&houseQuery.getStartDate()!=null&&!houseQuery.getStartDate().equals("")) {
			entityWrapper.ge("createdate", houseQuery.getStartDate());
		}
		if(houseQuery!=null&&houseQuery.getEndDate()!=null&&!houseQuery.getEndDate().equals("")) {
			entityWrapper.le("createdate", houseQuery.getEndDate());
		}
		entityWrapper.orderBy("id", false);
		Page<House> pages = houseService.selectPage(page, entityWrapper);
		//每页数据集合
		List<House> houses = pages.getRecords();
		for (House house : houses) {
			Integer typeid = house.getTypeid();
			Housetype housetype = housetypeService.selectById(typeid);
			house.setHousetype(housetype);
		}
		//总条数
		int totalCount = ((Long)pages.getTotal()).intValue();
		//总页数
		Integer pageCount = ((Long)pages.getPages()).intValue();
		
		Pager<House> pager= new Pager<>(pageNum, pageSize, pageCount, totalCount, houses);
		
		model.addAttribute("pager", pager);
		model.addAttribute("query", houseQuery);
		return "/list.jsp";
	}
	/**异步更改状态*/
	@RequestMapping("/changeState")
	public void changeState(Integer id,Integer state,HttpServletResponse response)throws Exception {
		House house = houseService.selectById(id);
		house.setState(state);
		boolean b = houseService.updateById(house);
		if(b) {
			response.getWriter().write("true");
		}else {
			response.getWriter().write("false");
		}	
	}
	/**批量删除*/
	@RequestMapping("/deleteHouseByid")
	public void deleteHouseByid(@RequestParam(value="cid")List<Integer> cid,HttpServletResponse response)throws Exception {
		response.setContentType("text/html;charset=utf-8");
		boolean b = houseService.deleteBatchIds(cid);
		if(b) {
			response.getWriter().write("<script>alert('删除成功');location.href='/house/show/1/5'</script>");
		}else {
			response.getWriter().write("<script>alert('删除失败');location.href='/house/show/1/5'</script>");
		}	
	}
}

