package com.cognizant;

import org.junit.jupiter.api.AfterEach;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class AAATest {

    private int number;

    @BeforeEach
    public void setUp() {
        System.out.println("Setting up test...");
        number = 10;
    }

    @Test
    public void testAddition() {

        // Arrange
        int a = number;
        int b = 5;

        // Act
        int result = a + b;

        // Assert
        assertEquals(15, result);
    }

    @AfterEach
    public void tearDown() {
        System.out.println("Cleaning up after test...");
    }
}