--����� ������

declare @answer nvarChar(100),@old_password nvarChar(12) = '2345',
@employee_code int,@new_password nvarChar(12)='3456',@id nvarChar(10)='2345'

--����� ��� ���� ��� ���� ����
select @employee_code =(select Code from Employee where ID=@id)

if @employee_code is null
begin --1
	select @answer = '�� ����� �� ����� �� ������'
	end
	else --1\1
	begin
		--����� �� ������ ����� ���� ����� ������
		if not exists(select * from Passwords where Employee_code = @employee_code
		and Is_active = 1 and Password = @old_password)
		begin --2
			select @answer = '�� ����� �� ����� �� ������'
		end
		else --2/2
		begin
		    --����� �� ������ ����� ��� ���� ������ ����
			if exists(select * from Passwords where Employee_code = @employee_code
			and Password= @new_password)--3
			begin
			  select @answer ='������ ������ �� ����,���� ������ ����� ����'
			end
			else --3/3
			begin 
			--�� �������� ������� �� ����� ����� ��� ������
			  update Passwords set Is_active =0 where Employee_code =@employee_code
			  insert into Passwords values(@employee_code,@new_password,getdate()+180,1)
			  select @answer ='������ ����� ������,������ ���� �30 ���'
			end
		end
	end
	
	select @answer
	
	select * from Passwords
