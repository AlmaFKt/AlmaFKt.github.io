import 'package:argamasa_mamposteria/Content/pdf/mamposteriaPDF.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Question {
  final String text;
  final List<Option> options;

  Question(this.text, this.options);
}

class Option {
  final String text;
  final int value;

  Option(this.text, this.value);
}

class Topic {
  final String name;
  final List<Question> questions;

  Topic(this.name, this.questions);
}

class MamposteriaPage extends StatefulWidget {
  const MamposteriaPage({super.key});

  @override
  State<MamposteriaPage> createState() => _MamposteriaPageState();
}

class _MamposteriaPageState extends State<MamposteriaPage> {
  final List<Topic> topics = [
    Topic('CONSTRUCTIVO', [
      Question('1', [
        Option(
            'El espesor de la mayoría de las juntas es más o menos de un centímetro',
            1),
        Option(
            'Las juntas son uniformes y rellenas de mezcla, rodeando cada tabique',
            1),
        Option(
            'El mortero o mezcla es de buena calidad y presenta adherencia con la pieza de mampostería.',
            1),
      ]),
      Question('2', [
        Option(
            'El espesor de la mayoría de las juntas es mayor a 1.5 cm o menor de 0.5 cm.',
            2),
        Option('Las juntas no son uniformes', 2),
        Option('No existen juntas verticales o son de mala calidad', 2),
      ]),
      Question('4', [
        Option('La junta es muy pobre entre los tabiques.', 4),
        Option(
            'El mortero o mezcla es de muy mala calidad o es claramente visible la separación con la pieza de mampostería o tabique.',
            4),
        Option(
            'No existen juntas verticales y/u horizontales en algunas zonas del muro.',
            4),
      ]),
    ]),
    Topic('IRREGULARIDAD DE ALTURA', [
      Question('1', [
        Option(
            'La mayoría de los muros estructurales son continuosdesde la cimentación hasta la cubierta.',
            1),
      ]),
      Question('2', [
        Option(
            'Menos de la mitad de los muros de carga y/o columnas de la vivienda presentan discontinuidades desde la cimentación hasta la cubierta o azotea',
            2),
      ]),
      Question('4', [
        Option(
            'Más de la mitad de los muros de carga y/o columnas de la vivienda presentan discontinuidades desde la cimentación hasta la cubierta o azotea.',
            4),
        Option(
            'Las discontinuidades pueden ser tanta eliminación en los niveles inferiores o cambio de un sistema de muros en los sistemas superiores o columnas en el primer nivel o variación en las alturas',
            4),
      ]),
    ]),
    Topic('CANTIDAD DE MUROS EN DOS DIRECCIONES', [
      Question('1', [
        Option(
            'Existen muros de carga en las dos direcciones de la vivienda.', 1),
        Option(
            'La longitud total de muros en las dos direcciones principales de la edificación (x,y) representativa de la cantidad de muros de la edificación es grande.',
            1),
      ]),
      Question('2', [
        Option(
            'La mayoría de los muros se concentran en una sola dirección, aunque existen unos o varios en la otra dirección',
            2),
        Option(
            'La longitud de los muros en la dirección de menor cantidad de ellos es notablemente inferior a la otra dirección.',
            2),
      ]),
      Question('4', [
        Option(
            'Más del 70% de los muros están en una sola dirección y muy pocos muros confinados o reforzados dejando una dirección débil',
            4),
        Option(
            'La longitud total de muros estructurales en cualquier dirección es muy pobre.',
            4),
      ]),
    ]),
  ];

  Map<String, Option?> scores = {};
  int totalScore = 0;

  void _calculateTotalScore() {
    totalScore = scores.values
        .whereType<Option>()
        .fold(0, (sum, option) => sum + option.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildWideLayout();
            } else {
              return _buildNarrowLayout();
            }
          },
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 16),
          ...topics.map((topic) => _buildTopicWide(topic)),
          SizedBox(height: 16),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildTopicWide(Topic topic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topic.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 251, 227, 156),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                spreadRadius: 1,
                offset: Offset(0, 0.5),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: topic.questions
                  .map((question) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildQuestionWide(topic.name, question),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildQuestionWide(String topicName, Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...question.options
            .map((option) => _buildOptionWidget(topicName, option)),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 16),
          ...topics.map((topic) => _buildTopicNarrow(topic)),
          SizedBox(height: 16),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildTopicNarrow(Topic topic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topic.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 251, 227, 156),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                spreadRadius: 1,
                offset: Offset(0, 0.5),
              ),
            ],
          ),
          child: Column(
            children: topic.questions
                .map((question) => _buildQuestionNarrow(topic.name, question))
                .toList(),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildQuestionNarrow(String topicName, Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...question.options
            .map((option) => _buildOptionWidget(topicName, option)),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildOptionWidget(String topicName, Option option) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<Option>(
          value: option,
          groupValue: scores[topicName],
          onChanged: (newValue) {
            setState(() {
              scores[topicName] = newValue;
            });
          },
        ),
        Flexible(child: Text(option.text)),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 251, 243, 203),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Mampostería',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      child: Text(
        'Resultados',
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        _calculateTotalScore();
        Get.to(Mamposteriapdf(totalScore: totalScore));
      },
    );
  }
}
