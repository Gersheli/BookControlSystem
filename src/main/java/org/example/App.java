package org.example;

import org.example.dao.AuthorDao;
import org.example.models.Model;

import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

public class App {
    public static void main(String[] args) {
        AuthorDao authorDao = new AuthorDao();
        try (Scanner scanner = new Scanner(System.in)) {
            while (true) {
                System.out.println("1 - exit");
                System.out.println("2 - print all authors");
                System.out.println("3 - print author by id");
                System.out.println("4 - print author by name and surname");

                switch (scanner.nextInt()) {
                    case 1: {
                        return;
                    }
                    case 2: {
                        List<Model> authorsList = authorDao.index();
                        authorsList.forEach(System.out::println);
                        System.out.println();
                        break;
                    }
                    case 3: {
                        Model author = authorDao.show(scanner.nextInt());
                        System.out.println(author);
                        System.out.println();
                        break;
                    }
                    case 4: {
                        scanner.nextLine();
                        String[] name_surname = scanner.nextLine().split(" ", 2);
                        Model author = authorDao.show(name_surname[0], name_surname[1]);
                        System.out.println(author);
                        System.out.println();
                        break;
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
