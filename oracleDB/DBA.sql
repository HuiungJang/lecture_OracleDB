SELECT * FROM DICT;
--오라클db에 대한 정보를 가지고 있는 테이블 : DATA DICTIONARY라고 함.
SELECT * FROM DICTIONARY;
--현재 DB에 등록된 사용자계정 정보보기
SELECT * FROM DBA_USERS;

-- 계정은 관리자 계정, 사용자 계정
-- 관리자계정 : 사용자 계정을 등록, 권한부여 하고, 전체 생성된 TABLE를 관리하는 역할 -> DBBASE를 전체적으로 관리
-- SYSTEM : 일반관리자 데이터 베이스자체를 생성, 삭제할 수 없음
-- SYS : 슈퍼관리자 데이터베이스 생성, 삭제, DATADICTIONARY 소유자 최고 관리자!

-- 기본적으로 오라클 DATA BASE를 이용하기 위해선 사용자 계정이 필요함.
-- 사용자 계정만들기, 계정 생성 후 이용권한부여
-- 사용자 계정은 SYSTEM, SYS AS SYSDBA 계정으로 명령어를 써야함.
-- CREATE USER 유저명 IDENTIFIED BY 비밀번호;
CREATE USER KH IDENTIFIED BY KH;
SELECT * FROM DBA_USERS;
-- 사용자계정은 CREATE로 생성한다고 해서 무조건 DB이용이 가능한것이 아님
-- 이용할 수 있는 권한을 SYSTEM/SYS계정이 부여해줘야함.
-- GRANT 권한명(ROLE) TO 사용자계정명;
-- RESOURCE, CONNECT권한(ROLE)을 부여한다.
GRANT RESOURCE, CONNECT TO KH;

-- test계정 생성 후 접속 하는것 
CREATE USER TEST IDENTIFIED BY TEST;
--RESOURCE, CONNECT 
-- -> RESOURCE 테이블을 생성 조작할 수 있는 권한
-- -> CONNECT 할당된 영역에 접속할 수 있는 권한
GRANT RESOURCE, CONNECT TO TEST;

-- KH계정 정보 확인하기
SELECT * FROM TAB; --계정이 가지고 있는 전체 테이블을 조회

-- 생성된 KH계정의 테이블확인해보자
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;
SELECT * FROM LOCATION;
SELECT * FROM SAL_GRADE;
SELECT * FROM NATIONAL;

-- KH계정의 EMPLOYEE 테이블을 조회해보자.
-- 사번(EMP_ID),이름(EMP_NAME), 월급(SALARY) 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 사원이름, 이메일, 부서코드, 직책코드 조회하기
SELECT EMP_NAME, EMAIL, DEPT_CODE,JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE테이블에 있는 전체 컬럼을 조회하세요!
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, 
       PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, 
       SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;
-- 테이블에 있는 컬럼을 전체 조회할때는 *을 사용하자
SELECT * 
FROM EMPLOYEE;


-- SELECT문은 단순히 조회뿐만 아니라 조회할때 산술연산처리도 가능
-- 단 산술연산은 숫자형타입을 계산
-- SELECT 컬럼명||리터럴값
SELECT 10*100
FROM DUAL; -- DUAL테이블은 오라클에서 기본제공하는 테이블로 간단한 테스트를 위한 테이블

-- SELECT문에서 산술연산할때는 컬럼명을 가져와 계산할 수도 있음
SELECT * 
FROM EMPLOYEE;

-- 사원의 연봉을 구하자
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;
-- 각 사원의 보너스를 구하자
SELECT EMP_NAME,SALARY, BONUS, SALARY*BONUS
FROM EMPLOYEE;

-- 컬럼값이 NULL인 ROW는 값이 없는것 쓰레기 -> 쓰레기 계산이 X

