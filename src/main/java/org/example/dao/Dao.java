package org.example.dao;

import org.example.models.Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

public abstract class Dao {
    protected static final String URL = "jdbc:postgresql://localhost:5432/db_labi";
    protected static final String USERNAME = "postgres";
    protected static final String PASSWORD = "abrashaterc";

    protected static Connection connection;

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try {
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            System.out.println(e.getErrorCode());
            System.out.println(e.getMessage());

            throw new RuntimeException(e);
        }
    }

    public abstract List<Model> index() throws SQLException;

    public abstract Model show(int id) throws SQLException;

    public abstract void save(Model model) throws SQLException;

    public abstract void update(int id, Model updatedModel) throws SQLException;

    public abstract void delete(int id) throws SQLException;
}
