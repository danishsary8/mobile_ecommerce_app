import 'package:flutter/cupertino.dart';

class SoundscapeTrack {
  final String id;
  final String title;
  final String location;
  final String description;
  final String duration;
  final IconData icon;

  const SoundscapeTrack({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.duration,
    required this.icon,
  });

  static const List<SoundscapeTrack> defaultTracks = [
    SoundscapeTrack(
      id: 'rain_silk',
      title: 'Place Vendôme Rain & Silk Rustle',
      location: '1er Arrondissement, Paris',
      description: 'Gentle autumn rain on zinc Parisian rooftops, shears slicing through Mulberry silk on oak cutting tables.',
      duration: '42:10 Ambient Loop',
      icon: CupertinoIcons.cloud_rain_fill,
    ),
    SoundscapeTrack(
      id: 'catwalk_echo',
      title: 'Grand Palais Catwalk Reverberation',
      location: 'Haute Couture Runway, Paris',
      description: 'Sub-bass atmospheric synthesizer drones echoing beneath glass vaulted ceilings as models traverse the catwalk.',
      duration: '38:45 Runway Loop',
      icon: CupertinoIcons.waveform_path,
    ),
    SoundscapeTrack(
      id: 'biella_looms',
      title: 'Biella Wool Weaving Sanctuary',
      location: 'Lanificio di Tollegno, Northern Italy',
      description: 'Rhythmic wooden warp and weft shuttles spinning 520gsm double-faced melton wool in the alpine foothills.',
      duration: '50:00 Archive Loop',
      icon: CupertinoIcons.circle_grid_hex_fill,
    ),
  ];
}
