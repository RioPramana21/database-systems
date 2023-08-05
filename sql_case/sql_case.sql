USE GoTraining
GO

-- 1
-- Show a list of participants who are doing the “SQL Server” course with the “Advanced” level.
SELECT
	*
FROM
	Participant
WHERE
	Participant_Id IN (
		SELECT
			p.Participant_Id
		FROM
			Participant p JOIN
			OnGoingCourse ogc ON
			p.Participant_Id = ogc.Participant_Id JOIN
			Course c ON
			c.Course_Id = ogc.Course_Id
		WHERE
			Course_Name = 'SQL Server'
			AND
			[Level] = 'Advanced'
	)

GO
-- 2
-- Using subquery, show a list of trainers who are responsible for the “Project Management dan Leadership” course.
SELECT
	*
FROM
	Teacher
WHERE
	Teacher_Id IN (
		SELECT
			t.Teacher_Id
		FROM
			Teacher t JOIN
			Course c ON
			t.Teacher_Id = c.Teacher
		WHERE
			Course_Name = 'Project Management dan Leadership'
	)

GO
-- 3
-- Create a view to show active participants and courses during January 2022.
CREATE VIEW [Active Participants and Courses During January 2022]
AS
SELECT
	c.*, p.*
FROM
	OnGoingCourse ogc JOIN
	Course c ON
	ogc.Course_Id = c.Course_Id JOIN
	Participant p ON
	p.Participant_Id = ogc.Participant_Id
WHERE
	[Start_date] <= '2022-01-31'
	AND
	[End_date] >= '2022-01-01'
	AND
	[Status] = 'Active'

GO

CREATE VIEW [Active Participants and Courses During January 2022]
AS
SELECT
	c.*, p.*
FROM
	OnGoingCourse ogc JOIN
	Course c ON
	ogc.Course_id = c.Course_id JOIN
	Participant p ON
	p.Participant_id = ogc.Participant_id
WHERE
	[Start_date] >= '2022-01-01'
	AND
	[End_date] <= '2022-01-31'
	AND
	[Status] = 'Active'

GO
-- 4
-- Create a trigger to update the “participant” table, with a success message: “Data has been recorded”.
CREATE TRIGGER TR_UPDATE_tblParticipant
ON Participant
FOR UPDATE
AS
SET NOCOUNT ON
BEGIN
	DECLARE @success_msg VARCHAR(30) = 'Data has been recorded'

	IF UPDATE(Participant_Id)
		PRINT @success_msg
	ELSE IF UPDATE (PFirst_Name)
		PRINT @success_msg
	ELSE IF UPDATE (PLast_Name)
		PRINT @success_msg
	ELSE IF UPDATE (Phone_Number)
		PRINT @success_msg
	ELSE IF UPDATE (Participant_email)
		PRINT @success_msg
	ELSE IF UPDATE (Client_Id)
		PRINT @success_msg
END