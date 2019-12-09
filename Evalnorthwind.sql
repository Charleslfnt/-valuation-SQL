USE northwind;
--exercice 01 liste contacts français 

SELECT CompanyName AS Société, ContactName AS Contact, ContactTitle AS Fonction, Phone AS Téléphone 
FROM customers 
WHERE Country = 'France';

--exercice 02 produits vendus par Exotic Liquids

SELECT ProductName AS Produit, UnitPrice AS Prix
FROM products 
WHERE supplierID = '1';

--exercice 03 produits vendus par fournisseurs français dans l'ordre décroissant
SELECT suppliers.CompanyName AS Fournisseur, COUNT(Products.SupplierID) as Nbre_produits FROM Suppliers
INNER JOIN Products ON Suppliers.SupplierID = Products.SupplierID
WHERE Suppliers.Country = 'France'
GROUP BY suppliers.CompanyName
HAVING COUNT(Products.SupplierID)
ORDER BY Nbre_produits DESC;

--exercice 04 client français ayant plus de 10 commmandes
SELECT CompanyName AS CLIENT, COUNT(orders.customerID) AS Nbre_commandes 
FROM customers 
INNER JOIN orders ON customers.CustomerID = orders.customerID
WHERE Country = 'France' 
GROUP BY customers.CustomerID
HAVING COUNT(orders.customerID) > 10;


--exercice05 listes des clients chiffre d'affaires > 30000
SELECT customers.CompanyName AS CLIENT, SUM(order_details.UnitPrice*order_details.Quantity) AS CA, 
customers.Country AS Pays 
FROM customers
INNER JOIN orders ON customers.CustomerID = orders.CustomerID
INNER JOIN order_details ON order_details.OrderID = orders.OrderID
GROUP BY customers.CustomerID
HAVING CA > 30000
ORDER BY CA DESC ;

--La condition HAVING en SQL est presque similaire à WHERE à la seule différence 
--que HAVING permet de filtrer en utilisant des fonctions telles que SUM(), COUNT(), AVG(), MIN() ou MAX().


--exercice06 liste des pays dont les clients ont passé commande de produits
-- fournis par Exotic Liquids

SELECT customers.Country AS Pays FROM customers
INNER JOIN orders ON customers.CustomerID = orders.CustomerID
INNER JOIN order_Details ON order_Details.OrderID = orders.OrderID
INNER JOIN products ON products.ProductID = order_Details.ProductID
INNER JOIN suppliers ON products.SupplierID = suppliers.SupplierID
WHERE suppliers.CompanyName = "Exotic Liquids"

--exercice07 montant des ventes de 1997
SELECT SUM(UnitPrice*Quantity) AS Total FROM order_details --SUM = somme, on multiplie le prix unitaire à la quantité
INNER JOIN orders ON order_details.OrderID = orders.OrderID
WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31' --Date entre 01/01/1997 et 31/12/1997


--exercice08 montant des ventes de 1997 mois par mois
SELECT MONTH(orderdate) AS Mois_97, SUM(UnitPrice*Quantity) AS Montant_ventes FROM order_details
INNER JOIN orders ON order_details.OrderID = orders.OrderID
WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY MONTH(orderdate);

--exercice09 dernière date de la commande du client "Du monde entier"
SELECT MAX(orderDate) AS Date_De_La_Dernière_Commande
FROM orders 
WHERE shipName = 'Du Monde Entier' ;
--Dans le langage SQL, la fonction d’agrégation MAX() permet de retourner la valeur maximale d’une colonne dans un set d’enregistrement


--exercice10 Délai moyen de livraison en jours 
SELECT ROUND (AVG(DATEDIFF(ShippedDate,OrderDate))) AS Délai_Moyen_De_Livraison_En_Jours
FROM orders ;
--Dans le langage SQL la fonction ROUND() permet d’arrondir un résultat numérique.
--la fonction DATEDIFF() permet de déterminer l’intervalle entre 2 dates spécifiées. 
--La fonction d’agrégation AVG() dans le langage SQL permet de calculer une valeur 
--moyenne sur un ensemble d’enregistrement de type numérique et non nul.