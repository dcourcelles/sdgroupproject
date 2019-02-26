USE MASTER
GO
DROP DATABASE dbTruphox
GO
CREATE DATABASE dbTruphox
GO
USE dbTruphox
GO

-------------------------------- TABLES --------------------------------

CREATE TABLE tbAccount
(
	username VARCHAR(30) PRIMARY KEY,
	userPassword VARCHAR(30),
	email VARCHAR(70),
	firstName VARCHAR(40),
	lastName VARCHAR (40),
	dob DATETIME,
	profileImage VARCHAR(1200),
	bio VARCHAR(400),
	joinDate DATETIME,
	active BIT,
	accessLevel INT
)

CREATE TABLE tbFollowing
(
	followID INT IDENTITY (0,1) PRIMARY KEY,
	username VARCHAR(30) FOREIGN KEY REFERENCES tbAccount(username),
	followedUser VARCHAR(30) FOREIGN KEY REFERENCES tbAccount(username)
)

CREATE TABLE tbBlocked
(
	blockID INT IDENTITY (0,1) PRIMARY KEY,
	username VARCHAR(30) FOREIGN KEY REFERENCES tbAccount(username),
	blockedUser VARCHAR(30) FOREIGN KEY REFERENCES tbAccount(username),
	blockDate DATETIME
)

CREATE TABLE tbNotification
(
	notificationID INT IDENTITY (0,1) PRIMARY KEY,
	notificationText VARCHAR(100),
	notificationDate DATETIME,
	username VARCHAR(30) FOREIGN KEY REFERENCES tbAccount(username)
)

CREATE TABLE tbPost
(
	postID INT IDENTITY(0,1) PRIMARY KEY,
	rating BIT,
	postTitle VARCHAR(50),
	postSubTitle VARCHAR(50),
	postDate DATETIME,
	lastComment INT,
	username VARCHAR(30) FOREIGN KEY REFERENCES tbAccount(username)
)

CREATE TABLE tbComment
(
	commentID INT IDENTITY (0,1) PRIMARY KEY,
	postID INT FOREIGN KEY REFERENCES tbPost(postID),
	postCommentNumber INT,
	commentText VARCHAR(100),
	commentDate DATETIME,
	username VARCHAR(30)
)

CREATE TABLE tbDeletedComments
(
	commentID INT,
	postID INT FOREIGN KEY REFERENCES tbPost(postID),
	postCommentNumber INT,
	commentText VARCHAR(100),
	commentDate DATETIME,
	username VARCHAR(30),
	deletedCommentDate DATETIME
)

CREATE TABLE tbLike
(
	likeID INT IDENTITY (0,1) PRIMARY KEY,
	postID INT FOREIGN KEY REFERENCES tbPost(postID),
	username VARCHAR(30) FOREIGN KEY REFERENCES tbAccount(username)
)

CREATE TABLE tbCommentLike
(
	commentLikeID INT IDENTITY (0,1) PRIMARY KEY,
	commentID INT FOREIGN KEY REFERENCES tbComment(commentID),
	username VARCHAR(30) FOREIGN KEY REFERENCES tbAccount(username)
)

CREATE TABLE tbTagName
(
	tagID INT IDENTITY (0,1) PRIMARY KEY,
	tagName VARCHAR(30)
)

CREATE TABLE tbPostTag
(
	postTagID INT IDENTITY (0,1) PRIMARY KEY,
	postID INT FOREIGN KEY REFERENCES tbPost(postID),
	tagID INT FOREIGN KEY REFERENCES tbTagName(tagID)
)

CREATE TABLE tbWriting
(
	writingID INT IDENTITY (0,1) PRIMARY KEY,
	postID INT FOREIGN KEY REFERENCES tbPost(postID),
	writingText VARCHAR(3000)
)

CREATE TABLE tbArt
(
	artID INT IDENTITY (0,1) PRIMARY KEY,
	postID INT FOREIGN KEY REFERENCES tbPost(postID),
	artLink VARCHAR(150)
)

CREATE TABLE tbPhotography
(
	photoID INT IDENTITY (0,1) PRIMARY KEY,
	postID INT FOREIGN KEY REFERENCES tbPost(postID),
	photoLink VARCHAR(150)
)

CREATE TABLE tbVideo
(
	videoID INT IDENTITY (0,1) PRIMARY KEY,
	postID INT FOREIGN KEY REFERENCES tbPost(postID),
	videoLink VARCHAR(150)
)

CREATE TABLE tbPassRecovery
(
	email VARCHAR(60),
	recoveryGuid VARCHAR(300),
	recoveryDate date
)

CREATE TABLE tbForum
(
	forumID INT IDENTITY(0,1) PRIMARY KEY,
	rating BIT,
	forumTitle VARCHAR(50),
	forumText VARCHAR(800),
	forumDate DATETIME,
	username VARCHAR(30)
)

CREATE TABLE tbForumResponse
(
	forumResID INT IDENTITY(0,1) PRIMARY KEY,
	forumResText VARCHAR(500),
	forumResDate DATETIME,
	username VARCHAR(30),
	forumID INT FOREIGN KEY REFERENCES tbForum(forumID)
)

