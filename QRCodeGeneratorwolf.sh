#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' 


show_header() {
    clear
    echo -e "${BLUE}"
    echo "   QR CODE GENERATOR"
    echo "   Pembuat Kode QR Otomatis"
    echo -e "${NC}"
    echo "   Gunakan untuk teks, URL, atau kontak"
    echo ""
}


validate_input() {
    local input="$1"
    if [ -z "$input" ]; then
        echo -e "${RED}Error: Input tidak boleh kosong!${NC}"
        return 1
    fi
    return 0
}


generate_qrcode() {
    local text="$1"
    echo -e "${YELLOW}Membuat QR code...${NC}"
    echo ""
    
   
    curl -s "qrenco.de/$text"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}"
        echo "QR code berhasil dibuat!"
        echo -e "${NC}"
    else
        echo -e "${RED}Gagal membuat QR code. Periksa koneksi internet.${NC}"
    fi
}


show_examples() {
    echo -e "${YELLOW}Contoh penggunaan:${NC}"
    echo "  - URL: https://github.com"
    echo "  - Teks: Hello World"
    echo "  - WhatsApp: https://wa.me/628123456789"
    echo "  - Email: mailto:example@email.com"
    echo "  - WiFi: WIFI:S:SSID;T:WPA;P:password;;"
    echo ""
}


main() {
    show_header
    show_examples
    
   
    echo -e "${BLUE}Pilih tinput input:${NC}"
    echo "1. URL Website"
    echo "2. Teks Biasa"
    echo "3. Nomor WhatsApp"
    echo "4. Alamat Email"
    echo "5. WiFi Network"
    echo "6. Input Custom"
    echo ""
    
    read -p "Pilihan (1-6): " choice
    echo ""
    
    case $choice in
        1)
            read -p "Masukkan URL website: " url
            if [[ ! $url =~ ^https?:// ]]; then
                url="https://$url"
            fi
            generate_qrcode "$url"
            ;;
        2)
            read -p "Masukkan teks: " text
            generate_qrcode "$text"
            ;;
        3)
            read -p "Masukkan nomor WhatsApp (contoh: 628123456789): " number
            generate_qrcode "https://wa.me/$number"
            ;;
        4)
            read -p "Masukkan alamat email: " email
            generate_qrcode "mailto:$email"
            ;;
        5)
            read -p "Masukkan SSID WiFi: " ssid
            read -p "Masukkan password WiFi: " password
            read -p "Tipe enkripsi (WPA/WEP): " encryption
            generate_qrcode "WIFI:S:$ssid;T:$encryption;P:$password;;"
            ;;
        6)
            read -p "Masukkan custom text: " custom
            generate_qrcode "$custom"
            ;;
        *)
            echo -e "${RED}Pilihan tidak valid!${NC}"
            exit 1
            ;;
    esac
    
    
    echo -e "${BLUE}Informasi:${NC}"
    echo "Scan QR code di atas dengan aplikasi QR scanner"
    echo "QR code akan hilang ketika terminal ditutup"
    echo ""
}


main