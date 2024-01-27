-- 1) Выведите все имена авторов из таблицы Authors.
Select author_name from authors

-- 2) Покажите названия всех книг и соответствующих им авторов.
select b.book_title, a.author_name from Books b
join Authors a on b.author_id = a.author_id

-- 3) Найдите все книги в жанре "Фэнтези" из таблицы Genres.
select b.book_title from Books b 
join BookGenres bg on bg.book_id =b.book_id
join Genres g on g.genre_id = bg.genre_id
where g.genre_name like 'Fantasy'

-- 4) Выведите имена всех читателей из таблицы Readers.
select reader_name from Readers r

 -- 5) Покажите все книги, которые прочитал читатель с именем "Alice Johnson".
 select book_title from Readers r 
 join ReaderBooks rb on rb.reader_id = r.reader_id 
 join books b on b.book_id=rb.book_id
 where r.reader_name like  'Alice Johnson'

-- 6) Найдите всех авторов, написавших хотя бы две книги.
select a.author_name
from Authors a
join Books b on a.author_id = b.author_id
group by a.author_name
having count(b.book_id) >= 2
-- 7) Выведите жанры всех книг с их количеством в базе данных.
select g.genre_name, count(b.book_id) from Genres g
 join BookGenres bg on bg.genre_id= g.genre_id
 join Books b on b.book_id = bg.book_id
group by g.genre_name

-- 8) Покажите все книги, написанные автором с именем "Jane Doe"
select b.book_title
from Books b
join Authors a on b.author_id = a.author_id
where a.author_name = 'Jane Doe'
-- 9) Найдите читателя, который прочитал наибольшее количество книг.
select r.reader_name, count(rb.book_id) book_count
from Readers r
join ReaderBooks rb on r.reader_id = rb.reader_id
group by r.reader_name
order by book_count desc
limit 1
-- 10) Выведите имена авторов и количество книг, написанных каждым из них.
select a.author_name, count(b.book_id) as book_count
from Authors a
join Books b on a.author_id = b.author_id
group by a.author_name
-- 11) Найдите все книги в жанре "Научная фантастика", написанные автором с именем "Michael Johnson".
select b.book_title
from Books b
join BookGenres bg on b.book_id = bg.book_id
join Genres g on bg.genre_id = g.genre_id
join Authors a on b.author_id = a.author_id
where g.genre_name = 'Science Fiction' and a.author_name = 'Michael Johnson'
-- 12) Покажите все книги, которые не были прочитаны ни одним читателем.
select b.book_title
from Books b
join ReaderBooks rb on b.book_id = rb.book_id
where rb.reader_id is null
-- 13) Выведите читателей, которые прочитали книги в жанре "Мистика".
select r.reader_name
from Readers r
join ReaderBooks rb on r.reader_id = rb.reader_id
join Books b on rb.book_id = b.book_id
join BookGenres bg on b.book_id = bg.book_id
join Genres g on bg.genre_id = g.genre_id
where g.genre_name = 'Mystery'
-- 14) Найдите все книги, написанные автором с именем "Daniel Miller" и прочитанные читателем с именем "Bob Smith".
select b.book_title
from Books b
join Authors a on b.author_id = a.author_id
join ReaderBooks rb on b.book_id = rb.book_id
join Readers r on rb.reader_id = r.reader_id
where a.author_name = 'Daniel Miller' and r.reader_name = 'Bob Smith'

-- 15) Покажите читателя, который прочитал наименьшее количество книг.

select r.reader_name, COUNT(rb.book_id) as book_count
from Readers r
join ReaderBooks rb on r.reader_id = rb.reader_id
group by r.reader_name
order by book_count
limit 1


