import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  bool isJustifying = false;
  TextEditingController justificationController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialisation de l'animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Durée de l'animation
      vsync: this, // Fournit un ticker
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    // Libération de l'AnimationController pour éviter les fuites
    _animationController.dispose();
    justificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Détails de l\'Absence',
          style: TextStyle(
            fontSize: 18, // Augmentation de la taille
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.white, size: 26),
            onPressed: () {
              // Action for contacting the school
            },
            tooltip: 'Appeler l\'école',
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 26),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text("Modifier l'absence"),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text("Supprimer l'absence"),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text("Ajouter une note"),
              ),
              const PopupMenuItem(
                value: 4,
                child: Text("Partager les détails"),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35, // Augmentation de la taille de l'avatar
                  backgroundColor: Colors.blue[100],
                  child: const Icon(
                    Icons.person,
                    size: 50, // Augmentation de la taille de l'icône
                    color: Color.fromARGB(255, 9, 60, 171),
                  ),
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2287382',
                      style: TextStyle(
                        fontSize: 16, // Augmentation de la taille
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      'Kaoutar BENNOUR',
                      style: TextStyle(
                        fontSize: 20, // Augmentation de la taille
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    Text(
                      '2ème Année - Lycée',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16, // Augmentation de la taille
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            buildDetailRow(Icons.calendar_today_outlined, 'Date de l\'Absence',
                '10 Janvier 2025'),
            const SizedBox(height: 10),
            buildDetailRow(
                Icons.access_time_outlined, 'Horaire Précis', '10h30 - 12h30'),
            const SizedBox(height: 10),
            buildDetailRow(Icons.book_outlined, 'Matière', 'Mathématiques'),
            const SizedBox(height: 10),
            buildDetailRow(
                Icons.person_outline, 'Enseignant', 'Mr. IDRISSI Mohammad'),
            const Spacer(),
            isJustifying
                ? FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: justificationController,
                            cursorColor: Colors.blue[700],
                            decoration: InputDecoration(
                              hintText: 'Justification',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.attach_file_outlined,
                              color: Colors.blue[700], size: 26),
                          onPressed: () async {
                            // Simulate file attachment
                            FilePickerResult? result = await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;
                              print('File attached: ${file.name}');
                              
                              // Display a Toast message
                              Fluttertoast.showToast(
                                msg: "Fichier attaché: ${file.name}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.blue[700],
                                textColor: Colors.white,
                                fontSize: 16.0
                              );
                            } else {
                              // User canceled the picker
                              Fluttertoast.showToast(
                                msg: "Aucun fichier sélectionné",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.send,
                              color: Colors.blue[700], size: 26),
                          onPressed: () {
                            // Action pour envoyer la justification
                            print('Justification envoyée : ${justificationController.text}');
    
                            // Display a Toast message
                            Fluttertoast.showToast(
                              msg: "Justification envoyée",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: const Color.fromARGB(255, 138, 193, 249),
                              textColor: Colors.white,
                              fontSize: 16.0
                            );

                            // Clear the input field
                            justificationController.clear();
                            // Show the initial button 
                            setState(() {
                              isJustifying = false;
                              _animationController.reverse();
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isJustifying = true;
                        _animationController.forward();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Justifier l\'Absence',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 26),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 26),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 26),
            label: 'Compte',
          ),
        ],
        currentIndex: 1, // Highlight "Historique"
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: const Color.fromARGB(255, 126, 126, 126),
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blueGrey.shade700, size: 24), // Taille augmentée
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.blueGrey.shade700,
                fontSize: 18, // Taille augmentée
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16, // Taille augmentée
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