-- EMPLOYEE 테이블에서 사원명, 부서코드, 직책코드, 월급, 연봉, 보너스 포함한 연봉 조회하기
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, 
        SALARY, SALARY*12, (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;

-- RESULTSET의 컬럼명 변경하기 컬럼명에 별칭부여하기
-- 컬럼명 AS 별칭명, 컬럼명 별칭, 
SELECT EMP_NAME, EMAIL, PHONE 
FROM EMPLOYEE;
SELECT EMP_NAME AS 사원명, EMAIL AS 이메일, PHONE 전화번호
FROM EMPLOYEE;

-- 별칭은 아무거나 다 사용이 가능한가? 띄어쓰기 특수기호
-- 특수기호, 첫글자숫자, 띄어쓰기를 사용할때는 ""으로 감싸야함.
-- ""로 감싼것은 문자열 리터럴이 아니다! 자바랑 다름!!!! -> 문자열리터럴 '' 으로 표시
SELECT EMP_NAME AS "사 원 명", EMAIL AS "^이메일",
     DEPT_CODE AS "1부서"
FROM EMPLOYEE;

-- SELECT절에서 문자열리터럴 사용하기
SELECT EMP_NAME,'님', SALARY,'원'
FROM EMPLOYEE;

-- 행에서 중복값을 제거하고 출력하기
-- DISTINCT : 중복된 행의 값을 한개만 출력
SELECT JOB_CODE
FROM EMPLOYEE;
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- JOB_CODE 출력할때 중복되는 값은 한개만 출력

SELECT JOB_CODE, DISTINCT DEPT_CODE
FROM EMOPLOYEE; -- DISTINCT는 SELECT문에서 한번 사용이 가능함. SELECT 맨 앞에.

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;

-- 컬럼, 리터럴을 연결해보자.
-- || 연산자 : SELECT 에 작성된 컬럼||리터럴을 한개의 컬럼으로 합쳐주는 기능
SELECT EMP_NAME,'님',SALARY,'원'
FROM EMPLOYEE;

SELECT EMP_NAME||'님'||SALARY||'원',DEPT_CODE||JOB_CODE AS 부서직책
FROM EMPLOYEE;

-- SELECT 컬럼명, 컬럼명, 리터럴
-- FROM 테이블명
-- [WHERE 컬럼명 비교연산자(=,>=,<=,<,>!=) 컬럼명||리터럴 ] : 조건문 ROW(행)를 (DATA) 필터링해주는 문장!
-- 비교연산자
-- = : 동등비교(같니) 10=10, A=20
-- !=,<>,^= : 같지 않다 비교
-- >,<,<=,>= : 대소비교(숫자,날짜)
-- BETWEEN 숫자 AND 숫자 : 특정 범위에 값을 비교 // 1<=A&&A<=10;
-- LIKE /NOT LIKE : 특정패턴에 의해 값을 비교 * 부분일치여부
-- IN / NOT IN : 다중값의 포함여부를 비교 A IN 10,20,30
-- IS NULL / IS NOT NULL : NULL값에 대한 비교
-- 논리연산 : 진위여부를 확인하는 연산자 논리 && 논리 논리 || 논리
-- AND : 그리고 && 동일한 기능
-- OR : 또는 || 동일한 기능
-- NOT : 부정연산
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 월급이 350만원 이상인 직원 조회 + 부서코드가 D5인 사원
-- 사원명, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND DEPT_CODE='D5';

-- 부서코드가 D6이 아닌 사원의 전체 컬럼 조회하기
SELECT * 
FROM EMPLOYEE
--WHERE DEPT_CODE!='D6';
--WHERE DEPT_CODE<>'D6';
WHERE NOT DEPT_CODE='D6';

-- 직급코드가 J1아닌 사원들의 SAL_LEVEL을 중복없이 출력하세요
-- DISTINCT
SELECT DISTINCT SAL_LEVEL
FROM EMPLOYEE
WHERE DEPT_CODE!='J1';

-- 부서코드가 D5이거나 급여를 300만원이상 받는 사원
-- 사원명, 부서코드, 급여 
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY >=3000000;

-- 사원의 급여가 200만원이상 400만원 이하인 사원의 사원명, 직책코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=2000000 AND SALARY <= 4000000;
-- 범위를 조회할때 BETWEEN AND 를 사용할 수 있다.
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 4000000;

-- 대소비교는 날짜할 수 있음 날짜는 문자열로 '년/월/일' -> '00/00/00'
-- EMPLOYEE 테이블에서 고용일(HIRE_DATE)이 00년01월01일 보다 빠른 사원을 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE < '00/01/01'; --'일/월/년' ->'01/JAN/00'

-- LIKE : 패턴에 의해 데이터를 조회하는 기능
-- WHERE 컬럼명 LIKE '%리%터_럴_'
-- % : 글자가 0개 이상 아무문자나 다 허용 -> 
  --    '%강' -> 강으로 끝나는 데이터 / '%강%' 데이터에 강이 포함되어있는지
  --    가나다라마강 o , 강, 가나다강라나아라, 강하나둘셋
-- _ : 그 자리 아무문자나 한개
  --    '_강' -> 강으로 끝나는 두글자 
  --    '___'
  
-- EMPLOYEE 테이블에서 전씨 성을 가진 사원을 조회해라
-- 사원명, 급여
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE EMP_NAME LIKE '전%';
WHERE EMP_NAME LIKE '전__%';

-- 사원명이 중간에 옹이들어가는 사원 이름 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE EMP_NAME LIKE '_옹%';
WHERE EMP_NAME LIKE '_옹_';

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE;
-- EMPLOYEE테이블에서 이메일이 _앞의 글자가 3글자인 사원을 조회
-- 사원명, 이메일
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '____%';
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

-- 성이 이씨가 아닌 사원 조회하기 사원명, 이메일
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMP_NAME NOT LIKE '이__%';
WHERE NOT EMP_NAME LIKE '이__%';

-- NULL을 비교해보자
-- BONUS가 NULL인 사원을 출력하기
-- 사원명, BONUS
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
--WHERE BONUS = NULL;
WHERE BONUS = (null);
-- null을 비교하기 위해서는 오라클에서 제공하는 예약어를 사용
-- IS NULL /IS NOT NULL
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
--WHERE BONUS IS NULL;
WHERE BONUS IS NOT NULL;

-- 다중값을 비교하기 
-- IN / NOT IN : 다중값을 한번에 동등비교
-- EMPLOYEE테이블에서 부서코드가 D5, D6인 사원 조회하기
-- 사원명, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE='D6';
--WHERE DEPT_CODE IN('D5','D6'); -- 다중행 서브쿼리와 같이 사용
--WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME LIKE '전%'); 
WHERE DEPT_CODE NOT IN('D5','D6');


