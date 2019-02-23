package com.house.util;

import java.util.ArrayList;
import java.util.List;

public class Pager<T> {
	
	private Integer pageIndex;//当前页面
	private Integer pageSize;//页面大小
	private Integer pageCount;//总页数
	private Integer totalCount;//总条数
	
	private List<T> records;//查询结果
	
	private int startPage=1;//开始的数字	
	private int endPage;//结束的数字
	
	private List<Integer> numbers=new ArrayList<Integer>();//存储页面中显示的页码
	
	public Pager(Integer pageIndex, Integer pageSize, Integer pageCount, Integer totalCount, List<T> records) {
		super();
		this.pageIndex = pageIndex;
		this.pageSize = pageSize;
		this.pageCount = pageCount;
		this.totalCount = totalCount;
		this.records = records;
		
		
		//一共显示10个页面 动态伸缩
		if (pageCount <= 10) {
			this.startPage = 1;
			this.endPage = pageCount;
		} else {
			this.startPage = pageIndex - 4;
			this.endPage = pageIndex + 5;
			if (startPage < 1) {
				this.startPage = 1;
				this.endPage = 10;
			} else if (endPage > pageCount) {
				this.endPage = pageCount;
				this.startPage = pageCount - 9;
			}
		}

		
		for (int i = startPage; i <= endPage; i++) {
			numbers.add(i);
		}
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getPageCount() {
		return pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public List<T> getRecords() {
		return records;
	}

	public void setRecords(List<T> records) {
		this.records = records;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public List<Integer> getNumbers() {
		return numbers;
	}

	public void setNumbers(List<Integer> numbers) {
		this.numbers = numbers;
	}
	
}
