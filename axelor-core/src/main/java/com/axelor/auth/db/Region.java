package com.axelor.auth.db;

import com.axelor.db.Model;

import javax.persistence.*;

@Entity
@Table(name = "BASE_REGION")
public class Region extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Long id;
    private Long country;
    private String name;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getCountry() {
        return country;
    }

    public void setCountry(Long country) {
        this.country = country;
    }

    @Override
    public String toString() {
        return "region:{" +
                        "id:" + id +
                        ", country:" + country +
                        ", name:'" + name + '\'' +
                      '}';
    }
}
