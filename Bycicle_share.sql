rop table ago;
-- de esta forma se crea una tabla 
CREATE TABLE AGO (
    ride_id VARCHAR(50) PRIMARY KEY, -- Aquí definimos la Primary Key
    rideable_type VARCHAR(50),
    started_at TEXT, -- Texto temporal para la carga inicial
    ended_at TEXT,   -- Texto temporal para la carga inicial
    start_station_name TEXT,
    start_station_id TEXT,
    end_station_name TEXT,
    end_station_id TEXT,
    start_lat TEXT,
    start_lng TEXT,
    end_lat TEXT,
    end_lng TEXT,
    member_casual VARCHAR(20)
);
-- si el Wizard no funciona lo que queda es importarla de forma manual 
-- Ve a la carpeta Uploads, abre el archivo agosto.csv, ignora la primera fila y mete todo en la tabla AGO, separando cada dato por las comas y cada viaje por los saltos de línea
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/agosto.csv' 
INTO TABLE AGO 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS;

-- 3. EL PASO CRUCIAL: Convertir las fechas SIN SOBREESCRIBIR
SET SQL_SAFE_UPDATES = 0;

UPDATE AGO SET 
    started_at = STR_TO_DATE(started_at, '%Y-%m-%d %H:%i:%s.%f'),
    ended_at = STR_TO_DATE(ended_at, '%Y-%m-%d %H:%i:%s.%f'); -- <--- Fíjate que aquí ya dice ended_at

-- 4. Cambiamos el tipo de dato a DATETIME
ALTER TABLE AGO 
    MODIFY started_at DATETIME(3), 
    MODIFY ended_at DATETIME(3);

-- 5. Calculamos la duración (¡Ahora sí verás números!)
UPDATE AGO SET ride_length_seconds = TIMESTAMPDIFF(SECOND, started_at, ended_at);

-- 6. Calculamos el día de la semana
UPDATE AGO SET day_of_week = DAYOFWEEK(started_at);

SET SQL_SAFE_UPDATES = 1;

-- VERIFICACIÓN FINAL
SELECT started_at, ended_at, ride_length_seconds FROM AGO LIMIT 10;

-- 1. Creamos las columnas necesarias
ALTER TABLE AGO ADD COLUMN ride_length_seconds INT;
ALTER TABLE AGO ADD COLUMN day_of_week INT;

-- 2. Apagamos el modo seguro para poder actualizar
SET SQL_SAFE_UPDATES = 0;

-- 3. Calculamos la duración y el día (Esto es lo que responderá tu caso de estudio)
UPDATE AGO 
SET ride_length_seconds = TIMESTAMPDIFF(SECOND, started_at, ended_at),
    day_of_week = DAYOFWEEK(started_at);

-- 4. Volvemos a encender la seguridad
SET SQL_SAFE_UPDATES = 1;

-- 5. Verificamos los resultados
SELECT started_at, ended_at, ride_length_seconds, day_of_week 
FROM AGO 
LIMIT 10;

-- Primera consulta El objetivo del proyecto es entender cómo usan las bicis los dos tipos de clientes

SELECT 
    member_casual, 
    AVG(ride_length_seconds) / 60 AS promedio_minutos,
    MIN(ride_length_seconds) AS viaje_mas_corto_seg,
    MAX(ride_length_seconds) / 3600 AS viaje_mas_largo_horas,
    COUNT(*) AS total_viajes
FROM AGO
GROUP BY member_casual;

------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE SEP (
    ride_id VARCHAR(50) PRIMARY KEY,
    rideable_type VARCHAR(50),
    started_at TEXT, 
    ended_at TEXT,  
    start_station_name TEXT,
    start_station_id TEXT,
    end_station_name TEXT,
    end_station_id TEXT,
    start_lat TEXT,
    start_lng TEXT,
    end_lat TEXT,
    end_lng TEXT,
    member_casual VARCHAR(20)
);

-- Versión "Salva-errores"
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/Septiembre.csv' 
INTO TABLE SEP 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS;

-- 3. EL PASO CRUCIAL: Convertir las fechas SIN SOBREESCRIBIR
SET SQL_SAFE_UPDATES = 0;

UPDATE sep SET 
    started_at = STR_TO_DATE(started_at, '%Y-%m-%d %H:%i:%s.%f'),
    ended_at = STR_TO_DATE(ended_at, '%Y-%m-%d %H:%i:%s.%f'); -- <--- Fíjate que aquí ya dice ended_at

-- 4. Cambiamos el tipo de dato a DATETIME
ALTER TABLE sep 
    MODIFY started_at DATETIME(3), 
    MODIFY ended_at DATETIME(3);

-- 5. Calculamos la duración (¡Ahora sí verás números!)
UPDATE sep SET ride_length_seconds = TIMESTAMPDIFF(SECOND, started_at, ended_at);

-- 6. Calculamos el día de la semana
UPDATE sep SET day_of_week = DAYOFWEEK(started_at);

SET SQL_SAFE_UPDATES = 1;

-- VERIFICACIÓN FINAL
SELECT started_at, ended_at, ride_length_seconds FROM AGO LIMIT 10;

