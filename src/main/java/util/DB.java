package util;

import models.Book;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.util.*;

public class DB {
    private static final JdbcTemplate jdbcTemplate;

    static {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl("jdbc:postgresql://localhost:5432/db_labi");
        dataSource.setUsername("postgres");
        dataSource.setPassword("abrashaterc");
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public static <T> List<T> getAllEntities(Class<T> entityClass) {
        String tableName = entityClass.getSimpleName();
        String query = "SELECT * FROM " + tableName;
        return jdbcTemplate.query(query, new BeanPropertyRowMapper<>(entityClass));
    }

    public static <T> T getEntityById(Class<T> entityClass, int id) {
        String tableName = entityClass.getSimpleName();
        String query = "SELECT * FROM " + tableName + " WHERE id=?";
        return jdbcTemplate.query(query, new Object[]{id}, new BeanPropertyRowMapper<>(entityClass))
                .stream().findAny().orElse(null);
    }

    public static <T> List<T> getEntitiesByProperty(Class<T> entityClass, String name, Object property) {
        String tableName = entityClass.getSimpleName();
        String query = "SELECT * FROM " + tableName + " WHERE " + name + "=?";
        return jdbcTemplate.query(query, new Object[]{property}, new BeanPropertyRowMapper<>(entityClass));
    }

    @SafeVarargs
    public static <T> List<T> getEntitiesByProperties(Class<T> entityClass, Map.Entry<String, Object>... nameValue) {
        String tableName = entityClass.getSimpleName();
        StringBuilder query = new StringBuilder("SELECT * FROM " + tableName + " WHERE ");

        List<Map.Entry<String, Object>> argList = Arrays.asList(nameValue);
        Iterator<Map.Entry<String, Object>> iterator = argList.listIterator();
        List<Object> values = new ArrayList<>();
        while (iterator.hasNext()) {
            Map.Entry<String, Object> arg = iterator.next();
            query.append(arg.getKey());
            query.append("=?");
            if (iterator.hasNext()) {
                query.append(" AND ");
            }
            values.add(arg.getValue());
        }
        return jdbcTemplate.query(query.toString(), values.toArray(), new BeanPropertyRowMapper<>(entityClass));
    }
}
