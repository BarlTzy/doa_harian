import 'package:flutter/material.dart';
import 'package:aplikasi_doa/models/doa_model.dart';

class DoaListItem extends StatelessWidget {
  final Doa doa;
  final bool isFavorite;
  final VoidCallback onTap;

  const DoaListItem({
    Key? key,
    required this.doa,
    required this.isFavorite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade100,
        foregroundColor: const Color(0xFF2E8B57),
        child: Text(
          '${doa.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        doa.judul,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: isFavorite ? const Icon(Icons.star, color: Colors.amber) : null,
      onTap: onTap,
    );
  }
}
