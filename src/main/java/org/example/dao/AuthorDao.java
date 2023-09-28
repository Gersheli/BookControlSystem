package org.example.dao;

import org.example.models.Author;
import org.example.models.Model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class AuthorDao extends Dao {

    @Override
    public List<Model> index() throws SQLException {
        List<Model> list = new ArrayList<>();

        Statement statement = connection.createStatement();
        String SQL = "SELECT * FROM Author";
        ResultSet resultSet = statement.executeQuery(SQL);

        while (resultSet.next()) {
            Author author = new Author();
            author.setId(resultSet.getInt("id"));
            author.setName(resultSet.getString("name"));
            author.setSurname(resultSet.getString("surname"));
            author.setCountry(resultSet.getString("country"));
            list.add(author);
        }
        return list;
    }

    @Override
    public Model show(int id) throws SQLException {
        PreparedStatement preparedStatement =
                connection.prepareStatement("SELECT * FROM Author WHERE id=?");

        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();

        Author author = new Author();
        author.setId(resultSet.getInt("id"));
        author.setName(resultSet.getString("name"));
        author.setSurname(resultSet.getString("surname"));
        author.setCountry(resultSet.getString("country"));

        return author;
    }

    public Model show(String name, String surname) throws SQLException {
        PreparedStatement preparedStatement =
                connection.prepareStatement("SELECT * FROM Author WHERE name=? and surname=?");

        preparedStatement.setString(1, name);
        preparedStatement.setString(2, name);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();

        Author author = new Author();
        author.setId(resultSet.getInt("id"));
        author.setName(name);
        author.setSurname(surname);
        author.setCountry(resultSet.getString("country"));

        return author;
    }

    @Override
    public void save(Model model) throws SQLException {
        PreparedStatement preparedStatement =
                connection.prepareStatement("INSERT INTO Author VALUES (?, ?, ?)");

        Author author = (Author) model;
        preparedStatement.setString(1, author.getName());
        preparedStatement.setString(2, author.getSurname());
        preparedStatement.setString(3, author.getCountry());
    }

    @Override
    public void update(int id, Model updatedModel) throws SQLException {
        PreparedStatement preparedStatement =
                connection.prepareStatement("UPDATE Author SET name=?, surname=?, country=? WHERE id=?");

        Author updatedAuthor = (Author) updatedModel;
        preparedStatement.setString(1, updatedAuthor.getName());
        preparedStatement.setString(2, updatedAuthor.getSurname());
        preparedStatement.setString(3, updatedAuthor.getCountry());
        preparedStatement.setInt(4, id);
    }

    @Override
    public void delete(int id) throws SQLException {
        PreparedStatement preparedStatement =
                connection.prepareStatement("DELETE FROM Author WHERE id=?");

        preparedStatement.setInt(1, id);
    }
}
