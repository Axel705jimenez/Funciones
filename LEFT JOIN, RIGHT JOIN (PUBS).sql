use pubs;

-----------------------LEFT JOIN-------------------------

--1.- Consulta de todos los autores y los t�tulos de los libros que han escrito, incluyendo aquellos autores que no han escrito ning�n libro
SELECT a.au_id, a.au_fname, a.au_lname, t.title
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id;

--2.- Obtener una lista de autores y los t�tulos de los libros que han escrito, incluso si no han escrito ning�n libro, ordenados por el apellido del autor:
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY authors.au_lname, authors.au_fname;

--3.- Obtener una lista de los t�tulos de los libros y sus respectivos editores, incluso si algunos libros no tienen editor asignado:
SELECT t.title, p.pub_name
FROM titles t
LEFT JOIN publishers p ON t.pub_id = p.pub_id;

--4.- Obtener una lista de los empleados de ventas y los t�tulos de los libros que han vendido, incluso si algunos empleados no han vendido ning�n libro:
SELECT e.emp_id, e.fname, e.lname, t.title
FROM employee e
LEFT JOIN sales s ON e.emp_id = s.stor_id
LEFT JOIN titles  t ON s.title_id = t.title_id;

--5.-Obtener una lista de los autores de los libros y los titulos a las que pertenecen, incluso si algunos libros no est�n categorizados:
SELECT t.title, a.au_fname
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
LEFT JOIN authors a ON ta.au_id = a.au_id;

 --6.- Obtener una lista de autores y contar cu�ntos libros han escrito, ordenados por la cantidad de libros en orden descendente:
SELECT a.au_id, a.au_lname, a.au_fname, COUNT(ta.title_id) AS num_books
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY num_books DESC;

--7.- Obtener una lista de editores y contar cu�ntos t�tulos de libros han publicado, solo para aquellos con m�s de 10 t�tulos publicados:
SELECT p.pub_id, p.pub_name, COUNT(t.title_id) AS num_titles
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
GROUP BY p.pub_id, p.pub_name
HAVING COUNT(t.title_id) > 10
ORDER BY num_titles DESC;

--8.- Obtener una lista de empleados y sus ventas totales, solo para aquellos cuyas ventas totales superen los $10,000, ordenados por ventas en orden descendente:
SELECT e.emp_id, e.fname, e.lname, SUM(s.qty * t.price) AS total_sales
FROM employee e
LEFT JOIN sales s ON e.emp_id = s.stor_id
LEFT JOIN titles t ON s.title_id = t.title_id
GROUP BY e.emp_id, e.fname, e.lname
HAVING SUM(s.qty * t.price) > 10000
ORDER BY total_sales DESC;

--9.- Obtener una lista de los empleados y la suma total de sus ventas, solo para aquellos que han realizado ventas, ordenados por la suma de ventas en orden descendente:
SELECT e.emp_id, e.fname, e.lname, COALESCE(SUM(s.qty * t.price), 0) AS total_sales
FROM employee e
LEFT JOIN sales s ON e.emp_id = s.title_id
LEFT JOIN titles t ON s.title_id = t.title_id
GROUP BY e.emp_id, e.fname, e.lname
HAVING COALESCE(SUM(s.qty * t.price), 0) > 0
ORDER BY total_sales DESC;

--10.- Obtener una lista de autores y el promedio de precios de sus libros, solo para aquellos autores que han escrito al menos 2 libros, ordenados por el precio promedio en orden descendente:
SELECT a.au_id, a.au_lname, a.au_fname, AVG(t.price) AS avg_price
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
HAVING COUNT(ta.title_id) >= 2
ORDER BY avg_price DESC;

--11.- Obtener una lista de t�tulos de libros y sus respectivos autores, ordenados alfab�ticamente por el apellido del autor:
SELECT t.title, a.au_lname, a.au_fname
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
LEFT JOIN authors a ON ta.au_id = a.au_id
ORDER BY a.au_lname, a.au_fname;

