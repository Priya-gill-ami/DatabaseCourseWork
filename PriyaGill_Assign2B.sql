USE premiere_products;

CREATE TABLE WarehouseDetail (
    WarehouseNum INT PRIMARY KEY,
    Location VARCHAR(50)
);

INSERT INTO WarehouseDetail (WarehouseNum, Location) VALUES
(1, 'New Haven, CT'),
(2, 'Boston, MA'),
(3, 'White Plains, NY');

ALTER TABLE Part 
ADD CONSTRAINT FK_WarehouseNum FOREIGN KEY (Warehouse) 
REFERENCES WarehouseDetail(WarehouseNum) 
ON UPDATE CASCADE;

CREATE TABLE PartInWarehouse (
    MyPartNum2 CHAR(4) PRIMARY KEY,
    MyWarehouseNum2 INT,
    FOREIGN KEY (MyPartNum2) REFERENCES Part(PartNum) ON UPDATE CASCADE,
    FOREIGN KEY (MyWarehouseNum2) REFERENCES WarehouseDetail(WarehouseNum) ON UPDATE CASCADE
);

INSERT INTO PartInWarehouse (MyPartNum2, MyWarehouseNum2) VALUES
('FD21', 3),
('KV29', 2),
('AT94', 3);

INSERT INTO PartInWarehouse (MyPartNum2, MyWarehouseNum2) VALUES
('KV29', 1);

INSERT INTO PartInWarehouse (MyPartNum2, MyWarehouseNum2) VALUES
('DW11', 5);