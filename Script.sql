select tem.EName as ������, to_char(tem.StartDate, 'YYYY-MM-DD') as �Ի���
from temployee as tem
where tem.dnumber in ('D1001', 'D2001')
order by tem.startdate 