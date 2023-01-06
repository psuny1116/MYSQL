# 테이블 합치기: 같은 의미의 값을 가지는 컬럼의 값을 기준으로 테이블을 합침 

/* INNER JOIN: JOIN의 디폴트값. 두 테이블 모두에 있는 값만 합침
SELECT 컬럼이름
FROM 테이블A이름
INNER JOIN 테이블B이름
ON 테이블A이름.컬럼A이름 = 테이블B이름.컬럼B이름
WHERE 조건식;
예시
SELECT *
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number;
*/

/* LEFT JOIN: 왼쪽 테이블에 있는 값만 합침 / RIGHT JOIN: 오른쪽 테이블에 있는 값만 합침
SELECT 컬럼이름
FROM 테이블A이름
LEFT JOIN 테이블B이름
ON 테이블A이름.컬럼A이름 = 테이블B이름.컬럼B이름
WHERE 조건식;

SELECT 컬럼이름
FROM 테이블A이름
RIGHT JOIN 테이블B이름
ON 테이블A이름.컬럼A이름 = 테이블B이름.컬럼B이름
WHERE 조건식;

LEFT JOIN 예시
SELECT *
FROM mypokemon
LEFT JOIN ability
ON mypokemon.number = ability.number;

RIGHT JOING 예시 
SELECT *
FROM mypokemon
RIGHT JOIN ability
ON mypokemon.number = ability.number;
*/

/* OUTER JOIN: 두 테이블에 있는 모든 값 합치기
OUTER JOIN은 MySQL키워드에 없음. 따라서 LEFT JOIN + UNION(두 쿼리의 결과를 중복을 제외하고 합쳐서 보여주는 집합 연산자) + RIGHT JOIN 사용

SELECT 컬럼이름
FROM 테이블A이름
LEFT JOIN 테이블B이름
ON 테이블A이름.컬럼A이름 = 테이블B이름.컬럼B이름
UNOIN
SELECT 컬럼이름
FROM 테이블A이름
RIGHT JOIN 테이블B이름
ON 테이블A이름.컬럼A이름 = 테이블B이름.컬럼B이름;

예시
SELECT *
FROM mypokemon
LEFT JOIN ability
ON mypokemon.number = ability.number
UNION
SELECT *
FROM mypokemon
RIGHT JOIN ability
ON mypokemon.number = ability.number;
*/

/* CROSS JOIN: 두 테이블에 있는 모든 값을 각각 합침 

SELECT 컬럼이름
FROM 테이블A이름
CROSS JOIN 테이블B이름     # ON 키워드가 없어도 됨
WHERE 조건식;

예시
SELECT *
FROM mypokemon
CROSS JOIN ability;
*/

/* SELF JOIN: 같은 테이블에 있는 값 합치기

SELECT 컬럼이름
FROM 테이블A이름 AS t1
INNER JOIN 테이블A이름 AS t2
ON t1.컬럼A이름 = t2.컬럼A이름
WHERE 조건식;

예시
SELECT *
FROM mypokemon AS t1
INNER JOIN mypokemon AS t2
ON t1.number = t2.number;
*/