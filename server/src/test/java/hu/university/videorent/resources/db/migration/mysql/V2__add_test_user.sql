INSERT INTO users (username, password, enabled) VALUES ('admin', '$2a$10$2Gi3G9XaKalERoIa74OYruEHZyqSUqn10uSiOzk4PvOgL49vejna.', true);
INSERT INTO authorities (username, authority) VALUES ('admin', 'ROLE_ADMIN');

INSERT INTO users (username, password, enabled) VALUES ('user', '$2y$12$eX731ZU7bI7O3bnizjX6ouDh6KQZm8yvAnhLpuKV63IHo2LTslI3W', true);
INSERT INTO authorities (username, authority) VALUES ('user', 'ROLE_USER');