select tem.EName as 직원명, to_char(tem.StartDate, 'YYYY-MM-DD') as 입사일
from temployee as tem
where tem.dnumber in ('D1001', 'D2001')
order by tem.startdate 