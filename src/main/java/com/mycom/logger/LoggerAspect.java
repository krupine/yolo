package com.mycom.logger;

import java.util.Arrays;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class LoggerAspect {


	//private : �ܺο��� �α׸� ����ä�� ���ϵ��� �ϱ� ����
	//static final : �α� ������ �ٲ��� �����Ƿ�
	// �α����� ����ϴ� ���� : sysout ��ɾ�� IO ���ҽ��� ���� ����Ͽ� �ý����� ������ �� �ִ�, �α׸� ���Ϸ� �����Ͽ� �м��� �ʿ䰡 �ִ�.
	

	private static final Log log = LogFactory.getLog(LoggerAspect.class);
	static String name = "";
	static String type = "";
	
	//Controller,Service,DAO�� ��� Method�� ���� ���Ŀ� LogPrint method�� �ڵ����� ����ȴ�.
	// .. : ������ ��� ���丮�� �ǹ�
	// *(..) : * - ������ ��� �޼���, (..) - ��� �Ű�����
	@Around("execution(* com.feline..*Controller.*(..)) or execution(* com.feline..*Service.*(..))")
	public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable {
		//���� �ð� üũ : ���� �ð�
		long start = System.currentTimeMillis();

		
		type = joinPoint.getSignature().getDeclaringTypeName();
		
		//Controller ���
		if(type.indexOf("Controller") > -1) {
			name = "Controller	\t:		";
		} 
		//Service ���
		else if(type.indexOf("Service") > -1) {
			name = "Service		\t:		";
		}
		
		//�޼��� �̸�
		log.debug(name+type + "."+ joinPoint.getSignature().getName()+"()");
		
		//�Ķ���� �̸�
		log.info(Arrays.toString(joinPoint.getArgs()));
		
		//���� �ð� üũ: ����ð�
		long end = System.currentTimeMillis();
		
		long time = end-start;
		
		log.debug("���� �ð�:"+time+"(ms)");
		
		return joinPoint.proceed();
		
	}
}
