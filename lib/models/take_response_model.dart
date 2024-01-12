class TokenResponse {
  String refresh;
  String access;

  TokenResponse({required this.refresh, required this.access});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      refresh: json['refresh'],
      access: json['access'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh': refresh,
      'access': access,
    };
  }
}