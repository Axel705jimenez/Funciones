use NORTHWND;
---------------------------INNER JOIN-----------------------------------

--1.-Ordenar productos por precio en una categoría específica:
SELECT P.ProductName, c.CategoryName, p.UnitPrice
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY p.UnitPrice DESC;

--2.-Contar el numero de productos que hay en cada categoria
SELECT c.CategoryName, COUNT(p.ProductID) AS NumProductos
FROM Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
HAVING COUNT(p.ProductID) > 5;

--3.-Mostrar precio mas caro de cada cartegoria

SELECT c.CategoryName, MAX(p.UnitPrice) AS PrecioMasCaro
FROM Categories c
INNER JOIN Products p ON c.CategoryID = P.CategoryID
GROUP BY c.CategoryName;

--4.- Calcular el precio promedio de productos en cada categoria
SELECT c.CategoryName, AVG(p.UnitPrice) AS PrecioPromedio
FROM Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
HAVING AVG(p.UnitPrice) > 50;

--5.- Mostrar la cantidad total vendida de cada producto
SELECT p.ProductName, SUM(o.Quantity) AS CantidadTotalVendida
FROM Products p
INNER JOIN [Order Details] o ON p.ProductID = o.ProductID
GROUP BY p.ProductName
ORDER BY CantidadTotalVendida DESC;

--6.- Mostrar los empleados y la cantidad total de pedidos que han atendido, ordenados por la cantidad total de mayor a menor
SELECT e.FirstName, e.LastName, COUNT(o.OrderID) AS TotalPedidosAtendidos
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalPedidosAtendidos DESC;

--7.- Listar los productos y sus precios promedio, agrupados por categoría 
SELECT c.CategoryName, AVG(p.UnitPrice) AS PrecioPromedio
FROM Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY c.CategoryName ASC;

--8.- Listar los clientes que tienen el mismo código postal y mostrar la cantidad de clientes por código postal
SELECT c.PostalCode, COUNT(c.CustomerID) AS NumClientes
FROM Customers c
INNER JOIN Customers AS C2 ON c.PostalCode = C2.PostalCode AND c.CustomerID <> C2.CustomerID
GROUP BY c.PostalCode
ORDER BY NumClientes DESC;

--9.- Listar los productos que tienen un precio mayor que el precio promedio de todos los productos
SELECT p.ProductName, p.UnitPrice
FROM Products p
INNER JOIN (
    SELECT AVG(UnitPrice) AS PrecioPromedio FROM Products p
) AS AvgPrice ON p.UnitPrice > AvgPrice.PrecioPromedio;

--10.- Mostrar los clientes que tienen el mismo nombre de ciudad y código postal y contar cuántos clientes comparten esta combinación
SELECT c.City, c.PostalCode, COUNT(c.CustomerID) AS NumClientes
FROM Customers c
INNER JOIN Customers AS C2 ON c.City = C2.City AND c.PostalCode = C2.PostalCode AND c.CustomerID <> C2.CustomerID
GROUP BY c.City, c.PostalCode
ORDER BY NumClientes DESC;

--11.- Mostrar los clientes que tienen la misma persona de contacto y contar cuántos clientes comparten la misma persona de contacto
SELECT c.ContactName, COUNT(c.CustomerID) AS NumClientes
FROM Customers c
INNER JOIN Customers AS C2 ON c.ContactName = C2.ContactName AND c.CustomerID <> C2.CustomerID
GROUP BY c.ContactName
ORDER BY NumClientes DESC;

--12.-Mostrar los productos que tengan menos de 10 unidades en stock y ordenados por categoría y nombre de producto
SELECT Products.ProductName, Categories.CategoryName, Products.UnitsInStock
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitsInStock < 10
ORDER BY Categories.CategoryName, Products.ProductName;

--13.- Mostrar el número total de empleados que comparten el mismo jefe
SELECT E1.FirstName AS Empleado, E2.FirstName AS Jefe, COUNT(E1.EmployeeID) AS NumEmpleados
FROM Employees AS E1
INNER JOIN Employees AS E2 ON E1.ReportsTo = E2.EmployeeID
GROUP BY E1.FirstName, E2.FirstName
ORDER BY NumEmpleados DESC;