--12.- Obtener una lista de los empleados de ventas y sus ventas totales, solo para aquellos con ventas totales superiores a $5,000, ordenados por ventas en orden descendente:
SELECT e.emp_id, e.fname, e.lname, COALESCE(SUM(s.qty * t.price), 0) AS total_sales
FROM employee e
LEFT JOIN sales s ON e.emp_id = s.stor_id
LEFT JOIN titles t ON s.title_id = t.title_id
GROUP BY e.emp_id, e.fname, e.lname
HAVING COALESCE(SUM(s.qty * t.price), 0) > 10
ORDER BY total_sales DESC;

--13.-Listar todas las editoriales y sus libros (incluso si no tienen libros):
SELECT p.pub_name, t.title
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id;

--14.- Mostrar todos los autores y los t�tulos que han escrito (incluso si no han escrito ning�n t�tulo):
SELECT a.au_fname, a.au_lname, t.title
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id;

--15.- Mostrar todas las tiendas y las ventas que han realizado (incluso si no han realizado ventas):
SELECT s.stor_name, s.city, s.state, COUNT(sa.ord_num) AS num_sales
FROM stores s
LEFT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_name, s.city, s.state;

--16.- Mostrar todas las editoriales y el n�mero total de libros que han publicado, ordenado por el n�mero de libros en orden descendente:
SELECT p.pub_name, COUNT(t.title_id) AS num_titles
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
GROUP BY p.pub_name
ORDER BY num_titles DESC;

--17.- Mostrar todos los autores y sus respectivos libros, incluso si no tienen libros publicados:
SELECT a.au_fname, a.au_lname, t.title
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id;

--18.- Mostrar todas las tiendas y sus ventas, incluso si no han realizado ninguna venta:
SELECT s.stor_name, COUNT(sa.ord_num) AS num_sales
FROM stores s
LEFT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_name;

--19.- Mostrar todos los editores y la cantidad total de ventas de libros de sus t�tulos, incluso si no han tenido ventas:
SELECT p.pub_name, COALESCE(SUM(s.qty), 0) AS total_sales
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
LEFT JOIN sales s ON t.title_id = s.title_id
GROUP BY p.pub_name;

--20.- Mostrar todos los autores y la cantidad total de libros vendidos de sus obras, incluso si no se han vendido libros de un autor en particular:
SELECT a.au_fname, a.au_lname, COALESCE(SUM(sd.qty), 0) AS total_books_sold
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN sales sd ON ta.title_id = sd.title_id
GROUP BY a.au_fname, a.au_lname;

--21.- Mostrar todos los autores y la cantidad total de copias vendidas de sus libros en una tienda espec�fica, incluso si no se han vendido copias de los libros de un autor en esa tienda:

SELECT a.au_fname, a.au_lname, COALESCE(SUM(sd.qty), 0) AS total_copies_sold
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN sales sd ON ta.title_id = sd.title_id
LEFT JOIN sales sa ON sd.ord_num = sa.ord_num
LEFT JOIN stores s ON sa.stor_id = s.stor_id
WHERE s.stor_name = 'Store Name'  -- Reemplaza 'Store Name' por el nombre de la tienda deseada
GROUP BY a.au_fname, a.au_lname;

--22.- Mostrar todos los t�tulos de libros que tienen en inventario, incluso si no tienen ning�n t�tulo en inventario:
SELECT s.stor_name, t.title
FROM stores s
LEFT JOIN titles t ON t.title_id = t.title_id;

--23.- Mostrar todas las editoriales y los t�tulos de libros que han publicado, ordenados alfab�ticamente por el nombre de la editorial:
SELECT p.pub_name, t.title
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
ORDER BY p.pub_name;

--24.- Mostrar todos los t�tulos de libros y sus respectivos autores, ordenados alfab�ticamente por el nombre del autor:
SELECT t.title, CONCAT(a.au_fname, ' ', a.au_lname) AS author_name
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
LEFT JOIN authors a ON ta.au_id = a.au_id
ORDER BY author_name;