-- 직책이 J2또는 J7인 사원중 급여가 200만원 보다 많은 사원을 조회하기
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
--WHERE JOB_CODE='J7' OR JOB_CODE='J2' AND SALARY>=2000000;
WHERE (JOB_CODE='J7' OR JOB_CODE='J2') AND SALARY>=2000000;

select job_name
from job;

select *
from department;

select emp_name, email, phone, hire_date
from employee;

select hire_date, emp_name, salary
from employee;

select emp_name, sal_level, salary
from employee
where salary >= 2500000;

select emp_name, phone
from employee
where job_code = 'J3' and salary >= 3500000;

select emp_name AS 이름, salary*12 as 연봉, 12*(salary+(salary*bonus)) as 총수령액
        , (12*(salary+(salary*bonus))-(salary*0.97)) as 실수령액
from employee; 

select emp_name, (sysdate - hire_date) 
from employee;

select emp_name, salary, bonus
from employee
where sysdate - hire_date>= 7300 ;

select *
from employee
where hire_date between '90/01/01' and '01/01/01';

select emp_name
from employee
where emp_name like '%이%';

select emp_name
from employee
where emp_name like '%연';

select emp_name, phone
from employee
where not phone like '010%';

select *
from employee
where (email like '____\_%' escape '\') and (dept_code = 'D9'or dept_code ='D6') 
        and (hire_date between '90/01/01' and '00/12/01') and (salary >= 2700000);

SELECT LENGTH('HIHI') FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL) >= 16;

SELECT LENGTHB('ASB') FROM EMPLOYEE;

SELECT INSTR('KH정보교육원','KH')FROM DUAL;