-- 1. Creamos las columnas necesarias
ALTER TABLE sep ADD COLUMN ride_length_seconds INT;
ALTER TABLE sep ADD COLUMN day_of_week INT;

-- 2. Apagamos el modo seguro para poder actualizar
SET SQL_SAFE_UPDATES = 0;

-- 3. Calculamos la duración y el día (Esto es lo que responderá tu caso de estudio)
UPDATE sep 
SET ride_length_seconds = TIMESTAMPDIFF(SECOND, started_at, ended_at),
    day_of_week = DAYOFWEEK(started_at);

-- 4. Volvemos a encender la seguridad
SET SQL_SAFE_UPDATES = 1;

-- 5. Verificamos los resultados
SELECT started_at, ended_at, ride_length_seconds, day_of_week 
FROM sep
LIMIT 10;

-- Primera consulta El objetivo de tu proyecto es entender cómo usan las bicis los dos tipos de clientes

SELECT 
    member_casual, 
    AVG(ride_length_seconds) / 60 AS promedio_minutos,
    MIN(ride_length_seconds) AS viaje_mas_corto_seg,
    MAX(ride_length_seconds) / 3600 AS viaje_mas_largo_horas,
    COUNT(*) AS total_viajes
FROM sep
GROUP BY member_casual;
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE OCT (
    ride_id VARCHAR(50) PRIMARY KEY,
    rideable_type VARCHAR(50),
    started_at TEXT, 
    ended_at TEXT,  
    start_station_name TEXT,
    start_station_id TEXT,
    end_station_name TEXT,
    end_station_id TEXT,
    start_lat TEXT,
    start_lng TEXT,
    end_lat TEXT,
    end_lng TEXT,
    member_casual VARCHAR(20)
);

-- Versión "Salva-errores"
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/Octubre.csv' 
INTO TABLE OCT -- <--- Aquí es donde estaba el error
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS;

-- 3. EL PASO CRUCIAL: Convertir las fechas SIN SOBREESCRIBIR
SET SQL_SAFE_UPDATES = 0;

UPDATE oct SET 
    started_at = STR_TO_DATE(started_at, '%Y-%m-%d %H:%i:%s.%f'),
    ended_at = STR_TO_DATE(ended_at, '%Y-%m-%d %H:%i:%s.%f'); -- <--- Fíjate que aquí ya dice ended_at

-- 4. Cambiamos el tipo de dato a DATETIME
ALTER TABLE oct 
    MODIFY started_at DATETIME(3), 
    MODIFY ended_at DATETIME(3);

-- 5. Calculamos la duración (¡Ahora sí verás números!)
UPDATE oct SET ride_length_seconds = TIMESTAMPDIFF(SECOND, started_at, ended_at);

-- 6. Calculamos el día de la semana
UPDATE oct SET day_of_week = DAYOFWEEK(started_at);

SET SQL_SAFE_UPDATES = 1;

-- VERIFICACIÓN FINAL
SELECT started_at, ended_at, ride_length_seconds FROM AGO LIMIT 10;

-- 1. Creamos las columnas necesarias
ALTER TABLE oct ADD COLUMN ride_length_seconds INT;
ALTER TABLE oct ADD COLUMN day_of_week INT;

-- 2. Apagamos el modo seguro para poder actualizar
SET SQL_SAFE_UPDATES = 0;

-- 3. Calculamos la duración y el día (Esto es lo que responderá tu caso de estudio)
UPDATE oct
SET ride_length_seconds = TIMESTAMPDIFF(SECOND, started_at, ended_at),
    day_of_week = DAYOFWEEK(started_at);

-- 4. Volvemos a encender la seguridad
SET SQL_SAFE_UPDATES = 1;

-- 5. Verificamos los resultados
SELECT started_at, ended_at, ride_length_seconds, day_of_week 
FROM oct
LIMIT 10;

-- Primera consulta El objetivo de tu proyecto es entender cómo usan las bicis los dos tipos de clientes

SELECT 
    member_casual, 
    AVG(ride_length_seconds) / 60 AS promedio_minutos,
    MIN(ride_length_seconds) AS viaje_mas_corto_seg,
    MAX(ride_length_seconds) / 3600 AS viaje_mas_largo_horas,
    COUNT(*) AS total_viajes
FROM oct
GROUP BY member_casual;

CREATE VIEW trimestre_3 AS
SELECT * FROM ago
UNION ALL
SELECT * FROM sep
UNION ALL
SELECT * FROM oct;

CREATE TABLE analisis_trimestre_3 AS
SELECT * FROM AGO
UNION ALL
SELECT * FROM SEP
UNION ALL
SELECT * FROM OCT;

SELECT member_casual, AVG(ride_length_seconds) / 60 AS promedio_trimestral
FROM trimestre_3
GROUP BY member_casual;

SELECT 
    member_casual, 
    day_of_week, 
    AVG(ride_length_seconds) / 60 AS promedio_minutos,
    COUNT(*) AS cantidad_viajes
FROM analisis_trimestre_3
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week;
