# SFWO
## ��������ο� ����������� ���������� Ȯ���Ϸ� ��
## ���� �ش��ϴ� �������� ������� �Ի����� �Ի����� ���� ������� ����ϼ���
## (����������� dnumber�� 'D1001', ��������δ� 'D2001'�̸� �Ի����� ��, ��, �ϱ����� ��µǾ�� ��)

select tem.ename as ������, to_char(tem.startdate, 'YYYY-MM-DD') as �Ի���
from temployee as tem
where tem.dnumber in ('D1001', 'D2001')
order by tem.startdate 