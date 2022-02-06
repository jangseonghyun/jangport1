package com.jang.portfolio.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;

public abstract class UserAbstractMapper extends SqlSessionDaoSupport{
	
	@Resource(name="sqlSession")
	public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
		super.setSqlSessionFactory(sqlSession);
	}
	
	//Insert
	public int insert(String queryId) {
		return getSqlSession().insert(queryId);
	}

	public int insert(String queryId, Object param) {
		return getSqlSession().insert(queryId, param);
	}
	
	//Update
	public int update(String queryId) {
		return getSqlSession().update(queryId);
	}
	

	public int update(String queryId, Object param) {
		return getSqlSession().update(queryId, param);
	}
	
	//Delete 
	public int delete(String queryId) {
		return getSqlSession().delete(queryId);
	}
	

	public int delete(String queryId, Object param) {
		return getSqlSession().delete(queryId, param);
	}
	
	//select
	public int selectOne(String queryId) {
		return getSqlSession().selectOne(queryId);
	}
	
	public <T> T selectOne(String queryId, Object param) {
		return getSqlSession().selectOne(queryId, param);
	}
	
	public <E> List<E> selectList(String queryId, Object param){
		return getSqlSession().selectList(queryId, param);
	}
}
