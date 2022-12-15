--החרזת משתנים

declare @answer nvarChar(100),@old_password nvarChar(12) = '2345',
@employee_code int,@new_password nvarChar(12)='3456',@id nvarChar(10)='2345'

--מציאת קוד עובד לפי מספר זהות
select @employee_code =(select Code from Employee where ID=@id)

if @employee_code is null
begin --1
	select @answer = 'שם משתמש או סיסמא לא נכונים'
	end
	else --1\1
	begin
		--בדיקה על הסיסמא הישנה שהיא פעילה ונכונה
		if not exists(select * from Passwords where Employee_code = @employee_code
		and Is_active = 1 and Password = @old_password)
		begin --2
			select @answer = 'שם משתמש או סיסמא לא נכונים'
		end
		else --2/2
		begin
		    --בדיקה על הסיסמא החדשה שלא היתה בשימוש בעבר
			if exists(select * from Passwords where Employee_code = @employee_code
			and Password= @new_password)--3
			begin
			  select @answer ='השתמשת בסיסמא זו בעבר,עליך להכניס סיסמא חדשה'
			end
			else --3/3
			begin 
			--כל הסיסמאות הקודמות של העובד נהפכו ללא פעילות
			  update Passwords set Is_active =0 where Employee_code =@employee_code
			  insert into Passwords values(@employee_code,@new_password,getdate()+180,1)
			  select @answer ='הסיסמא שונתה בהצלחה,הסיסמא הינה ל30 יום'
			end
		end
	end
	
	select @answer
	
	select * from Passwords
