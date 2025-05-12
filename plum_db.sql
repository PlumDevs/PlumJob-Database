CREATE DATABASE Plum;
USE Plum;

CREATE TABLE users (
  username VARCHAR(50) NOT NULL PRIMARY KEY,
  password VARCHAR(500) NOT NULL,
  enabled BOOLEAN NOT NULL
);

CREATE TABLE authorities (
  username VARCHAR(50) NOT NULL,
  authority VARCHAR(50) NOT NULL,
  CONSTRAINT fk_authorities_users FOREIGN KEY(username) REFERENCES users(username)
);

CREATE UNIQUE INDEX ix_auth_username ON authorities (username, authority);

CREATE TABLE UserInfo (
	username VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY(username) REFERENCES users(username),
    user_legalname VARCHAR(30) NOT NULL,
    user_lastname VARCHAR(30) NOT NULL,
    user_email VARCHAR(255), -- 320 lub 255
    account_creation_date DATE,
    is_active BOOL
);

CREATE TABLE Ads (
	ad_id INT PRIMARY KEY AUTO_INCREMENT,
    who_created VARCHAR(50),
    ad_start DATE,
    ad_end DATE,
    offer_link VARCHAR(255),
    img_libk VARCHAR(255),
    is_active BOOL
);

CREATE TABLE RecruitmentStatus (
	status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50)
);

DELIMITER $$
CREATE PROCEDURE sp_showUserHistory (userID VARCHAR(50), onlyActive BOOL)
BEGIN
	SELECT * FROM RecruitmentHistory WHERE user_id = userID and ended = onlyActive;
END $$
DELIMITER 

CREATE TABLE RecruitmentHistory (
	history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(50),
    position VARCHAR(50),
    company VARCHAR(50),
    FOREIGN KEY(user_id) REFERENCES users(username),
    user_start_date DATE,
    stage INT,
    FOREIGN KEY(stage) REFERENCES RecruitmentStatus(status_id),
    description VARCHAR(200),
    ended BOOL
);


CREATE INDEX ix_history_users ON RecruitmentHistory (user_id, user_start_date);

CREATE TABLE TagCodes (
	tag_id INT PRIMARY KEY AUTO_INCREMENT,
    tag_name VARCHAR(100)
);

CREATE TABLE TagUsers (
	tag_user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(50),
    FOREIGN KEY(user_id) REFERENCES users(username),
    tag_id INT,
    FOREIGN KEY(tag_id) REFERENCES TagCodes(tag_id)
);

CREATE INDEX ix_tag_users ON TagUsers (user_id, tag_id);

CREATE TABLE TagOffer (
	tag_offer_id INT PRIMARY KEY AUTO_INCREMENT,
    offer_id INT,
    FOREIGN KEY(offer_id) REFERENCES RecruitmentOffer(recrutation_id),
    tag_id INT,
    FOREIGN KEY(tag_id) REFERENCES TagCodes(tag_id)
);

CREATE INDEX ix_tag_offer ON TagOffer (offer_id, tag_id);

CREATE TABLE Template (
	template_id INT PRIMARY KEY AUTO_INCREMENT,
    template_name VARCHAR(100),
    template_desc VARCHAR(255),
    creation_date DATE,
    last_update DATE
);

CREATE TABLE Article (
	article_id INT PRIMARY KEY AUTO_INCREMENT,
    article_name VARCHAR(100),
	creation_date DATE,
    last_update DATE
);

CREATE TABLE ErrorLogs (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    error_code INT,
    error_date DATE
);

CREATE FUNCTION get_accepted()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE amount INT DEFAULT 0;

	SELECT COUNT(CASE WHEN RecruitmentHistory.stage = 10 THEN 1 ELSE NULL END) INTO @amount FROM RecruitmentHistory;
    
    RETURN @amount;
END//



DELIMITER ;

INSERT INTO RecruitmentStatus VALUES (1, "toApply");
INSERT INTO RecruitmentStatus VALUES (2, "applied");
INSERT INTO RecruitmentStatus VALUES (3, "onlineAssesment");
INSERT INTO RecruitmentStatus VALUES (4, "afterOA");
INSERT INTO RecruitmentStatus VALUES (5, "interviewScheduled");
INSERT INTO RecruitmentStatus VALUES (6, "afterInterview");
INSERT INTO RecruitmentStatus VALUES (7, "jobOffer");
INSERT INTO RecruitmentStatus VALUES (8, "rejected");
INSERT INTO RecruitmentStatus VALUES (9, "ghosted");
INSERT INTO RecruitmentStatus VALUES (10, "accepted");

-- INSERT INTO users VALUES("testo", "1234", 1);
-- INSERT INTO users VALUES("testo2", "333", 2);
-- INSERT INTO RecruitmentOffer VALUES(1, "testo", "mrowkidb", "naczelna mrowka", '2025-04-01', '2025-04-27', "nie", "link1.com", 0);
-- INSERT INTO RecruitmentOffer VALUES(2, "testo", "mrowkidb", "pod mrowka", '2025-05-01', '2025-05-07', "nie", "link2.com", 1);
-- INSERT INTO RecruitmentOffer VALUES(3, "testo2", "mrowkojadydb", "pomoc domowa", '2025-05-02',  '2025-08-01', "ma pomagac", "link3.com", 1);

-- INSERT INTO RecruitmentHistory VALUES(1, "testo", 1, '2025-04-01', 10, 1);
-- INSERT INTO RecruitmentHistory VALUES(2, "testo", 2, '2025-05-03', 5, 0);
-- INSERT INTO RecruitmentHistory VALUES(3, "testo2", 3, '2025-05-09', 3, 0);
-- INSERT INTO RecruitmentHistory VALUES(4, "testo2", 2, '2025-05-09', 1, 0);
-- INSERT INTO RecruitmentHistory VALUES(5, "testo2", 3, '2025-06-01', 10, 1);
-- INSERT INTO RecruitmentHistory VALUES(6, "testo", 3, '2025-06-01', 10, 1);

-- SELECT * FROM RecruitmentHistory;

-- CALL sp_showUserHistory("testo", 2);

-- SELECT get_accepted()
