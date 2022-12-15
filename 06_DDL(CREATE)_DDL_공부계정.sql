/*
    * DDL ( DATA DEFINITION LANGUAGE) : 데이터를 정의 언어
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE), 구조를 변경하고(ALTER), 삭제하는(DROP) 명령문.
    즉, 구조자체를 정의하는 언어로 DB관리자, 설계자가 사용한다.
    
    오라클에서 객체(DB를 이루는 구조들)
    테이블 , 사용자(USER), 함수(FUNCTION), 뷰(VIEW) , 시퀀스(SEQUENCE) , 인덱스(INDEX), 등등..
*/

/*
    <CREATE TABLE>
    테이블 : 행(ROW) , 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체 종류중 하나
            모든 데이터는 테이블을 통해서 저장됨(데이터를 조작하고자 하려면 무조건 테이블을 만들어야한다)
    [표현법]
    CREATE TAGBLE 테이블(
    컬럼명 자료형,
    컬럼명 자료형,
    컬럼명 자료형,
    컬럼명 자료형,
    ...
    ) 
    <자료형 종류>
    -문자 (CHAR(크기)/VARCHAR2(크기)) : 크기는 BYTE 수이다.
                                    (숫자, 영문자, 특수문자 => 1글자당 1BYTE)
    - CHAR(바이트수) : 최대 2000BYTE까지 지정가능.
                      고정길이(아무리 적은값이 들어와도 빈공간은 공백으로 채우서 처음 할당한 크기를 유지함)
                      주로 들어올 값의 글자수가 정해져 있을 경우 사용
                      예) 성별 : 남/여, M/F
                          주민번호 : 6-7 ->14BYTE
    - VARCHAR2(바이트수) : 최대길이 4000BYTE까지 가능
                          기변길이(적은 값이 들어온 경우 그 담긴 값에 맞춰 크기가 줄어든다)
                          VAR는 가변 2는 2배를 의미함
                          주로 들어온 값의 글자수가 정해져 있지 않은 경우 사용
                          매개변수에 CHAR가 들어온경우 BYTE단위로 데이터 체크하지 않고 문자의 갯수로 체크함
                          VARCHAR2(CHAR 10)
     - NAVARCHAR : 문자열의 바이트가아닌, 문자 갯수 자체를 길이로 취급하여 유니코드를 지원하기 위한 자료명                       
                          
                          
    - 숫자 (NUMBER) : 정수/실수 상관없이 NUMBER
    - 날짜 (DATE) : 년/월/일/시/분/초 형식으로 지정
*/
-- 회원들의 정보를 담을 테이블 (MEMBER) -> (아이디, 비밀번호, 이름, 생년월일)
CREATE TABLE MEMBER ( -- 동일한 테이블명 중복 불가.
    MEMBER_ID VARCHAR2(20), -- 대소문자 구분하지 않음. 따라서 낙타봉표기법이 의미없다. => 언더바로 구분.
    MEMBER_FWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);
SELECT * FROM MEMBER;

-- 테이블 확인방법 : 테이터 딕셔너리 이용
-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
SELECT * FROM USER_TABLES;
-- USER_TABLES : 현재 이 사용자 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 데이터 딕셔너리

-- 컬럼들 확인법
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 현재 이 사용자 계정이 가지고있는 테이블들의 모든 칼럼의 정보를 조회할수있는 데이터 딕셔너리

