package com.axelor.auth.db;

import com.axelor.db.Model;

import javax.persistence.*;

@Entity
@Table(name = "BASE_COUNTRY")
public class Country extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Long id;
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

    @Override
    public String toString() {
        return "country :{" +
                "id:" + id +
                ", name:'" + name + '\'' +
                '}';
    }
}
