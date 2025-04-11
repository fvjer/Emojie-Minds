//
//  ContentView.swift
//  Emojie Minds
//
//  Created by ahad alshehah on 13/10/1446 AH.
//

import SwiftUI



enum Screen {
    case start, harryQuestion, result1, pyramidsQuestion, result2, chinaQuestion, result3, titanicQuestion, result4, final
}

extension Color {
    static let customButton = Color(red: 0.984, green: 0.725, blue: 0.729) // #FBB9BA
    static let customBackground = Color(red: 1.0, green: 0.804, blue: 0.867) // #FFCDDD
}

struct ContentView: View {
    @State private var screen: Screen = .start
    @State private var isCorrectAnswer = false
    
    var body: some View {
        ZStack {
            switch screen {
            case .start:
                FirstScreen {
                    screen = .harryQuestion
                }
            case .harryQuestion:
                QuestionView(
                    question: "ماذا تدل عليه هذه الرموز؟",
                    emoji: "⚡🧙‍♂️🪄",
                    options: ["مرلين", "قندلف", "دكتور سترينج", "هاري بوتر"],
                    correctAnswer: "هاري بوتر"
                ) { isCorrect in
                    isCorrectAnswer = isCorrect
                    screen = .result1
                }
            case .result1:
                ResultScreen(isCorrect: isCorrectAnswer) {
                    screen = .pyramidsQuestion
                }
            case .pyramidsQuestion:
                QuestionView(
                    question: "ماذا تدل عليه هذه الرموز؟",
                    emoji: "🏜️🐫🗿",
                    options: ["أبو الهول", "تاج محل", "الأهرامات", "البتراء"],
                    correctAnswer: "الأهرامات"
                ) { isCorrect in
                    isCorrectAnswer = isCorrect
                    screen = .result2
                }
            case .result2:
                ResultScreen(isCorrect: isCorrectAnswer) {
                    screen = .chinaQuestion
                }
            case .chinaQuestion:
                QuestionView(
                    question: "ماذا تدل عليه هذه الرموز؟",
                    emoji: "🏯🧱🐉",
                    options: ["كيوتو", "سور الصين العظيم", "قصر الحمراء", "جبل فوجي"],
                    correctAnswer: "سور الصين العظيم"
                ) { isCorrect in
                    isCorrectAnswer = isCorrect
                    screen = .result3
                }
            case .result3:
                ResultScreen(isCorrect: isCorrectAnswer) {
                    screen = .titanicQuestion
                }
            case .titanicQuestion:
                QuestionView(
                    question: "ماذا تدل عليه هذه الرموز؟",
                    emoji: "❄️🚢💔",
                    options: ["تايتنك", "موانا", "القارب المشؤوم", "قراصنة الكاريبي"],
                    correctAnswer: "تايتنك"
                ) { isCorrect in
                    isCorrectAnswer = isCorrect
                    screen = .result4
                }
            case .result4:
                ResultScreen(isCorrect: isCorrectAnswer) {
                    screen = .final
                }
            case .final:
                FinalScreen {
                    screen = .start
                }
            }
        }
    }
    
    struct FirstScreen: View {
        var onStart: () -> Void
        
        var body: some View {
            VStack(spacing: 25) {
                Spacer()
                
                Text("فكك الرموز!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                 
                VStack {
                    Text("🥰💗🏝️🌍")
                        .font(.system(size: 40))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
                
                Text("ايموجيات × تحديات")
                    .foregroundColor(.white)
                    .font(.subheadline)
                
                Button(action: onStart) {
                    Text("ابدأ اللعبة")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: 250)
                        .padding()
                        .background(Color.customButton)
                        .cornerRadius(10)
                }
                
                
                VStack(spacing: 8) {
                    Text("🤔📝")
                        .font(.largeTitle)
                    Text("قلم وورقة واحسب نقاطك\nشاهد الرموز، واحزر الكلمة")
                        .font(.footnote)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 30)
                
                Text("شارك صديقك 🚀")
                    .foregroundColor(.white)
                    .font(.subheadline)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.customBackground)
        }
    }
    
    struct QuestionView: View {
        var question: String
        var emoji: String
        var options: [String]
        var correctAnswer: String
        var onAnswer: (Bool) -> Void
        
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
        var body: some View {
            VStack(spacing: 20) {
                Spacer()
                
                Text(question)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Text(emoji)
                    .font(.system(size: 50))
                
                Spacer(minLength: 30)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            onAnswer(option == correctAnswer)
                        }) {
                            Text(option)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.customButton)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.headline)
                        }
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.customBackground)
        }
    }
    
    struct ResultScreen: View {
        var isCorrect: Bool
        var onNext: () -> Void
        
        var body: some View {
            VStack {
                Spacer()
                
                Text(isCorrect ? "مبروك!\nحصلت على نقطة" : "حظ أوفر\nإجابة خاطئة")
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: onNext) {
                        HStack {
                            Text("أكمل")
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                        .background(Color.customButton)
                        .cornerRadius(10)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.customBackground)
        }
    }
    
    struct FinalScreen: View {
        var onRestart: () -> Void
        
        var body: some View {
            VStack(spacing: 25) {
                Spacer()
                Text("🥳 مبروك!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text("انتهت اللعبة بنجاح 🎊\nكم حصلت على نقطة ؟")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                Text("جرب من جديد أو شاركها مع أحد تتحداه")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Button(action: onRestart) {
                    Text("إعادة اللعب")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 180)
                        .background(Color.customButton)
                        .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.customBackground)
        }
    }
}
#Preview {
    ContentView()
}