--25.- Mostrar todos los autores y la cantidad total de copias de sus libros vendidas, incluso si algunos autores no tienen ventas registradas:
SELECT a.au_fname, a.au_lname, COALESCE(SUM(sa.qty), 0) AS total_copies_sold
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
LEFT JOIN sales sa ON t.title_id = sa.title_id
GROUP BY a.au_fname, a.au_lname;

--26.- Mostrar todos los t�tulos de libros y sus respectivas editoriales, incluyendo los t�tulos que no tienen una editorial asignada:
SELECT t.title, COALESCE(p.pub_name, 'Sin editorial') AS publisher_name
FROM titles t
LEFT JOIN publishers p ON t.pub_id = p.pub_id;

--27.- Mostrar todas las tiendas y la fecha de la �ltima venta realizada en cada una, incluso si algunas tiendas no han realizado ventas:
SELECT s.stor_name, MAX(sa.ord_date) AS last_sale_date
FROM stores s
LEFT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_name;

--28.- Mostrar todos los t�tulos de libros y sus respectivos autores, incluyendo los t�tulos sin autor asociado:
SELECT t.title, COALESCE(CONCAT(a.au_fname, ' ', a.au_lname), 'Sin autor') AS author_name
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
LEFT JOIN authors a ON ta.au_id = a.au_id;

--29.-Listar todas las tiendas y sus respectivas ventas, mostrando 0 para las tiendas sin ventas registradas:
SELECT s.stor_name, COALESCE(SUM(sales.qty), 0) AS total_sales
FROM stores s
LEFT JOIN sales ON s.stor_id = sales.stor_id
GROUP BY s.stor_name;

--30.- Mostrar los autores que no han publicado libros
SELECT a.au_fname, a.au_lname
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
WHERE t.title IS NULL;


--31.- Mostrar todas las tiendas y sus respectivos gerentes, incluso si algunas tiendas no tienen gerentes asignados:
SELECT s.stor_name, COALESCE(CONCAT(m.au_fname, ' ', m.au_lname), 'Sin gerente') AS manager
FROM stores s
LEFT JOIN authors m ON s.stor_id = m.au_id;

--32 Mostrar todos los autores y sus libros, mostrando autores que no tienen libros publicados:}
SELECT a.au_fname, a.au_lname, COALESCE(t.title, 'Sin libro publicado') AS libro_publicado
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id;

--33.- Mostrar todos los t�tulos de libros junto con los nombres de las editoriales a las que pertenecen, incluyendo t�tulos sin editoriales asignadas:
SELECT t.title, COALESCE(p.pub_name, 'Sin editorial asignada') AS editorial
FROM titles t
LEFT JOIN publishers p ON t.pub_id = p.pub_id;

--34.- Mostrar libros sin editorial asignada
SELECT t.title
FROM titles t
LEFT JOIN publishers p ON t.pub_id = p.pub_id
WHERE p.pub_name IS NULL;

--35.- Mostrar ventas totales menores de 10
SELECT s.stor_name, COALESCE(SUM(sales.qty), 0) AS ventas_totales
FROM stores s
LEFT JOIN sales ON s.stor_id = sales.stor_id
GROUP BY s.stor_name
HAVING COALESCE(SUM(sales.qty), 0) < 10;

--36.- Mostrar todos los autores junto con la cantidad de libros que han escrito, incluyendo autores sin libros publicados:
SELECT a.au_fname, a.au_lname, COALESCE(COUNT(ta.title_id), 0) AS num_libros_escritos
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_fname, a.au_lname;

--37.- Mostrar autores que no han escirot libros
SELECT a.au_fname, a.au_lname, COALESCE(COUNT(ta.title_id), 0) AS num_libros_escritos
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_fname, a.au_lname
HAVING COALESCE(COUNT(ta.title_id), 0) = 0;

--38.- Mostrar todas las ciudades en las que se encuentran las tiendas ("stores") junto con la cantidad total de ventas realizadas en cada ciudad, mostrando solo las ciudades con ventas totales superiores a $1000:
SELECT s.city, COALESCE(SUM(sales.qty * titles.price), 0) AS ventas_totales
FROM stores s
LEFT JOIN sales ON s.stor_id = sales.stor_id
LEFT JOIN titles ON sales.title_id = titles.title_id
GROUP BY s.city
HAVING COALESCE(SUM(sales.qty * titles.price), 0) > 1000;

