const { test, expect } = require('@playwright/test');
const path = require('path');

test('default for all options', async ({ page }) => {
  // Sube dos niveles desde test/playwright/ para encontrar index.html
    await page.goto('/');

    await expect(page).toHaveTitle('Local Bulk Image Converter');

    // Apunta a una de tus imágenes reales en test/images/
    const imagePath = path.resolve(__dirname, '../images/movie.webp');

    // Sube el archivo al input
    await page.setInputFiles('#imageInput', imagePath);

    // El botón de conversión debería habilitarse
    const convertBtn = page.locator('#convertBtn');
    await expect(convertBtn).toBeEnabled();

    // Ejecuta la conversión
    await convertBtn.click();

    // Espera a que aparezca el botón para descargar el ZIP
    const downloadZipBtn = page.locator('#downloadZipBtn');
    await expect(downloadZipBtn).toBeVisible({ timeout: 15000 });
});
