package com.axelor.auth.db;

import com.axelor.db.Model;

import javax.persistence.*;

@Entity
@Table(name = "BASE_DEPARTMENT")
public class Department extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Long id;
    private Long region;
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

    public Long getRegion() {
        return region;
    }

    public void setRegion(Long region) {
        this.region = region;
    }

    @Override
    public String toString() {
        return "department:{" +
                    "id:" + id +
                    ", region:" + region +
                    ", name:'" + name + '\'' +
                '}';
    }
}
