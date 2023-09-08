use pubs;

-----------------------LEFT JOIN-------------------------

--1.- Consulta de todos los autores y los títulos de los libros que han escrito, incluyendo aquellos autores que no han escrito ningún libro
SELECT a.au_id, a.au_fname, a.au_lname, t.title
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id;

--2.- Obtener una lista de autores y los títulos de los libros que han escrito, incluso si no han escrito ningún libro, ordenados por el apellido del autor:
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY authors.au_lname, authors.au_fname;

--3.- Obtener una lista de los títulos de los libros y sus respectivos editores, incluso si algunos libros no tienen editor asignado:
SELECT t.title, p.pub_name
FROM titles t
LEFT JOIN publishers p ON t.pub_id = p.pub_id;

--4.- Obtener una lista de los empleados de ventas y los títulos de los libros que han vendido, incluso si algunos empleados no han vendido ningún libro:
SELECT e.emp_id, e.fname, e.lname, t.title
FROM employee e
LEFT JOIN sales s ON e.emp_id = s.stor_id
LEFT JOIN titles  t ON s.title_id = t.title_id;

--5.-Obtener una lista de los autores de los libros y los titulos a las que pertenecen, incluso si algunos libros no están categorizados:
SELECT t.title, a.au_fname
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
LEFT JOIN authors a ON ta.au_id = a.au_id;

 --6.- Obtener una lista de autores y contar cuántos libros han escrito, ordenados por la cantidad de libros en orden descendente:
SELECT a.au_id, a.au_lname, a.au_fname, COUNT(ta.title_id) AS num_books
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY num_books DESC;

--7.- Obtener una lista de editores y contar cuántos títulos de libros han publicado, solo para aquellos con más de 10 títulos publicados:
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

--11.- Obtener una lista de títulos de libros y sus respectivos autores, ordenados alfabéticamente por el apellido del autor:
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

--14.- Mostrar todos los autores y los títulos que han escrito (incluso si no han escrito ningún título):
SELECT a.au_fname, a.au_lname, t.title
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id;

--15.- Mostrar todas las tiendas y las ventas que han realizado (incluso si no han realizado ventas):
SELECT s.stor_name, s.city, s.state, COUNT(sa.ord_num) AS num_sales
FROM stores s
LEFT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_name, s.city, s.state;

--16.- Mostrar todas las editoriales y el número total de libros que han publicado, ordenado por el número de libros en orden descendente:
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

--19.- Mostrar todos los editores y la cantidad total de ventas de libros de sus títulos, incluso si no han tenido ventas:
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

--21.- Mostrar todos los autores y la cantidad total de copias vendidas de sus libros en una tienda específica, incluso si no se han vendido copias de los libros de un autor en esa tienda:

SELECT a.au_fname, a.au_lname, COALESCE(SUM(sd.qty), 0) AS total_copies_sold
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN sales sd ON ta.title_id = sd.title_id
LEFT JOIN sales sa ON sd.ord_num = sa.ord_num
LEFT JOIN stores s ON sa.stor_id = s.stor_id
WHERE s.stor_name = 'Store Name'  -- Reemplaza 'Store Name' por el nombre de la tienda deseada
GROUP BY a.au_fname, a.au_lname;

--22.- Mostrar todos los títulos de libros que tienen en inventario, incluso si no tienen ningún título en inventario:
SELECT s.stor_name, t.title
FROM stores s
LEFT JOIN titles t ON t.title_id = t.title_id;

--23.- Mostrar todas las editoriales y los títulos de libros que han publicado, ordenados alfabéticamente por el nombre de la editorial:
SELECT p.pub_name, t.title
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
ORDER BY p.pub_name;

--24.- Mostrar todos los títulos de libros y sus respectivos autores, ordenados alfabéticamente por el nombre del autor:
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

--26.- Mostrar todos los títulos de libros y sus respectivas editoriales, incluyendo los títulos que no tienen una editorial asignada:
SELECT t.title, COALESCE(p.pub_name, 'Sin editorial') AS publisher_name
FROM titles t
LEFT JOIN publishers p ON t.pub_id = p.pub_id;

--27.- Mostrar todas las tiendas y la fecha de la última venta realizada en cada una, incluso si algunas tiendas no han realizado ventas:
SELECT s.stor_name, MAX(sa.ord_date) AS last_sale_date
FROM stores s
LEFT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_name;

--28.- Mostrar todos los títulos de libros y sus respectivos autores, incluyendo los títulos sin autor asociado:
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

