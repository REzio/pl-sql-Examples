
CREATE TABLE DEPT (
 DEPTNO              NUMBER(2) NOT NULL,
 DNAME               CHAR(14),
 LOC                 CHAR(13),
 CONSTRAINT DEPT_PRIMARY_KEY PRIMARY KEY (DEPTNO));

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');

INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');

INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');

INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');



CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               CHAR(10),
 JOB                 CHAR(9),
 MGR                 NUMBER(4) CONSTRAINT EMP_SELF_KEY REFERENCES EMP (EMPNO),
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) NOT NULL,
 CONSTRAINT EMP_FOREIGN_KEY FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO),
 CONSTRAINT EMP_PRIMARY_KEY PRIMARY KEY (EMPNO));



INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'17-NOV-1981',5000,NULL,10);

INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'1-MAY-1981',2850,NULL,30);

INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'9-JUN-1981',2450,NULL,10);

INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'2-APR-1981',2975,NULL,20);

INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'28-SEP-1981',1250,1400,30);

INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'20-FEB-1981',1600,300,30);

INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'8-SEP-1981',1500,0,30);

INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'3-DEC-1981',950,NULL,30);

INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'22-FEB-1981',1250,500,30);

INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'3-DEC-1981',3000,NULL,20);

INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'17-DEC-1980',800,NULL,20);

INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'09-DEC-1982',3000,NULL,20);

INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'12-JAN-1983',1100,NULL,20);

INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'23-JAN-1982',1300,NULL,10);



CREATE TABLE BONUS (
 ENAME               CHAR(10),
 JOB                 CHAR(9),
 SAL                 NUMBER,
 COMM                NUMBER);


CREATE TABLE SALGRADE (
 GRADE               NUMBER,
 LOSAL               NUMBER,
 HISAL               NUMBER);



INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

commit;



begin
    
	dbms_output.put_line('Hello World');

end;

declare
    
v_no1 number(2) := 45;
    
v_no2 number(2) default 30;
    
v_sum number(3);


begin
    
v_sum := v_no1 + v_no2;
    
dbms_output.put_line('Sum = ' || v_sum);

end;




declare

    v_empNo emp.empno%type := 7788;


    type emp_record is record (

        ename emp.ename%type,

        job emp.job%type,

        sal emp.sal%type

    );

    v_er emp_record;


begin

    select ename,job, sal into v_er
 
    from emp
    where empno = v_empno;

    dbms_output.put_line('Name = ' || v_er.ename || ' Job = ' || v_er.job || ' Sal = ' || v_er.sal);

end;







declare

    v_dept_row dept%rowtype;


begin

    select * into v_dept_row
 
    from dept

    where deptno = 20;

    dbms_output.put_line('Name = ' || v_dept_row.dname || ' DNo = ' || v_dept_row.deptno || ' Location = ' || v_dept_row.loc);

end;







declare

    v_empno emp.empno%type := 7566;

    v_job emp.job%type;

begin

    select job into v_job

    from emp

    where empno = v_empno;

    dbms_output.put_line('Job ' || v_job);

    if v_job = 'MANAGER' then

        update emp set sal = sal + 100

        where empno =v_empno;

    else

        update emp set sal = sal + 200

        where empno =v_empno;

    end if;

    dbms_output.put_line('Salary Updated');

end;

declare

    v_ename emp.ename%type;

    v_job emp.job%type;

    v_sal emp.sal%type;

    
v_empno emp.empno%type := 7782;

    v_grade salgrade.grade%type;

begin

    select ename,job,sal into v_ename,v_job,v_sal

    from emp

    where empno = v_empno;


    
select grade into v_grade

    from salgrade

    where v_sal between losal and hisal;

    

    if v_grade = 1 then

        insert into bonus values (v_ename,v_job,v_sal,300);

    elsif v_grade = 2 then

        insert into bonus values (v_ename,v_job,v_sal,200);

    else

        insert into bonus values (v_ename,v_job,v_sal,100);

    end if;

end;

select * from bonus;

