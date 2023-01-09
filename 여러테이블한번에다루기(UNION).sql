/* UNION, UNION ALL
UNION: 동일한 값은 제외하고 보여줌
UNION ALL: 동일한 값도 포함해서 보여줌
쿼리A UNION 또는 UNION ALL 쿼리B 형식으로 사용. 쿼리A와 쿼리B의 결과값을 합쳐서 보여줌
쿼리A와 쿼리B의 결과값의 개수가 같아야 함
ORDER BY는 쿼리 가장 마지막에 작성 가능. 쿼리A에서 가져온 컬럼으로만 가능

SELECT 컬럼이름
FROM 테이블A이름
UNION
SELECT 컬럼이름
FROM 테이블B이름;

SELECT 컬럼이름
FROM 테이블A이름
UNION ALL
SELECT 컬럼이름
FROM 테이블B이름;

UNION 예시
SELECT name
FROM mypokemon
UNION
SELECT name
FROM friendpokemon;

UNION ALL 예시
SELECT name
FROM mypokemon
UNION ALL
SELECT name
FROM friendpokemon;

UNION, ORDER BY 사용 예시
SELECT number, name, attack
FROM mypokemon
UNION
SELECT number, name, attack
FROM friendpokemon
ORDER BY number;
*/

/* INTERSECT: 교집합, MINUS: 차집합 => MySQL에는 두 표현이 존재하지 않음. 따라서 JOIN 사용
교집합
SELECT 컬럼이름
FROM 테이블A이름 AS A
INNER JOIN 테이블B이름 AS B
ON A.컬럼1이름 = B.컬럼1이름 AND ... AND A.컬럼n이름 = B.컬럼n이름;     # 교집합을 확인하고 싶은 컬럼은 모두 다 기준(ON)으로 두고 합쳐줘야 함(단순 INNER JOIN과의 차이점)

교집합 예시
SELECT A.name
FROM mypokemon AS A
INNER JOIN friendpokemon AS B
ON A.number = B.number AND A.name = B.name AND A.type = B.type;

차집합
SELECT 컬럼이름
FROM 테이블A이름 AS A
LEFT JOIN 테이블B이름 AS B
ON A.컬럼1이름 = B.컬럼1이름 AND ... AND A.컬럼n이름 = B.컬럼n이름     # 차집합을 확인하고 싶은 컬럼은 모두 다 기준으로 두고 합쳐줘야 함
WHERE B.컬럼이름 IS NULL;

차집합 예시
SELECT A.name
FROM mypokemon AS A
LEFT JOIN friendpokemon AS B
ON A.number = B.number AND A.name = B.name AND A.type = B.type
WHERE B.name IS NULL;
*/