import models.Author;
import models.Book;

import java.util.AbstractMap;
import java.util.List;

import static util.DB.*;

public class Main {
    public static void main(String[] args) {
        List<Author> books = getEntitiesByProperties(Author.class, new AbstractMap.SimpleEntry<>("name","Фёдор"),
                new AbstractMap.SimpleEntry<>("surname","Достоевский"));
        for (Author author :
                books) {
            System.out.println(author);
        }
    }
}
