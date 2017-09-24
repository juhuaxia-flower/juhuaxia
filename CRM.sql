drop database if exists crm;

create database crm charset=utf8;

use crm;
#客户端
#角色表(后台)

create table role(
	id int primary key auto_increment,
	name varchar(20) not null
);
insert into role values
	(1,'总监'),
	(2,'销售主管'),
	(3,'销售经理');

#员工登录表(后台)
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
	('1','1','蒲丽奇','18688888888',1),
	('user','user','李正洁','18455555555',2),
	('admin','admin','周腾','13012121212',3),
	('2','2','石梦奎','18788454545',3);

#客户表
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
#顾客信息表
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
	(1,'陈灿','18608202249',18,'男','南充',1),
	(2,'何强','18508201242',21,'男','成都',2);

#业务表
	create table bus(
	id int primary key auto_increment,
	name varchar(20) not null
);

insert into bus values
	(1,'基金'),
	(2,'股票'),
	(3,'国债'),
	(4,'高利贷'),
	(5,'美女投资');

#客户_业务表
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
#后台


#功能表
create table func(
	id int primary key auto_increment,
	title varchar(20) not null,
	path varchar(30) not null,
	pid int
);

insert into func values
	(1,'个人信息管理','/info',0),
	(2,'更新信息','/info/update',1),
	(3,'修改密码','/info/update',1),
	(4,'客户管理','/cus',0),
	(5,'公共客户列表','/cus/allList',4),
	(6,'从公共池挑入','/cus/in',4),
	(7,'挑出到公共池','/cus/out',4),
	(8,'客户列表','/cus/lists',4),
	(9,'成功客户列表','/cus/didList',4),
	(10,'挑入挑出记录','/cus/pickList',4),
	(11,'跟进管理','/keepUp',0),
	(12,'待跟进客户','/keepUp/ing',10),
	(13,'客户跟进记录','/keepUp/record',10),
	(14,'销售客户与员工管理','/cusManage',0),
	(15,'添加员工','/cusManage/add',14),
	(16,'删除员工','/cusManage/del',14),
	(17,'查看员工','/cusManage/lists',14),
	(18,'分配顾客','/cusManage/assign',14),
	(19,'销售客户统计','/count',0),
	(20,'统计任意时间成交顾客量','/count/deal',19),
	(21,'每个销售的挑入成功率','/count/success',19),
	(22,'主管管理','/empManage',0),
	(23,'升级主管','/empManage/up',22),
	(24,'降级主管','/empManage/down',22);

#角色功能表
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
	
	

#挑入挑出记录表

create table pick(
	id int primary key auto_increment,
	pickIn varchar(30),
	pickOut varchar(30),
	cus_id int,
	emp_id int,
	foreign key (cus_id) references cus(id),
	foreign key (emp_id) references emp(id)
);

#跟进记录表
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