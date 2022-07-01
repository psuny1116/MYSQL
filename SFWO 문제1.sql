# SFWO
## 문구생산부와 가구생산부의 직원정보를 확인하려 함
## 위에 해당하는 직원들의 직원명과 입사일을 입사일이 빠른 순서대로 출력하세요
## (문구생산부의 dnumber는 'D1001', 가구생산부는 'D2001'이며 입사일은 연, 월, 일까지만 출력되어야 함)

select tem.ename as 직원명, to_char(tem.startdate, 'YYYY-MM-DD') as 입사일
from temployee as tem
where tem.dnumber in ('D1001', 'D2001')
order by tem.startdate 