# 조건에 맞는 데이터 가져오기(WHERE)
/*
SELECT 컬럼이름
FROM 테이블이름
WHERE 조건식;
*/

USE pokemon;
SELECT * FROM mypokemon;

# 1. 피카츄의 number를 찾아라.
SELECT number
FROM mypokemon
WHERE name = 'pikachu';

# 2. 속도가 50보다 큰 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE speed > 50;

# 3. 전기 타입이 아닌 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE type != 'electric';

# 4. 속도가 100이하인 전기 타입 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE speed <= 100 AND type = 'electric';

# 5. 벌레 타입이거나 노말 타입인 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE type = 'bug' OR type = 'normal';

# 6. 속도가 100이하이고 벌레 타입이 아닌 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE speed <= 100 AND NOT type = 'bug';     # WHERE speed <= 100 AND type != 'bug'; 도 가능 

# 특정 범위 내의 데이터를 선택할 때 사용하는 연산자(BETWEEN)
/*
SELECT 컬럼이름
FROM 테이블이름
WHERE 컬럼이름 BETWEEN 조건1 AND 조건2;
*/

# 7. 속도가 50과 100 사이인 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE speed BETWEEN 50 AND 100;     # WHERE speed >= 50 AND speed <= 100; 과 동일

# 목록 내 포함되는 데이터를 선택할 때 사용하는 연산자(IN)
/*
SELECT 컬럼이름
FROM 테이블이름
WHERE 컬럼이름 IN (조건1, 조건2, ...);
*/

# 8. 벌레 타입이거나 노말 타입인 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE type IN ('bug', 'normal');

# 특정 문자열이 포함된 데이터를 선택하는 연산자(LIKE)
## % : 0개 이상의 문자
## _ : 1개의 문자
### '%e' : e로 끝나는 문자열
### 'e%' : e로 시작하는 문자열
### '%e%' : e가 포함된 문자열
### '_e' : e로 끝나고 e 앞에 1개의 문자가 있는 문자열
### '%_e' : e로 끝나고 e 앞에 1개 이상의 문자가 있는 문자열
### '%_e_%' : e를 포함하고 e 앞뒤로 각각 1개 이상의 문자가 있는 문자열
/*
SELECT 컬럼이름
FROM 테이블이름
WHERE 컬럼이름 LIKE 검색할문자열;
*/

# 9. 이름이 'chu'로 끝나는 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE name LIKE '%chu';

# 10. 이름에 'a'가 포함되는 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE name LIKE '%a%';

# 데이터가 NULL인지 아닌지를 확인하는 연산자(IS NULL)
/*
SELECT 컬럼이름
FROM 테이블이름
WHERE 컬럼이름 IS NULL;
*/
## NULL: 데이터값이 존재하지 않음. 0이나 공백이 아닌 알 수 없는 값을 의미
INSERT INTO mypokemon (name, type)
VALUES ('kkobugi', '');

SELECT *
FROM mypokemon;

# 11. number가 null인 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE number IS NULL;

# 12. type이 null이 아닌 포켓몬의 이름을 찾아라.
SELECT name
FROM mypokemon
WHERE type IS NOT NULL;