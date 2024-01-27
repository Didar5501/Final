-- 1) Обновите имя автора с именем "John Smith" на "John A. Smith"

update authors
set author_name = 'John A. Smith'
where author_name = 'John Smith'

-- 2) Удалите все книги в жанре "Мистика"

DELETE FROM readerbooks
WHERE book_id IN (
    SELECT b.book_id
    FROM books AS b
    JOIN bookgenres AS bg ON b.book_id = bg.book_id
    JOIN genres AS g ON bg.genre_id = g.genre_id
    WHERE g.genre_name = 'Mystery'
);

DELETE FROM books
WHERE book_id IN (
    SELECT b.book_id
    FROM books AS b
    LEFT JOIN bookgenres AS bg ON b.book_id = bg.book_id
    WHERE bg.book_id IS NULL
);

-- 3) Измените название книги с именем "The Great Adventure" на "The Amazing 
update books
set book_title = 'The Amazing Adventure'
where book_title = 'The Great Adventure';

-- 4) Удалите все записи из таблицы ReaderBooks, связанные с читателем с именем "Bob Smith"
delete from readerbooks
where reader_id in (
    select reader_id
    from readers
    where reader_name = 'Bob Smith'
);
-- 5) Обновите жанр книги "The Power of Now" на "Self-Help"
UPDATE BookGenres
SET genre_id = (
    SELECT genre_id
    FROM Genres
    WHERE genre_name = 'Self-Help'
)
WHERE book_id = (
    SELECT book_id
    FROM Books
    WHERE book_title = 'The Power of Now'
)

-- 6) Удалите автора с наименьшим количеством написанных книг

with authorbookcounts as (
    select a.author_id, count(b.book_id) as book_count
    from authors as a
    left join books as b on a.author_id = b.author_id
    group by a.author_id
)
delete from authors
where author_id = (
    select author_id
    from authorbookcounts
    order by book_count asc
    limit 1
);
-- 7) Обновите имя читателя с именем "Eva White" на "Eva Johnson"
update readers
set reader_name = 'Eva Johnson'
where reader_name = 'Eva White';
-- 8) Удалите все книги, написанные автором с именем "Christopher Wilson"
delete from books
where author_id = (
    select author_id
    from authors
    where author_name = 'Christopher Wilson'
);
-- 9) Измените жанр книги "Moonlight Sonata" на "Romance"
update bookgenres
set genre_id = (
    select genre_id
    from genres
    where genre_name = 'Romance'
)
where book_id = (
    select book_id
    from books
    where book_title = 'Moonlight Sonata'
);
-- 10) Удалите все записи из таблицы BookGenres, связанные с книгой с именем "To Kill a Mockingbird"
delete from bookgenres
where book_id = (
    select book_id
    from books
    where book_title = 'To Kill a Mockingbird'
);