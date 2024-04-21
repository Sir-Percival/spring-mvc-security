package org.example.springmvcsecurity.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import javax.sql.DataSource;

@Configuration
public class SecurityConfig
{
    @Bean
    public UserDetailsManager userDetailsManager(DataSource dataSource)
    {
        // Use default database schema
        // return new JdbcUserDetailsManager(dataSource);

        // Use custom database schema
        JdbcUserDetailsManager detailsManager = new JdbcUserDetailsManager(dataSource);

        detailsManager.setUsersByUsernameQuery("SELECT user_custom_name, pass, active FROM members WHERE user_custom_name=?");

        detailsManager.setAuthoritiesByUsernameQuery("SELECT user_custom_name, role FROM roles WHERE user_custom_name=?");

        return detailsManager;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity security) throws Exception
    {
        security.authorizeHttpRequests(customizer ->
                        customizer
                                .requestMatchers("css/**").permitAll()
                                .requestMatchers("images/**").permitAll()
                                .requestMatchers("/").permitAll()
                                .requestMatchers("/employees/**").hasRole("EMPLOYEE")
                                .requestMatchers("/leaders/**").hasRole("MANAGER")
                                .requestMatchers("/systems/**").hasRole("ADMIN")
                                .anyRequest().authenticated()
                )
                .formLogin(form ->
                        form
                                .loginPage("/showLoginPage")
                                .loginProcessingUrl("/authenticateTheUser")
                                .permitAll()
                )
                .logout(customizer -> customizer
                        .permitAll()
                        .logoutSuccessUrl("/")
                )
                .exceptionHandling(customizer ->
                        customizer.accessDeniedPage("/access-denied"));

        return security.build();
    }

    /*
    @Bean
    public InMemoryUserDetailsManager userDetailsManager()
    {
        UserDetails john = User.builder()
                .username("john")
                .password("{noop}test123")
                .roles("EMPLOYEE")
                .build();

        UserDetails mary = User.builder()
                .username("mary")
                .password("{noop}test123")
                .roles("EMPLOYEE", "MANAGER")
                .build();

        UserDetails susan = User.builder()
                .username("susan")
                .password("{noop}test123")
                .roles("EMPLOYEE", "MANAGER", "ADMIN")
                .build();

        return new InMemoryUserDetailsManager(john, mary, susan);
    }
    */
}