--33.- Mostrar todos los títulos de libros junto con los nombres de las editoriales a las que pertenecen, incluyendo títulos sin editoriales asignadas:
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

--39.- Mostrar el título de cada libro junto con el nombre de su autor (si tiene uno asignado) y ordenarlos alfabéticamente por título:
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

--41.- Mostrar el nombre de cada tienda ("stores") junto con el número total de ventas realizadas, incluyendo las tiendas que no tienen ventas:
SELECT s.stor_name, COALESCE(COUNT(sales.title_id), 0) AS total_ventas
FROM stores s
LEFT JOIN sales ON s.stor_id = sales.stor_id
GROUP BY s.stor_name;

--42.- Mostrar los nombres de los editores ("publishers") que no han publicado ningún libro
SELECT p.pub_name
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
WHERE t.title_id IS NULL;

--43.- Enumerar los títulos de libros ("titles") que no han tenido ventas
SELECT t.title
FROM titles t
LEFT JOIN sales s ON t.title_id = s.title_id
WHERE s.title_id IS NULL;

--44.- Listar los títulos de libros ("titles") junto con la cantidad total de ventas para cada uno de ellos, ordenados de mayor a menor cantidad de ventas:
SELECT t.title, COALESCE(SUM(s.qty), 0) AS total_ventas
FROM titles t
LEFT JOIN sales s ON t.title_id = s.title_id
GROUP BY t.title
ORDER BY total_ventas DESC;

--45.- Enumerar los títulos de libros ("titles") que no han sido escritos por ningún autor
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

--47.- Mostrar el nombre de cada autor ("authors") y la cantidad total de libros que han escrito, pero solo si han escrito más de 1 libro
SELECT a.au_fname, a.au_lname, COALESCE(COUNT(ta.title_id), 0) AS total_libros_escritos
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_fname, a.au_lname
HAVING COALESCE(COUNT(ta.title_id), 0) > 1;

--48.- Obtener el nombre de cada autor ("authors") y la cantidad total de regalías ganadas por sus libros, excluyendo a los autores que no tienen regalías:
SELECT a.au_fname, a.au_lname, COALESCE(SUM(t.royalty), 0) AS regalias_totales
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
GROUP BY a.au_fname, a.au_lname
HAVING COALESCE(SUM(t.royalty), 0) > 0;

--49.-Obtener el nombre de cada autor ("authors") que no ha escrito un libro después del año 2000:
SELECT a.au_fname, a.au_lname
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
WHERE YEAR(t.pubdate) <= 2000 OR t.pubdate IS NULL;

--50.- Obtener el nombre de cada autor ("authors") que no ha escrito ningún libro después del año 2005
SELECT a.au_fname, a.au_lname
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
WHERE YEAR(t.pubdate) <= 2005 OR t.pubdate IS NULL;

------------------------RIGHT JOIN----------------------------

--51.- Obtener todos los autores y los libros que han escrito (incluidos los autores que no han escrito libros):
SELECT a.au_fname, a.au_lname, t.title
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
RIGHT JOIN titles t ON ta.title_id = t.title_id;

--52.- Obtener todas las editoriales y los libros que han publicado (incluidas las editoriales sin libros publicados):
SELECT p.pub_name, t.title
FROM publishers p
RIGHT JOIN titles t ON p.pub_id = t.pub_id;

--53.- Obtener todas las tiendas y las ventas realizadas en esas tiendas (incluidas las tiendas sin ventas):
SELECT s.stor_name, sales.ord_num
FROM stores s
RIGHT JOIN sales ON s.stor_id = sales.stor_id;

--54.- Obtener todos los empleados y sus trabajos (incluidos los empleados sin trabajos asignados):
SELECT e.fname, e.lname, j.job_desc
FROM employee e
RIGHT JOIN jobs j ON e.job_id = j.job_id;


--56.- Obtener todos los libros y sus regalías (incluidos los libros sin esquemas de regalías definidos):
SELECT t.title, r.royalty
FROM titles t
RIGHT JOIN roysched r ON t.title_id = r.title_id;

--57.- Obtener todas las ventas y las tiendas correspondientes (incluidas las ventas sin tiendas asociadas):
SELECT sales.ord_num, s.stor_name
FROM sales
RIGHT JOIN stores s ON sales.stor_id = s.stor_id;

