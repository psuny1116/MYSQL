# 데이터베이스 다루기 실습2. 테이블 만들고 데이터 넣기
/* 'pokemon' 데이터베이스에 'mynewpokemon' 테이블을 만들고, 포니타, 메타몽, 뮤의 포켓몬 번호, 이름, 타입 데이터를 넣어라. */
## 쿼리 순서
/* STEP1. 'pokemon' 데이터베이스 생성
STEP2. 포켓몬 데이터베이스 안에 mynewpokemon 테이블을 만들어라.(테이블 이름: mynewpokemon)
       이때, 컬럼은 (1) 포켓몬 번호, (2) 포켓몬 영문 이름, (3) 포켓몬 타입, 총 3가지로 하고, 이름과 데이터 타입을 지정해라.
       컬럼 이름 및 데이터 타입: (1) number: INT, (2) name: VARCHAR(20), (3) type: VARCHAR(10)
STEP3. mynewpokemon 테이블 안에 포켓몬 데이터를 각각의 로우로 넣어라.
*/

## STEP1. 데이터베이스 생성
CREATE DATABASE pokemon;

## STEP2. 테이블 생성mynewpokemonmynewpokemonmynewpokemon
CREATE TABLE pokemon.mynewpokemon(
             number INT,
             name VARCHAR(20),
             type VARCHAR(10)
             );

## STEP3. 테이블에 데이터 삽입
INSERT INTO pokemon.mynewpokemon (number, name, type)
VALUES (77, '포니타', '불꽃'),
       (132, '메타몽', '노말'),
       (151, '뮤', '에스퍼');
       
## 테이블 전체 조회
SELECT * FROM pokemon.mynewpokemon