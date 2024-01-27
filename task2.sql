-- 1) Выведите все жанры книг, которые прочитал читатель с именем "Grace Taylor".
select distinct g.genre_name
from genres g
join bookgenres bg on bg.genre_id = g.genre_id
join books b on bg.book_id = b.book_id
join readerbooks rb on b.book_id = rb.book_id
join readers r on rb.reader_id = r.reader_id
where r.reader_name = 'Grace Taylor'
-- 2) Найдите авторов, написавших книги в жанре "Фантастика".

select distinct a.author_name
from authors a
join books b on a.author_id = b.author_id
join bookgenres bg on b.book_id = bg.book_id
join genres g on bg.genre_id = g.genre_id
where g.genre_name = 'Fantasy';
-- 3) Покажите книги, написанные авторами с именами "John Smith" и "Jane Doe".

select b.book_title
from books b
join authors a on b.author_id = a.author_id
where a.author_name in ('John Smith', 'Jane Doe')

-- 4) Выведите все книги, у которых нет жанра.

select b.book_title
from books b
join bookgenres bg on b.book_id = bg.book_id
where bg.genre_id is null

-- 5) Найдите читателей, которые прочитали книги хотя бы в двух разных жанрах.

select r.reader_name
from readers r
join readerbooks rb on r.reader_id = rb.reader_id
join books b on rb.book_id = b.book_id
join bookgenres bg on b.book_id = bg.book_id
join genres g on bg.genre_id = g.genre_id
group by r.reader_name
having count(distinct g.genre_id) >= 2

-- 6) Покажите авторов, чьи книги не были прочитаны.

select distinct a.author_name
from authors a
left join books b on a.author_id = b.author_id
left join readerbooks rb on b.book_id = rb.book_id
where rb.reader_id is null

-- 7) Выведите читателей, прочитавших книги только в жанре "Фэнтези".
select r.reader_name
from readers r
join readerbooks rb on r.reader_id = rb.reader_id
join books b on rb.book_id = b.book_id
join bookgenres bg on b.book_id = bg.book_id
join genres g on bg.genre_id = g.genre_id
where g.genre_name = 'Fantasy'
group by r.reader_name
having count(distinct g.genre_id) = 1;

-- 8) Найдите автора с наибольшим количеством книг в жанре "Детектив".


select a.author_name
from authors a
join books b on a.author_id = b.author_id
join bookgenres bg on b.book_id = bg.book_id
join genres g on bg.genre_id = g.genre_id
where g.genre_name = 'Mystery'
group by a.author_name
order by count(b.book_id) desc
limit 1;

-- 9) Покажите все книги, написанные в жанре "Научная фантастика", которые еще не прочитаны.

select b.book_title
from books b
join bookgenres bg on b.book_id = bg.book_id
join genres g on bg.genre_id = g.genre_id
left join readerbooks rb on b.book_id = rb.book_id
where g.genre_name = 'Science Fiction' and rb.reader_id is null

-- 10) Выведите все книги, которые прочитаны более чем одним читателем.
select b.book_title
from books b
join readerbooks rb on b.book_id = rb.book_id
group by b.book_title
having count(rb.reader_id) > 1