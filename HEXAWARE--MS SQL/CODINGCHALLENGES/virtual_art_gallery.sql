

-- Virtual Art Gallery SQL Script


-- 1. Create the Artists table
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Biography TEXT,
    Nationality VARCHAR(100)
);

-- 2. Create the Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 3. Create the Artworks table
CREATE TABLE Artworks (
    ArtworkID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ArtistID INT,
    CategoryID INT,
    Year INT,
    Description TEXT,
    ImageURL VARCHAR(255),
    FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
    FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
);

-- 4. Create the Exhibitions table
CREATE TABLE Exhibitions (
    ExhibitionID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Description TEXT
);

-- 5. Create the ExhibitionArtworks associative table
CREATE TABLE ExhibitionArtworks (
    ExhibitionID INT,
    ArtworkID INT,
    PRIMARY KEY (ExhibitionID, ArtworkID),
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)
);

-- Insert data into Artists
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

-- Insert data into Categories
INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');

-- Insert data into Artworks (base)
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso\'s powerful anti-war mural.', 'guernica.jpg'),
(4, 'The Weeping Woman', 1, 1, 1937, 'Another famous Picasso painting.', 'weeping_woman.jpg'),
(5, 'Les Demoiselles d''Avignon', 1, 1, 1907, 'Pioneering work of Cubism.', 'demoiselles.jpg'),
(6, 'Girl before a Mirror', 1, 1, 1932, 'A famous surrealist painting by Picasso.', 'girl_before_mirror.jpg'),
(7, 'Picasso Sculpture', 1, 2, 1930, 'A modern sculpture by Picasso.', 'picasso_sculpture.jpg'),
(8, 'Picasso Photograph', 1, 3, 1935, 'A rare photograph attributed to Picasso.', 'picasso_photo.jpg');

-- Insert data into Exhibitions
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

-- Insert data into ExhibitionArtworks
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2);

-- 1. Artists with number of artworks
SELECT A.Name, COUNT(Ar.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
GROUP BY A.Name
ORDER BY ArtworkCount DESC;

-- 2. Artworks by Spanish and Dutch artists
SELECT Ar.Title
FROM Artworks Ar
JOIN Artists A ON Ar.ArtistID = A.ArtistID
WHERE A.Nationality IN ('Spanish', 'Dutch')
ORDER BY Ar.Year ASC;

-- 3. Artists with artworks in 'Painting' category
SELECT A.Name, COUNT(*) AS PaintingCount
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
WHERE Ar.CategoryID = 1
GROUP BY A.Name;

-- 4. Artworks in 'Modern Art Masterpieces' with artist and category
SELECT Ar.Title, A.Name AS Artist, C.Name AS Category
FROM ExhibitionArtworks EA
JOIN Artworks Ar ON EA.ArtworkID = Ar.ArtworkID
JOIN Artists A ON Ar.ArtistID = A.ArtistID
JOIN Categories C ON Ar.CategoryID = C.CategoryID
JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
WHERE E.Title = 'Modern Art Masterpieces';

-- 5. Artists with more than two artworks
SELECT A.Name, COUNT(Ar.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
GROUP BY A.Name
HAVING COUNT(Ar.ArtworkID) > 2;

-- 6. Artworks in both exhibitions
SELECT Ar.Title
FROM ExhibitionArtworks EA1
JOIN ExhibitionArtworks EA2 ON EA1.ArtworkID = EA2.ArtworkID
JOIN Artworks Ar ON EA1.ArtworkID = Ar.ArtworkID
WHERE EA1.ExhibitionID = 1 AND EA2.ExhibitionID = 2;

-- 7. Total artworks in each category
SELECT C.Name, COUNT(A.ArtworkID) AS TotalArtworks
FROM Categories C
LEFT JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.Name;

-- 8. Artists with more than 3 artworks
SELECT A.Name, COUNT(Ar.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
GROUP BY A.Name
HAVING COUNT(Ar.ArtworkID) > 3;

-- 9. Artworks by Spanish artists
SELECT Title FROM Artworks WHERE ArtistID IN (
    SELECT ArtistID FROM Artists WHERE Nationality = 'Spanish'
);

-- 10. Exhibitions featuring both van Gogh and da Vinci
SELECT E.Title
FROM Exhibitions E
JOIN ExhibitionArtworks EA ON E.ExhibitionID = EA.ExhibitionID
JOIN Artworks A1 ON EA.ArtworkID = A1.ArtworkID
WHERE A1.ArtistID IN (
    SELECT ArtistID FROM Artists WHERE Name = 'Vincent van Gogh'
)
AND E.ExhibitionID IN (
    SELECT EA2.ExhibitionID
    FROM ExhibitionArtworks EA2
    JOIN Artworks A2 ON EA2.ArtworkID = A2.ArtworkID
    WHERE A2.ArtistID = (SELECT ArtistID FROM Artists WHERE Name = 'Leonardo da Vinci')
)
GROUP BY E.Title;

-- 11. Artworks not in any exhibition
SELECT A.ArtworkID, A.Title
FROM Artworks A
LEFT JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

-- 12. Artists with artworks in all categories
SELECT A.Name
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
GROUP BY A.ArtistID, A.Name
HAVING COUNT(DISTINCT Ar.CategoryID) = (SELECT COUNT(*) FROM Categories);

-- 13. Total number of artworks in each category
SELECT C.Name AS CategoryName, COUNT(A.ArtworkID) AS TotalArtworks
FROM Categories C
LEFT JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name;

-- 14. Artists with more than 2 artworks
SELECT A.Name
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
GROUP BY A.ArtistID, A.Name
HAVING COUNT(*) > 2;

-- 15. Categories with average year of artworks (more than 1 artwork)
SELECT C.Name, AVG(A.Year) AS AvgYear
FROM Categories C
JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name
HAVING COUNT(*) > 1;

-- 16. Artworks in 'Modern Art Masterpieces'
SELECT A.Title
FROM Artworks A
JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
WHERE E.Title = 'Modern Art Masterpieces';

-- 17. Categories with avg year greater than overall avg
SELECT C.Name, AVG(A.Year) AS AvgYear
FROM Categories C
JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name
HAVING AVG(A.Year) > (SELECT AVG(Year) FROM Artworks);

-- 18. Artworks not exhibited
SELECT A.Title
FROM Artworks A
LEFT JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

-- 19. Artists with artworks in same category as 'Mona Lisa'
SELECT DISTINCT A.Name
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
WHERE Ar.CategoryID = (
    SELECT CategoryID FROM Artworks WHERE Title = 'Mona Lisa'
);

-- 20. Artists and number of artworks
SELECT A.Name, COUNT(Ar.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
GROUP BY A.Name;
