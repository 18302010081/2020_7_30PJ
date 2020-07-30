package classes;

import java.util.Date;

public class Photos {
    private int id;
    private String uploader;
    private String topic;
    private String label;
    private String introduction;
    private int heat;
    private String country;
    private String city;
    private Date date;

    public Photos(){

    }
    public Photos(int id,String uploader,String topic,String label,
                  String introduction,int heat,String country,String city,Date date){
        this.id=id;
        this.uploader=uploader;
        this.topic=topic;
        this.label=label;
        this.introduction=introduction;
        this.heat=heat;
        this.country=country;
        this.city=city;
        this.date=date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUploader() {
        return uploader;
    }

    public void setUploader(String uploader) {
        this.uploader = uploader;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public int getHeat() {
        return heat;
    }

    public void setHeat(int heat) {
        this.heat = heat;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
