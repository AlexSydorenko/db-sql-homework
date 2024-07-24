# Movie App Database

## ER Diagram

```mermaid
erDiagram
    USER {
        int id
        string username
        string first_name
        string last_name
        string email
        string password
        int avatar_file_id
    }
    FILE {
        int id
        string file_name
        string mime_type
        string key
        string url
    }
    COUNTRY {
        int id
        string country_name
    }
    PERSON {
        int id
        string first_name
        string last_name
        string biography
        date date_of_birth
        enum gender_enum
        int country_id
        int primary_photo_file_id
    }
    MOVIE {
        int id
        string title
        text description
        decimal budget
        date release_date
        int duration
        int director_id
        int country_id
        int poster_file_id
    }
    CHARACTER {
        int id
        string name
        text description
        enum role_enum
        int movie_id
        int person_id
    }
    GENRE {
        int id
        string genre_name
    }
    FAVORITEMOVIES {
        int user_id
        int movie_id
    }
    MOVIEGENRE {
        int movie_id
        int genre_id
    }
    PERSONPHOTO {
        int person_id
        int file_id
    }

    USER ||--o{ FILE : "has"
    COUNTRY ||--o{ PERSON : "has"
    PERSON ||--o{ FILE : "has"
    MOVIE ||--o{ FILE : "has"
    MOVIE ||--o{ COUNTRY : "is produced in"
    MOVIE ||--o{ PERSON : "is directed by"
    CHARACTER ||--o{ MOVIE : "belongs to"
    CHARACTER ||--o{ PERSON : "is played by"
    PERSONPHOTO ||--o{ PERSON : "belongs to"
    PERSONPHOTO ||--o{ FILE : "contains"
    FAVORITEMOVIES ||--o{ USER : "is added by"
    FAVORITEMOVIES ||--o{ MOVIE : "contains"
    MOVIEGENRE ||--o{ MOVIE : "belongs to"
    MOVIEGENRE ||--o{ GENRE : "contains"
