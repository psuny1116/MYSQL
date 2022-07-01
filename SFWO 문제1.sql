# SFWO
## 문구생산부와 가구생산부의 직원정보를 확인하려 함
## 위에 해당하는 직원들의 직원명과 입사일을 입사일이 빠른 순서대로 출력하세요
## (문구생산부의 DNumber는 'D1001', 가구생산부는 'D2001'이며 입사일은 연, 월, 일까지만 출력되어야 함)

### EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 칼럼인 EName을 가져오고
### StartDate(입사일)을 출력하기 위해 직원테이블인 tEmployee에서 입사일 칼럼인 StartDate를 가져온 후 TO_CHAR함수를 사용해 연-월-일형태로 변환
### 'D1001', 'D2001'에 해당하는 값을 가져오기 위해 직원테이블인 tEmployee에서 DNumber(부서코드)를 가져온 후 IN을 사용하여 조건 설정 
### 정렬기준인 StartDate(입사일)을 오름차순 정렬하기 위해 ORDER BY 사용

SELECT tem.EName AS 직원명, TO_CHAR(tem.StartDate, 'YYYY-MM-DD') AS 입사일 FROM tEmployee AS tem
WHERE tem.DNumber IN ('D1001', 'D2001')
ORDER BY tem.StartDate