--14.- Mostrar los productos que se han pedido exactamente 10 veces, y el numero total de pedidos
SELECT p.ProductName, COUNT(od.OrderID) AS NumPedidos
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING COUNT(od.OrderID) = 10;

--15.- Mostrar los productos y sus categorías, pero solo para productos que tengan menos de 15 unidades en stock y estén disponibles
SELECT p.ProductName, c.CategoryName, p.UnitsInStock
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.UnitsInStock < 15
ORDER BY c.CategoryName, p.ProductName;

--16.- Mostrar los productos que se han pedido al menos 25 veces en total, junto con el número total de pedidos para cada producto
SELECT p.ProductName, COUNT(od.orderID) AS NumPedidos
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING COUNT(od.OrderID) >= 25;

--17.- Mostrar los productos que se han pedido al menos 30 veces en total, junto con el número total de pedidos para cada producto
SELECT p.ProductName, COUNT(od.OrderID) AS NumPedidos
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING COUNT(od.OrderID) >= 30;

--18.- Mostrar los productos y sus precios promedio por categoría
SELECT Categories.CategoryName, Products.ProductName, AVG(Products.UnitPrice) AS PrecioPromedio
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName, Products.ProductName
ORDER BY Categories.CategoryName ASC, PrecioPromedio DESC;

--19.- Listar los productos que no han sido pedidos en absoluto, es decir, no tienen registros en la tabla OrderDetails
SELECT p.ProductName
FROM Products p
inner JOIN [Order Details] od ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL;

--20.- Mostrar los productos y su cantidad total en stock
SELECT p.ProductName, p.UnitsInStock
FROM Products p
GROUP BY p.ProductName, p.UnitsInStock
ORDER BY p.UnitsInStock DESC;

--21.- Mostrar una descripcion de la region y el territorio 
SELECT r.RegionDescription, T.TerritoryDescription
FROM Region r
inner join Territories t ON r.RegionID = t.RegionID
GROUP BY r.RegionDescription, TerritoryDescription;

--22.- Listar los clientes que han realizado al menos un pedido durante el año 2023
SELECT Customers.CustomerID, COUNT(Orders.OrderID) AS NumPedidos
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(Orders.OrderDate) = 2023
GROUP BY Customers.CustomerID;

--23.- Mostrar la compañia y los productos que ofrece
SELECT s.CompanyName, p.ProductName AS ProductoCompañia
FROM Suppliers s
INNER JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName, p.ProductName;

--24.- Mostrar el nombre de la compañia, el pais y el numero de envios
SELECT c.CompanyName, c.Country, COUNT(o.OrderID) AS NumEnvios
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName, c.Country;

--25.- Mostrar el numero de pedidos de cada producto que se ha hecho
SELECT p.ProductName, COUNT(od.OrderID) AS NumPedidos
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

--26.- Mostrar los productos y sus proveedores correspondientes, pero solo para productos que tengan más de 20 unidades en stock y estén disponibles
SELECT p.ProductName, s.CompanyName, p.UnitsInStock
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.UnitsInStock > 20
ORDER BY p.ProductName;

--27.- Mostrar los productos con su categoria
SELECT p.ProductName, c.CategoryName
FROM Products p 
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName, p.ProductName;

--28.- Mostrar el nombre de la compañia y el total de sus pedidos, pero solo para la compañia que tengan al menos 5 pedidos
SELECT c.CompanyName, COUNT(o.OrderID) AS TotalPedidos
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
HAVING COUNT(o.OrderID) >= 5;

--29.- Calcular el total de ventas por empleado y año, mostrando solo las ventas totales superiores a $100,000
SELECT e.FirstName, e.LastName, YEAR(o.OrderDate) AS Año, SUM(o.OrderID) AS VentasTotales
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName, o.OrderDate, o.OrderID
HAVING o.OrderID > 100000;

--30.- Mostrar los productos y su cantidad total vendida en el año 2023, ordenados por cantidad total vendida en orden descendente
SELECT p.ProductName, SUM(od.Quantity) AS TotalVendido
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) = 2023
GROUP BY p.ProductName
ORDER BY TotalVendido DESC;

--31.- Mostrar los empleados y la cantidad total de pedidos que han realizado en el año 2024, en orden descendente
SELECT e.FirstName, e.LastName, COUNT(o.OrderID) AS TotalPedidos
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE YEAR(o.OrderDate) = 2024
GROUP BY e.FirstName, e.LastName
ORDER BY TotalPedidos DESC;

