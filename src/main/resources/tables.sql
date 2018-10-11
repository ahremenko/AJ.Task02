CREATE SCHEMA `team6` ;

use team6;


drop table role;

create table role
( `id` int not null AUTO_INCREMENT 
, `name` varchar(255) not null
, `isAdmin` boolean not null default false
, primary key (`id`)
, unique key (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1001;

insert into role (`name`, `isAdmin`) values ('Administrator', true);

insert into role (`name`) values ('Developer');

insert into role (`name`) values ('Manager');


drop table user;

create table user
( `id` int not null AUTO_INCREMENT
, `email` varchar(100) not null
, `password` varchar(255) not null
, name varchar(255) not null
, surname varchar(255)
, isBlocked boolean not null default false
, primary key (`id`)
, unique key (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=101;

insert into user (`email`, `name`, `surname`, `password`) values ('admin@sj.com','Администратор','','111111'); 


drop table userRoles;

create table userRoles
( `idUser` int not null 
, `idRole` int not null
, unique key (`idUser`,`idRole`)
);

alter table userRoles add constraint userRolesFK_userId foreign key (idUser) references `user`(id) on delete cascade on update cascade;

alter table userRoles add constraint userRolesFK_roleId foreign key (idRole) references `role`(id) on delete cascade on update cascade;

insert into userRoles (`idUser`, `idRole`) values ((select `id` from user where email = 'admin@sj.com'), (select `id` from role where isAdmin = true));


drop table candidateState;

create table candidateState
( `id` int not null AUTO_INCREMENT
, `name` varchar(255) not null
, primary key (`id`)
, unique key (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11;

insert into candidateState (`name`) values ('Активен');

insert into candidateState (`name`) values ('В архиве');


drop table suitableState;

create table suitableState
( `id` int not null AUTO_INCREMENT
, `name` varchar(255) not null
, primary key (`id`)
, unique key (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21;

insert into suitableState (`name`) values ('Подходит');

insert into suitableState (`name`) values ('Не подходит');


drop table feedbackState;

create table feedbackState
( `id` int not null AUTO_INCREMENT
, `name` varchar(255) not null
, primary key (`id`)
, unique key (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=31;

insert into feedbackState (`name`) values ('Принять');

insert into feedbackState (`name`) values ('Отказать');


drop table contactType;

create table contactType
( `id` int not null AUTO_INCREMENT
, `name` varchar(255) not null
, primary key (`id`)
, unique key (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=41;

insert into contactType (`name`) values ('моб.телефон');

insert into contactType (`name`) values ('адрес');

insert into contactType (`name`) values ('e-mail');

insert into contactType (`name`) values ('skype');


drop table skill;

create table skill
( `id` int not null AUTO_INCREMENT
, `name` varchar(255) not null
, primary key (`id`)
, unique key (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=51;

insert into skill (`name`) values ('Java');

insert into skill (`name`) values ('JS');

insert into skill (`name`) values ('RDB');

insert into skill (`name`) values ('.Net');

insert into skill (`name`) values ('C++');



drop table candidate;

create table candidate
( `id` int not null AUTO_INCREMENT
, `email` varchar(100) not null
, `name` varchar(255) not null
, `surname` varchar(255)
, `birthday` date
, `photoFilePath` varchar(1000)
, `salary` decimal(10,2) check(`salary`>=0)
, `idCandidateState` int
, primary key (`id`)
, unique key (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=201;

alter table candidate add constraint candidateFK_state foreign key (idCandidateState) references `candidateState`(id) on delete cascade on update cascade;

insert into candidate (`email`, `name`, `surname`, `birthday`, `salary`, `idCandidateState`) values ('poupkine@sj.com','Пупкин','Вася','1995-12-27', 650, (select `id` from candidateState where `name`='Активен')); 

insert into candidate (`email`, `name`, `surname`, `birthday`, `salary`, `idCandidateState`) values ('zaytsev@sj.com','Зайцев','Стёпа','1997-02-20', 450.55, (select `id` from candidateState where `name`='Активен')); 


drop table contactDetails;

create table contactDetails
( `idCandidate` int not null
, `idContactType` int not null
, `contactDetails` varchar(1000)
, index `contactDetails_I01` (`idCandidate`)
, index `contactDetails_I02` (`idContactType`)
);

alter table contactDetails add constraint contactDetailsFK_candidate foreign key (idCandidate) references `candidate`(id) on delete cascade on update cascade;

alter table contactDetails add constraint contactDetailsFK_contacttype foreign key (idContactType) references `contactType`(id) on delete cascade on update cascade;


insert into contactDetails (`idCandidate`, `idContactType`, `contactDetails`)
values (
  (select `id` from candidate where email = 'poupkine@sj.com')
, (select `id` from contactType where name = 'моб.телефон') 
, '+375 29 123 45 78'
);

insert into contactDetails (`idCandidate`, `idContactType`, `contactDetails`)
values (
  (select `id` from candidate where email = 'zaytsev@sj.com')
, (select `id` from contactType where name = 'моб.телефон') 
, '+375 44 999 88 11'
);


drop table candidateExperience;

create table candidateExperience
( `idCandidate` int not null
, `dateFrom` date not null
, `dateTo` date not null
, `jobDescription` varchar(4000)
, `jobPosition` varchar(1000)
, `companyName` varchar(1000)
, index `contactDetails_I01` (`idCandidate`)
, index `contactDetails_I02` (`dateFrom`)
);

alter table candidateExperience add constraint candidateExperienceFK_candidate foreign key (idCandidate) references `candidate`(id) on delete cascade on update cascade;


drop table attachment;

create table attachment
( `idCandidate` int not null
, `filePath` varchar(1000)
, `type` int not null check(`type` in (1,2))
);

alter table attachment add constraint attachmentFK_candidate foreign key (idCandidate) references `candidate`(id) on delete cascade on update cascade;

create table candidateCompetence
( `idCandidate` int not null
, `idSkill` int not null
, unique key (`idCandidate`,`idSkill`)
);

alter table candidateCompetence add constraint candidateCompetenceFK_candidate foreign key (idCandidate) references `candidate`(id) on delete cascade on update cascade;

alter table candidateCompetence add constraint candidateCompetenceFK_skill foreign key (idSkill) references `skill`(id) on delete cascade on update cascade;

drop table vacancy;

create table vacancy
( `id` int not null AUTO_INCREMENT
, `position` varchar(1000)
, `idDeveloper` int not null
, `salaryFrom` decimal(10,2) check(`salaryFrom`>=0)
, `salaryTo` decimal(10,2) check(`salaryTo`>=0)
, `isActive` boolean not null default true
, primary key (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2001;

alter table vacancy add constraint vacancyFK_developer foreign key (idDeveloper) references `user`(id) on delete cascade on update cascade;

drop table vacancyRequirement;

create table vacancyRequirement
( `idVacancy` int not null
, `idSkill` int not null
, unique key (`idVacancy`,`idSkill`)
);

alter table vacancyRequirement add constraint vacancyRequirementFK_vacancy foreign key (idVacancy) references `vacancy`(id) on delete cascade on update cascade;

alter table vacancyRequirement add constraint vacancyRequirementFK_skill foreign key (idSkill) references `skill`(id) on delete cascade on update cascade;

drop table vacancyCandidates;

create table vacancyCandidates 
( `idVacancy` int not null
, `idCandidate` int not null
, `idSuitableState` int
, reason varchar(1000)
, unique key (`idVacancy`,`idCandidate`)
);

alter table vacancyCandidates add constraint vacancyCandidatesFK_vacancy foreign key (idVacancy) references `vacancy`(id) on delete cascade on update cascade;

alter table vacancyCandidates add constraint vacancyCandidatesFK_candidate foreign key (idCandidate) references `candidate`(id) on delete cascade on update cascade;

alter table vacancyCandidates add constraint vacancyCandidatesFK_state foreign key (idSuitableState) references `suitableState`(id) on delete cascade on update cascade;



create table interview
( `id` int not null AUTO_INCREMENT
, `idVacancy` int not null
, `planDate` datetime not null
, `idCandidate` int not null
, `factDate` datetime
, unique key (`idVacancy`,`idCandidate`,`planDate`)
, primary key (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3001;

alter table interview add constraint interviewFK_vacancy foreign key (idVacancy) references `vacancy`(id) on delete cascade on update cascade;

alter table interview add constraint interviewFK_candidate foreign key (idCandidate) references `candidate`(id) on delete cascade on update cascade;


create table interviewFeedback
( `idInterview` int not null 
, `idInterviewer` int not null
, `idFeedbackState` int not null
, `reason` varchar(4000)
, unique key (`idInterview`,`idInterviewer`)
);

alter table interviewFeedback add constraint interviewFeedbackFK_interview foreign key (idInterview) references `interview`(id) on delete cascade on update cascade;

alter table interviewFeedback add constraint interviewFeedbackFK_interviewer foreign key (idInterviewer) references `user`(id) on delete cascade on update cascade;

alter table interviewFeedback add constraint interviewFeedbackFK_state foreign key (idFeedbackState) references `feedbackState`(id) on delete cascade on update cascade;

commit;

