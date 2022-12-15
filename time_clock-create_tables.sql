--יצירת טבלת עובדים

--create table Employee(Code int primary key identity,
--ID nvarChar(10),First_name nvarChar(20),Last_name nvarChar(20),
--Celephone nvarChar(10))

--select ID as 'מספר זהות',First_name+' '+Last_name as 'שם מלא',
--Celephone as 'מספר טלפון'
--from Employee

----------------------------tbl1

--יצירת טבלת סיסמאות
--create table Passwords(Code int primary key identity,
----שדה מקשר עם הטבלה של העובדים
--Employee_code int foreign key references Employee(Code),
--Password nvarChar(12),Expiry date,
--Is_active bit)

---------------------------tbl2

--create table times(Code int primary key identity,
--Employee_code int foreign key references Employee(Code),
--Entry_time datetime,Exit_time datetime)

--------------------------tbl3

--הצהרת על משתנים
declare @id nvarChar(10) ='2345',
@first_name nvarChar(20) ='שefe',
@last_name nvarChar(20) = 'fwefw',
@celephone nvarChar(20) = '050-14546',
@temp_password nvarChar(12) ='2345',
@answer nvarChar(100),
@employee_code int

--בדיקה האם מספר הזהות של העובד קיים במערכת
if exists(select Code from Employee where ID = @id)
begin --פתיחת סוגריים
update Employee set First_name = @first_name,
--קבלת קוד עובד
Last_name = @last_name, Celephone = @celephone
where ID = @id
select @employee_code =(select Code from Employee where ID = @id)
select @answer ='פרטי' + @first_name +' '+@last_name+'עודכנו בהצלחה'
end --סגירת סוגריים

else
begin
--הכנסת עובד חדש עם סיסמא זמנית
insert into Employee values(@id,@first_name,@last_name,@celephone)
--קבלת קוד עובד
select @employee_code =@@IDENTITY 
select @answer = 'העובד הוכנס למערכת בהצלחה'
end

--הכנסת סיסמא זמנית
insert into Passwords values(@employee_code,@temp_password,getdate(),1)
select @answer = @answer+' \n הסיסמא הזמנית היא '+@temp_password

select @answer

select * from Employee
select * from Passwords

select ID,First_name,Last_name,Password,Expiry  from Employee E inner join Passwords P on P.Employee_code = E.Code