--32.- Calcular el promedio de días que tardan los productos en ser entregados desde el pedido, y mostrar solo los productos con un promedio de días de entrega menor a 6 días
SELECT p.ProductName, AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS PromedioDiasEntrega
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.ProductName
HAVING AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) < 6;

--33.- Mostrar las compañias y sus ciudades de envío, pero mostrar solo las ciudades de envío que comiencen con la letra "S"
SELECT c.CompanyName, o.ShipCity
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.ShipCity LIKE 'S%';

--34.- Mostrar los productos que se han pedido exactamente 3 veces en total, junto con el número total de pedidos para cada producto
SELECT p.ProductName, COUNT(od.OrderID) AS NumPedidos
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING  COUNT(od.OrderID) = 3;

--35.- Mostrar los productos y sus proveedores correspondientes, pero solo para productos que tengan menos de 10 unidades en stock y estén disponibles, ordenados por nombre de producto
SELECT p.ProductName, s.SupplierID, p.UnitsInStock
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.UnitsInStock < 10
ORDER BY p.ProductName;

--36.- Mostrar los productos y sus categorías correspondientes, pero solo para categorías que tengan al menos 5 productos, ordenados por nombre de categoría
SELECT c.CategoryName, p.ProductName
FROM Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName, p.ProductName
HAVING COUNT(p.ProductID) >= 5
ORDER BY c.CategoryName;

--37.- Calcular el total de ventas por año y mes, y mostrar solo los meses con ventas totales superiores a $90,000 en el año 2025
SELECT YEAR(o.OrderDate) AS Año, MONTH(o.OrderDate) AS Mes, SUM(o.OrderID) AS TotalVentas
FROM Orders o
WHERE YEAR(o.OrderDate) = 2025
GROUP BY o.OrderDate, o.OrderID
HAVING o.OrderID > 90000;

--38.- Mostrar los empleados y sus jefes correspondientes, mostrando solo los empleados que tienen un jefe
SELECT E1.FirstName AS Empleado, E2.FirstName AS Jefe
FROM Employees AS E1
INNER JOIN Employees AS E2 ON E1.ReportsTo = E2.EmployeeID
ORDER BY Jefe, Empleado;

--39.- Mostrar las compañias y sus ciudades de envío más comunes, ordenados por la cantidad de veces que se ha utilizado cada ciudad como destino de envío, pero mostrar solo las ciudades utilizadas al menos 3 veces
SELECT c.CompanyName, o.ShipCity, COUNT(o.ShipCity) AS NumEnvios
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName, o.ShipCity
HAVING COUNT(o.ShipCity) >= 3
ORDER BY NumEnvios DESC;

-- 40.- Mostrar los productos y sus categorías, pero solo para productos que tengan una cantidad mínima de unidades en stock en todas las categorías de al menos 20 unidades
SELECT p.ProductName, c.CategoryName, p.UnitsInStock
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.ProductID IN (
    SELECT ProductID
    FROM Products
    GROUP BY ProductID
    HAVING MIN(UnitsInStock) >= 20
)
ORDER BY c.CategoryName, p.ProductName;

--41.- Mostrar los clientes y su país de envío más común, junto con la cantidad de veces que se ha utilizado cada país como destino de envío, pero mostrar solo los países utilizados al menos 5 veces
SELECT c.CompanyName, c.Country, COUNT(c.Country) AS NumEnvios
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName, c.Country
HAVING COUNT(c.Country) >= 5
ORDER BY NumEnvios DESC;

--42.- Mostrar los productos y sus precios promedio por categoría, pero solo para categorías que tengan al menos 4 productos y precios promedio superiores a $20
SELECT c.CategoryName, p.ProductName, AVG(p.UnitPrice) AS PrecioPromedio
FROM  Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName, p.ProductName, p.UnitPrice
HAVING COUNT(p.ProductID) >= 4 AND p.UnitPrice > 20;

--43.- Calcular el total de ventas por empleado y mes, mostrando solo los meses con ventas totales superiores a $10,000 en el año 2024
SELECT e.FirstName, e.LastName, YEAR(o.OrderDate) AS Anio, MONTH(o.OrderDate) AS Mes, SUM(o.OrderID) AS VentasTotales
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE YEAR(o.OrderDate) = 2024
GROUP BY e.FirstName, e.LastName, o.OrderDate, o.OrderID
HAVING o.OrderID > 10000;

