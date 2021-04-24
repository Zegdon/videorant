package hu.university.videorant;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.web.filter.OncePerRequestFilter;

@SpringBootApplication
@EnableCaching
@EnableScheduling
public class WebApplicationConfiguration extends WebSecurityConfigurerAdapter {

    // Allows authentication through the /auth endpoint using GET requests
    // exclusively.
    @Configuration
    @EnableWebSecurity
    @EnableGlobalMethodSecurity(securedEnabled = true)
    @Order(1)
    public static class AuthConfig extends WebSecurityConfigurerAdapter {

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()).and()
                    .antMatcher("/auth/login*")
                    .authorizeRequests()
                    .antMatchers(HttpMethod.GET)
                    .authenticated()
                    .and()
                    .httpBasic()
                    .authenticationEntryPoint((request, response, authException) -> response.sendError(HttpServletResponse.SC_FORBIDDEN, authException.getMessage()));
        }

        @Override
        public void configure(WebSecurity web) throws Exception {
            web.ignoring().antMatchers("/auth/getUserNames", "/auth/resetPasswordByUserNameAndEmail", "/version/**", "/", "/*.*", "/assets/**");
        }
    }

    // Only allows access with an already authenticated session.
    @Configuration
    @Order(2)
    public static class ApiConfig extends WebSecurityConfigurerAdapter {

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse());
            // CSRF
            // https://stackoverflow.com/questions/27457442/how-to-configure-spring-security-to-send-x-csrf-token
            // https://stackoverflow.com/questions/38108357/how-to-enable-post-put-and-delete-methods-in-spring-security
            http.addFilterAfter(new OncePerRequestFilter() {
                @Override
                protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                                FilterChain filterChain) throws ServletException, IOException {
                    CsrfToken csrf = (CsrfToken) request.getAttribute(CsrfToken.class.getName());
                    if (csrf != null) {
                        Cookie cookie = new Cookie("XSRF-TOKEN", csrf.getToken());
                        cookie.setPath("/");
                        response.addCookie(cookie);
                    }
                    filterChain.doFilter(request, response);
                }
            }, CsrfFilter.class);
            http.authorizeRequests().anyRequest().authenticated();
        }
    }

    // Official way to expose the AuthenticationManager as a bean.
    // https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-2.0-Migration-Guide#authenticationmanager-bean
    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    UserDetailsManager userDetailsManager(@Autowired DataSource dataSource, @Autowired JdbcTemplate jdbcTemplate,
                                          @Autowired AuthenticationManager authenticationManager) {
        JdbcUserDetailsManager userDetailsManager = new JdbcUserDetailsManager();
        userDetailsManager.setJdbcTemplate(jdbcTemplate);
        userDetailsManager.setDataSource(dataSource);
        // Using AuthenticationManager re-authenticates the session on password change.
        userDetailsManager.setAuthenticationManager(authenticationManager);
        return userDetailsManager;
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}