--58.- Obtener todos los autores y sus libros (incluidos los autores sin libros):
SELECT a.au_fname, a.au_lname, t.title
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
RIGHT JOIN titles t ON ta.title_id = t.title_id;

--59.- Obtener todas las editoriales y los libros que han publicado (incluidas las editoriales sin libros publicados):
SELECT p.pub_name, t.title
FROM publishers p
RIGHT JOIN titles t ON p.pub_id = t.pub_id;

--60.- Obtener todas las ventas y las fechas correspondientes (incluidas las ventas sin fechas):
SELECT s.ord_num, s.ord_date
FROM sales s
RIGHT JOIN stores st ON s.stor_id = st.stor_id;

--61.- Obtener todos los trabajos y los empleados asignados a esos trabajos (incluidos los trabajos sin empleados asignados):
SELECT j.job_desc, e.fname, e.lname
FROM jobs j
RIGHT JOIN employee e ON j.job_id = e.job_id;

--62.- Obtener todos los registros de la tabla "jobs" junto con los empleados asignados a esos trabajos (incluidos los trabajos sin empleados asignados):
SELECT j.job_id, j.job_desc, e.fname, e.lname
FROM jobs j
RIGHT JOIN employee e ON j.job_id = e.job_id;

--63.- Obtener todos los registros de la tabla "sales" junto con las tiendas correspondientes (incluidas las ventas sin tiendas asociadas):
SELECT s.ord_num, s.stor_id, s.ord_date, st.stor_name
FROM sales s
RIGHT JOIN stores st ON s.stor_id = st.stor_id;

--64.- Obtener todos los registros de la tabla "titles" junto con las editoriales correspondientes (incluidas las editoriales sin libros publicados):
SELECT t.title_id, t.title, t.pub_id, p.pub_name
FROM titles t
RIGHT JOIN publishers p ON t.pub_id = p.pub_id;

--65.- Consulta 11: Obtener todos los registros de la tabla "jobs" junto con los empleados asignados a esos trabajos (incluidos los trabajos sin empleados asignados):
SELECT j.job_id, j.job_desc, e.fname, e.lname
FROM jobs j
RIGHT JOIN employee e ON j.job_id = e.job_id;

--66.-Obtener todos los registros de la tabla "sales" junto con las tiendas correspondientes (incluidas las ventas sin tiendas asociadas):
SELECT s.ord_num, s.stor_id, s.ord_date, st.stor_name
FROM sales s
RIGHT JOIN stores st ON s.stor_id = st.stor_id;

--67.- Obtener todos los registros de la tabla "titles" junto con las editoriales correspondientes (incluidas las editoriales sin libros publicados):
SELECT t.title_id, t.title, t.pub_id, p.pub_name
FROM titles t
RIGHT JOIN publishers p ON t.pub_id = p.pub_id;

--68.- Obtener todos los registros de la tabla "stores" junto con las ventas correspondientes (excluyendo las tiendas sin ventas) y mostrar solo las tiendas con ventas:
SELECT st.stor_id, st.stor_name, s.ord_num, s.ord_date, s.qty, s.payterms
FROM stores st
RIGHT JOIN sales s ON st.stor_id = s.stor_id
WHERE s.ord_num IS NOT NULL;

--69.- Obtener todos los registros de la tabla "titleauthor" junto con los autores correspondientes (excluyendo las combinaciones sin autores) y mostrar solo las combinaciones con autores:
SELECT ta.au_id, ta.title_id, a.au_fname, a.au_lname
FROM titleauthor ta
RIGHT JOIN authors a ON ta.au_id = a.au_id
WHERE a.au_fname IS NOT NULL;

--70.- Obtener todos los registros de la tabla "jobs" junto con los empleados asignados a esos trabajos (excluyendo los trabajos sin empleados asignados) y mostrar "Ningún trabajo" para los empleados sin trabajo asignado:
SELECT j.job_id, j.job_desc, e.fname, e.lname
FROM jobs j
RIGHT JOIN employee e ON j.job_id = e.job_id
WHERE j.job_desc IS NOT NULL;

--71.- Obtener todos los registros de la tabla "publishers" junto con los libros publicados por esas editoriales (excluyendo las editoriales sin libros) y mostrar solo las editoriales con libros publicados:
SELECT p.pub_id, p.pub_name, t.title
FROM publishers p
RIGHT JOIN titles t ON p.pub_id = t.pub_id
WHERE t.title IS NOT NULL;