--44.- Listar los clientes que han realizado pedidos en todas las ciudades de envío disponibles
SELECT c.CompanyName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
HAVING COUNT(DISTINCT o.ShipCity) = (SELECT COUNT(DISTINCT ShipCity) FROM Orders);

--45.- Mostrar los productos y su cantidad total vendida en el año 2024, ordenados por cantidad total vendida en orden descendente
SELECT p.ProductName, SUM(od.Quantity) AS TotalVendido
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) = 2024
GROUP BY p.ProductName
ORDER BY TotalVendido DESC;

--46.- Mostrar los productos y su precio unitario más alto por categoría, ordenados por categoría en orden ascendente y precio unitario más alto en orden descendente
SELECT c.CategoryName, p.ProductName, MAX(p.UnitPrice) AS PrecioUnitarioMasAlto
FROM Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName, p.ProductName
ORDER BY c.CategoryName ASC, PrecioUnitarioMasAlto DESC;

--47.- Mostrar los clientes y sus respectivos productos comprados, pero mostrar solo los clientes que han realizado pedidos y han comprado productos en la categoría "Bebidas":
SELECT c.CompanyName, p.ProductName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Categories ca ON p.CategoryID = ca.CategoryID
WHERE ca.CategoryName = 'Beverages';

--48.- Mostrar los productos y sus proveedores correspondientes, pero solo para productos que tengan un precio mayor que $50 y que se encuentren en stock en este momento (UnitsInStock > 0)
SELECT p.ProductName, s.SupplierID
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.UnitPrice > 50 AND p.UnitsInStock > 0;

--49.- Mostrar los productos y sus categorías correspondientes, pero solo para productos que tengan al menos 10 unidades vendidas en pedidos
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Categories c ON od.ProductID = c.CategoryID
GROUP BY p.ProductName, c.CategoryName
HAVING SUM(od.Quantity) >= 10;

--50.- Mostrar las compañias que han realizado al menos 3 pedidos en el año 2023 y que tienen una cantidad total de productos pedidos superior a 100 unidades, ordenados por el nombre del cliente
SELECT c.CompanyName, COUNT(o.OrderID) AS TotalPedidos, SUM(od.Quantity) AS TotalProductosPedidos
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 2023
GROUP BY c.CompanyName
HAVING COUNT(o.OrderID) >= 3 AND SUM(od.Quantity) > 100
ORDER BY c.CompanyName;

---------------------------FULL JOIN-----------------------------------

--51.- Mostrar todas la compañias y proveedores, mostrando los que coinciden por país
SELECT c.CompanyName AS Cliente, c.Country AS PaisCliente, s.SupplierID AS Proveedor, s.Country AS PaisProveedor
FROM Customers c
FULL JOIN Suppliers s ON c.Country = s.Country
ORDER BY c.Country, s.Country;

--52.- Mostrar todos los productos y categorías, incluyendo productos sin categoría asignada
SELECT p.ProductName AS Producto, c.CategoryName AS Categoria
FROM Products p
FULL JOIN Categories c ON p.CategoryID = c.CategoryID;

--53.- Mostrar todos los empleados y sus territorios de ventas asignados, incluyendo empleados sin territorios asignados
SELECT e.FirstName AS Empleado, e.LastName AS Apellido, t.TerritoryDescription AS Territorio
FROM Employees e
FULL JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
FULL JOIN Territories t ON et.TerritoryID = t.TerritoryID
ORDER BY e.EmployeeID;

--54.- Mostrar todos los pedidos y los productos incluidos en cada pedido, incluyendo pedidos sin productos:
SELECT o.OrderID AS IDPedido, p.ProductName AS Producto
FROM Orders o
FULL JOIN [Order Details] od ON o.OrderID = od.OrderID
FULL JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderID, p.ProductName;

--55.- Mostrar todas la compañias y empleados, mostrando las coincidencias por ciudad:
SELECT c.CompanyName AS Cliente, c.City AS CiudadCliente, e.FirstName AS Empleado, e.City AS CiudadEmpleado
FROM Customers c
FULL JOIN Employees e ON c.City = e.City
ORDER BY c.City, e.City;

