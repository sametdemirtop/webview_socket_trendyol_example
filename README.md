#  Trendyol ve WebSocket Entegrasyonu

Bu Flutter projesi, Trendyol'un web sitesini bir web görünümü (web view) olarak gösteren ve belirtilen WebSocket bağlantısına bir istek gönderip gelen veriyi ürün sayfası olarak gösteren bir uygulamadır. Aşağıda, projenin yapısı ve kullanılan mimariler hakkında bilgiler bulunmaktadır.

## Proje Detayları
### 1. Sayfa - Trendyol Web View
Bu sayfada Trendyol sitesi, bir web görünümü (web view) şeklinde gösterilmektedir.

### 2. Sayfa - Ürün Sayfası
Bu sayfada, belirtilen WebSocket bağlantısına aşağıdaki gibi bir istek gönderilmekte ve gelen veri ürün sayfası olarak gösterilmektedir.

## Kullanılan Mimariler
*Stream Library: Proje içerisinde, anlık görüntülemeleri sağlamak için stream kullanılmıştır.

*BLoC Mimarisi: Proje, BLoC mimarisi kullanılarak geliştirilmiştir.

*Route Generator: Sayfa yönlendirmelerini yönetmek için onGenerateRoute özelliği kullanılmıştır.

## Kullanılan Paketler
 flutter_bloc: ^8.1.3

 webview_flutter: ^4.4.4

 web_socket_channel: ^2.4.3

 flutter_secure_storage: ^9.0.0

 flutter_svg: ^2.0.9

 http: ^1.1.2


## Projenin Çalıştırılması


https://github.com/sametdemirtop/webview_socket_trendyol_example/assets/86069575/932757fe-c1a1-4910-8f60-5142200f9b43