--72.- Obtener todos los registros de la tabla "authors" junto con los libros escritos por esos autores (excluyendo los autores sin libros escritos) y mostrar solo los autores con libros escritos:
SELECT a.au_id, a.au_fname, a.au_lname, t.title
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
RIGHT JOIN titles t ON ta.title_id = t.title_id
WHERE t.title IS NOT NULL;

--73.- Consulta 19: Obtener todos los registros de la tabla "stores" junto con las ventas correspondientes (excluyendo las tiendas sin ventas) y mostrar solo las tiendas con ventas:
SELECT st.stor_id, st.stor_name, s.ord_num, s.ord_date, s.qty, s.payterms
FROM stores st
RIGHT JOIN sales s ON st.stor_id = s.stor_id
WHERE s.ord_num IS NOT NULL;

--73.- Obtener todos los registros de la tabla "titleauthor" junto con los autores correspondientes (excluyendo las combinaciones sin autores) y mostrar solo las combinaciones con autores:
SELECT ta.au_id, ta.title_id, a.au_fname, a.au_lname
FROM titleauthor ta
RIGHT JOIN authors a ON ta.au_id = a.au_id
WHERE a.au_fname IS NOT NULL;

--74.- Obtener todos los registros de la tabla "jobs" junto con los empleados asignados a esos trabajos (excluyendo los trabajos sin empleados asignados) y mostrar "Ningún trabajo" para los empleados sin trabajo asignado:
SELECT j.job_id, j.job_desc, e.fname, e.lname
FROM jobs j
RIGHT JOIN employee e ON j.job_id = e.job_id
WHERE j.job_desc IS NOT NULL;

--75.- Obtener todos los registros de la tabla "publishers" junto con los libros publicados por esas editoriales (excluyendo las editoriales sin libros) y mostrar solo las editoriales con libros publicados:
SELECT p.pub_id, p.pub_name, t.title
FROM publishers p
RIGHT JOIN titles t ON p.pub_id = t.pub_id
WHERE t.title IS NOT NULL;

--76.- Obtener todos los registros de la tabla "authors" junto con los libros escritos por esos autores (excluyendo los autores sin libros escritos) y mostrar solo los autores con libros escritos:
SELECT a.au_id, a.au_fname, a.au_lname, t.title
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
RIGHT JOIN titles t ON ta.title_id = t.title_id
WHERE t.title IS NOT NULL;

--77.- Consulta 29: Obtener todos los registros de la tabla "sales" junto con la información de las tiendas correspondientes (incluyendo las ventas sin tiendas) y mostrar "Sin tienda asignada" para las ventas sin tiendas asignadas:
SELECT s.stor_id, st.stor_name, s.ord_num, s.ord_date, s.qty, s.payterms
FROM stores st
RIGHT JOIN sales s ON st.stor_id = s.stor_id;

--78.- Obtener todos los registros de la tabla "titleauthor" junto con los libros correspondientes (incluyendo las combinaciones sin libros) y mostrar "Sin libro asignado" para las combinaciones sin libros asignados:

SELECT ta.au_id, ta.title_id, ta.au_ord, COALESCE(t.title, 'Sin libro asignado') AS title
FROM titleauthor ta
RIGHT JOIN titles t ON ta.title_id = t.title_id;

--79.- Obtener todos los registros de la tabla "jobs" junto con los empleados asignados a esos trabajos (incluyendo los trabajos sin empleados asignados) y mostrar "Ningún empleado" para los trabajos sin empleados asignados:
SELECT j.job_id, j.job_desc, e.fname, e.lname
FROM jobs j
RIGHT JOIN employee e ON j.job_id = e.job_id;

--80.- Obtener todos los registros de la tabla "titles" junto con las editoriales correspondientes (incluyendo los libros sin editoriales) y mostrar "Sin editorial asignada" para los libros sin editoriales asignadas:
SELECT t.title_id, t.title, COALESCE(p.pub_name, 'Sin editorial asignada') AS pub_name
FROM titles t
RIGHT JOIN publishers p ON t.pub_id = p.pub_id;

--81.- Obtener todos los registros de la tabla "authors" junto con las combinaciones autor-libro correspondientes (incluyendo las combinaciones sin autores o libros) y mostrar "Sin autor asignado" o "Sin libro asignado" según corresponda:
SELECT a.au_id, COALESCE(a.au_fname, 'Sin autor asignado') AS au_fname, COALESCE(a.au_lname, 'Sin autor asignado') AS au_lname, COALESCE(t.title, 'Sin libro asignado') AS title
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
RIGHT JOIN titles t ON ta.title_id = t.title_id;