SELECT INSTR('KH정보교육원 KH수강생화이팅','KH',3)FROM DUAL;

SELECT INSTR('KH정보교육원 KH수강생화이팅 KH RCLASS힘내라','KH',3,2)FROM DUAL;


SELECT LPAD('유병승',10,'*')FROM DUAL;

SELECT LTRIM('    병승')FROM DUAL;

SELECT RTRIM('    병승00000','0')FROM DUAL;

SELECT LTRIM('12312434239505607567병승   ','0123456789')FROM DUAL;

SELECT LTRIM('0101010101010100001011병승','01')FROM DUAL;

SELECT LTRIM(RTRIM('12312434607567병승1293643192875','0123456789'),'0123456789')FROM DUAL;

SELECT TRIM('    A  BS   B    ') FROM DUAL;


SELECT TRIM('Z' FROM 'ZZZZZBSZZZZZ')FROM DUAL;


SELECT TRIM(LEADING FROM('       BS      ')) AS A FROM DUAL;

SELECT TRIM(TRAILING FROM('     BS     ')) AS A FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',5)FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',-3,3) FROM DUAL;

SELECT SUBSTR(EMP_NO,1,6)
FROM EMPLOYEE;

SELECT EMP_NAME,EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) =2;

SELECT SUBSTR(EMAIL,INSTR(EMAIL,'@')+1) FROM EMPLOYEE;

SELECT LOWER('Welcome to OracleWorld') FROM DUAL;
SELECT UPPER('Welcome to OracleWorld') FROM DUAL;
SELECT INITCAP('welcome to OracleWorld') FROM DUAL;

SELECT EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE LOWER( '%KH%' );

SELECT CONCAT('여러분 ','오라클 재미있나요?')FROM DUAL;

SELECT '여러분 '|| '오라클 재미있나요?'FROM DUAL;

SELECT REPLACE('I LOVE MY LIFE','LOVE','HATE')FROM DUAL;

SELECT REPLACE(EMAIL, 'kh.or.kr', 'bs.com') FROM EMPLOYEE;

SELECT REVERSE('ABC')FROM DUAL;

SELECT TRANSLATE('010-3644-6259','0123456789','영일이삼사오육칠팔구') FROM DUAL;

SELECT MOD(3,2) FROM DUAL;

SELECT ABS(10),ABS(-10) FROM DUAL;

select round(123.456) from dual;
select round(123.456,2) from dual;
select round(123.456,-1) from dual;

SELECT TRUNC(123.456), TRUNC(123.456,2) FROM DUAL;

SELECT FLOOR(123.456) FROM DUAL;

SELECT EMP_NAME, CEIL(SALARY+(SALARY*BONUS)/3) FROM EMPLOYEE;

SELECT SYSDATE FROM DUAL;

SELECT SYSDATE, CURRENT_DATE, LOCALTIMESTAMP, CURRENT_TIMESTAMP
FROM DUAL;

SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;


SELECT ADD_MONTHS(SYSDATE,3) FROM DUAL;

SELECT HIRE_DATE, ADD_MONTHS(HIRE_DATE,3) FROM EMPLOYEE;

SELECT ADD_MONTHS(SYSDATE,18) AS 전역일,(ADD_MONTHS(SYSDATE,18) - SYSDATE)*3 AS 먹을짬밥수
FROM DUAL;

SELECT FLOOR(MONTHS_BETWEEN(SYSDATE,TO_DATE('21/07/10','RR/MM/DD')))
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금') FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE,'MON') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL;

SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
 
SELECT*FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;


SELECT EXTRACT(YEAR FROM SYSDATE), EXTRACT (MONTH FROM SYSDATE), EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

SELECT EXTRACT(HOUR FROM CAST(SYSDATE AS TIMESTAMP)), EXTRACT(MINUTE FROM CAST(SYSDATE AS TIMESTAMP))
        ,EXTRACT(SECOND FROM CAST(SYSDATE AS TIMESTAMP))
FROM DUAL;


SELECT EMP_NAME, DEPT_CODE, EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) BETWEEN 1990 AND 1999;