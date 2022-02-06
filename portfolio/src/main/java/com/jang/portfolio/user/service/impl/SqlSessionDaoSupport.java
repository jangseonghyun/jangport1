package com.jang.portfolio.user.service.impl;
import static org.springframework.util.Assert.notNull;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;

public abstract class SqlSessionDaoSupport extends DaoSupport{
	
	  private SqlSession sqlSession;

	  private boolean externalSqlSession;

	  public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
	    if (!this.externalSqlSession) {
	      this.sqlSession = new SqlSessionTemplate(sqlSessionFactory);
	    }
	  }

	  public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
	    this.sqlSession = sqlSessionTemplate;
	    this.externalSqlSession = true;
	  }

	  /**
	   * Users should use this method to get a SqlSession to call its statement methods
	   * This is SqlSession is managed by spring. Users should not commit/rollback/close it
	   * because it will be automatically done.
	   *
	   * @return Spring managed thread safe SqlSession
	   */
	  public SqlSession getSqlSession() {
	    return this.sqlSession;
	  }

	  /**
	   * {@inheritDoc}
	   */
	  @Override
	  protected void checkDaoConfig() {
	    notNull(this.sqlSession, "Property 'sqlSessionFactory' or 'sqlSessionTemplate' are required");
	  }
	 
}
