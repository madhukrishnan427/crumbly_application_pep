import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);

  final List<Map<String, dynamic>> feedbackList = [
    {
      'name': 'Ananya',
      'message': 'The chocolate cake was delicious!',
      'rating': 5,
    },
    {
      'name': 'Priya',
      'message': 'Beautiful cupcakes and lovely packaging.',
      'rating': 4,
    },
    {
      'name': 'Rahul',
      'message': 'The cake was fresh and delivered on time.',
      'rating': 5,
    },
  ];

  void _addFeedback() {
    final nameController = TextEditingController();
    final messageController = TextEditingController();
    int rating = 5;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Feedback'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Customer name',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: messageController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Feedback',
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Rating'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setDialogState(() {
                              rating = index + 1;
                            });
                          },
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final message = messageController.text.trim();

                    if (name.isEmpty || message.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a name and feedback.'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      feedbackList.insert(0, {
                        'name': name,
                        'message': message,
                        'rating': rating,
                      });
                    });

                    Navigator.pop(dialogContext);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: coral,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      nameController.dispose();
      messageController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Customer Feedback'),
        backgroundColor: cream,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addFeedback,
        backgroundColor: coral,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Feedback'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'What customers say',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${feedbackList.length} feedback entries',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 16),
              if (feedbackList.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text('No feedback entries yet.'),
                  ),
                ),
              ...feedbackList.map((feedback) {
                final rating = feedback['rating'] as int;

                return Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(color: Color(0xFFF3E4DE)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0xFFFFE4DA),
                              child: Icon(
                                Icons.person_outline,
                                color: coral,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feedback['name'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              tooltip: 'Delete feedback',
                              onPressed: () {
                                setState(() {
                                  feedbackList.remove(feedback);
                                });
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(
                            5,
                                (index) => Icon(
                              index < rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 19,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(feedback['message'] as String),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}