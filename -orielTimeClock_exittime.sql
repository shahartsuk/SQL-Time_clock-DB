declare @ID varchar(10)='1234',
@password varchar(10)='1234',
@employee_code int, 
@answer varchar(100)

select @employee_code=(select Code from Employee where ID=@ID)
if @employee_code is null
begin
	select @answer = '�� ����� �� ����� ���� ������,����� �� 3 �������'
end
else
	begin
		if not exists( select Code from Passwords where password=@password and 
		Is_active=1 and employee_code=@employee_code)
		begin
		select @answer = '�� ����� �� ����� ���� ������,����� �� 2 �������'
		end
		else
		begin
		if not exists( select code from Passwords where password=@password and 
		is_active=1 and employee_code=@employee_code and expiry>getdate())
		begin 
		select @answer = '����� ���� �����,���� ������ �����'
		end
		else
		begin
			if not exists (select * from times where 
				employee_code=@employee_code and exit_time is null)
				begin
		insert into times values(@employee_code,getdate(),null)
		select @answer= '��� �����'+(convert(nvarChar(20),getdate(),103)+' '+convert(nvarChar(20),getdate(),108))
		end
		else 
		update times set exit_time =getdate() where employee_code=@employee_code
		and exit_time is null
		select @answer= '��� �����'+(convert(nvarChar(20),getdate(),103)+' '+convert(nvarChar(20),getdate(),108))
		end
	end
end
end

select @answer