--56.- Mostrar las categorías de productos y la cantidad total de productos en cada categoría, ordenados por cantidad en orden descendente:
SELECT c.CategoryName, COUNT(p.ProductID) AS TotalProductos
FROM Categories c
FULL JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalProductos DESC;

--57.- Mostrar todos los clientes y sus respectivos empleados de ventas asignados, incluyendo clientes sin empleado de ventas asignado, y ordenarlos por nombre de cliente:
SELECT c.CompanyName, e.FirstName AS NombreEmpleado, e.LastName AS ApellidoEmpleado
FROM Customers c
FULL JOIN Employees e ON c.Country = e.Country
ORDER BY c.CompanyName;

--58.- Mostrar todos los empleados y la cantidad total de pedidos que han gestionado, pero mostrar solo los empleados que han gestionado al menos 10 pedidos, ordenados por cantidad de pedidos en orden descendente:
SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(o.OrderID) AS TotalPedidos
FROM Employees e
FULL JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) >= 10
ORDER BY TotalPedidos DESC;

--59.- Mostrar todos los productos y la cantidad total vendida de cada producto, incluyendo productos sin ventas, y ordenarlos por cantidad vendida en orden descendente:
SELECT p.ProductName, SUM(od.Quantity) AS TotalVendido
FROM Products p
FULL JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalVendido DESC;

--60.- Mostrar todos los proveedores y la cantidad total de productos que suministran, pero mostrar solo los proveedores que suministran al menos 5 productos y ordenarlos por cantidad de productos suministrados en orden descendente:
SELECT s.CompanyName, COUNT(p.ProductID) AS TotalProductosSuministrados
FROM Suppliers s
FULL JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName
HAVING COUNT(p.ProductID) >= 5
ORDER BY TotalProductosSuministrados DESC;

--61.- Calcular el total de ventas por país de clientes y mostrar solo los países con ventas totales superiores a $100,000, ordenados por ventas totales en orden descendente:
SELECT c.Country, SUM(o.OrderID) AS TotalVentas
FROM Customers c
FULL JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Country
HAVING SUM(o.OrderID) > 100000
ORDER BY TotalVentas DESC;

--62.- Mostrar todos los productos y sus proveedores correspondientes, incluyendo productos sin proveedor, y ordenarlos por nombre de producto:
SELECT p.ProductName, s.SupplierID
FROM Products p
FULL JOIN Suppliers s ON p.SupplierID = s.SupplierID
ORDER BY p.ProductName;

--63.- Mostrar todos los empleados y la cantidad total de pedidos que han gestionado, pero mostrar solo los empleados que han gestionado al menos 20 pedidos y ordenarlos por cantidad de pedidos en orden ascendente:
SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(o.OrderID) AS TotalPedidos
FROM Employees e
FULL JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) >= 20
ORDER BY TotalPedidos ASC;

--64.-Mostrar todos los productos y sus precios unitarios, incluyendo productos sin precio, y ordenarlos por precio unitario en orden ascendente:
SELECT p.ProductName, p.UnitPrice
FROM Products p
FULL JOIN Suppliers s ON p.SupplierID = s.SupplierID
ORDER BY p.UnitPrice ASC;

--65.- Mostrar todos los clientes y la cantidad total de pedidos que han realizado, pero mostrar solo los clientes que han realizado al menos 3 pedidos y ordenarlos por nombre de cliente:
SELECT c.CompanyName, COUNT(o.OrderID) AS TotalPedidos
FROM Customers c
FULL JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
HAVING COUNT(o.OrderID) >= 3
ORDER BY c.CompanyName;

--66.-Mostrar todos los clientes y el id de sus pedidos correspondientes, incluyendo clientes que no han realizado pedidos y ordenarlos por nombre de cliente:
SELECT c.CompanyName, o.OrderID
FROM Customers c
FULL JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY c.CompanyName;

--67.- Mostrar todos los productos y sus categorías correspondientes, incluyendo productos sin categoría, y ordenarlos por nombre de producto:
SELECT p.ProductName, c.CategoryName
FROM Products p
FULL JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY p.ProductName;

