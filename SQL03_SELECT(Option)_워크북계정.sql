SELECT STUDENT_NAME AS 학생이름 , STUDENT_ADDRESS AS 주소지
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

SELECT STUDENT_NAME , STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y' 
ORDER BY STUDENT_SSN DESC;

SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT 
WHERE STUDENT_NO LIKE '9%' 
AND STUDENT_ADDRESS LIKE '%경기도%' OR STUDENT_ADDRESS LIKE '%강원도%'
ORDER BY STUDENT_NAME;

SELECT PROFESSOR_NAME , PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

SELECT STUDENT_NO, TO_CHAR(POINT, '9.00') POINT
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

SELECT STUDENT_NO , STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

SELECT CLASS_NAME , DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

SELECT CLASS_NAME ,PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);


SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS 
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO) 
JOIN TB_DEPARTMENT D ON(P.DEPARTMENT_NO = D.DEPARTMENT_NO)  
WHERE CATEGORY = '인문사회';

SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름", 
ROUND(AVG(POINT), 1) "전체 평점" FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) 
JOIN TB_GRADE USING(STUDENT_NO) 
WHERE DEPARTMENT_NAME = '음악학과' 
GROUP BY STUDENT_NO, STUDENT_NAME ORDER BY STUDENT_NO;

SELECT STUDENT_NO, STUDENT_NAME FROM (
    SELECT STUDENT_NO, STUDENT_NAME FROM TB_STUDENT 
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) 
    JOIN TB_GRADE USING(STUDENT_NO) 
    WHERE DEPARTMENT_NAME = '국어국문학과' 
    GROUP BY STUDENT_NO, STUDENT_NAME 
    ORDER BY AVG(POINT) DESC)
WHERE ROWNUM = 1;



