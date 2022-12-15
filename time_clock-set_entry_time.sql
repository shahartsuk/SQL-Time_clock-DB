declare @id nvarChar(10) ='2345',
@password nvarChar(20) ='2345',
@temp_password nvarChar(12),
@answer nvarChar(100),
@employee_code int

if exists(select E.Code from Employee E inner join Passwords P
on E.Code = P.Employee_code  where ID=@id and Password = @password
and P.Is_active=1)
begin --1
select @employee_code =(select Code from Employee where ID=@id)
	if exists(select* from Passwords where Expiry > getdate() and Employee_code = @employee_code
	and Password = @password)
	begin --2
	select @answer ='הסיסמא שלך לא בתוקף נא להחליף לסיסמא חדשה'
  end --2
		else
		begin --3

			if not exists (select * from times where Exit_time is null and Employee_code = @employee_code)
			begin --4
			insert into times values(@employee_code,getdate(),null) 
			select @answer = 'ברוך הבא, שעת הכניסה היא'+(convert(nvarChar(20),getdate(),103)+' '+convert(nvarChar(20),getdate(),108))
				end --4
				else
				begin --5
					update times set Exit_time = getdate() where Employee_code = @employee_code 
					and Exit_time is null
					select @answer ='להתראות שעת היציאה היא'+(convert(nvarChar(20),getdate(),103)+' '+convert(nvarChar(20),getdate(),108))
					end --5
			end --3
end --1
else 
begin --5
select @answer = 'השם משתמש או הסיסמא לא נכונים'
end --5

select @answer
select * from times

--delete times
--insert into times values(3,getdate(),null) 