--68.- Calcular el total de ventas por año y mes, y mostrar solo los meses con ventas totales superiores a $50,000 en el año 2023:
SELECT YEAR(o.OrderDate) AS Año, MONTH(o.OrderDate) AS Mes, SUM(o.OrderID) AS TotalVentas
FROM Orders o
FULL JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2023
GROUP BY o.OrderDate
HAVING SUM(o.OrderID) > 50000;

--69.- Mostrar todos los empleados y sus jefes correspondientes, incluyendo empleados que no tienen jefe, y ordenarlos por nombre de empleado:
SELECT E1.FirstName AS Empleado, E1.LastName AS ApellidoEmpleado, E2.FirstName AS Jefe, E2.LastName AS ApellidoJefe
FROM Employees AS E1
FULL JOIN Employees AS E2 ON E1.ReportsTo = E2.EmployeeID
ORDER BY E1.FirstName, E1.LastName;

--70.- Mostrar todos los productos y sus unidades vendidas totales, incluyendo productos sin ventas, y ordenarlos por unidades vendidas en orden descendente:
SELECT p.ProductName, SUM(ISNULL(od.Quantity, 0)) AS UnidadesVendidasTotales
FROM Products p
FULL JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY UnidadesVendidasTotales DESC;

--71.- Mostrar todos las compañias y la cantidad total de productos que han comprado, pero mostrar solo los clientes que han comprado al menos 20 productos y ordenarlos por cantidad de productos comprados en orden descendente:
SELECT Customers.CompanyName, SUM(ISNULL(od.Quantity, 0)) AS TotalProductosComprados
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID
FULL JOIN [Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY Customers.CompanyName
HAVING SUM(ISNULL(od.Quantity, 0)) >= 20
ORDER BY TotalProductosComprados DESC;

--72.- Calcular el promedio de días transcurridos desde la fecha de pedido hasta la fecha de envío, y mostrar solo los pedidos con un promedio de días de envío superior a 5 días:
SELECT o.OrderDate, AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS PromedioDiasEnvio
FROM Orders o 
GROUP BY o.OrderID, o.OrderDate
HAVING AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) > 5;

--73.- Mostrar todos los productos y sus precios unitarios, incluyendo productos sin precios, y ordenarlos por precio unitario en orden descendente:
SELECT p.ProductName, p.UnitPrice
FROM Products p
FULL JOIN Suppliers s ON p.SupplierID = s.SupplierID
ORDER BY p.UnitPrice DESC;

--74.- Listar todos los proveedores y la cantidad total de productos que suministran, pero mostrar solo los proveedores que suministran al menos 10 productos y ordenarlos por cantidad de productos suministrados en orden descendente:
SELECT s.SupplierID, COUNT(p.ProductID) AS TotalProductosSuministrados
FROM Suppliers s
FULL JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID
HAVING COUNT(p.ProductID) >= 10
ORDER BY TotalProductosSuministrados DESC;

--75.- Mostrar todos los empleados y sus territorios de ventas asignados, incluyendo empleados sin territorios asignados, y ordenarlos por nombre de empleado:
SELECT e.FirstName AS Empleado, e.LastName AS Apellido, t.TerritoryDescription AS Territorio
FROM Employees e
FULL JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
FULL JOIN Territories t ON et.TerritoryID = t.TerritoryID
ORDER BY e.FirstName, e.LastName;

--76.- Mostrar todos los clientes y la cantidad total de pedidos que han realizado, pero mostrar solo los clientes que han realizado al menos 5 pedidos y ordenarlos por cantidad de pedidos en orden ascendente:
SELECT c.CompanyName, COUNT(o.OrderID) AS TotalPedidos
FROM Customers c
FULL JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
HAVING COUNT(o.OrderID) >= 5
ORDER BY TotalPedidos ASC;

--77.- Mostrar todos los productos y sus categorías correspondientes, incluyendo productos sin categoría, y ordenarlos por nombre de categoría y nombre de producto:
SELECT Categories.CategoryName, Products.ProductName
FROM Categories
FULL JOIN Products ON Categories.CategoryID = Products.CategoryID
ORDER BY Categories.CategoryName, Products.ProductName;

--78.- Calcular el total de ventas por año y mes, y mostrar solo los años con ventas totales superiores a $500,000 en cualquier mes:
SELECT YEAR(o.OrderDate) AS Anio, MONTH(o.OrderDate) AS Mes, SUM(o.OrderID) AS TotalVentas
FROM Orders o
FULL JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.OrderDate
HAVING SUM(o.OrderID) > 500000;