--82.- Obtener todos los registros de la tabla "stores" junto con las ventas correspondientes (incluyendo las tiendas sin ventas) y mostrar "0" para las tiendas sin ventas:
SELECT s.stor_id, s.stor_name, COALESCE(SUM(sa.qty), 0) AS total_qty
FROM stores s
RIGHT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_id, s.stor_name;

--83.- Obtener todos los registros de la tabla "authors" junto con las editoriales correspondientes (incluyendo los autores sin editoriales) y mostrar "Sin editorial asignada" para los autores sin editoriales asignadas:
SELECT a.au_id, a.au_fname, a.au_lname, COALESCE(p.pub_name, 'Sin editorial asignada') AS pub_name
FROM authors a
RIGHT JOIN publishers p ON a.city = p.city;

--84.- Obtener todos los registros de la tabla "jobs" junto con los empleados asignados a esos trabajos (incluyendo los trabajos sin empleados asignados) y mostrar "Sin empleado asignado" para los trabajos sin empleados asignados:
SELECT j.job_id, j.job_desc, COALESCE(e.fname, 'Sin empleado asignado') AS fname, COALESCE(e.lname, 'Sin empleado asignado') AS lname
FROM jobs j
RIGHT JOIN employee e ON j.job_id = e.job_id;

--85.- Obtener todos los registros de la tabla "stores" junto con las ventas correspondientes (incluyendo las tiendas sin ventas) y mostrar "Sin ventas" para las tiendas sin ventas:
SELECT s.stor_id, s.stor_name, COALESCE(SUM(sa.qty), 'Sin ventas') AS total_qty
FROM stores s
RIGHT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_id, s.stor_name;

--86.- Obtener todos los registros de la tabla "titles" junto con las editoriales correspondientes (incluyendo los libros sin editoriales) y mostrar "Sin editorial asignada" para los libros sin editoriales asignadas:
SELECT t.title_id, t.title, COALESCE(p.pub_name, 'Sin editorial asignada') AS pub_name
FROM titles t
RIGHT JOIN publishers p ON t.pub_id = p.pub_id;

--87.- Consulta 39: Obtener la cantidad total de ventas realizadas por cada tienda y mostrar solo las tiendas con ventas totales superiores a 100:
SELECT s.stor_id, s.stor_name, COALESCE(SUM(sa.qty), 0) AS total_qty
FROM stores s
RIGHT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_id, s.stor_name
HAVING COALESCE(SUM(sa.qty), 0) > 100
ORDER BY total_qty DESC;

--88.- Obtener la lista de empleados y sus trabajos asignados (incluyendo los empleados sin trabajos asignados) y mostrar solo los empleados que tienen trabajos asignados ordenados por el apellido:
SELECT e.emp_id, e.fname, e.lname, COALESCE(j.job_desc, 'Sin trabajo asignado') AS job_desc
FROM employee e
RIGHT JOIN jobs j ON e.job_id = j.job_id
ORDER BY e.lname;

--89.- Obtener la lista de autores y la cantidad de libros que han escrito (incluyendo los autores que no han escrito ningún libro) y mostrar solo los autores que han escrito al menos 2 libros:
SELECT a.au_id, a.au_fname, a.au_lname, COALESCE(COUNT(ta.title_id), 0) AS num_libros_escritos
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_fname, a.au_lname
HAVING COALESCE(COUNT(ta.title_id), 0) >= 2;

--90.- Obtener la lista de autores y la cantidad total de ventas de sus libros (incluyendo los autores sin ventas) y mostrar solo los autores con al menos una venta:
SELECT a.au_id, a.au_fname, a.au_lname, COALESCE(SUM(s.qty), 0) AS total_sales
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
RIGHT JOIN sales s ON ta.title_id = s.title_id
GROUP BY a.au_id, a.au_fname, a.au_lname
HAVING COALESCE(SUM(s.qty), 0) > 0;

--91.- Consulta 44: Obtener la lista de tiendas y la cantidad total de ventas realizadas en cada tienda (incluyendo las tiendas sin ventas) y mostrar solo las tiendas con al menos una venta, ordenadas por la cantidad total de ventas en orden ascendente:
SELECT s.stor_id, s.stor_name, COALESCE(SUM(sa.qty), 0) AS total_qty
FROM stores s
RIGHT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_id, s.stor_name
HAVING COALESCE(SUM(sa.qty), 0) > 0
ORDER BY total_qty ASC;

