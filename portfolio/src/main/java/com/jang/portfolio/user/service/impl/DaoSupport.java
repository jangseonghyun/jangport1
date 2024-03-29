package com.jang.portfolio.user.service.impl;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.beans.factory.InitializingBean;

public abstract class DaoSupport implements InitializingBean {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Override
	public final void afterPropertiesSet() throws IllegalArgumentException, BeanInitializationException {
		// Let abstract subclasses check their configuration.
		checkDaoConfig();

		// Let concrete implementations initialize themselves.
		try {
			initDao();
		}
		catch (Exception ex) {
			throw new BeanInitializationException("Initialization of DAO failed", ex);
		}
	}

	/**
	 * Abstract subclasses must override this to check their configuration.
	 * <p>Implementors should be marked as {@code final} if concrete subclasses
	 * are not supposed to override this template method themselves.
	 * @throws IllegalArgumentException in case of illegal configuration
	 */
	protected abstract void checkDaoConfig() throws IllegalArgumentException;

	/**
	 * Concrete subclasses can override this for custom initialization behavior.
	 * Gets called after population of this instance's bean properties.
	 * @throws Exception if DAO initialization fails
	 * (will be rethrown as a BeanInitializationException)
	 * @see org.springframework.beans.factory.BeanInitializationException
	 */
	protected void initDao() throws Exception {
	}
	
}
