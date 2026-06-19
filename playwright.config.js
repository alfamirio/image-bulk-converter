const { defineConfig, devices } = require('@playwright/test');

module.exports = defineConfig({
  // Directorio donde Playwright buscará los archivos de test
  testDir: './test/playwright',
  
  // Patrón para identificar los archivos de prueba
  testMatch: /.*\.spec\.js/,

  // Ejecución en paralelo si tienes múltiples archivos
  fullyParallel: false,
  retries: 0,
  workers: 1,

  // Reporter para la terminal
  reporter: 'list',

  use: {
    // URL base que mapeará con el page.goto('/') de tus tests
    baseURL: 'http://localhost:8080',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  /* Configuración del servidor web local incorporado */
  webServer: {
    command: 'npx http-server . -p 8080',
    url: 'http://localhost:8080',
    reuseExistingServer: !process.env.CI,
    timeout: 10 * 1000,
  },

  // Probar con Chromium (suficiente para validar los Web Workers de tu index.html)
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
});
