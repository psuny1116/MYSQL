# 데이터베이스 다루기 실습3. 테이블 변경 및 삭제
/* 실습1과 실습2에서 생성했던 'pokemon' 데이터베이스 안에 있는 'mypokemon' 테이블과 'mynewpokemon' 테이블이 다음과 같이 될 수 있게 변경하라. */
## 쿼리 순서
/* STEP1. 'mypokemon' 테이블의 이름을 'myoldpokemon'으로 변경하라.
STEP2. 'myoldpokemon' 테이블의 'name' 칼럼의 이름을 'eng_nm'으로 변경하라.
       (컬럼 이름: eng_nm, 데이터 타입: VARCHAR(20))
STEP3. 'mynewpokemon' 테이블의 'name' 칼럼의 이름을 'kor_nm'으로 변경하라.
       (컬럼 이름: kor_nm, 데이터 타입: VARCHAR(20))
*/

## 실습1, 2에서 생성했던 코드
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon(
             number INT,
             name VARCHAR(20),
             type VARCHAR(10)
             );
INSERT INTO mypokemon (number, name, type)
VALUES (10, 'caterpie', 'bug'),
       (25, 'pikachu', 'electric'),
       (133, 'eevee', 'normal');
CREATE TABLE mynewpokemon(
             number INT,
             name VARCHAR(20),
             type VARCHAR(10)
             );
INSERT INTO mynewpokemon (number, name, type)
VALUES (77, '포니타', '불꽃'),
       (132, '메타몽', '노말'),
       (151, '뮤', '에스퍼');
       
## STEP1. 테이블명 변경
ALTER TABLE mypokemon RENAME myoldpokemon;

## STEP2. 컬럼명 변경
ALTER TABLE myoldpokemon
CHANGE COLUMN name eng_nm VARCHAR(20);

## STEP3. 컬럼명 변경
ALTER TABLE mynewpokemon
CHANGE COLUMN name kor_nm VARCHAR(20);

## 테이블 전체 조회
SELECT * FROM myoldpokemon;
SELECT * FROM mynewpokemon;

/* 'pokemon' 데이터베이스 안에 있는 'myoldpokemon' 테이블은 값만 지우고, 'mynewpokemon' 테이블은 전부 지워라.*/
## 테이블 값만 삭제
TRUNCATE TABLE myoldpokemon;

## 테이블 전체 삭제
DROP TABLE mynewpokemon;

## 테이블 전체 조회
SELECT * FROM myoldpokemon;
SELECT * FROM mynewpokemon;     # 테이블 전체가 삭제됐으므로 실행 안됨.

## 데이터베이스 삭제
DROP DATABASE pokemon;