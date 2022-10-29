CREATE DATABASE SecondHomeTask
GO
USE SecondHomeTask
GO


CREATE TABLE Departments(

	[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Financing] MONEY NOT NULL DEFAULT 0,
	CHECK([Financing]>=0),
	[DepartmentName] NVARCHAR(100) NOT NULL,
	UNIQUE([DepartmentName])
)


INSERT INTO Departments([DepartmentName],[Financing])
VALUES('Open-Source Hardware Backup Team',1000),
('Multimedia Connectivity Division',2000),
('Database Security and Computer Connectivity Department',3000),
('Programming Administration and Installation Branch',5000),
('Statistical Multimedia Technology Team',4000)



CREATE TABLE Groups(

	[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[GroupName] NVARCHAR(30) NOT NULL,
	UNIQUE([GroupName]),
	[GroupRating] INT NOT NULL,
	CHECK([GroupRating]>=0 AND [GroupRating]<=5),
	[GroupYear] INT NOT NULL,
	CHECK([GroupYear]>0 AND [GroupYear]<=5)
)


INSERT INTO Groups([GroupName],[GroupRating],[GroupYear])
VALUES ('FBES_3212',3,5),
('Flash Ninjas',3,2),
('New York Sonics',4,1),
('American Blasters',2,3),
('Red XPress',5,4),
('Awesome Heroes',4,3)




CREATE TABLE Teachers(


	[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[EmployementDate] DATE NOT NULL,
	CHECK([EmployementDate]>'1990-01-01'),
	[IsAssistant] BIT NOT NULL DEFAULT 0,
	[IsProfessor] BIT NOT NULL DEFAULT 0,
	[TeacherName] NVARCHAR(MAX) NOT NULL,
	[TeacherPosition] NVARCHAR(MAX) NOT NULL,
	[TeacherPremium] MONEY NOT NULL DEFAULT 0,
	CHECK([TeacherPremium]>0),
	[Salary] MONEY NOT NULL,
	CHECK([Salary]>0),
	[Surname] NVARCHAR(MAX) NOT NULL


)


INSERT INTO Teachers([TeacherName],[Surname],[EmployementDate],[IsAssistant],[IsProfessor],[TeacherPosition],[TeacherPremium],[Salary])
VALUES('Akif','Akifzade','2021-05-04',0,1,'Mathematichs',200,2000),
('John','Doe','2020-02-12',1,0,'Computer Science',100,1200),
('Leyla','Aliyeva','2012-12-10',0,1,'Physics',400,500),
('Arif','Arifzade','2022-05-14',1,0,'Chemistry',600,5000),
('Ali','Alizade','2019-10-23',0,1,'Computer Graphics',50,1100)


CREATE TABLE Faculties(

	[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Dean] NVARCHAR(MAX) NOT NULL,
	[Name] NVARCHAR(MAX) NOT NULL
)


INSERT INTO Faculties([Dean],[Name])
VALUES('Bradley Atcher','Computer Science'),
('Charles Climer','Physics'),
('Connor Gadwah','Chemistry'),
('Spencer Kreatsoulas','Mathematics'),
('Zion Krupp','Computer Graphics')


-- #1  Print departments table but arrange its field in the reverse order.

SELECT *
FROM Departments AS D
ORDER BY D.Financing DESC


-- #2 Print group names and their ratings using �Group Name� and �Group Rating�, respectively, as names of the fields

SELECT [GroupName],[GroupRating]
FROM  Groups


-- #3 Print for the teachers their surname, percentage of wage rate 
--    to premium ratio and percentage of wage rate to the salary ratio 
--   (the amount of wage rate and premium).


SELECT [Surname],(([TeacherPremium]/[Salary])*100)/[TeacherPremium] AS PerSalaryToPremium,(([TeacherPremium]/[Salary])*100)/[Salary] AS PerWageRateToSalary
FROM Teachers



-- #4 Print the faculty table as a single field in the following format: "The dean of faculty [faculty] is [dean]"

SELECT 'The dean of faculty '+[Name]+' is '+[Dean] AS FullInfo
FROM Faculties



-- #5 Identify names of the teachers who are professors and whose wage rate exceeds 1050


SELECT *
FROM Teachers
WHERE Teachers.[IsProfessor]=1 AND Teachers.[Salary]>1050


-- #6 Print names of the departments whose funding is less than 2000 or more than 4000.

SELECT *
FROM Departments
WHERE Departments.[Financing]<2000 OR Departments.[Financing]>4000


-- #7 Print names of faculties other than Computer Science.

SELECT *
FROM Faculties
WHERE Faculties.[Name]!='Computer Science'


-- #8 Print names and positions of teachers who are not professors.

SELECT [TeacherName],[TeacherPosition]
FROM Teachers
WHERE Teachers.IsProfessor=0


-- #9 Print surnames, positions, wage rates, and premia of assistants whose premium is in the range from 160 to 550.

SELECT [Surname],[TeacherPosition],[Salary],[TeacherPremium]
FROM Teachers
WHERE Teachers.TeacherPremium>=160 AND Teachers.TeacherPremium<=550

-- #10 Print surnames and wage rates of assistants.

SELECT [Surname],[Salary]
FROM Teachers
WHERE Teachers.IsAssistant=1


-- #11 Print surnames and positions of the teachers who were hired before 01.01.2020. 

SELECT [Surname],[TeacherPosition]
FROM Teachers
WHERE Teachers.EmployementDate<'2020-01-01'


-- #12 Print names of the departments in alphabetical order up 
--     to  the  Software Development Department. The output field 
--     should be named "Name of Department".


SELECT [DepartmentName] AS NameOfDepartment
FROM Departments
ORDER BY Departments.DepartmentName ASC


-- #13 Print names of the assistants whose salary (amount of wage rate and premium) is not more than 2000.

SELECT [TeacherName],[Salary]
FROM Teachers
WHERE Teachers.IsAssistant=1 AND (Teachers.Salary+Teachers.TeacherPremium)<=2000

-- #14 Print names of groups of the 5th year whose rating is in the range 
--     from 2 to 4.

SELECT [GroupName] AS GroupNames
FROM Groups
WHERE Groups.GroupYear=5 AND (Groups.GroupRating>=2 AND Groups.GroupRating<=4)


-- #15 Print names of assistants whose wage rate is less than 550 or premium is less than 200.

SELECT [TeacherName],[Salary],[TeacherPremium]
FROM Teachers
WHERE Teachers.Salary<550 OR Teachers.TeacherPremium<200