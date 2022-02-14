import winim


var contrast: HIGHCONTRASTA
contrast.cbSize = (int32)sizeof(HIGHCONTRASTA)

SystemParametersInfoA(SPI_GETHIGHCONTRAST, (int32)sizeof(HIGHCONTRASTA), &contrast, 0)

contrast.dwFlags = contrast.dwFlags xor HCF_HIGHCONTRASTON

SystemParametersInfoA(SPI_SETHIGHCONTRAST, (int32)sizeof(HIGHCONTRASTA), &contrast, 0)