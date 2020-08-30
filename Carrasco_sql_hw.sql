--1. SQL Queries

select "EmployeeId", "LastName", "Email"
from "Employee" 
where "LastName" = 'King'; 
 /* I specified the rows I wanted from the Employee table and then
  * used to the where keyword to set the conditions of the last name to be King
  */
select "City", "State"
from "Employee"
where "FirstName" = 'Andrew' and "ReportsTo" is null;
/*I specified the columns I wanted from the emloyee table 
 * and used the where keyword to specify the first name to be Andrew and the reportso column be set to null
 */
select * from "Album" where "AlbumId" in 
(select "AlbumId" from "Track" where "Composer" = 'AC/DC');
/*I used a nested query to select all the 
 * all records from the Album table where the composer is AC/DC.
 */
select * 
from "Album" 
order by "Title" desc;
/*I selected all the columns from the Album table
 *and ordered them by title in descending order
 */
select "FirstName"
from "Customer"
order by "City" asc;
/*I selected the first name column from the customer table and then
 * oredered them by city in ascedning order
 */
select *
from "Invoice" 
where "BillingAddress" 
like 'T%';
/*I selected all the columns from the invoice table
 * and used the where statement to pick specify that 
 * the billingaddress name start with the letter T
 */
select * 
from "Invoice" 
where "Total" 
between 15 and 50;
/*I selected all the columns from the invoice table
 * and then used the where keyword to specify that total 
 * between 15 and 50
 */
select *
from "Employee" 
where "HireDate"
between '2003-06-01' and '2004-03-01';
/*I selected all the columns from Employee table 
 * and then specified that the hiredate be between the dates 
 * 2003-06-01 and 2004-03-01
 */
--2. DML Statements

insert into "Genre"("GenreId","Name" )
values (26, 'How soon is now?');
/*I inserted a row into the genre table that had specified
 * values for the GenreId column and name column
 */
insert into "Genre"("GenreId", "Name" )
values (27, 'There is a light that never goes out');
/*I inserted a row into the genre table that had specified
 * values for the GenreId column and name column
 */
insert into "Employee"
values (9, 'Carrasco','Ricardo','Pega Systems Architect');
/*I inserted a row into the employee column
 * and then input values into it columns without specifying them 
 * in the employee table 
 */
insert into "Employee"
values (10, 'Li', 'Diana','Accountant');
/*I inserted a row into the employee table
 * and then input values into it columns without specifying them 
 * in the employee table 
 */

insert into "Customer" ("CustomerId", "FirstName", "LastName", "Company","Address","City",
"State","Country","PostalCode","Email" ,"SupportRepId")
values (60, 'Sebastion','Damazo','Wells Fargo', '123 A','Goleta',
'CA','USA','93117','sebass@yahoo.com','4');
/*I inserted a row into the customer table and then
 * specified the columns I would be inputting values into 
 */
insert into "Customer" ("CustomerId", "FirstName", "LastName", "Company","Address","City",
"State","Country","PostalCode","Email" ,"SupportRepId")
values (61, 'Ricky','Carr','Revature', 'Boolin','Goleta',
'CA','USA','93117','rc@yahoo.com','5');
/*I inserted a row into the customer table and then
 * specified the columns I would be inputting values into 
 */

update "Customer" 
set "FirstName" = 'Robert',"LastName" = 'Walker'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';
/* I updated the customer column and the changed the name
 * Aaron Mitchell to Robert Walker
 */
update "Artist"
set "Name" = 'CCR'
where "Name" = 'Creedence Clearwater Revival';
/*I updated the Artist column 
 * and the changed the Name of the artist to CCR
 */
alter table "Invoice" 
drop constraint "FK_InvoiceCustomerId";

delete from "Customer" 
where "FirstName" = 'Robert' and "LastName" = 'Walker';
/*I dropped the Foreign Key constraint from the invoice column
 * so that I could delete the Robert Walker row
 */

--3. SQL Functions

select *
from CURRENT_TIMESTAMP;
--used a select stament to return the current time

select length("Name")
from "MediaType";
--used a length function on the name column of the mediatype table

select avg("Total") 
from "Invoice";
--used a average function on the total column of the invoice table

select max("UnitPrice")
from "Track";
--I selected the max price from the track table

select avg("UnitPrice")
from "InvoiceLine";
--I used the average funtion on unit price on the invoiceline table

select *
from "Employee" 
where "BirthDate">'1968-12-31';
/*I selected all the columns from the employee table
*where the birthdate was after the year 1968
*/
--4. Triggers
create or replace function emp_insert()
return trigger as $$
begin 
	if (TG_OP = "Insert") then 
	new."Phone"= '867-5309'
	end if; 
	return new;
end;
$$ language plpgsql;

create trigger employee_insert1()
after insert on "Employee"
for each row 
execute function emp_insert();
/*I created the emp_insert function so that it will set the value of phone
 * to specifed value and the used the function to create a trigger where it 
 * will be excecuted after I insert a row in the employee table
 */

create or replace function custy_insert()
return trigger as $$
begin 
	if (TG_OP = 'Insert') then 
	new."Company" = 'Revature';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger customer_insert100
before insert on "Customer"
for each row 
execute function custy_insert();
/*I created the custy_insert function so that it will set the value of the company 
 *column to a specifed value and thes used the function to create a trigger where it 
 * will be excecuted before I insert a row in the employee table
 */

--5. JOINs
select * 
from "Customer" c2 inner join "Invoice" i2 
on c2."CustomerId" = i2."CustomerId";
/*I used an inner join on the customer table 
 * and invoice table and joined them using the Customerid column
 */
select c."FirstName" ,c."LastName" , i."InvoiceId", i."Total" 
from "Customer" c left outer join "Invoice" i 
on c."CustomerId" = i."CustomerId" ;
/*I used a left outer join on the customer table 
 * and invoice table and joined them using the Customerid column 
 * and then selected the first and last name from the customer table
 * and also selected the invoiceid and total column from the invoice table
 */
select a."Name" , a2."Title" 
from "Artist" a right join "Album" a2 
on a."ArtistId"  = a2."ArtistId";
/*I used a right join on the atist table and album table
 * and joined them the artistId foreign key 
 */
select *
from "Artist" a cross join "Album" a3
order by a."Name" asc;
/*I used a cross join on the Artist and album
 *table and then ordered them by name column in ascending orders 
 */
select *
from "Employee" e join "Employee" e2 
on e."ReportsTo" = e2."ReportsTo";
/*I joined both employee albums and linked them 
 * using the ReportsTO column 
 */
--6. Set Operations 

select c."LastName", c."FirstName", c."Phone" 
from "Customer" c
union
select e."LastName", e."FirstName", e."Phone"
from "Employee" e;
/*I unified the customer table and employee table 
 * and I also selected the Lastname column, firstname column, and phone colum
 * from both tables
 */
select "City", "State", "PostalCode"
from "Employee"
EXCEPT ALL
select "City", "State", "PostalCode"
from "Customer" ;
/*I selected the city column, state column, and postalcode column 
 * from the employee table that were not in the customer table
 */
