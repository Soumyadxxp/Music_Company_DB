create table ARTIST
(
    Artist_ID varchar(6) primary key check(Artist_ID like 'Ar%'),
    Ar_Name varchar(20) not null,
    Ar_Sex varchar(10) not null,
    Ar_DOB date not null,
    Ar_Age number(3) not null
);

create table ALBUM
(
    Album_ID varchar(6) primary key check(Album_ID like 'A%'),
    --Album_Name varchar(20) not null,
    Genre varchar(20) not null,
    R_Date date,
    NO_Downloads number(6) not null,
    NO_Sales number(6) not null
);

create table COMPOSER
(
    Composer_ID varchar(6) primary key check(Composer_ID like 'C%'),
    C_Name varchar(20) not null,
    C_Sex varchar(10) not null,
    C_DOB date not null,
    C_Age number(3) not null
);

create table LYRICIST
(
    Lyricist_ID varchar(6) primary key check(Lyricist_ID like 'L%'),
    L_Name varchar(20) not null,
    L_Sex varchar(10) not null,
    L_DOB date not null,
    L_Age number(3) not null
);

create table PRODUCER
(
    P_ID varchar(6) primary key check(P_ID like 'P%'),
    P_Name varchar(20) not null,
    P_Sex varchar(10) not null,
    P_DOB date not null,
    P_Age number(3) not null
);

create table SONG
(
    S_ID varchar(6) primary key check(S_ID like 'S%'),
    S_Name varchar(30) not null,
    Artist_ID varchar(6) not null,
    Album_ID varchar(6) not null,
    Composer_ID varchar(6) not null,
    Lyricist_ID varchar(6) not null,
    P_ID varchar(6) not null,
    S_Sales number(6) not null,
    foreign key(Artist_ID) references ARTIST(Artist_ID) on delete cascade,
    foreign key(Composer_ID) references COMPOSER(Composer_ID) on delete cascade,
    foreign key(Lyricist_ID) references LYRICIST(Lyricist_ID) on delete cascade,
    foreign key(P_ID) references PRODUCER(P_ID) on delete cascade,
    foreign key(Album_ID) references ALBUM(Album_ID) on delete cascade
);

insert into ARTIST
values("Ar001","Akriti Kakkar","Female","33","07-08-1986");

insert into ARTIST
values("Ar002","Arijit Singh","Male","33","25-04-1987");

insert into ARTIST
values("Ar003","Kumar Sanu","Male","62","20-10-1957");

insert into ARTIST
values("Ar004","Atif Aslam","Male","37","12-03-1983");

insert into ARTIST
values("Ar005","Sonu Nigam","Male","46","30-07-1973");

insert into ALBUM
values("A0001","Romantic","24-11-2011","1000","250");

insert into ALBUM
values("A0002","Comedy","12-06-2009","1150","175");

insert into ALBUM
values("A0003","Horror","14-09-2004","1340","500");

insert into ALBUM
values("A0004","Tragic","07-11-2001","600","325");

insert into ALBUM
values("A0005","Drama","09-01-2015","800","600");

insert into ALBUM
values("A0006","Patriotic","03-08-2010","300","400");

insert into COMPOSER
values("C001","Bagchi","Male","13-06-1997","23");

insert into COMPOSER
values("C002","Rahman","Male","12-10-1989","30");

insert into COMPOSER
values("C003","Clerk","Male","14-12-1997","24");

insert into LYRICIST
values("L0001","Javed Akhtar","Male","14-06-1978","42");

insert into LYRICIST
values("L0002","Begum Akhtar","Female","04-11-1964","56");

insert into LYRICIST
values("L0003","Jenny Rodriques","Non-Binary","01-12-1993","26");

insert into LYRICIST
values("L0004","Milind Soman","Queer","12-05-1981","39");

insert into PRODUCER
values("P001","Eros","N/A","12-09-1959","60");

insert into PRODUCER
values("P002","Ratan Shah","Male","12-03-1966","54");

insert into PRODUCER
values("P003","T-Music","N/A","12-05-1975","45");

insert into PRODUCER
values("P004","Vijaylakshmi","Female","13-08-1981","38");

insert into PRODUCER
values("P005","Surtal","N/A","14-04-1940","80");

insert into SONG
values("S001","Abhi Abhi","Ar001","A0001","C001","L0001","P001","250");

insert into SONG
values("S002","Baarish","Ar002","A0002","C002","L0004","P003","175");

insert into SONG
values("S003","Dheere Dheere","Ar003","A0003","C001","L0001","P002","500");

insert into SONG
values("S004","Bas Ek Sanam","Ar003","A0003","C001","L0001","P001","250");

insert into SONG
values("S005","Tu Jaane Na","Ar004","A0004","C003","L0002","P005","325");

insert into SONG
values("S006","Suraj","Ar005","A0006","C003","L0003","P004","400");

insert into SONG
values("S007","Main Agar","Ar005","A0006","C003","L0004","P004","400");

insert into SONG
values("S008","Saathiya","Ar001","A0001","C002","L0004","P001","250");

insert into SONG
values("S009","Dil Diyaan","Ar004","A0005","C002","L0003","P004","600");

insert into SONG
values("S010","Mast Magan","Ar002","A0002","C002","L0002","P003","175");

/*Query 1*/
select * from ARTIST
where Artist_ID in (
select Artist_ID from SONG
group by Artist_ID
having count(*)>1
);

/*Query 2*/
select * from SONG
where S_Sales = (
    select max(S_Sales) from SONG
);

/*Query 3*/
select * from ALBUM
where NO_Downloads > 1000;

/*Query 4*/
select * from ALBUM
natural join SONG
natural join ARTIST
where Song.Artist_ID = "Ar003" and Song.Album_ID = "A0001";

/*Query 5*/
select * from COMPOSER
where Composer_ID in (
    select COMPOSER.Composer_ID from COMPOSER
    natural join SONG
    natural join ALBUM
    where C_DOB > 31-12-1980 and NO_Downloads > 500
);

/*Query 6*/
select * from PRODUCER
where P_Sex = "Male" and P_ID in (
    select P_ID from SONG
    where S_Sales > 450
);

/*Query 7*/
select * from SONG
where Album_ID in (
    select Album_ID from ALBUM
    where Genre = "Patriotic"
);

/*Query 8*/
delete from SONG
where Artist_ID = "Ar005";

update SONG
set Artist_ID = "Ar004";

/*Query 9*/
select distinct(C_Name) from SONG
natural join COMPOSER
where C_Age < 25
group by COMPOSER.Composer_ID;

/*Query 10*/
select * from SONG
where P_ID = "P001" and Artist_ID = "Ar001";

/*Query 11*/
select * from SONG
where Artist_ID = "Ar004" and Album_ID in (
    select Album_ID from ALBUM
    where R_Date > 31-12-2005
);

/*Query 12*/
select sum(NO_Downloads) from ALBUM;