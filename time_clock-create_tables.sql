--����� ���� ������

--create table Employee(Code int primary key identity,
--ID nvarChar(10),First_name nvarChar(20),Last_name nvarChar(20),
--Celephone nvarChar(10))

--select ID as '���� ����',First_name+' '+Last_name as '�� ���',
--Celephone as '���� �����'
--from Employee

----------------------------tbl1

--����� ���� �������
--create table Passwords(Code int primary key identity,
----��� ���� �� ����� �� �������
--Employee_code int foreign key references Employee(Code),
--Password nvarChar(12),Expiry date,
--Is_active bit)

---------------------------tbl2

--create table times(Code int primary key identity,
--Employee_code int foreign key references Employee(Code),
--Entry_time datetime,Exit_time datetime)

--------------------------tbl3

--����� �� ������
declare @id nvarChar(10) ='2345',
@first_name nvarChar(20) ='�efe',
@last_name nvarChar(20) = 'fwefw',
@celephone nvarChar(20) = '050-14546',
@temp_password nvarChar(12) ='2345',
@answer nvarChar(100),
@employee_code int

--����� ��� ���� ����� �� ����� ���� ������
if exists(select Code from Employee where ID = @id)
begin --����� �������
update Employee set First_name = @first_name,
--���� ��� ����
Last_name = @last_name, Celephone = @celephone
where ID = @id
select @employee_code =(select Code from Employee where ID = @id)
select @answer ='����' + @first_name +' '+@last_name+'������ ������'
end --����� �������

else
begin
--����� ���� ��� �� ����� �����
insert into Employee values(@id,@first_name,@last_name,@celephone)
--���� ��� ����
select @employee_code =@@IDENTITY 
select @answer = '����� ����� ������ ������'
end

--����� ����� �����
insert into Passwords values(@employee_code,@temp_password,getdate(),1)
select @answer = @answer+' \n ������ ������ ��� '+@temp_password

select @answer

select * from Employee
select * from Passwords

select ID,First_name,Last_name,Password,Expiry  from Employee E inner join Passwords P on P.Employee_code = E.Code