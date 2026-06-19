import { test, expect } from '@playwright/test';
import path from 'path';
import fs from 'fs';

test.describe('default webp to', () => {

    test.beforeEach(async ({ page }) => {
        await page.goto('/'); 
    });

    test('webp', async ({ page }) => {
        await expect(page).toHaveTitle('Local Bulk Image Converter');
        await page.selectOption('#formatSelect', 'image/webp');

        // Apunta a una de tus imágenes reales en test/images/. Sube el archivo al input
        const imagePath = path.resolve(__dirname, '../images/movie.webp');
        await page.setInputFiles('#imageInput', imagePath);

        // El botón de conversión debería habilitarse. Ejecuta la conversión
        const convertBtn = page.locator('#convertBtn');
        await expect(convertBtn).toBeEnabled();
        await convertBtn.click();

        // Espera a que aparezca el botón para descargar el ZIP
        const downloadZipBtn = page.locator('#downloadZipBtn');
        await expect(downloadZipBtn).toBeVisible({ timeout: 15000 });
    });

    test('avif', async ({ page }) => {
        await expect(page).toHaveTitle('Local Bulk Image Converter');
        await page.selectOption('#formatSelect', 'image/avif');

        // Apunta a una de tus imágenes reales en test/images/. Sube el archivo al input
        const imagePath = path.resolve(__dirname, '../images/movie.webp');
        await page.setInputFiles('#imageInput', imagePath);

        // El botón de conversión debería habilitarse. Ejecuta la conversión
        const convertBtn = page.locator('#convertBtn');
        await expect(convertBtn).toBeEnabled();
        await convertBtn.click();

        // Espera a que aparezca el botón para descargar el ZIP
        const downloadZipBtn = page.locator('#downloadZipBtn');
        await expect(downloadZipBtn).toBeVisible({ timeout: 15000 });
    });
    
    test('mozjpg', async ({ page }) => {
        await expect(page).toHaveTitle('Local Bulk Image Converter');
        await page.selectOption('#formatSelect', 'image/mozjpeg');

        // Apunta a una de tus imágenes reales en test/images/. Sube el archivo al input
        const imagePath = path.resolve(__dirname, '../images/movie.webp');
        await page.setInputFiles('#imageInput', imagePath);

        // El botón de conversión debería habilitarse. Ejecuta la conversión
        const convertBtn = page.locator('#convertBtn');
        await expect(convertBtn).toBeEnabled();
        await convertBtn.click();

        // Espera a que aparezca el botón para descargar el ZIP
        const downloadZipBtn = page.locator('#downloadZipBtn');
        await expect(downloadZipBtn).toBeVisible({ timeout: 15000 });
    });
    
    test('jpg', async ({ page }) => {
        await expect(page).toHaveTitle('Local Bulk Image Converter');
        await page.selectOption('#formatSelect', 'image/jpeg');

        // Apunta a una de tus imágenes reales en test/images/. Sube el archivo al input
        const imagePath = path.resolve(__dirname, '../images/movie.webp');
        await page.setInputFiles('#imageInput', imagePath);

        // El botón de conversión debería habilitarse. Ejecuta la conversión
        const convertBtn = page.locator('#convertBtn');
        await expect(convertBtn).toBeEnabled();
        await convertBtn.click();

        // Espera a que aparezca el botón para descargar el ZIP
        const downloadZipBtn = page.locator('#downloadZipBtn');
        await expect(downloadZipBtn).toBeVisible({ timeout: 15000 });
    });
    
    test('png', async ({ page }) => {
        await expect(page).toHaveTitle('Local Bulk Image Converter');
        await page.selectOption('#formatSelect', 'image/png');

        // Apunta a una de tus imágenes reales en test/images/. Sube el archivo al input
        const imagePath = path.resolve(__dirname, '../images/movie.webp');
        await page.setInputFiles('#imageInput', imagePath);

        // El botón de conversión debería habilitarse. Ejecuta la conversión
        const convertBtn = page.locator('#convertBtn');
        await expect(convertBtn).toBeEnabled();
        await convertBtn.click();

        // Espera a que aparezca el botón para descargar el ZIP
        const downloadZipBtn = page.locator('#downloadZipBtn');
        await expect(downloadZipBtn).toBeVisible({ timeout: 15000 });
    });
    
});
