package models;

public class Book {
    private int id;
    private int authorId;
    private Integer genreId;
    private String title;
    private String series;

    public Book() {
    }

    public Book(int id, int authorId, int genreId, String title, String series) {
        this.id = id;
        this.authorId = authorId;
        this.genreId = genreId;
        this.title = title;
        this.series = series;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public Integer getGenreId() {
        return genreId;
    }

    public void setGenreId(Integer genreId) {
        this.genreId = genreId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSeries() {
        return series;
    }

    public void setSeries(String series) {
        this.series = series;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", authorId=" + authorId +
                ", genreId=" + genreId +
                ", title='" + title + '\'' +
                ", series='" + series + '\'' +
                '}';
    }
}
