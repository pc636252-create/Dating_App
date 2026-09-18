import '../models/user_model.dart';
import '../models/message_model.dart';

class DummyData {
  DummyData._();
  static List<String> _photos(String seed, int count) => List.generate(
    count, (i) => 'https://picsum.photos/seed/$seed$i/800/900');

  static List<UserModel> discoverUsers() => [
        UserModel(
          id: 'u1',
          name: 'Jessica Parker',
          age: 23,
          location: 'Chicago, United States',
          profession: 'Professional model',
          about:
              'My name is Jessica and I enjoy meeting new people and finding ways to help them '
              'have an uplifting experience. I enjoy reading.',
          interests: const ['Traveling', 'Studio', 'Music', 'Dancing', 'Modeling'],
          photos: _photos('jess', 4),
          isOnline: true,
          distanceKm: 2.4,
        ),
        UserModel(
          id: 'u2',
          name: 'Camila Snow',
          age: 24,
          location: 'New York, United States',
          profession: 'Photographer',
          about: 'Coffee first, questions later. Always up for a spontaneous road trip.',
          interests: const ['Photography', 'Coffee', 'Hiking'],
          photos: _photos('camila', 3),
          isOnline: false,
          distanceKm: 5.1,
        ),
        UserModel(
          id: 'u3',
          name: 'Bred Jackson',
          age: 25,
          location: 'Los Angeles, United States',
          profession: 'Fitness coach',
          about: 'Gym in the morning, tacos at night. Looking for a workout buddy.',
          interests: const ['Fitness', 'Nutrition', 'Movies'],
          photos: _photos('bred', 3),
          isOnline: true,
          distanceKm: 1.2,
        ),
        UserModel(
          id: 'u4',
          name: 'Grace Miller',
          age: 26,
          location: 'Austin, United States',
          profession: 'UX Designer',
          about: 'Designing pretty things by day, board games by night.',
          interests: const ['Design', 'Board games', 'Art'],
          photos: _photos('grace', 3),
          isOnline: true,
          distanceKm: 3.8,
        ),
        UserModel(
          id: 'u5',
          name: 'Sophia Adams',
          age: 22,
          location: 'Miami, United States',
          profession: 'Marine biologist',
          about: 'Ocean lover. Ask me anything about dolphins.',
          interests: const ['Diving', 'Animals', 'Beach'],
          photos: _photos('sophia', 3),
          isOnline: false,
          distanceKm: 7.6,
        ),
       UserModel(
          id: 'u6',
          name: 'Am grinder ',
          age: 12,
          location: 'mohali , sector 12',
          profession: 'Developer',
          about: 'i like to develop any type of App',
          interests: const ['Swimming', 'Typing'],
          photos: _photos('Approach', 5),
          isOnline: false,
          distanceKm: 9.6,
        ),
      ];

  static ConversationModel sampleConversation(UserModel user) {
    final now = DateTime.now();
    return ConversationModel(
      id: 'c_${user.id}',
      userId: user.id,
      name: user.name,
      avatar: user.mainPhoto,
      isOnline: user.isOnline,
      messages: [
        MessageModel(
          id: 'm1',
          text: "Hello this is my chat box ",
          isMe: false,
          time: now.subtract(const Duration(minutes: 40)),
          isRead: true,
        ),
        MessageModel(
          id: 'm2',
          text: "Haha buy I've already crossed off several weeks this week!",
          isMe: true,
          time: now.subtract(const Duration(minutes: 32)),
          isRead: true,
        ),
        MessageModel(
          id: 'm3',
          text: "Sure, let's do it! What about coffee today evening?",
          isMe: false,
          time: now.subtract(const Duration(minutes: 5)),
          isRead: false,
        ), MessageModel(
          id: 'm4',
          text: "Sure, evening?",
          isMe: false,
          time: now.subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
        MessageModel(
          id: 'm5',
          text: "buddy !",
          isMe: false,
          time: now.subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
      ],
    );
  }
}
