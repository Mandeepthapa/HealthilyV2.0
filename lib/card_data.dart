final List<CardViewModel> demoCards = [
  new CardViewModel(
    backdropAssetPath: 'assets/images/yoga.jpg',
    text:"Yoga (Sanskrit: योग) is a group of physical,\n "
          "mental, and spiritual practices or disciplines\n"
          "which originated in ancient India. Yoga is one\n"
          "of the six orthodox schools of Hindu \n"
          "philosophical traditions. There is a broad\n"
          "variety of yoga schools, practices, and goals\n"
          "in Hinduism, Buddhism and Jainism.",
    address: 'Yoga',
    start: "Start"
  ),
  new CardViewModel(
    backdropAssetPath: 'assets/images/medi.jpg',
    text: "Meditation is a practice where an individual \n"
          "uses a technique – such as mindfulness, or \n"
          "focusing their mind on a particular object,\n"
          "thought or activity – to train attention and \n"
          "awareness, and achieve a mentally clear and \n"
          "emotionally calm and stable state.",
    address: 'Meditation',
    start1: "Start"

  ),
  new CardViewModel(
    backdropAssetPath: 'assets/images/zumba12.jpg',
    text: "Zumba is an exercise fitness program created\n"
          "by Colombian dancer and choreographer Alberto\n"
          "Beto Perez during the 1990s. Zumba involves\n"
          "dance and aerobic movements performed to \n"
          "energetic music. The choreography incorporates\n"
          "hip-hop, soca, samba, salsa, merengue and mambo.\n" 
          "Squats and lunges are also included.",
    address: 'Zumba',
    start2: "Start"

  ),
  new CardViewModel(
    backdropAssetPath: 'assets/images/man.jpg',
    text: "Exercise is any bodily activity that enhances\n" 
          "or maintains physical fitness and overall\n"
          "health and wellness. It is performed for\n" 
          "various reasons, including increasing growth \n"
          "and development, preventing aging, strengthening\n" 
          "muscles and the cardiovascular system, honing \n"
          "athletic skills, weight loss or maintenance, \n"
          "improving health and also for enjoyment",
    address: 'Workout',
    start3: "Start"

  ),
];

class CardViewModel {
  final String backdropAssetPath;
  final address;
  final start;
  final start1;
  final start2;
  final start3;
  final String text;

  CardViewModel({
    this.backdropAssetPath,
    this.address,
    this.text,
    this.start,
    this.start1,
    this.start2,
    this.start3
  });
}