--39.- Mostrar el t�tulo de cada libro junto con el nombre de su autor (si tiene uno asignado) y ordenarlos alfab�ticamente por t�tulo:
SELECT t.title, COALESCE(CONCAT(a.au_fname, ' ', a.au_lname), 'Sin autor asignado') AS autor
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
LEFT JOIN authors a ON ta.au_id = a.au_id
ORDER BY t.title;

--40.-Mostrar los nombres de todos los editores ("publishers") junto con la cantidad total de libros que han publicado, ordenados por la cantidad de libros de forma descendente:
SELECT p.pub_name, COALESCE(COUNT(t.title_id), 0) AS num_libros_publicados
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
GROUP BY p.pub_name
ORDER BY num_libros_publicados DESC;

--41.- Mostrar el nombre de cada tienda ("stores") junto con el n�mero total de ventas realizadas, incluyendo las tiendas que no tienen ventas:
SELECT s.stor_name, COALESCE(COUNT(sales.title_id), 0) AS total_ventas
FROM stores s
LEFT JOIN sales ON s.stor_id = sales.stor_id
GROUP BY s.stor_name;

--42.- Mostrar los nombres de los editores ("publishers") que no han publicado ning�n libro
SELECT p.pub_name
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
WHERE t.title_id IS NULL;

--43.- Enumerar los t�tulos de libros ("titles") que no han tenido ventas
SELECT t.title
FROM titles t
LEFT JOIN sales s ON t.title_id = s.title_id
WHERE s.title_id IS NULL;

--44.- Listar los t�tulos de libros ("titles") junto con la cantidad total de ventas para cada uno de ellos, ordenados de mayor a menor cantidad de ventas:
SELECT t.title, COALESCE(SUM(s.qty), 0) AS total_ventas
FROM titles t
LEFT JOIN sales s ON t.title_id = s.title_id
GROUP BY t.title
ORDER BY total_ventas DESC;

--45.- Enumerar los t�tulos de libros ("titles") que no han sido escritos por ning�n autor
SELECT t.title
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
WHERE ta.title_id IS NULL;

--46.- Mostrar el nombre de cada tienda ("stores") y la cantidad total de ventas realizadas en cada una de ellas, excluyendo las tiendas que no tienen ventas:
SELECT s.stor_name, COALESCE(SUM(sa.qty), 0) AS total_ventas
FROM stores s
LEFT JOIN sales sa ON s.stor_id = s.stor_id
GROUP BY s.stor_name
HAVING COALESCE(SUM(sa.qty), 0) > 0;

--47.- Mostrar el nombre de cada autor ("authors") y la cantidad total de libros que han escrito, pero solo si han escrito m�s de 1 libro
SELECT a.au_fname, a.au_lname, COALESCE(COUNT(ta.title_id), 0) AS total_libros_escritos
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_fname, a.au_lname
HAVING COALESCE(COUNT(ta.title_id), 0) > 1;

--48.- Obtener el nombre de cada autor ("authors") y la cantidad total de regal�as ganadas por sus libros, excluyendo a los autores que no tienen regal�as:
SELECT a.au_fname, a.au_lname, COALESCE(SUM(t.royalty), 0) AS regalias_totales
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
GROUP BY a.au_fname, a.au_lname
HAVING COALESCE(SUM(t.royalty), 0) > 0;

--49.-Obtener el nombre de cada autor ("authors") que no ha escrito un libro despu�s del a�o 2000:
SELECT a.au_fname, a.au_lname
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
WHERE YEAR(t.pubdate) <= 2000 OR t.pubdate IS NULL;

--50.- Obtener el nombre de cada autor ("authors") que no ha escrito ning�n libro despu�s del a�o 2005
SELECT a.au_fname, a.au_lname
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
WHERE YEAR(t.pubdate) <= 2005 OR t.pubdate IS NULL;

------------------------RIGHT JOIN----------------------------