--CREATE TABLE tbSale
--(
--	saleID INT IDENTITY (0,1) PRIMARY KEY,
--	saleStatus VARCHAR(30)


--CREATE TABLE tbType
--(
--	typeID INT IDENTITY (0,1) PRIMARY KEY,
--	typeName VARCHAR(30)
--)

--CREATE TABLE tbItem
--(
--	itemID INT IDENTITY (0,1) PRIMARY KEY,
--	typeID INT FOREIGN KEY REFERENCES tbType(typeID),
--	itemName VARCHAR(40)
--)

GO

-------------------------------- ACCOUNTS PROCEDURES--------------------------------

CREATE PROCEDURE spCreateAccount
(
	@username VARCHAR(30),
	@userPassword VARCHAR(30),
	@email VARCHAR(70),
	@firstName VARCHAR(40),
	@lastName VARCHAR (40),
	@dob DATETIME,
	@bio VARCHAR(400) = NULL,
	@profileImage VARCHAR(1200) = NULL,
	@active BIT = 1,
	@accessLevel INT = 1
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbAccount WHERE username = @username)
		BEGIN
			SELECT 'User already exists' as MESSAGE
		END
	ELSE
		BEGIN
			INSERT INTO tbAccount (username, userPassword, email, firstName, lastName, dob, bio, profileImage, joinDate, active, accessLevel) VALUES
						(@username, @userPassword, @email, @firstName, @lastName, @dob, @bio, @profileImage, GETDATE(), @active, @accessLevel)
		END
END
GO

CREATE PROCEDURE spActivateAccount
(
	@username VARCHAR(30)
)
AS
BEGIN
	UPDATE tbAccount SET
	active = 1
	WHERE username = @username;
END
GO

CREATE PROCEDURE spReadAccount
(
	@username VARCHAR(30)=NULL
)
AS
BEGIN
	SELECT * FROM tbAccount WHERE username = ISNULL (@username, username)
END
GO

CREATE PROCEDURE spUpdateAccount
(
    @username VARCHAR(30), 
	@firstName VARCHAR(40)=NULL,
	@lastName VARCHAR (40)=NULL,
	@email VARCHAR(70),
	@bio VARCHAR(400) = NULL,
	@dob DATETIME=NULL,
	@userPassword VARCHAR(30)
)
AS
BEGIN
	UPDATE tbAccount SET
    firstName = @firstName, 
    lastName = @lastName, 
	email = @email,
    bio=@bio,
	dob = @dob,
	userPassword = @userPassword
	WHERE username = @username

END
GO

CREATE PROCEDURE spUpdateProfilePict
(
    @username VARCHAR(30), 
	@profileImage VARCHAR(1200)
)
AS
BEGIN
    UPDATE tbAccount SET
	profileImage = @profileImage
	WHERE username = @username
END
GO


CREATE PROCEDURE spDisableAccount
(
	@username VARCHAR(30)
)
AS
BEGIN
	UPDATE tbAccount SET
	active = 0
	WHERE username = @username
END
GO

-------------------------------- LOGIN --------------------------------
CREATE PROCEDURE spLogin
(
	@username VARCHAR(30),
	@userPassword VARCHAR(30)
)
AS
BEGIN
   IF EXISTS (SELECT * FROM tbAccount WHERE username = @username and userPassword = @userPassword)
		BEGIN
			SELECT 'valid' as MESSAGE, active, accessLevel, username FROM tbAccount WHERE username = @username and userPassword=@userPassword; 
		END
   ELSE 
        BEGIN 
	        SELECT 'invalid' AS MESSAGE, -1 as active, -1 as accessLevel, '' as username 
	    END 
END
GO

-------------------------------- RECOVER --------------------------------

CREATE PROCEDURE spRecoverUsername
(
	@email VARCHAR(60)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbAccount WHERE email = @email)
		BEGIN
			SELECT 'VALID' AS MESSAGE, username
			FROM tbAccount
			WHERE email = @email
		END
END
GO

CREATE PROCEDURE spRecoverPassword
(
	@username VARCHAR(30)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbAccount WHERE username = @username)
		BEGIN
			SELECT 'VALID' AS MESSAGE, userPassword, email
			FROM tbAccount
			WHERE username = @username
		END
END
GO

CREATE PROCEDURE spInsertGuid
(
	@recoveryGuid VARCHAR(300),
	@email VARCHAR(60)
)
AS
BEGIN
	INSERT INTO tbPassRecovery (email, recoveryGuid, recoveryDate) VALUES
								(@email, @recoveryGuid, GETDATE())
END
GO

CREATE PROCEDURE spValidCheck
(
	@recoveryGuid VARCHAR(200)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbPassRecovery WHERE recoveryGuid = @recoveryGuid)
		BEGIN
			SELECT 'VALID' AS MESSAGE, username
			FROM tbAccount a INNER JOIN tbPassRecovery r ON
			a.email = r.email
			WHERE r.recoveryGuid = @recoveryGuid

			DELETE FROM tbPassRecovery
			WHERE recoveryGuid = @recoveryGuid
		END
END
GO

CREATE PROCEDURE spResetPassword
(
	@username VARCHAR(30),
	@userPassword VARCHAR(30)
)
AS
BEGIN
	UPDATE tbAccount SET
	userPassword = @userPassword
	WHERE username = @username
END
GO

-------------------------------- FOLLOWING --------------------------------

CREATE PROCEDURE spCreateFollow
(
	@username VARCHAR(30),
	@followedUser VARCHAR(30)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbBlocked WHERE username = @username AND blockedUser = @followedUser OR username = @followedUser AND blockedUser = @username)
		BEGIN
			SELECT 'User cannot be followed' AS MESSAGE
		END
	ELSE
		BEGIN
			IF EXISTS (SELECT * FROM tbFollowing WHERE username = @username and followedUser = @followedUser)
				BEGIN
					DELETE FROM tbFollowing WHERE username = @username and followedUser = @followedUser
					SELECT 'unfollowed' AS MESSAGE
				END
			ELSE
				BEGIN
					INSERT INTO tbFollowing (username, followedUser) VALUES
											(@username, @followedUser)
					SELECT 'followed' AS MESSAGE
				END
		END
END
GO

CREATE PROCEDURE spReadFollow
(
	@username VARCHAR(30) = NULL,
	@followedUser VARCHAR(30) = NULL
)
AS
BEGIN
	IF (@username IS NOT NULL and @followedUser IS NULL)
		BEGIN
			SELECT * FROM tbFollowing WHERE username = @username
		END
	ELSE IF (@followedUser IS NOT NULL and @username IS NULL)
		BEGIN
			SELECT * FROM tbFollowing WHERE followedUser = @followedUser
		END
	ELSE
		BEGIN
			SELECT 'Must provide only username or followedUser' as MESSAGE
		END
END
GO	


-------------------------------- BLOCKED --------------------------------

CREATE PROCEDURE spCreateBlock
(
	@username VARCHAR(30),
	@blockedUser VARCHAR(30),
	@blockDate DATETIME = null
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbBlocked WHERE username = @username and blockedUser = @blockedUser)
		BEGIN
			DELETE FROM tbBlocked WHERE username = @username and blockedUser = @blockedUser
			SELECT 'unblocked' AS MESSAGE
		END
	ELSE
		BEGIN
			INSERT INTO tbBlocked(username, blockedUser, blockDate) VALUES
						(@username, @blockedUser, GETDATE())
		SELECT 'blocked' AS MESSAGE
		END
END
GO

CREATE PROCEDURE spReadBlock
(
	@username VARCHAR(30) = null,
	@blockedUser VARCHAR(30)
)
AS
BEGIN
	IF (@username IS NOT NULL and @blockedUser IS NULL)
		BEGIN
			SELECT * FROM tbBlocked WHERE username = @username
		END
	ELSE IF (@blockedUser IS NOT NULL and @username IS NULL)
		BEGIN
			SELECT * FROM tbBlocked WHERE blockedUser = @blockedUser
		END
	ELSE
		BEGIN
			SELECT 'Must provide only username or blockedUser' as MESSAGE
		END
END
GO

-------------------------------- Notification --------------------------------

CREATE PROCEDURE spCreateNotification
(
	@notificationText VARCHAR(100),
	@username VARCHAR(30)
)
AS
BEGIN
	INSERT INTO tbNotification (notificationText, notificationDate, username) VALUES (@notificationText, GETDATE(), @username)
END
GO

CREATE PROCEDURE spReadNotification
(
	@username VARCHAR(30)
)
AS
BEGIN
	SELECT TOP 10 * FROM tbNotification WHERE username = ISNULL (@username, username)
END
GO

CREATE PROCEDURE spUpdateNotification
(
	@notificationID INT,
	@notificationText VARCHAR(100),
	@notificationDate DATETIME,
	@username VARCHAR(30)
)
AS
BEGIN
	UPDATE tbNotification SET
	notificationText = @notificationText,
	notificationDate = @notificationDate,
	username = @username
	WHERE notificationID = @notificationID
END
GO

CREATE PROCEDURE spDeleteNotification
(
	@notificationID INT
)
AS
BEGIN
	DELETE FROM tbNotification WHERE notificationID = @notificationID
END
GO

-------------------------------- POST --------------------------------
CREATE PROCEDURE spReadPost
(
	@postID INT
)
AS
BEGIN
	SELECT * FROM tbPost WHERE postID = ISNULL (@postID, postID)
END
GO

EXEC spReadPost @postID=10
GO

CREATE PROCEDURE spDeletePost
(
	@postID INT
)
AS
BEGIN
	DELETE FROM tbComment WHERE postID = @postID
	DELETE FROM tbDeletedComments WHERE postID = @postID
	DELETE FROM tbLike WHERE postID = @postID
	DELETE FROM tbPostTag WHERE postID = @postID
	DELETE FROM tbWriting WHERE postID = @postID
    DELETE FROM tbVideo WHERE postID = @postID
	DELETE FROM tbArt WHERE postID = @postID
	DELETE FROM tbPhotography WHERE postID = @postID
	DELETE FROM tbPost WHERE postID = @postID
END
GO

SELECT * FROM tbPost
GO


-------------------------------- COMMENT --------------------------------

CREATE PROCEDURE spCreateComment
(
	@postID INT,
	@commentText VARCHAR(100),
	@username VARCHAR(30)
)
AS
BEGIN
	INSERT INTO tbComment (postID, commentText, commentDate, username) VALUES
						(@postID, @commentText, GETDATE(), @username)

END
GO

CREATE PROCEDURE spReadComment
(
	@postID INT
)
AS
BEGIN
	SELECT c.postID, c.postCommentNumber, c.commentText, c.commentDate, c.username, a.profileImage
	FROM tbComment c INNER JOIN tbAccount a ON
	c.username = a.username
	WHERE postID = ISNULL (@postID, postID)
	ORDER BY c.commentDate DESC	
END
GO

CREATE PROCEDURE spUpdateComment
(
	@commentID INT,	
	@commentText VARCHAR(100)	
)
AS
BEGIN
	UPDATE tbComment SET
	commentText = @commentText
	WHERE commentID = @commentID
END
GO

CREATE PROCEDURE spDeleteComment
(
	@commentID INT
)	
AS
BEGIN
	INSERT INTO tbDeletedComments (commentID, postID, commentText, commentDate, username)
	SELECT commentID, postID, commentText, commentDate, username
	FROM tbComment
	WHERE commentID = @commentID
	
	UPDATE tbDeletedComments SET
	deletedCommentDate = GETDATE()
	WHERE commentID = @commentID

	DELETE FROM tbComment WHERE commentID = @commentID
END
GO

CREATE PROCEDURE spReadDeletedComments
(
	@commentID INT = null
)
AS
BEGIN
	SELECT * FROM tbDeletedComments WHERE commentID = ISNULL (@commentID, commentID)
END
GO

CREATE PROCEDURE spClearDeletedComments
(
	@deletedDate DATETIME
)
AS
BEGIN
	DELETE FROM tbDeletedComments WHERE deletedCommentDate < @deletedDate
END
GO

-------------------------------- POST LIKE --------------------------------

CREATE PROCEDURE spCreateLike
(
	@postID INT,
	@username VARCHAR(30)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbLike WHERE username = @username and postID = @postID)
				BEGIN
					DELETE FROM tbLike WHERE username = @username and postID = @postID
					SELECT 'UNLIKED' AS MESSAGE
				END
			ELSE
				BEGIN				
					INSERT INTO tbLike (postID, username) VALUES
									(@postID, @username)
					SELECT 'LIKED' AS MESSAGE
				END
END
GO

CREATE PROCEDURE spReadLike
(
	@postID INT
)
AS
BEGIN
	SELECT count(postID) as 'count' FROM tbLike WHERE postID = ISNULL (@postID, postID)
END
GO

CREATE PROCEDURE spReadUserLike
(
	@postID INT,
	@username VARCHAR(30)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbLike WHERE username = @username and postID = @postID)
		BEGIN
			SELECT 'LIKED' AS MESSAGE
		END
	ELSE
		BEGIN
			SELECT 'LIKE' AS MESSAGE
		END
END
GO

EXEC spReadUserLike @postID='17', @username='CanadaGhost';
GO


-------------------------------- TAGS --------------------------------

CREATE PROCEDURE spCreateTag
(
	@tagName VARCHAR(30)
)
AS
BEGIN
		IF EXISTS (SELECT * FROM tbTagName WHERE tagName = @tagName)
			BEGIN
				SELECT 'Tag Already Exists' AS MESSAGE
			END
		ELSE
			BEGIN				
				INSERT INTO tbTagName(tagName) VALUES
									(@tagName)
			END	
END
GO

CREATE PROCEDURE spReadTag
(
	@tagID INT
)
AS
BEGIN
	SELECT * FROM tbTagName WHERE tagID = ISNULL (@tagID, tagID)
END
GO

CREATE PROCEDURE spDeleteTag
(
	@tagID INT
)
AS
BEGIN
	DELETE FROM tbTagName WHERE tagID = @tagID
END
GO

-------------------------------- POST TAGS --------------------------------

CREATE PROCEDURE spCreatePostTag
(
	@postID INT,
	@tagName VARCHAR(30),
	@tagID INT
)
AS
BEGIN
	IF EXISTS (SELECT * FROM tbTagName WHERE tagName = @tagName)
		BEGIN
			INSERT INTO tbPostTag (postID, tagID) VALUES
								(@postID, @tagID)
		END
	ELSE
		BEGIN				
			INSERT INTO tbTagName(tagName) VALUES
								(@tagName)
			INSERT INTO tbPostTag (postID, tagID) VALUES
								(@postID, @@IDENTITY)
		END	
END
GO

CREATE PROCEDURE spReadPostTag
(
	@postTagID INT
)
AS
BEGIN
	SELECT * FROM tbPostTag WHERE postTagID = ISNULL (@postTagID, postTagID)
END
GO

CREATE PROCEDURE spDeletePostTag
(
	@postTagID INT
)
AS
BEGIN
	DELETE FROM tbPostTag WHERE postTagID = @postTagID
END
GO

-------------------------------- WRITING --------------------------------

CREATE PROCEDURE spCreateWriting
(
	@rating BIT,
	@postTitle VARCHAR(50),
	@postSubTitle VARCHAR(50)=NULL,
	@username VARCHAR(30),
	@writingText VARCHAR(3000)
)
AS
BEGIN
	INSERT INTO tbPost (rating, postDate, postTitle, postSubTitle, username) VALUES
					(@rating, GETDATE(), @postTitle, @postSubTitle, @username)
	SELECT @@IDENTITY AS 'postID'
	INSERT INTO tbWriting (writingText, postID) VALUES
					(@writingText, @@IDENTITY)
END
GO

CREATE PROCEDURE spReadWriting
(
	@postID INT=NULL
)
AS
BEGIN
	SELECT p.postID, p.postTitle, p.postSubTitle, w.writingText
	FROM tbPost p INNER JOIN tbWriting w ON
	p.postID = w.postID
   WHERE p.postID = ISNULL(@postID, p.postID);
END
GO

EXEC spReadWriting 
GO

CREATE PROCEDURE spReadRecentWriting
(
	@postID INT=NULL
)
AS
BEGIN
	SELECT p.postID, p.postTitle, p.postSubTitle, w.writingText
	FROM tbPost p INNER JOIN tbWriting w ON
	p.postID = w.postID
   WHERE p.postID = ISNULL(@postID, p.postID) AND postDate = GETDATE();	
END
GO

EXEC spReadRecentWriting 
GO

CREATE PROCEDURE spUpdateWriting
(
	@postID INT,
	@rating BIT,
	@postTitle VARCHAR(50),
	@postSubTitle VARCHAR(50)=NULL,
	@username VARCHAR(30),
	@writingText VARCHAR(3000)
)
AS
BEGIN
	UPDATE tbPost SET
	rating = @rating,
	postTitle = @postTitle,
	postSubtitle = @postSubTitle,
	username = @username
   WHERE postID = ISNULL(@postID, postID);

	UPDATE tbWriting SET
	writingText = @writingText
	WHERE postID = ISNULL(@postID, postID);
END
GO

-------------------------------- ART --------------------------------
	
CREATE PROCEDURE spCreateArt
(
	@rating BIT,
	@postTitle VARCHAR(50),
	@postSubTitle VARCHAR(50) = NULL,
	@username VARCHAR(30),
	@artLink VARCHAR(150)
)
AS
BEGIN
	INSERT INTO tbPost (rating, postDate, postTitle, postSubTitle, username) VALUES
					(@rating,  GETDATE(),@postTitle, @postSubTitle, @username)
	SELECT @@IDENTITY AS 'postID'
	INSERT INTO tbArt (postID, artLink) VALUES
					(@@IDENTITY, @artLink)
	
END
GO

CREATE PROCEDURE spReadArt
(
	@postID INT=NULL
)
AS
BEGIN
	SELECT a.postID as 'postID', './Images/' + artLink  as 'artLink', postTitle, postSubTitle
	FROM tbPost p INNER JOIN tbArt a ON
	p.postID = a.postID
	WHERE a.postID = ISNULL(@postID, a.postID);
END
GO

EXEC spReadArt @postID=17;
GO
 
 CREATE PROCEDURE spReadRecentArt
(
	@postID INT=NULL
)
AS
BEGIN
	SELECT a.postID as 'postID', './Images/' + artLink  as 'artLink', postTitle, postSubTitle
	FROM tbPost p INNER JOIN tbArt a ON
	p.postID = a.postID
	WHERE a.postID = ISNULL(@postID, a.postID) AND postDate = GETDATE();
END
GO

CREATE PROCEDURE spUpdateArt
(
	@postID INT,
	@rating BIT,
	@postTitle VARCHAR(50),
	@postSubTitle VARCHAR(50)=NULL,
	@username VARCHAR(30)
)
AS
BEGIN
	UPDATE tbPost SET
	rating = @rating,
	postTitle = @postTitle,
	postSubtitle = @postSubTitle,
	username = @username
	WHERE postID = ISNULL(@postID, postID);	
END
GO

-------------------------------- PHOTOGRAPHY --------------------------------

CREATE PROCEDURE spCreatePhotography
(
	@rating BIT,
	@postTitle VARCHAR(50),
	@postSubTitle VARCHAR(50)= NULL,
	@username VARCHAR(30),
	@photoLink VARCHAR(150)

)
AS
BEGIN
	INSERT INTO tbPost (rating, postDate, postTitle, postSubTitle, username) VALUES
					(@rating,  GETDATE(), @postTitle, @postSubTitle,  @username)
	SELECT @@IDENTITY AS 'postID'
	INSERT INTO tbPhotography (postID, photoLink) VALUES
					(@@IDENTITY, @photoLink)	
END
GO

CREATE PROCEDURE spReadPhotography
(
	@postID INT=NULL
)
AS
BEGIN
	SELECT ph.postID as 'postID', './Images/' + photoLink as 'photoLink', postTitle, postSubTitle
	    FROM tbPost p  INNER JOIN tbPhotography ph ON 
	    p.postID= ph.postID 
	    WHERE  ph.postID = ISNULL(@postID, p.postID);	
END
GO

EXEC spReadPhotography;
GO

CREATE PROCEDURE spReadRecentPhoto
(
@postID INT=NULL
)
AS
BEGIN
	SELECT ph.postID as 'postID', './Images/' + photoLink as 'photoLink', postTitle, postSubTitle
	    FROM tbPost p  INNER JOIN tbPhotography ph ON 
	    p.postID= ph.postID 
	    WHERE  ph.postID = ISNULL(@postID, p.postID) AND postDate = GETDATE();	
END
GO

EXEC spReadRecentPhoto;
GO

CREATE PROCEDURE spUpdatePhotography
(
	@postID INT,
	@rating BIT,
	@postTitle VARCHAR(50),
	@postSubTitle VARCHAR(50)=NULL,
	@username VARCHAR(30)
)
AS
BEGIN
	UPDATE tbPost SET
	rating = @rating,
	postTitle = @postTitle,
	postSubtitle = @postSubTitle,
	username = @username
	WHERE postID = ISNULL(@postID, postID);
END
GO

--CREATE PROCEDURE spDeletePhotography
--(
--	@postID INT
--)
--AS
--BEGIN
--	DELETE FROM tbComment WHERE postID = @postID
--	DELETE FROM tbDeletedComments WHERE postID = @postID
--	DELETE FROM tbLike WHERE postID = @postID
--	DELETE FROM tbPostTag WHERE postID = @postID
--	DELETE FROM tbPhotography WHERE postID = @postID
--	DELETE FROM tbPost WHERE postID = @postID
--END
--GO

-------------------------------- VIDEO --------------------------------

CREATE PROCEDURE spCreateVideo
(
	@rating BIT,
	@postTitle VARCHAR(50),
	@postSubTitle VARCHAR(50)=NULL,
	@username VARCHAR(30),
	@videoLink VARCHAR(150)
)
AS
BEGIN
	INSERT INTO tbPost (rating, postDate, postTitle, postSubTitle, username) VALUES
					(@rating, GETDATE(), @postTitle, @postSubTitle, @username)
	SELECT @@IDENTITY AS 'postID'
	INSERT INTO tbVideo (postID, videoLink) VALUES
					(@@IDENTITY, @videoLink)  
END
GO

CREATE PROCEDURE spReadVideo
(
	@postID INT=NULL
)
AS
BEGIN
	SELECT p.postID, p.postTitle, p.postSubTitle, p.postDate, p.username, v.videoID, './Video/' + v.videoLink as 'videoLink'
	FROM tbPost p INNER JOIN tbVideo v ON
	p.postID = v.postID
	WHERE p.postID = ISNULL(@postID, p.postID);
END
GO

CREATE PROCEDURE spUpdateVideo
(
	@postID INT,
	@rating BIT,
	@postTitle VARCHAR(50),
	@postSubTitle VARCHAR(50)=NULL,
	@username VARCHAR(30)
)
AS
BEGIN
	UPDATE tbPost SET
	rating = @rating,
	postTitle = @postTitle,
	postSubtitle = @postSubTitle,
	username = @username
	WHERE postID = ISNULL(@postID, postID);
END
GO


------------------RECENTLY ADDED... PROFILE--------------------

CREATE PROCEDURE spRecentlyAdded
(
@postID INT=NULL,
@username VARCHAR(30)
)
AS
BEGIN
    SELECT TOP 10  * FROM tbPost  
	WHERE username = @username 
	ORDER BY  postDate DESC
END
GO

------------------USER ART -------------------

CREATE PROCEDURE spReadUserArt
(
@postID INT=NULL,
@username VARCHAR(30)
)
AS
BEGIN
	SELECT a.postID as 'postID', './Images/' + artLink  as 'artLink', postTitle, postSubTitle FROM tbPost p INNER JOIN tbArt a ON 
	a.postID = p.postID
	WHERE username = @username 
	ORDER BY  postDate ASC
END
GO

------------------USER PHOTOGRAPHY -------------------

CREATE PROCEDURE spReadUserPhotography
(
@postID INT=NULL,
@username VARCHAR(30)
)
AS
BEGIN
	SELECT p.postID as 'postID', './Images/' + photoLink  as 'photoLink', postTitle, postSubTitle 
	FROM tbPost p INNER JOIN tbPhotography ph ON 
	ph.postID = p.postID
	WHERE username = @username 
	ORDER BY  postDate ASC
END
GO

------------------USER VIDEOS -------------------

CREATE PROCEDURE spReadUserVideo
(
@postID INT=NULL,
@username VARCHAR(30)
)
AS
BEGIN
	SELECT p.postID, p.postTitle, p.postSubTitle, p.postDate, p.username, v.videoID, './Video/' + v.videoLink as 'videoLink'
	FROM tbPost p INNER JOIN tbVideo v ON 
	v.postID = p.postID
	WHERE username = @username 
	ORDER BY  postDate ASC
END
GO

------------------USER WRITING -------------------

CREATE PROCEDURE spReadUserWriting
(
@postID INT=NULL,
@username VARCHAR(30)
)
AS
BEGIN
	SELECT  * FROM tbPost p INNER JOIN tbWriting w ON 
	w.postID = p.postID
	WHERE username = @username 
	ORDER BY  postDate ASC
END
GO

----------------------------------UNION BASED ON USERS  --------------------------------
CREATE PROCEDURE spHoomanUnion
(
 	@username VARCHAR(30)=NULL
)
AS 
BEGIN 
--UNION --ART 
      SELECT a.postID, rating, postTitle, postSubTitle, username,  './Images/' + artLink AS 'Images', 'Art' AS TYPE 
 FROM tbArt a INNER JOIN tbPost po ON 
  a.postID = po.postID
   WHERE username = @username

UNION --PHOTOGRAPHY 
      SELECT ph.postID, rating, postTitle, postSubTitle, username, './Images/' + photoLink AS 'Images', 'Photography' AS TYPE  
 FROM tbPhotography ph INNER JOIN tbPost po ON 
  ph.postID = po.postID
   WHERE username = @username

UNION --VIDEO 
      SELECT v.postID, rating, postTitle, postSubTitle, username,  './Video/' + videoLink AS 'Images', 'Video' AS TYPE 
 FROM tbVideo v INNER JOIN tbPost po ON 
  v.postID = po.postID
      WHERE username = @username

END 
GO

------------------UNION  PROC -------------------
CREATE PROCEDURE spSearchUnion
(
  @input VARCHAR (200) = NULL
)
AS 
BEGIN

--UNION --ART 
      SELECT a.postID, rating, postTitle, postSubTitle, username,  './Images/' + artLink AS 'Images', 'Art' AS TYPE 
 FROM tbArt a INNER JOIN tbPost po ON 
  a.postID = po.postID
   WHERE postTitle LIKE '%' + TRIM(@input) + '%'

UNION --PHOTOGRAPHY 
      SELECT ph.postID, rating, postTitle, postSubTitle, username, './Images/' + photoLink AS 'Images', 'Photography' AS TYPE  
 FROM tbPhotography ph INNER JOIN tbPost po ON 
  ph.postID = po.postID
   WHERE postTitle LIKE '%' + TRIM(@input) + '%'

UNION --VIDEO 
      SELECT v.postID, rating, postTitle, postSubTitle, username,  './Video/' + videoLink AS 'Images', 'Video' AS TYPE 
 FROM tbVideo v INNER JOIN tbPost po ON 
  v.postID = po.postID
   WHERE postTitle LIKE '%' + TRIM(@input) + '%'

END 
GO


------------------PHOX  PROC -------------------
CREATE PROCEDURE spPhoxUnion
(
  @input VARCHAR (200) = NULL
)
AS 
BEGIN

--UNION --ART 
      SELECT a.postID, rating, postTitle, postSubTitle, username,  './Images/' + artLink AS 'Images', 'Art' AS TYPE, postDate
 FROM tbArt a INNER JOIN tbPost po ON 
  a.postID = po.postID
   WHERE postTitle LIKE '%' + TRIM(@input) + '%'

UNION --PHOTOGRAPHY 
      SELECT ph.postID, rating, postTitle, postSubTitle, username, './Images/' + photoLink AS 'Images', 'Photography' AS TYPE, postDate 
 FROM tbPhotography ph INNER JOIN tbPost po ON 
  ph.postID = po.postID
   WHERE postTitle LIKE '%' + TRIM(@input) + '%'

UNION --VIDEO 
      SELECT v.postID, rating, postTitle, postSubTitle, username,  './Video/' + videoLink AS 'Images', 'Video' AS TYPE, postDate
 FROM tbVideo v INNER JOIN tbPost po ON 
  v.postID = po.postID
   WHERE postTitle LIKE '%' + TRIM(@input) + '%'
	SELECT TOP 6 * FROM tbPost
	   	ORDER BY  postDate ASC 

END 
GO

-------------------------------- SEARCH SITE --------------------------------
CREATE PROCEDURE spSearch 
(
  @input VARCHAR (200) = NULL
)
AS
BEGIN
	 SELECT * FROM  tbPost
 WHERE postTitle LIKE '%' + TRIM(@input) + '%';
END
GO

-------------------------------- SEARCH USERS --------------------------------
CREATE PROCEDURE spUSearch 
(
  @input VARCHAR (200) = NULL
)
AS
BEGIN
	 SELECT username, './Images/' +profileImage as profileImage, bio FROM tbAccount
	             WHERE username LIKE '%' + TRIM(@input) + '%';
END
GO

---------------------------------- FORUMS --------------------------------
CREATE PROCEDURE spForums
(
	@rating BIT,
	@forumTitle VARCHAR(50),
	@forumText VARCHAR(800),
	@username VARCHAR(30)
)
AS
BEGIN
	INSERT INTO tbForum (rating, forumTitle, forumText, forumDate, username) VALUES
					          (@rating, @forumTitle, @forumText, GETDATE(), @username)
   SELECT @@IDENTITY AS 'forumID'
END
GO

---------------------------------- READ FORUMS --------------------------------
CREATE PROCEDURE spReadForums
(
  @forumID INT = NULL 
)
 AS
BEGIN
    SELECT * FROM tbForum WHERE forumID = ISNULL (@forumID, forumID);
END 
GO

EXEC spReadForums @forumID = NULL;
EXEC spReadForums @forumID = 1;

GO

----------------------------------DELETE  FORUMS --------------------------------
--CREATE PROCEDURE spDeleteForum
--(
--	@forumID INT
--)
--AS
--BEGIN
--	DELETE FROM tbForum WHERE forumID = @forumID
--END
--GO

----------------------------------RESPONSE  FORUMS --------------------------------

CREATE PROCEDURE spCreateForumResponse
(
	@forumResText VARCHAR(500),	
	@username VARCHAR(30),
	@forumID INT
)
AS
BEGIN
	INSERT INTO tbForumResponse (forumResText, forumResDate, username, forumID) VALUES
								(@forumResText, GETDATE(), @username, @forumID)
END
GO

CREATE PROCEDURE spReadForumResponse
(
	@forumID INT
)
AS
BEGIN
	SELECT forumResText, forumResDate, username, forumID
	FROM tbForumResponse WHERE forumID = ISNULL (@forumID, forumID)
	ORDER BY forumResDate DESC
END
GO

-------------------------------- USERS CREATED --------------------------------

EXEC spCreateAccount @username='wrenjay', @userPassword='admin', @email='wrenjaymes@gmail.com', @firstName='Wren', @lastName='Jaymes', @dob='1997-01-01', @profileImage='profilePict.jpg', @bio='One of the geeky nerds running this website.', @active='1', @accessLevel='0';
EXEC spCreateAccount @username='CanadaGhost', @userPassword='admin', @email='dcourcelles7@gmail.com', @firstName='Dan', @lastName='Courcelles', @dob='1990-01-01', @profileImage='tiny-rick_profile.jpg', @bio='',  @active='1', @accessLevel='0';
EXEC spCreateAccount @username='Truphox', @userPassword='admin', @email='truphox@gmail.com', @firstName='Truphox', @lastName='Admin', @dob='', @profileImage='profilePict.jpg',  @bio='IT HAS FINIALLY ARRIVED! This is the offical launch of TruPhox, the website built for even the most novice of artists, videographers and poets. Post your creavity, like and share other ones and join the community that will accept you where ever you are.', @active='1', @accessLevel='0';
EXEC spCreateAccount @username='TestAccount1', @userPassword='password', @email='email@gmail.com', @firstName='Person', @lastName='PersonLast', @dob='1999-11-28', @profileImage='profilePict.jpg',  @bio='', @active='1', @accessLevel='1';
EXEC spCreateAccount @username='TestAccount2', @userPassword='password', @email='email2@gmail.com', @firstName='Person', @lastName='Person', @dob='1989-01-24', @profileImage='profilePict.jpg',  @bio='', @active='1', @accessLevel='1';

SELECT * FROM tbAccount
GO

---------------------POSTS CREATED (WRITING) -------------------

EXEC spCreateWriting @rating=0, @postTitle='WELCOME', @postSubTitle='', @username='Truphox', @writingText='IT HAS FINALLY ARRIVED! This is the offical launch of TruPhox, the website built for even the most novice of artists, videographers and poets. Post your creativity, like and share other ones and join the community that will accept you where ever you are.';
EXEC spCreateWriting @rating=0,  @postTitle='Albert Einstein', @postSubTitle='Quotes', @username='Truphox', @writingText='Two things are infinite: the universe and human stupidity; and I''m not sure about the universe';
EXEC spCreateWriting @rating=0,  @postTitle='The Four Loves', @postSubTitle='C.S. Lewis', @username='wrenjay', @writingText='To love at all is to be vulnerable. Love anything and your heart will be wrung and possibly broken. If you want to make sure of keeping it intact you must give it to no one, not even an animal. Wrap it carefully round with hobbies and little luxuries; avoid all entanglements. Lock it up safe in the casket or coffin of your selfishness. But in that casket, safe, dark, motionless, airless, it will change. It will not be broken; it will become unbreakable, impenetrable, irredeemable. To love is to be vulnerabe.';
EXEC spCreateWriting @rating=0,  @postTitle='Truphox', @postSubTitle='', @username='CanadaGhost' , @writingText='Truphox is a great place for writing stories and quotes that you created!';
EXEC spCreateWriting @rating=0, @postTitle='Philosophy', @postSubTitle='', @username='wrenjay', @writingText='I have decied that if I spent my whole life believing I am something, I will amount to nothing. But if I believe I am nothing I will amount to nothing. Either way you cannot win...';
EXEC spCreateWriting @rating=0,  @postTitle='Rick and Morty Quotes', @postSubTitle='', @username='TestAccount2', @writingText='Nobody exists on purpose. Nobody belongs anywhere. We''re all going to die. Come watch TV.';
GO

------------------POSTS CREATED (ART) -------------------

EXEC spCreateArt @rating=0, @postTitle='Dragon', @postSubTitle='', @username='wrenjay', @artLink='dragon.png'; 
EXEC spCreateArt @rating=0, @postTitle='Demonized Angels', @postSubTitle='', @username='wrenjay', @artLink='DAngel.jpg'; 
EXEC spCreateArt @rating=1, @postTitle='Truphox', @postSubTitle='', @username='Truphox', @artLink='GP-Logo.png';  
EXEC spCreateArt @rating=0, @postTitle='Space', @postSubTitle='Inktober prompt day 17', @username='wrenjay', @artLink='Astro.jpg';
EXEC spCreateArt @rating=0, @postTitle='Million Dollar Painting', @postSubTitle='$5000 to even look at it', @username='CanadaGhost', @artLink='MillionDollarArt.png'; 
GO

------------------POSTS CREATED (VIDEO) -------------------
EXEC spCreateVideo @rating=0, @postTitle='Sample Video', @postSubtitle='Rabbit Video', @username='CanadaGhost', @videoLink='SampleVideo.mp4';

------------------POSTS CREATED (PHOTOGRAPHY) -------------------

EXEC spCreatePhotography @rating=0,  @postTitle='Debby', @postSubTitle='Crazy cat lady life', @username='wrenjay', @photoLink='Debby.jpg';
EXEC spCreatePhotography @rating=0,  @postTitle='Pumpkin #1', @postSubTitle='KCarvings', @username='wrenjay', @photoLink='pumpkinK.jpg';
EXEC spCreatePhotography @rating=0,  @postTitle='Pumpkin #2', @postSubTitle='DCarvings', @username='CanadaGhost', @photoLink='pumpkinD.jpg';
EXEC spCreatePhotography @rating=0, @postTitle='Ruka', @postSubTitle='My canine', @username='wrenjay', @photoLink='Ruka.jpg';
EXEC spCreatePhotography @rating=0,  @postTitle='Sunset', @postSubTitle='.', @username='wrenjay', @photoLink='WpgSky.jpg';
EXEC spCreatePhotography @rating=0,  @postTitle='Camping', @postSubTitle='', @username='CanadaGhost', @photoLink='Sky.jpg';
GO

------------------ COMMENTS -------------------

EXEC spCreateComment @postID=7, @commentText='Cool logo!', @username='CanadaGhost';
EXEC spCreateComment @postID=7, @commentText='We thought so!', @username='Truphox';
EXEC spCreateComment @postID=7, @commentText='Drew it myself!', @username='wrenjay';
EXEC spCreateComment @postID=7, @commentText='I like it!', @username='TestAccount1';
EXEC spCreateComment @postID=7, @commentText='Truphox da best #truphox', @username='CanadaGhost';
EXEC  spCreateComment @postID=10, @commentText='My painting of a million dollars.', @username='CanadaGhost';
GO

EXEC spCreateLike @postID=12, @username='CanadaGhost';
EXEC spCreateLike @postID=12, @username='wrenjay';
EXEC spCreateLike @postID=12, @username='TestAccount1';
EXEC spCreateLike @postID=12, @username='TestAccount2';
EXEC spCreateLike @postID=12, @username='Truphox';

SELECT * FROM tbPost
SELECT * FROM tbWriting
SELECT * FROM tbPhotography
SELECT * FROM tbArt
SELECT * FROM tbWriting
SELECT * FROM tbVideo
SELECT * FROM tbComment
GO

------------------FOLLOWING PROC -------------------

EXEC spCreateFollow @username='wrenjay', @followedUser='CanadaGhost';
EXEC spCreateFollow @username='wrenjay', @followedUser='Truphox';
EXEC spCreateFollow @username='wrenjay', @followedUser='TestAccount2';
EXEC spCreateFollow @username='CanadaGhost', @followedUser='Truphox'; 
EXEC spCreateFollow @username='TestAccount2', @followedUser='Truphox';
EXEC spCreateFollow @username='TestAccount1', @followedUser='Truphox';
SELECT * FROM tbFollowing 
GO

EXEC spCreateNotification @notificationText='This is a notification.', @username='CanadaGhost';
EXEC spCreateNotification @notificationText='Another notification.', @username='CanadaGhost';
EXEC spCreateNotification @notificationText='Someone liked your Tiny Rick post.', @username='CanadaGhost';
EXEC spReadNotification @username='CanadaGhost';
EXEC spReadNotification @username='wrenjay';

EXEC spForums @rating=1, @forumTitle='Broken', @forumText='Do you feel like your broken? But you''ve already broke. You keep trying to talk but someone already spoke....',  @username='wrenjay';
EXEC spForums @rating=0, @forumTitle='Torn', @forumText='Some days I feel like I''m living sea to sea, Like every wave comes crashing over me. What do you do when your drowning? When the waves come crashing in, I will stand my ground again...', @username='TestAccount2';
EXEC spForums @rating=1, @forumTitle='A quote', @forumText='Nothing in this world can take the place of persistence. Talent will not: nothing is more common than unsuccessful men with talent. Genius will not; unrewarded genius is almost a proverb. Education will not: the world is full of educated derelicts. Persistence and determination alone are omnipotent.', @username='wrenjay';
EXEC spForums @rating=1, @forumTitle='Winston Churchill', @forumText='Success is not final, failure is not fatal: it is the courage to continue that counts.', @username='TestAccount1';

EXEC spCreateForumResponse @forumResText='This is a response', @username='CanadaGhost', @forumID='0';
EXEC spCreateForumResponse @forumResText='Test reponse with a lot of text. This is to see how the gridview responds to having all this text in a forum response.', @username='wrenjay', @forumID='0';
EXEC spCreateForumResponse @forumResText='This is not the forum I was looking for.', @username='CanadaGhost', @forumID='0';

EXEC spReadForumResponse @forumID='0';
