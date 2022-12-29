# 순서를 정해 원하는 데이터 가져오기(ORDER BY)
## ORDER BY 컬럼1, 컬럼2 형식으로 사용.
## 컬럼 번호로도 정렬 가능. 이때, 컬럼 번호는 SELECT 절의 컬럼 이름의 순서를 의미함

/*
- 오름차순 정렬
SELECT 컬럼이름
FROM 테이블이름
WHERE 조건식
ORDER BY 컬럼이름 ASC;     # 디폴트가 ASC이므로 ASC는 생략가능

- 내림차순 정렬
SELECT 컬럼이름
FROM 테이블이름
WHERE 조건식
ORDER BY 컬럼이름 DESC;
*/

USE pokemon;
SELECT * FROM mypokemon;
 
# mypokemon 테이블의 number, name을 가져오는데 number를 내림차순해라.
SELECT number, name
FROM mypokemon
ORDER BY number DESC;

# mypokemon 테이블의 number, name, attack, defense를 가져오는데 attack을 기준으로 내림차순하고, 그 다음 defense를 기준으로 오름차순하라.
SELECT number, name, attack, defense
FROM mypokemon
ORDER BY attack DESC, defense;     # ORDER BY 3 DESC, 4; 로 써도 됨.

# 순위를 정해 원하는 데이터 가져오기(RANK)
/* 
RANK() OVER (ORDER BY 컬럼이름) 형식으로 사용. 
항상 ORDER BY와 함께 사용. 
SELECT절에 사용. 
정렬된 순서에 순위를 붙인 새로운 컬럼을 보여줌.

- 오름차순 순위 만들기
SELECT 컬럼이름, ..., RANK() OVER (ORDER BY 컬럼이름)
FROM 테이블이름
WHERE 조건식;

- 내림차순 순위 만들기
SELECT 컬럼이름, ..., RANK() OVER (ORDER BY 컬럼이름 DESC)
FROM 테이블이름
WHERE 조건식;
*/

# mypokemon 테이블의 name, attack을 attack의 내림차순 순위와 함께 가져와라.
SELECT name, attack, RANK() OVER (ORDER BY attack DESC) AS attack_rank
FROM mypokemon;

## 데이터를 정렬해 순위를 만들어주는 함수: RANK, DENSE_RANK, ROW_NUMBER

# DENSE_RANK 사용해 mypokemon 테이블의 name, attack을 attack의 내림차순 순위와 함께 가져와라.
SELECT name, attack, DENSE_RANK() OVER (ORDER BY attack DESC) AS attack_rank
FROM mypokemon;

# ROW_NUMBER 사용해 mypokemon 테이블의 name, attack을 attack의 내림차순 순위와 함께 가져와라.
SELECT name, attack, ROW_NUMBER() OVER (ORDER BY attack DESC) AS attack_rank
FROM mypokemon;

## 데이터 순위를 만드는 함수 비교
SELECT name, attack,
       RANK() OVER (ORDER BY attack DESC) AS rank_rank,     # 공동 순위가 있으면 다음 순서로 건너뜀(1위, 2위, 2위, 4위, 5위)
       DENSE_RANK() OVER (ORDER BY attack DESC) AS rank_dense_rank,     # 공동 순위가 있어도 다음 순위를 뛰어 넘지 않음(1위, 2위, 2위, 3위, 4위)
       ROW_NUMBER() OVER (ORDER BY attack DESC) AS rank_row_number     # 공동 순위를 무시함(1위, 2위, 3위, 4위, 5위)
FROM mypokemon;