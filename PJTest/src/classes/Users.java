package classes;

import java.util.ArrayList;
import java.util.Date;

public class Users {
    private int id;
    private String username;
    private String password;
    private String email;
    private Date date;

    private ArrayList<String> collections;
    private ArrayList<String> friends;
    private ArrayList<String> photos;
    public Users(){

    }
    public Users(int id,String username,String password,String email,Date date,
                 ArrayList<String> collections,ArrayList<String> friends,ArrayList<String> photos){
        this.id=id;
        this.username=username;
        this.password=password;
        this.email=email;
        this.date=date;
        this.collections=collections;
        this.friends=friends;
        this.photos=photos;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public ArrayList<String> getCollections() {
        return collections;
    }

    public void setCollections(ArrayList<String> collections) {
        this.collections = collections;
    }

    public ArrayList<String> getFriends() {
        return friends;
    }

    public void setFriends(ArrayList<String> friends) {
        this.friends = friends;
    }

    public ArrayList<String> getPhotos() {
        return photos;
    }

    public void setPhotos(ArrayList<String> photos) {
        this.photos = photos;
    }
}
