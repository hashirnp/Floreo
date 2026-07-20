abstract class QuizData {
  static const Map<String, dynamic> sampleQuizJson = {
    'id': 'aptitude_quiz_01',
    'title': 'General Aptitude & Logical Reasoning Assessment',
    'questions': [
      {
        'id': 1,
        'questionText':
            'A train passes a station platform in 36 seconds and a man standing on the platform in 20 seconds. If the speed of the train is 54 km/hr, what is the length of the platform?',
        'options': ['120 m', '240 m', '300 m', 'None of these'],
        'correctAnswerIndex': 1,
        'explanation':
            'Speed of train = 54 × (5/18) = 15 m/s.\nLength of train = Speed × time to pass man = 15 m/s × 20 s = 300 m.\nLet length of platform be L.\nTotal distance to cross platform = 300 + L.\nTime = (300 + L) / 15 = 36 s ⟹ 300 + L = 540 ⟹ L = 240 m.',
      },
      {
        'id': 2,
        'questionText':
            'The ratio of the current ages of Alex and Ben is 4:5. Eight years from now, the ratio of their ages will be 5:6. What is Alex\'s current age?',
        'options': ['24 years', '32 years', '40 years', '48 years'],
        'correctAnswerIndex': 1,
        'explanation':
            'Let Alex\'s age = 4x and Ben\'s age = 5x.\nAfter 8 years: (4x + 8) / (5x + 8) = 5 / 6.\nCross-multiplying: 6(4x + 8) = 5(5x + 8) ⟹ 24x + 48 = 25x + 40 ⟹ x = 8.\nAlex\'s current age = 4x = 4(8) = 32 years.',
      },
      {
        'id': 3,
        'questionText':
            'Find the next number in the logical sequence: 2, 6, 12, 20, 30, 42, ?',
        'options': ['52', '54', '56', '60'],
        'correctAnswerIndex': 2,
        'explanation':
            'The pattern of differences between consecutive terms is: +4, +6, +8, +10, +12, +14.\n42 + 14 = 56.\nAlternatively, n² + n: 1²+1=2, 2²+2=6, 3²+3=12, 4²+4=20, 5²+5=30, 6²+6=42, 7²+7=56.',
      },
      {
        'id': 4,
        'questionText':
            'Two unbiased dice are thrown simultaneously. What is the probability of obtaining a total score of 8?',
        'options': ['5/36', '1/6', '7/36', '1/9'],
        'correctAnswerIndex': 0,
        'explanation':
            'Total possible outcomes = 6 × 6 = 36.\nFavorable outcomes for sum of 8: (2,6), (3,5), (4,4), (5,3), (6,2) ⟹ 5 outcomes.\nProbability = 5/36.',
      },
      {
        'id': 5,
        'questionText':
            'A can complete a project in 12 days, while B can complete the same project in 18 days. If they work together, in how many days will they finish the project?',
        'options': ['6.5 days', '7.2 days', '8.0 days', '9.6 days'],
        'correctAnswerIndex': 1,
        'explanation':
            'A\'s 1-day work = 1/12.\nB\'s 1-day work = 1/18.\nCombined 1-day work = 1/12 + 1/18 = (3 + 2) / 36 = 5/36.\nTime required = 36 / 5 = 7.2 days.',
      },
      {
        'id': 6,
        'questionText':
            'A merchant buys an article for \$400 and sells it at a profit of 25%. What is the selling price of the article?',
        'options': ['\$450', '\$480', '\$500', '\$520'],
        'correctAnswerIndex': 2,
        'explanation':
            'Selling Price = Cost Price × (1 + Profit% / 100)\n= \$400 × (1 + 0.25) = \$400 × 1.25 = \$500.',
      },
      {
        'id': 7,
        'questionText':
            'What is the acute angle between the hour hand and the minute hand of a clock at 3:30 PM?',
        'options': ['60°', '75°', '85°', '90°'],
        'correctAnswerIndex': 1,
        'explanation':
            'Angle formula: |30H - 5.5M| where H = 3 and M = 30.\nAngle = |30(3) - 5.5(30)| = |90 - 165| = 75°.',
      },
      {
        'id': 8,
        'questionText':
            'In a certain code language, "FLOREO" is coded as "GMPSEP". How is "SYSTEM" coded in the same language?',
        'options': ['TZTUFN', 'TZTUEN', 'TZTUDN', 'SYTSEM'],
        'correctAnswerIndex': 0,
        'explanation':
            'Each letter is shifted forward by 1 position in the alphabet:\nF+1=G, L+1=M, O+1=P, R+1=S, E+1=F (Wait: R+1=S, E+1=F, O+1=P).\nFor SYSTEM:\nS+1=T, Y+1=Z, S+1=T, T+1=U, E+1=F, M+1=N ⟹ TZTUFN.',
      },
      {
        'id': 9,
        'questionText':
            'Calculate the compound interest earned on \$10,000 invested for 2 years at an annual interest rate of 10% compounded annually.',
        'options': ['\$2,000', '\$2,100', '\$2,200', '\$2,500'],
        'correctAnswerIndex': 1,
        'explanation':
            'Amount = Principal × (1 + r/100)^t = 10,000 × (1.10)² = 10,000 × 1.21 = \$12,100.\nCompound Interest = Amount - Principal = \$12,100 - \$10,000 = \$2,100.',
      },
      {
        'id': 10,
        'questionText':
            'Pointing to a woman in a photograph, David said, "She is the daughter of my grandfather\'s only son." How is the woman related to David?',
        'options': ['Mother', 'Sister', 'Aunt', 'Cousin'],
        'correctAnswerIndex': 1,
        'explanation':
            'David\'s grandfather\'s only son is David\'s father.\nThe daughter of David\'s father is David\'s sister.',
      },
      {
        'id': 11,
        'questionText':
            'If the price of sugar increases by 25%, by what percentage must a household reduce its sugar consumption to keep total expenditure unchanged?',
        'options': ['15%', '20%', '25%', '30%'],
        'correctAnswerIndex': 1,
        'explanation':
            'Reduction percentage formula = [R / (100 + R)] × 100%\n= [25 / (100 + 25)] × 100% = (25 / 125) × 100% = 20%.',
      },
      {
        'id': 12,
        'questionText': 'What is the unit digit of 7^95 - 3^58?',
        'options': ['0', '4', '6', '7'],
        'correctAnswerIndex': 1,
        'explanation':
            'Cyclicity of 7 is 4 (7, 9, 3, 1). 95 mod 4 = 3 ⟹ unit digit of 7^95 is 3.\nCyclicity of 3 is 4 (3, 9, 7, 1). 58 mod 4 = 2 ⟹ unit digit of 3^58 is 9.\nUnit digit calculation: (3 - 9) ≡ (13 - 9) = 4.',
      },
      {
        'id': 13,
        'questionText':
            'In a group of 60 students, 35 play football, 30 play basketball, and 15 play both sports. How many students play neither sport?',
        'options': ['5', '10', '15', '20'],
        'correctAnswerIndex': 1,
        'explanation':
            'n(F ∪ B) = n(F) + n(B) - n(F ∩ B) = 35 + 30 - 15 = 50 students play at least one sport.\nStudents playing neither = Total - n(F ∪ B) = 60 - 50 = 10.',
      },
      {
        'id': 14,
        'questionText':
            'The average weight of 8 individuals increases by 2.5 kg when one person weighing 65 kg is replaced by a new person. What is the weight of the new person?',
        'options': ['75 kg', '80 kg', '85 kg', '90 kg'],
        'correctAnswerIndex': 2,
        'explanation':
            'Total weight increase = Number of individuals × average increase = 8 × 2.5 = 20 kg.\nWeight of new person = Weight of replaced person + Total increase = 65 kg + 20 kg = 85 kg.',
      },
      {
        'id': 15,
        'questionText':
            'Pipe A can fill a water tank in 6 hours, while Pipe B can empty the full tank in 10 hours. If both pipes are opened together, how long will it take to fill an empty tank?',
        'options': ['12 hours', '15 hours', '18 hours', '20 hours'],
        'correctAnswerIndex': 1,
        'explanation':
            'Net filling rate per hour = (1/6) - (1/10) = (5 - 3) / 30 = 2/30 = 1/15.\nTime to fill tank = 15 hours.',
      },
      {
        'id': 16,
        'questionText':
            'Statements:\n1. All mammals are animals.\n2. All dogs are mammals.\nConclusion:\nI. All dogs are animals.\nII. Some animals are mammals.',
        'options': [
          'Only Conclusion I follows',
          'Only Conclusion II follows',
          'Neither follows',
          'Both Conclusion I and II follow',
        ],
        'correctAnswerIndex': 3,
        'explanation':
            'Since Dogs ⊂ Mammals ⊂ Animals, all dogs are animals (Conclusion I is valid).\nAlso, since Mammals ⊂ Animals, some animals are mammals (Conclusion II is valid).\nTherefore, both conclusions follow.',
      },
      {
        'id': 17,
        'questionText':
            'The length of a rectangle is increased by 20% and its width is decreased by 10%. What is the net percentage change in its area?',
        'options': [
          '8% increase',
          '10% increase',
          '12% increase',
          '2% decrease',
        ],
        'correctAnswerIndex': 0,
        'explanation':
            'Net % change = x + y + (xy / 100) where x = +20 and y = -10.\nNet change = 20 - 10 + (20 × -10 / 100) = 10 - 2 = +8% (8% increase).',
      },
      {
        'id': 18,
        'questionText':
            'In how many distinct ways can the letters of the word "FLOREO" be arranged?',
        'options': ['360', '720', '1,080', '1,440'],
        'correctAnswerIndex': 0,
        'explanation':
            'The word "FLOREO" contains 6 letters with the letter "O" appearing 2 times.\nNumber of distinct arrangements = 6! / 2! = 720 / 2 = 360.',
      },
      {
        'id': 19,
        'questionText':
            'Identify the number that does not belong in the following set: 3, 5, 11, 14, 17, 19, 23',
        'options': ['11', '14', '17', '23'],
        'correctAnswerIndex': 1,
        'explanation':
            '3, 5, 11, 17, 19, and 23 are all prime numbers.\n14 is an even composite number (2 × 7), so it does not belong in the set.',
      },
      {
        'id': 20,
        'questionText':
            'If 5 workers can build 5 wooden tables in 5 days, how many days will 10 workers take to build 10 wooden tables?',
        'options': ['2.5 days', '5 days', '10 days', '25 days'],
        'correctAnswerIndex': 1,
        'explanation':
            'Work formula: (M1 × D1) / W1 = (M2 × D2) / W2.\n(5 workers × 5 days) / 5 tables = (10 workers × D2 days) / 10 tables.\n5 = 10 × D2 / 10 ⟹ D2 = 5 days.',
      },
    ],
  };
}
