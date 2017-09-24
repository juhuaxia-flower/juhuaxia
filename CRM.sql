drop database if exists crm;

create database crm charset=utf8;

use crm;
#�ͻ���
#��ɫ��(��̨)

create table role(
	id int primary key auto_increment,
	name varchar(20) not null
);
insert into role values
	(1,'�ܼ�'),
	(2,'��������'),
	(3,'���۾���');

#Ա����¼��(��̨)
create table emp(
	id int primary key auto_increment,
	login varchar(20) not null,
	password varchar(20) not null,
	name varchar(20) not null,
	tel varchar(20) not null,
	role_id int not null default 0,
	foreign key (role_id) references role(id)
);
insert into emp(login,password,name,tel,role_id) values
	('1','1','������','18688888888',1),
	('user','user','������','18455555555',2),
	('admin','admin','����','13012121212',3),
	('2','2','ʯ�ο�','18788454545',3);

#�ͻ���
create table cus(
	id int primary key auto_increment,
	login varchar(20) not null,
	password varchar(20) not null,
	emp_id int,
	foreign key (emp_id) references emp(id)
);


insert into cus values
	(1,'1','1',null),
	(2,'admin','admin',null);
#�˿���Ϣ��
create table cusInfo(
	id int primary key auto_increment,
	name varchar(20) not null,
	tel varchar(20) not null,
	age int,
	sex varchar(20),
	address varchar(20),
	cus_id int not null,
	foreign key (cus_id) references cus(id)
);

insert into cusInfo values
	(1,'�²�','18608202249',18,'��','�ϳ�',1),
	(2,'��ǿ','18508201242',21,'��','�ɶ�',2);

#ҵ���
	create table bus(
	id int primary key auto_increment,
	name varchar(20) not null
);

insert into bus values
	(1,'����'),
	(2,'��Ʊ'),
	(3,'��ծ'),
	(4,'������'),
	(5,'��ŮͶ��');

#�ͻ�_ҵ���
create table cusBus(
	cus_id int not null,
	bus_id int not null,
	ifConf int default 0,
	ifPay int default 0,
	primary key(cus_id,bus_id),
	foreign key (cus_id) references cus(id),
	foreign key (bus_id) references bus(id)
);

insert into cusBus values
	(1,1,0,0),
	(1,4,1,0),
	(2,2,1,0),
	(2,3,1,0);
#��̨


#���ܱ�
create table func(
	id int primary key auto_increment,
	title varchar(20) not null,
	path varchar(30) not null,
	pid int
);

insert into func values
	(1,'������Ϣ����','/info',0),
	(2,'������Ϣ','/info/update',1),
	(3,'�޸�����','/info/update',1),
	(4,'�ͻ�����','/cus',0),
	(5,'�����ͻ��б�','/cus/allList',4),
	(6,'�ӹ���������','/cus/in',4),
	(7,'������������','/cus/out',4),
	(8,'�ͻ��б�','/cus/lists',4),
	(9,'�ɹ��ͻ��б�','/cus/didList',4),
	(10,'����������¼','/cus/pickList',4),
	(11,'��������','/keepUp',0),
	(12,'�������ͻ�','/keepUp/ing',10),
	(13,'�ͻ�������¼','/keepUp/record',10),
	(14,'���ۿͻ���Ա������','/cusManage',0),
	(15,'���Ա��','/cusManage/add',14),
	(16,'ɾ��Ա��','/cusManage/del',14),
	(17,'�鿴Ա��','/cusManage/lists',14),
	(18,'����˿�','/cusManage/assign',14),
	(19,'���ۿͻ�ͳ��','/count',0),
	(20,'ͳ������ʱ��ɽ��˿���','/count/deal',19),
	(21,'ÿ�����۵�����ɹ���','/count/success',19),
	(22,'���ܹ���','/empManage',0),
	(23,'��������','/empManage/up',22),
	(24,'��������','/empManage/down',22);

#��ɫ���ܱ�
create table roleFunc(
	role_id int,
	func_id int,
	primary key (role_id,func_id),
	foreign key (role_id) references role(id),
	foreign key (func_id) references func(id)
);

insert into roleFunc values
	(3,1),
	(3,2),
	(3,3),
	(3,4),
	(3,5),
	(3,6),
	(3,7),
	(3,8),
	(3,9),
	(3,10),
	(2,1),
	(2,2),
	(2,3),
	(2,14),
	(2,15),
	(2,16),
	(2,17),
	(2,18),
	(2,19),
	(2,20),
	(2,21),
	(1,1),
	(1,2),
	(1,3),
	(1,19),
	(1,20),
	(1,21),
	(1,22),
	(1,23),
	(1,24);
	
	

#����������¼��

create table pick(
	id int primary key auto_increment,
	pickIn varchar(30),
	pickOut varchar(30),
	cus_id int,
	emp_id int,
	foreign key (cus_id) references cus(id),
	foreign key (emp_id) references emp(id)
);

#������¼��
create table keepUp(
	id int primary key auto_increment,
	confTime varchar(30),
	payTime varchar(30),
	cus_id int,
	bus_id int,
	emp_id int,
	foreign key (cus_id) references cus(id),
	foreign key (bus_id) references bus(id),
	foreign key (emp_id) references emp(id)
);

select path from emp join role on emp.role_id=role.id join roleFunc on role.id=roleFunc.role_id join func on roleFunc.func_id=func.id WHERE emp.id=3;
select pick.id,pickIn,pickOut,pick.cus_id,cusInfo.name as cname from cus JOIN cusInfo on cus.id=cusInfo.cus_id join pick on pick.cus_id=cus.id where pick.emp_id=3;
select cus.id,name,address,tel,sex,age,emp_id from cus join cusInfo on cus.id=cusInfo.cus_id where emp_id is null ;