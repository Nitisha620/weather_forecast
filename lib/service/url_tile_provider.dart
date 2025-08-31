import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class UrlTileProvider implements TileProvider {
  final int width;
  final int height;
  final String Function(int x, int y, int zoom) getTileUrl;

  UrlTileProvider(this.width, this.height, this.getTileUrl);

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    if (zoom == null) {
      // generate transparent tile
      return _emptyTile();
    }

    final url = getTileUrl(x, y, zoom);

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Tile(width, height, response.bodyBytes);
      }
    } catch (e) {
      print("Tile load error: $e");
    }

    // fallback to transparent tile
    return _emptyTile();
  }

  Future<Tile> _emptyTile() async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final paint = ui.Paint()..color = const ui.Color(0x00000000);
    canvas.drawRect(
      ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      paint,
    );
    final picture = recorder.endRecording();
    final img = await picture.toImage(width, height);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return Tile(width, height, byteData!.buffer.asUint8List());
  }
}