--92.- Obtener la lista de autores y la cantidad de libros que han escrito (incluyendo los autores que no han escrito ningún libro) y mostrar solo los autores que no han escrito ningún libro:
SELECT a.au_id, a.au_fname, a.au_lname
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_fname, a.au_lname
HAVING COALESCE(COUNT(ta.title_id), 0) = 0;

--93.- Obtener la lista de editores y la cantidad total de ventas de los libros publicados por cada editor (incluyendo los editores sin ventas) y mostrar solo los editores con ventas totales superiores a 100:
SELECT p.pub_id, p.pub_name, COALESCE(SUM(s.qty), 0) AS total_sales
FROM publishers p
RIGHT JOIN titles t ON p.pub_id = t.pub_id
RIGHT JOIN sales s ON t.title_id = s.title_id
GROUP BY p.pub_id, p.pub_name
HAVING COALESCE(SUM(s.qty), 0) > 100;

--94.- Obtener la lista de autores y la cantidad total de copias vendidas de todos sus libros (incluyendo los autores sin ventas) y mostrar solo los autores con ventas totales superiores a 1000 copias:
SELECT a.au_id, a.au_fname, a.au_lname, COALESCE(SUM(s.qty), 0) AS total_copies_sold
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
RIGHT JOIN sales s ON ta.title_id = s.title_id
GROUP BY a.au_id, a.au_fname, a.au_lname
HAVING COALESCE(SUM(s.qty), 0) > 1000;

--95.- Obtener la lista de tiendas y la cantidad total de ventas realizadas en cada tienda (incluyendo las tiendas sin ventas) y mostrar todas las tiendas, ordenadas alfabéticamente por nombre de tienda:
SELECT s.stor_id, s.stor_name, COALESCE(SUM(sa.qty), 0) AS total_qty
FROM stores s
RIGHT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_id, s.stor_name
ORDER BY s.stor_name;

--96.- Obtener la lista de autores y la cantidad de libros que han escrito (incluyendo los autores que no han escrito ningún libro) y mostrar todos los autores, ordenados alfabéticamente por apellido:
SELECT a.au_id, a.au_fname, a.au_lname, COALESCE(COUNT(ta.title_id), 0) AS num_libros_escritos
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_fname, a.au_lname
ORDER BY a.au_lname;

--97.-Obtener la lista de autores y la cantidad total de títulos de libros escritos por cada autor (incluyendo los autores sin libros escritos) y mostrar solo los autores que han escrito al menos 3 libros, ordenados por la cantidad de títulos escritos en orden descendente:
SELECT a.au_id, a.au_fname, a.au_lname, COALESCE(COUNT(ta.title_id), 0) AS num_titles_written
FROM authors a
RIGHT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_fname, a.au_lname
HAVING COALESCE(COUNT(ta.title_id), 0) >= 3
ORDER BY num_titles_written DESC;

--98.- Obtener la lista de títulos de libros y la cantidad total de copias vendidas de cada título (incluyendo los libros sin ventas) y mostrar solo los títulos con más de 100 copias vendidas, ordenados por la cantidad de copias vendidas en orden descendente:
SELECT t.title, COALESCE(SUM(s.qty), 0) AS total_copies_sold
FROM titles t
RIGHT JOIN sales s ON t.title_id = s.title_id
GROUP BY t.title
HAVING COALESCE(SUM(s.qty), 0) > 100
ORDER BY total_copies_sold DESC;

--99.- Obtener la lista de tiendas y la cantidad total de ventas realizadas en cada tienda (incluyendo las tiendas sin ventas) y mostrar todas las tiendas, ordenadas por la cantidad total de ventas en orden ascendente:
SELECT s.stor_id, s.stor_name, COALESCE(SUM(sa.qty), 0) AS total_qty
FROM stores s
RIGHT JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_id, s.stor_name
ORDER BY total_qty ASC;

--100.- Obtener la lista de editores y la cantidad total de títulos de libros publicados por cada editor (incluyendo los editores sin libros publicados) y mostrar todos los editores, ordenados por la cantidad de títulos en orden ascendente:
SELECT p.pub_id, p.pub_name, COALESCE(COUNT(t.title_id), 0) AS num_titles_published
FROM publishers p
RIGHT JOIN titles t ON p.pub_id = t.pub_id
GROUP BY p.pub_id, p.pub_name
ORDER BY num_titles_published ASC;


