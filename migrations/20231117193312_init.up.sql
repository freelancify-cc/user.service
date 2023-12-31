-- Add up migration script here
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE 
    IF NOT EXISTS UserRoles (
        id SERIAL PRIMARY KEY NOT NULL,
        role_name VARCHAR(12) NOT NULL
    );

CREATE TABLE 
    IF NOT EXISTS Users (
        id UUID PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
        email VARCHAR(30) UNIQUE NOT NULL,
        password VARCHAR NOT NULL,
        user_role_id INT NOT NULL,
        CONSTRAINT fk_user_role FOREIGN KEY (user_role_id) REFERENCES UserRoles(id),
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP 
    );

CREATE TABLE 
    IF NOT EXISTS UserProfiles (
        id UUID PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
        first_name VARCHAR(20) NOT NULL,
        second_name VARCHAR(20) NOT NULL,
        date_of_birth VARCHAR(30) NOT NULL,
        username VARCHAR(10) NOT NULL,
        profile_picture_url VARCHAR NOT NULL,
        user_id UUID NOT NULL,
        CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES Users(id),
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP 
    );

CREATE TABLE 
    IF NOT EXISTS UserContactInformation (
        id UUID PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
        contact VARCHAR(10) NOT NULL,
        user_profile_id UUID NOT NULL,
        CONSTRAINT fk_user_profile FOREIGN KEY (user_profile_id) REFERENCES UserProfiles(id),
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP
    );

CREATE TABLE 
    if NOT EXISTS UserBankingInformation (
        id UUID PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
        bank VARCHAR(20) NOT NULL,
        account VARCHAR NOT NULL,
        user_profile_id UUID NOT NULL,
        CONSTRAINT fk_user_profile FOREIGN KEY (user_profile_id) REFERENCES UserProfiles(id),
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP
    );


INSERT INTO UserRoles ( role_name ) VALUES ('freelancer');
INSERT INTO UserRoles ( role_name ) VALUES ('employer');