/*
    컬럼에 주석 달기(컬럼에 대한 설명)
    
    COMMENT ON COLUNMN 테이블명. 컬럼명 IS '주석내용';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEMBER_FWD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원 생년월일';

SELECT 
    *
FROM MEMBER;

-- INSERT문(데이터를 테이블에 추가할수 있는 구문) => DML 문
-- 한행으로 추가(행 기준으로 데이터 추가함) , 추가할 값을 기술(값으 순서 중요!)
-- INSERT INTO 테이블명 VALUES (첫번째 칼럼값, 두번째 칼럼값,...)
INSERT INTO MEMBER VALUES(null,null,null,null); -- 아이디 비밀번호 이름에 NULL 존재 가능?

-- 위 의 null값이나 중복된 아이디값은 유효하지 않은 값들이다
-- 유효한 데이터값을 유지하기위해서 제약조건을 추가해야한다
-- 무결성 보장을 위해선 제약조건을 추가해야함

/*
    <제약조건 CONSTRAINTS>
    
    - 원하는 데이터값만 유지하기 위해서 특정 컬럼마다 성장하는 제약
    - 제약조건이 부여된 컬럼에 들어올 데이터에 문제가 있는지 없는지 자동으로 검사할 목적
    
    - 종류 : NOT NULL , UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    - 컬럼에 제약조건을 부여하는 방식 : 컬럼레벨, 테이블레벨
*/

/*
    1. NOT NULL 제약조건
    해당 칼럼에 반드시 값이 존재해야만 할경우 사용.
    => 즉, NULL값이 절대 들어와서는 안되는 칼럼에 부여하는 제약조건.
       삽입/수정시 NULL값을 허용하지 않도록하는 제한하는 제약조건.
       
       주의사항 : 컬럼레벨방식밖에 안됨.
*/
-- NOT NULL 제약조건을 가진 테이블 성정
-- 컬럼레벨방식 : 컬럼명 자료형 제약조건 => 제약조건을 부여하고자 하는 칼럼 뒤에 곧바로 기술.
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_FWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
     GENDER CHAR(3),
     PHONE VARCHAR2(15),
     EMAIL VARCHAR2(30)
);

INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass01', NULL,null,null,null);
--> NOT NULL 제약조건에 위배되어 오류가 발생함.
--> NOT NULL 제약조건 추가하지 않는 칼럼에대해서는 NULL값을 추가해도 무방함.

/*
        2. UNIQUE 제약조건
            컬럼에 중복값을 제한하는 제약조건
            삽입/ 수정시 기존에 해당 칼럼값에 중복된값이 있을경우 추가 또는 삭제가 되지않게 제약
            
            컬럼레벨방식/테이블레벨방식 둘다 가능.
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,-- 제약조건부여방식 :칼럼레벨
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL
);

DROP TABLE MEM_UNIQUE;

-- 테이블레벨 방식: 모든칼럼을 다 기술하고 그 이후에 제약조건을 나열
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    UNIQUE(MEM_ID) -- 테이블 레벨방식 
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01' , '민경민'); 
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02' , '민경민2');
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03' , '민경민3');
-- unique 제약조건에 위배됨
-- 제약조건부여서 직접 제약조건의 이름을 지정해주지 않으면 시스템에서 알아서 임의 제약조건명을 부여함
-- SYS_C~~~~(고유한 , 중복되지 않은 이름으로 지정)
/*
    제약조건 부여시 제약조건 명도 지정하는 방법.
    > 칼럼레벨방식
    CREATE TABLE 테이블명 (
         컬럼명 자료형 제약조건1, 제약조건2,
         컬럼명 자료형 CONSTRAINT 제약조건명 제약조건,
         ...
         );
         > 테이블레벨방식
         CREATE TABLE 테이블명 (
          칼럼명 자료형,
          칼럼명 자료형,
          ...
          CONSTRAINT 제약조건명 제약조건(칼럼명)
        );    
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL, --컬럼레벨방식
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) -- 테이블 레벨방식 
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01' , '민경민'); 
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02' , '민경민2');
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03' , '민경민3');

/*
    3.PRIMARY KEY (기본키) 제약조건
    테이블에서 각 행들의 정보를 유일하게 식별할 수 있는 칼럼에 부여하는 제약조건
    => 각 행들을 구분할 수 있는 식별자의 역할
       EX) 사번, 부서아이디, 직급코드, 회원번호...
    => 식별자의 조건 : 중복X, 값이 없어도 안됨(NOT NULLL + UNIQUE)

    주의사항 : 한 테이블당 한개의 칼럼값만 지정가능.
*/

CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR(15),
    EMAIL VARCHAR(30)
);














