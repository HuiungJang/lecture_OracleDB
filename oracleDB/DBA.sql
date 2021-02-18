SELECT * FROM DICT; 
-- 이거는 주석표기
-- 오라클 db에 대한 정보를 가지고 있는 테이블 : DATA DICTIONARY라고 함.
SELECT * FROM dictionary;
-- 대소문자는 상관없다
-- 현재 db에 등록된 사용자계정 정보보기
select * from DBA_users;

-- 계정은 관리자 계정, 사용자 계정으로 나뉘어짐
-- 관리자계정 : 사용자계정을 등록, 권한부여하고, 전체 생성된 table를 관리하는 역할.
-- -> DBBASE를 전체적으로 관리
-- SYSTEM : 일반 관리자 -> 데이터 베이스 자제를 생성, 삭제 할 수 없음.
-- SYS : 슈퍼관리자 -> 데이터베이스 생성, 삭제, DATADICTIONANRY 소유자 최고관리자.

-- 기본적으로 오라클 DATA BASE를 이용하기 위해선 사용자 계정이 필요함.
-- 사용자 계정만들기, 계정생성 후 이용권한 부여

-- 사용자 계정 만들기
-- 사용자 계정은 SYSTEM, SYS AS SYSDBA계정으로 명령어를 써야함.
-- CREATE USER 유저명 IDENTIFIED BY 비밀번호;
-- 유저명은 대소문자 구분하지 않음 
-- 비밀번호는 대소문자 구분함.
CREATE USER KH IDENTIFIED BY KH;
SELECT * FROM DBA_USERS;

-- 사용자 계정은 CREATE로 생성한다고 해서 무조건 DB이용이 가능한것이 아님.
-- 이용할 수 있는 권한을 SYSTEM/ SYS 계정이 부여해줘야함.
-- GRANT 권한명(ROLE) TO 사용자 계정명;
-- RESOURCE, CONNECT 권한을(ROLE) 부여한다.
GRANT RESOURCE, CONNECT TO KH;

-- test계정 생성 후 접속하는 것.

create user test identified by test;
-- 명령을 실행 하려면 권한이 필요하다.
-- 계정을 생성하려면 항상.
-- SYSTEM 계정으로 생성해야한다.
-- KH db로 실행하면 권한 부족하다고 나온다.
grant resource, connect to test;
-- resource -> table을 생성, 조작할 수 있는 권한.
-- connect -> 할당된영역에 접속 할 수 있는 권한.

-- KH계정 정보 확인하기
select * from tab; -- 계정이 가지고 있는 전체 테이블을 조회

-- 생성된 KH계정의 테이블 확인해보자.
select * from department;
select * from employee;
select * from job;
select * from location;
select * from national;
select * from sal_grade;


-- KH계정의 EMPLOYEE 테이블을 조회해 보자.
-- 사번(EMP_ID) 이름(EMP_NAME), 월급(SALARY)조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원 이름, 이메일, 부서코드, 직책코드 조회하기
SELECT EMP_NAME, EMAIL , DEPT_CODE , JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE테이블에 있는 전체 컬럼을 조회하세요.
SELECT * 
FROM EMPLOYEE;
-- 테이블에 있는 컬럼을 전체 조회할때는 *을 사용하자


-- SELECT문은 단순히 조회뿐만 아니라 산술연산 처리도 가능.
-- 단, 산술 연산은 숫자형타입을 계산.
-- SELECT 컬럼명 || 리터럴 값 
SELECT 10*100
FROM DUAL; -- DUAL테이블은 오라클에서 기본제공하는 테이블로 간단한 테스트를 위한 테이블

-- SELECT문에서 산술연산할때는 컬럼명을 가져와 계산할 수도 있음.
SELECT *
FROM EMPLOYEE;

-- 사원의 연봉을 구하자
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- 각 사원의 보너스를 구하자
SELECT EMP_NAME,SALARY,BONUS, SALARY*BONUS
FROM EMPLOYEE;
-- NULL -> 컬럼값이면 ROW는 값이 없는 쓰레기값. 즉 계산이 안됨 

-- EMPLOYEE 테이블에서 사원명, 부서코드, 직책코드,월급, 연봉, 보너스 포함한 연봉 조회하기
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,
        SALARY,SALARY*12, SALARY*BONUS*12+SALARY*12
FROM EMPLOYEE;

-- RESULTSET의 컬럼명 변경하기 
-- 실제컬럼명은 안바뀜 -> 별칭부여하기
-- 컬럼명 AS 별칭명, 컬럼명 별칭
SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;

SELECT EMP_NAME AS 사원명, EMAIL AS 이메일 ,PHONE 전화번호
FROM EMPLOYEE;


-- 별칭은 아무거나 다 사용이 기능한가?
SELECT EMP_NAME AS  "사 원 명", EMAIL AS "@EMAIL"
FROM EMPLOYEE;

-- SELECT절에서 문자열 리터럴 사용하기.
SELECT EMP_NAME,'님',SALARY,'원'
FROM EMPLOYEE;

-- 행에서 중복값을 제거하고 출력하기
-- DISTINCT : 중복된 행의 값을 한개만 출력
SELECT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- JOB_CODE 출력할 때 중복되는 값을 제거하고  출력 

-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
-- FROM EMPLOYEE; -- DISTINCT는 SELECT문에서 한번만 사용이가능함-> 맨앞에 

SELECT DISTINCT JOB_CODE,DEPT_CODE
FROM EMPLOYEE; -- 두개가 겹치는 것이 없으면 출력 

-- 컬럼, 리터럴을 연결해보자.
-- ||연산자 : SELECT에 작선된 컬럼 || 리터럴을 한개의 컬럼으로 합쳐주는 기능
SELECT EMP_NAME,'NIM',SALARY,'WON'
FROM EMPLOYEE;

SELECT EMP_NAME||'NIM' AS 이름, SALARY||'WON' AS 급여
FROM EMPLOYEE;

-- [WHERE]
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND (DEPT_CODE ='D5' OR DEPT_CODE = 'D1');

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE != 'D6';
--WHERE NOT DEPT_CODE = 'D6';
--WHERE DEPT_CODE <> 'D6';

SELECT DISTINCT SAL_LEVEL
FROM EMPLOYEE
WHERE NOT JOB_CODE = 'J1';

SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY >=3000000;

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
--WHERE SALARY >= 2000000 AND SALARY<= 4000000
WHERE SALARY BETWEEN 2000000 AND 4000000;


-- 대소비교는 날짜 비교 할수 있음.
SELECT EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE < '00/01/01';

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전_%';

SELECT EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_옹_%';

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\';


SELECT EMP_NAME,EMAIL
FROM EMPLOYEE
WHERE NOT EMP_NAME LIKE '이_%';
-- WHERE EMP_NAME NOT LIKE '이_%';

SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6');
--WHERE DEPT_CODE IN(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME LIKE'전%');


SELECT EMP_NAME, JOB_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE =' J2' AND SALARY>=2000000;

SELECT EMP_NAME, JOB_CODE,SALARY
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE ='J2') AND SALARY>=2000000;