--79.- Listar todos los empleados y la cantidad total de pedidos que han gestionado, pero mostrar solo los empleados que han gestionado al menos 15 pedidos y ordenarlos por cantidad de pedidos en orden descendente:
SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(o.OrderID) AS TotalPedidos
FROM Employees e
FULL JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) >= 15
ORDER BY TotalPedidos DESC;

--80.- Mostrar todos los productos y sus precios unitarios, incluyendo productos sin precios, y ordenarlos por nombre de producto:
SELECT p.ProductName, p.UnitPrice
FROM Products p
FULL JOIN Suppliers ON p.SupplierID = Suppliers.SupplierID
ORDER BY p.ProductName;

--81.- Calcular el total de ventas por año y mes, y mostrar solo los años con ventas totales superiores a $500 en cualquier mes:
SELECT YEAR(o.OrderDate) AS Año, MONTH(o.OrderDate) AS Mes, SUM(o.OrderID) AS TotalVentas
FROM Orders o
FULL JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.OrderDate
HAVING SUM(o.OrderID) > 500;

--82.-Mostrar todos los productos y sus precios unitarios, incluyendo productos sin precios, y ordenarlos por nombre de producto:
SELECT p.ProductName, p.UnitPrice
FROM Products p
FULL JOIN Suppliers s ON p.SupplierID = s.SupplierID
ORDER BY p.ProductName;

--83.- Mostrar todos los proveedores y la cantidad total de productos que suministran, pero mostrar solo los proveedores que suministran al menos 10 productos y ordenarlos por cantidad de productos suministrados en orden descendente:
SELECT s.SupplierID, COUNT(p.ProductID) AS TotalProductosSuministrados
FROM Suppliers s
FULL JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID
HAVING COUNT(p.ProductID) >= 10
ORDER BY TotalProductosSuministrados DESC;

--84.- Mostrar todos los empleados y sus territorios de ventas asignados, incluyendo empleados sin territorios asignados, y ordenarlos por nombre de empleado:
SELECT e.FirstName AS Empleado, e.LastName AS Apellido, t.TerritoryDescription AS Territorio
FROM Employees e
FULL JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
FULL JOIN Territories t ON et.TerritoryID = t.TerritoryID
ORDER BY e.FirstName, e.LastName;

--85.- Mostrar las compañias y la cantidad total de productos que han comprado, pero mostrar solo los clientes que han comprado al menos 20 productos y ordenarlos por cantidad de productos comprados en orden descendente:
SELECT c.CompanyName, SUM(ISNULL(od.Quantity, 0)) AS TotalProductosComprados
FROM Customers c
FULL JOIN Orders o ON c.CustomerID = o.CustomerID
FULL JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
HAVING SUM(ISNULL(od.Quantity, 0)) >= 20
ORDER BY TotalProductosComprados DESC;

--86.-Listar todos los proveedores y la cantidad total de productos que suministran, pero mostrar solo los proveedores que suministran al menos 50 productos y ordenarlos por cantidad de productos suministrados en orden descendente:
SELECT s.CompanyName, COUNT(p.ProductID) AS TotalProductosSuministrados
FROM Suppliers s
FULL JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName
HAVING COUNT(p.ProductID) >= 3
ORDER BY TotalProductosSuministrados DESC;

--87.- Mostrar todos los empleados y sus jefes correspondientes, incluyendo empleados que no tienen jefe, y ordenarlos por apellido del empleado
SELECT E1.LastName AS Empleado, E2.LastName AS Jefe
FROM Employees AS E1
FULL JOIN Employees AS E2 ON E1.ReportsTo = E2.EmployeeID
ORDER BY E1.LastName;

--88.- Mostrar todos los clientes y sus pedidos, incluyendo clientes que no han realizado pedidos, y mostrar la fecha de pedido más reciente si existe un pedido asociado:
SELECT c.CompanyName, MAX(o.OrderDate) AS FechaUltimoPedido
FROM Customers c
FULL JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName;

--89.- Mostrar todos los productos y sus ventas totales correspondientes, incluyendo productos que no han sido vendidos, y ordenarlos por nombre de producto:
SELECT p.ProductName, SUM(od.Quantity) AS VentasTotales
FROM Products p
FULL JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY p.ProductName;

