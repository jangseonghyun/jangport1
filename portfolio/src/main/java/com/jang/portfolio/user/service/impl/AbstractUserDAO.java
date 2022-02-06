package com.jang.portfolio.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class AbstractUserDAO extends UserAbstractMapper {
	
	private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="sqlSessionFactory")
	public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
		super.setSqlSessionFactory(sqlSession);
	}
	
	//insert
	@Override
	public int insert(String queryId) {
		LOGGER.debug("queryId : "+queryId);
		return getSqlSession().insert(queryId);
	}
	
	@Override
	public int insert(String queryId, Object param) {
		LOGGER.debug("queryId : "+queryId);
		LOGGER.debug("param : "+param);
		return getSqlSession().insert(queryId, param); 
	}
	
	//update 
	@Override
	public int update(String queryId) {
		LOGGER.debug("queryId : "+queryId);
		return getSqlSession().update(queryId);
	}
	
	@Override
	public int update(String queryId, Object param) {
		LOGGER.debug("queryId : "+queryId);
		LOGGER.debug("param : "+param);
		return getSqlSession().update(queryId, param);
	}
	
	//Delete 
	@Override
	public int delete(String queryId) {
		LOGGER.debug("queryId : "+queryId);
		return getSqlSession().delete(queryId);
	}
	
	@Override
	public int delete(String queryId, Object param) {
		LOGGER.debug("queryId : "+queryId);
		LOGGER.debug("param : "+param);
		return getSqlSession().delete(queryId, param);
	}
	
	//select
	
	@Override
	public int selectOne(String queryId) {
		LOGGER.debug("queryId : "+queryId);
		return getSqlSession().selectOne(queryId);
	}
	/*
	@Override
	public int selectOne(String queryId, Object param) {
		LOGGER.debug("queryId : "+queryId);
		LOGGER.debug("param : "+param);
		return getSqlSession().selectOne(queryId, param);
	}
	*/
	
	@Override
	public <T> T selectOne(String queryId, Object param) {
		LOGGER.debug("queryId : "+queryId);
		return getSqlSession().selectOne(queryId, param);
	}
	
	@Override
	public <E> List<E> selectList(String queryId, Object param){
		LOGGER.debug("queryId : "+queryId);
		return getSqlSession().selectList(queryId, param);
	}
	
}
