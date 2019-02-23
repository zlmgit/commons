package com.house.service.impl;

import com.house.bean.House;
import com.house.mapper.HouseMapper;
import com.house.service.HouseService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zlm
 * @since 2019-02-15
 */
@Service
public class HouseServiceImpl extends ServiceImpl<HouseMapper, House> implements HouseService {

}
