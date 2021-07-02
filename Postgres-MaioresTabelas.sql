-- maiores tabelas postgres tamanho
SELECT relname, pg_size_pretty(relpages::bigint*8192) as "tamanho" from pg_class order by relpages DESC limit 10;
select relname, pg_size_pretty(relpages::bigint*8192) from pg_class order by pg_size_pretty desc;
select count (1) from pg_largeobject;
select * from pg_largeobject;
select pg_size_pretty(relpages::bigint*8192) from pg_class where relname like '%large%';
select * from pg_size_pretty;
select version();
select pg_database_size(NOMEBASEDEDADOS);