--90.- Mostrar todos los proveedores y la cantidad total de productos que suministran, pero mostrar solo los proveedores que suministran al mas 5 productos y ordenarlos por cantidad de productos suministrados en orden descendente:
SELECT s.SupplierID, COUNT(p.ProductID) AS TotalProductosSuministrados
FROM Suppliers s
FULL JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID
HAVING COUNT(p.ProductID) <= 5
ORDER BY TotalProductosSuministrados DESC;

--91.- Mostrar todos los empleados y sus respectivas ciudades de residencia, incluyendo empleados sin ciudad de residencia
SELECT e.FirstName, e.LastName, e.City
FROM Employees e
FULL JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
FULL JOIN Territories t ON et.TerritoryID = t.TerritoryID;

--92.- Mostrar todos los productos y sus respectivos proveedores y categorías correspondientes, incluyendo productos sin proveedor o categoría, y ordenarlos por nombre de producto
SELECT p.ProductName, s.SupplierID, c.CategoryName
FROM Products p
FULL JOIN Suppliers s ON p.SupplierID = s.SupplierID
FULL JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY p.ProductName;

--93.- Mostrar todos los pedidos y sus detalles correspondientes, incluyendo pedidos sin detalles, y mostrar la cantidad total de productos si existen detalles asociados
SELECT o.OrderID, SUM(ISNULL(od.Quantity, 0)) AS TotalProductos
FROM Orders o
FULL JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.OrderID;

--94.- Mostrar todos los empleados y sus respectivos jefes correspondientes, incluyendo empleados que no tienen jefe, y ordenarlos por apellido del empleado
SELECT E1.FirstName AS Empleado, E1.LastName AS Apellido, E2.FirstName AS Jefe
FROM Employees AS E1
FULL JOIN Employees AS E2 ON E1.ReportsTo = E2.EmployeeID
ORDER BY E1.LastName;

--95.- Mostrar todos los productos, la categoria y sus precios unitarios, incluyendo productos sin precios, y ordenarlos por nombre de producto
SELECT p.ProductName,c.CategoryName,  p.UnitPrice
FROM Products p
FULL JOIN Suppliers s ON p.SupplierID = s.SupplierID
FULL JOIN Categories c ON s.SupplierID = c.CategoryID
ORDER BY p.ProductName;

--96.- Mostrar el nombre de los productos y la cantidad máxima vendida de cada producto
SELECT p.ProductName, MAX(ISNULL(od.Quantity, 0)) AS TotalVendido
FROM Products p
FULL JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING MAX(ISNULL(od.Quantity, 0)) > 0
ORDER BY TotalVendido ASC;

--97--calcular la cantidad total de productos comprados por cada compañía
SELECT c.CompanyName, SUM(ISNULL(od.Quantity, 0)) AS TotalProductosComprados
FROM Customers c
FULL JOIN Orders o ON c.CustomerID = o.CustomerID
FULL JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
HAVING SUM(ISNULL(od.Quantity, 0)) >= 10
ORDER BY c.CompanyName ASC;

--98.- recuperar los nombres de productos y sus precios unitarios correspondientes, incluyendo productos sin precios
SELECT p.ProductName, ISNULL(p.UnitPrice, 0) AS PrecioUnitario
FROM Products p
FULL JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE ISNULL(p.UnitPrice, 0) > 0
ORDER BY p.ProductName DESC;

--99.- Consulta que proporciona información sobre los proveedores y los productos que han suministrados suministrados en orden descendente:
SELECT s.SupplierID, s.CompanyName AS NombreProveedor, p.ProductName AS NombreProducto, COUNT(p.ProductID) AS TotalProductosSuministrados
FROM Suppliers s
FULL JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.CompanyName, p.ProductName
HAVING COUNT(p.ProductID) >= 2
ORDER BY TotalProductosSuministrados DESC;

--100.- lista de clientes junto con información sobre sus pedidos, incluyendo el nombre del cliente, el nombre de contacto, el ID del pedido y la fecha del pedido, y los ordena por nombre de cliente.
SELECT Customers.CompanyName, Customers.ContactName, Orders.OrderID, Orders.OrderDate
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CompanyName;







