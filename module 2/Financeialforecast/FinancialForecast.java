public class FinancialForecast {

    public static double predictFutureValue(double currentValue,
                                            double growthRate,
                                            int years) {

        // Base Case
        if (years == 0) {
            return currentValue;
        }

        // Recursive Case
        return predictFutureValue(
                currentValue * (1 + growthRate),
                growthRate,
                years - 1
        );
    }

    public static void main(String[] args) {

       

    double currentValue = 10000;
    double growthRate = 0.10;
    int years = 5;

    double futureValue =
            predictFutureValue(currentValue, growthRate, years);

    System.out.println("========================================");
    System.out.println("      FINANCIAL FORECASTING SYSTEM");
    System.out.println("========================================");

    System.out.printf("Current Investment Value : ₹%.2f%n",
            currentValue);
    System.out.printf("Annual Growth Rate       : %.2f%%%n",
            growthRate * 100);
    System.out.printf("Forecast Period          : %d Years%n",
            years);

    System.out.println("----------------------------------------");

    System.out.printf("Predicted Future Value   : ₹%.2f%n",
            futureValue);

    System.out.println("----------------------------------------");
    System.out.println("\nForecast generated successfully.");
}
}