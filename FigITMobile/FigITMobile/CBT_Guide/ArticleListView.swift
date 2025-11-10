//
//  ArticleListView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.
//


import SwiftUI

struct ArticleListView: View {
    // Sample articles data
    @State private var articles = [
        Article(title: "Understanding Anxiety", summary: "Anxiety is a range of normal though unpleasant emotions.", content: "Anxiety is a range of normal though unpleasant emotions. We can feel worried, nervous, uneasy, or we can feel extreme fear, panic or terror. Appropriate levels of anxiety are actually a helpful survival mechanism. Anxiety is designed to alert us to a situation that we need to respond to, if we do not respond there are usually negative consequences, we could be in danger or under threat.  These situations might include feeling anxious about an exam or presentation at work, for which we can respond to by preparing and practicing for. Anxiety also can be more sudden and acute in some circumstances such as when we are about to cross the road and we hear the beeping of a car before we step out. Our response is to jump out of the way to safety.  These examples highlight how anxiety provides the driving force behind motivation and keeps us safe from harmful situations. In this way anxiety is similar to physical pain. Pain keeps us safe from harm by telling us to remove our hand from a hot flame. Anxiety keeps us safe by ensuring we appropriately respond to dangerous, difficult or threatening situations. If we did not experience physical pain or anxiety how safe would we be?"),
        Article(title: "Understanding Panic", summary: "Panic attacks are an extreme form of anxiety. It is not harmful but it is incredibly unpleasant, usually as they are unexpected.", content: "Panic attacks are an extreme form of anxiety. It is not harmful but it is incredibly unpleasant, usually as they are unexpected. Many people have been so terrified by having a panic attack that they call an ambulance as they have felt and feared that they were ‘losing control’, ‘having a heart attack’, ‘going to suffocate’ or ‘going to die’. Panic attack can be even more frightening if you have a long-term health condition such as asthma or COPD.  We often recognise panic as a problem when we are having recurrent attacks and are concerned about any further attacks. For others panic can seem to occur ‘out of the blue’. We can also have night time panics which affect our sleep. We may also avoid certain situations where we feel the panic attacks occur, such as busy places.  Physical symptoms include an accelerated, sometimes doubled, heart rate, shortness of breath, sweating, and nausea. These symptoms usually peak within 5 to 10 minutes (as our bodies cannot maintain these symptoms for very long). However this feels prolonged, and it can be a repetitive cycle occurring many times during the day or night. We are exhausted afterwards as our bodies recover.  We overestimate the physical symptoms of the anxiety we are experiencing in that moment and feel that it can harm us and is extremely dangerous. We call this catastrophic misinterpretation. The vicious cycle of panic can then spiral as we focus on symptoms and our thoughts become more distressed, we feel as though we cannot cope and our worse fears will happen."),
        Article(title: "What is CBT?", summary: "Cognitive Behavioural Therapy (CBT) can help people look at the different situations that they find themselves in, and to understand their thoughts, physical sensations and behaviours.", content: "Cognitive Behavioural Therapy (CBT) can help people look at the different situations that they find themselves in, and to understand their thoughts, physical sensations and behaviours. The idea is that our thoughts, physical symptoms and behaviour can all influence one another and therefore contribute in maintaining unhelpful moods such as low mood and anxiety.CBT emphasises that it is not necessarily the situation that causes the emotional distress that an individual experiences, but rather it is the individual’s interpretation or view of that situation that leads to this. CBT works by learning how to challenge negative thoughts and learning how to change unhelpful behaviours.  When feeling low or anxious, it is common to have Negative Automatic Thoughts (NATs). These are unhelpful thoughts that pop into our minds without any effort. With anxiety, NATs are often about overestimating threat and underestimating an individual’s ability to cope, which can maintain anxiety. Sometimes people find coping mechanisms which help them deal with the situation. This may involve avoiding the situation, or doing something differently to help control their anxiety. Although this may lower their anxiety in the short term, it can actually maintain and reinforce it in the long term. Breaking this vicious cycle may cause an increase in anxiety to begin with but ultimately help reduce it.")
    ]
    
    var body: some View {
        NavigationView {
            List(articles) { article in
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    VStack(alignment: .leading) {
                        Text(article.title).font(.headline)
                        Text(article.summary).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Articles")
        }
    }
}
