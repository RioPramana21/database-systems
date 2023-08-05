CREATE DATABASE GoTraining
GO
USE GoTraining
GO
CREATE TABLE [Teacher] (
	Teacher_id CHAR(5) PRIMARY KEY CHECK (Teacher_id LIKE 'TE[0-9][0-9][0-9]'),
	First_Name VARCHAR(50) NOT NULL
);
GO
CREATE TABLE [Client] (
	Client_id CHAR(5) PRIMARY KEY CHECK (Client_id LIKE 'CL[0-9][0-9][0-9]'),
	Company_Name VARCHAR(50) NOT NULL
);
GO
CREATE TABLE [Course] (
	Course_id CHAR(5) PRIMARY KEY CHECK (Course_id LIKE 'CL[0-9][0-9][0-9]'),
	Course_Name VARCHAR(50) NOT NULL,
	[Level] VARCHAR(50) NOT NULL,
	[Start_date] DATE NOT NULL,
	[End_date] DATE NOT NULL,
	Teacher CHAR(5) FOREIGN KEY REFERENCES [Teacher](Teacher_id) NOT NULL,
	Client CHAR(5) FOREIGN KEY REFERENCES [Client](Client_id) NOT NULL
);
GO
CREATE TABLE [Participant] (
	Participant_id CHAR(5) PRIMARY KEY CHECK (Participant_id LIKE 'PA[0-9][0-9][0-9]'),
	P_Name VARCHAR(50) NOT NULL,
	Client_id CHAR(5) FOREIGN KEY REFERENCES [Client](Client_id) NOT NULL
);
GO
CREATE TABLE [OnGoingCourse] (
	Course_id CHAR(5) FOREIGN KEY REFERENCES [Course](Course_id) NOT NULL,
	Participant_id CHAR(5) FOREIGN KEY REFERENCES [Participant](Participant_id) NOT NULL,
	[Status] VARCHAR(100),
	PRIMARY KEY (Course_id, Participant_id)
);

INSERT INTO Teacher VALUES
('TE001', 'Teacher1'),
('TE002', 'Teacher2'),
('TE003', 'Teacher3'),
('TE004', 'Teacher4'),
('TE005', 'Teacher5')
GO
INSERT INTO Client VALUES
('CL001', 'Client1'),
('CL002', 'Client2'),
('CL003', 'Client3'),
('CL004', 'Client4'),
('CL005', 'Client5')
GO
INSERT INTO Course VALUES
('CL007', 'Project Management dan Leadership', 'Intermediate', '2021-12-21', '2022-02-21', 'TE004', 'CL002'),
('CL006', 'Project Management dan Leadership', 'Beginner', '2022-02-03', '2022-04-03', 'TE003', 'CL002'),
('CL001', 'SQL Server', 'Advanced', '2022-01-01', '2022-01-30', 'TE001', 'CL003'),
('CL002', 'SQL Server', 'Beginner', '2021-12-28', '2022-02-18', 'TE002', 'CL001'),
('CL003', 'Project Management dan Leadership', 'Advanced', '2022-02-03', '2022-04-03', 'TE002', 'CL002'),
('CL004', 'Course4', 'Advanced', '2022-01-18', '2022-02-03', 'TE001', 'CL004'),
('CL005', 'Course5', 'Beginner', '2022-03-01', '2022-04-28', 'TE005', 'CL005')
GO
INSERT INTO Participant VALUES
('PA001', 'Participant1', 'CL001'),
('PA002', 'Participant2', 'CL002'),
('PA003', 'Participant3', 'CL003'),
('PA004', 'Participant4', 'CL004'),
('PA005', 'Participant5', 'CL005'),
('PA006', 'Participant6', 'CL001'),
('PA007', 'Participant7', 'CL002'),
('PA008', 'Participant8', 'CL003'),
('PA009', 'Participant9', 'CL004'),
('PA010', 'Participant10', 'CL005')
GO
INSERT INTO OnGoingCourse VALUES
('CL007', 'PA008', 'Active'),
('CL001', 'PA001', 'Active'),
('CL001', 'PA002', 'Active'),
('CL001', 'PA003', 'Active'),
('CL001', 'PA004', 'Active'),
('CL002', 'PA005', 'Done'),
('CL003', 'PA006', 'Active'),
('CL003', 'PA007', 'Active'),
('CL004', 'PA008', 'Done'),
('CL004', 'PA009', 'Done'),
('CL005', 'PA010', 'Active')

SELECT * FROM Course
SELECT * FROM Client
SELECT * FROM Participant
SELECT * FROM OnGoingCourse
SELECT * FROM Teacher