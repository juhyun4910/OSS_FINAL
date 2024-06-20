import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart'; // URL launcher import
import 'dart:io'; // File 사용을 위해 필요

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Juhyun Park Gallery',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 42, 82, 121)),
        ),
        home: MainPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String name = '';
  String bio = '';
  String contact = '';
  String socialMedia = '';
  String imageUrl = '';

  void updateUserInfo(String newName, String newBio, String newContact,
      String newSocialMedia, String newImageUrl) {
    name = newName;
    bio = newBio;
    contact = newContact;
    socialMedia = newSocialMedia;
    imageUrl = newImageUrl;
    notifyListeners();
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 112, 183, 218), // 전체 배경색 설정
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 172, 212, 232), // AppBar 배경색 설정
          title: Text('Juhyun Park Gallery'),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 18), // 탭 글씨 크기 설정
            unselectedLabelStyle: TextStyle(fontSize: 18), // 선택되지 않은 탭 글씨 크기 설정
            tabs: [
              Tab(text: 'HOME'),
              Tab(text: 'PROFILE'),
              Tab(text: 'ABOUT ME'),
              Tab(text: 'CONTACT'),
            ],
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            HomePage(),
            ProfilePage(),
            AboutPage(),
            ContactPage(),
          ],
        ),
      ),
    );
  }
}

//.............................................홈페이지............................................
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 82, 138, 165), // 배경색 설정
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'), // 로컬 이미지 파일
              radius: 130,
            ),
            SizedBox(height: 20),
            Text(
              '안녕하세요! 저는 박주현입니다.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '단국대학교 20학번으로 장차 억만장자 개발자가 될 컴퓨터공학과 학생입니다!',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '제 사진전에 오신 것을 환영합니다.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

//.........................................프로필.................................................
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 82, 138, 165), // 배경색 설정
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 80,
              ),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileInfo(title: 'Name', content: '박주현'),
                    ProfileInfo(title: 'Age', content: '25'),
                    ProfileInfo(title: 'Birthday', content: '2000-05-07'),
                    ProfileInfo(
                        title: 'Residence', content: '경기도 수원시 영통구 영통동 청명로 100'),
                    ProfileInfo(
                      title: 'Career',
                      contentWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('2000.05.07 탄생'),
                          Text('2007~2012 신성초등학교'),
                          Text('2013~2015 영덕중학교'),
                          Text('2016~2018 창현고등학교'),
                          Text('2019~2019.12.31 분당메가스터디'),
                          Text('2020~2021 단국대학교(죽전) 컴퓨터공학과'),
                          Text('2022~2023.11.27 산업체(나노테크)'),
                          Text('2024~ 단국대학교(죽전) 컴퓨터공학과'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String title;
  final String content;
  final Widget? contentWidget;

  ProfileInfo({required this.title, this.content = '', this.contentWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          if (contentWidget != null)
            Expanded(child: contentWidget!)
          else
            Expanded(
              child: Text(
                content,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
        ],
      ),
    );
  }
}

//.........................................About me.............................................
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem(Icons.info, 'About Me', 0),
            _buildDrawerItem(Icons.favorite, 'My Favorites', 1),
            _buildDrawerItem(Icons.memory, 'My Memories', 2),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AboutMeTab(),
          MyFavoritesTab(),
          MyMemoryTab(),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: () {
        setState(() {
          _tabController.index = index;
        });
        Navigator.pop(context);
      },
    );
  }
}

class AboutMeTab extends StatelessWidget {
  final List<Map<String, String>> photos = [
    {
      'url': 'assets/baby.jpg',
      'description': '2000년 5월 7일 아주아주 귀여운 제가 탄생했습니다! \n'
          '"빛나는 기둥이 되어라" 라는 의미의 기둥 주, 빛날 현 자를 써 주현이라는 이름을 갖고 태어난 저는\n'
          '항상 이름에 걸맞은 사람이 되기 위해 노력하고 있습니다!'
    },
    {
      'url': 'assets/baby2.jpg',
      'description': '어렸을때부터 장난기가 많아 부모님께서 항상 "까불이"라고 부르셨는데\n'
          '25살이 된 아직까지도 장난기는 많은 것 같습니다...'
    },
    {
      'url': 'assets/me.jpg',
      'description': '제 MBTI는 INFJ입니다. \n'
          'MBTI가 나타내는 제 성격은 저도 잘 알지는 못하지만 제가 생각하는 저의 성격은\n'
          ' 평소에는 굉장히 조용한 편이지만 편한 사람들과 함께라면 활발해지고 \n'
          '거짓 없는 제 모습이 드러나는 그런 성격인 것 같습니다.'
    },
    {
      'url': 'assets/me2.jpg',
      'description': '다행이도 성격이 맞고 마음이 맞는 친구들을 일찍부터 많이 사귀어서 \n'
          '같이 여행도 다니면서 많은 추억들을 공유하며 지내고 있습니다!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Icon(Icons.info, size: 50, color: Colors.blueAccent),
          Text(
            'About me',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '사진을 클릭하시면 내용을 보실 수 있습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 400,
                                height: 300,
                                child: Image.network(
                                  photos[index]['url']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                photos[index]['description']!,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      photos[index]['url']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//.................................My Favorites......................................
class MyFavoritesTab extends StatelessWidget {
  final List<Map<String, String>> photos = [
    {
      'url': 'assets/football.jpg',
      'description': '제 취미는 축구입니다! \n'
          '하는 것도 좋아하고 보는 것도 정말 좋아합니다. \n'
          '제가 가장 좋아하고 응원하는 해외 축구 팀은 "뉴캐슬 유나이티드"이고 \n'
          'K리그 에서는 "수원FC"와 "수원삼성"을 좋아합니다.'
    },
    {
      'url': 'assets/football2.jpg',
      'description': '이 사진은 저희 컴퓨터공학과가 체전 때 찍은 사진인데 아쉽게 결승에서 패배했답니다...'
    },
    {
      'url': 'assets/susi.jpg',
      'description': '제가 세상에서 가장 좋아하는 음식은 바로 "초밥" 입니다!\n'
          ' 저는 평생 한 가지 음식만 먹을 수 있고 죽기 전에 한 가지 음식을 고르라면 \n'
          '고민 없이 초밥을 고를 것입니다.\n'
          ' 이 사진은 일본 여행을 갔을 때 찍은 초밥 사진입니다!'
    },
    {
      'url': 'assets/susi2.jpg',
      'description': '저희 어머니께서 저를 가지셨을 때 초밥이 그렇게 당기셔서 많이 드셨다는데\n'
          ' 그때부터 초밥 맛을 알았나 봅니다... \n'
          '매번 어머니와 얘기를 나누며 둘이서 되게 신기해하는 대화 주제 중 하나입니다. \n'
          '이 사진은 제가 처음으로 갔던 오마카세에서 찍은 사진입니다!'
    },
    {
      'url': 'assets/animal.jpg',
      'description': '그리고 저는 동물들을 정말 좋아합니다.\n'
          ' 그리고 동물들도 저를 되게 좋아하는 것 같아요. \n'
          '눈을 보고 있으면 마음이 통하는 것 같습니다. \n'
          '아니면 제 냄새가 동물들이 좋아하는 냄새인걸까요...?'
    },
    {
      'url': 'assets/animal2.jpg',
      'description': '이 사진은 일본 여행을 갔을 때 \n'
          '공원에서 주인 분과 산책 중이던 원숭이가 길을 가다가 \n'
          '갑자기 저한테 다가와 제 등 뒤에 올라왔던 사진입니다!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Icon(Icons.favorite, size: 50, color: Colors.blueAccent),
          Text(
            'My Favorites',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '사진을 클릭하시면 내용을 보실 수 있습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 400,
                                height: 300,
                                child: Image.network(
                                  photos[index]['url']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                photos[index]['description']!,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      photos[index]['url']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//............................................My Memories.................................
class MyMemoryTab extends StatelessWidget {
  final List<Map<String, String>> mediaList = [
    {
      'url': 'assets/travel.mp4',
      'description': '이건 제가 작년 겨울에 오스트리아의 할슈타트 에서 찍은 동영상입니다!\n'
          '너무 멋있지 않나요?'
    },
    {
      'url': 'assets/rome.jpg',
      'description': '여기는 로마의 콜로세움 입니다! 안에 들어가 보지는 못해서 아쉬웠어요.'
    },
    {
      'url': 'assets/rome2.jpg',
      'description': '여기는 판테온 신전입니다. 들어가서 높은 천장과 웅장함에 놀랐던 기억이 있네요.'
    },
    {
      'url': 'assets/france.jpg',
      'description': '에펠탑입니다! 우중충한 날씨에 봐서 더 멋있었던 것 같아요!.'
    },
    {
      'url': 'assets/france2.jpg',
      'description': '여기는 개선문 입니다! 밑에 사진을 찍으려는 사람들이 정말 많았어요.'
    },
    {
      'url': 'assets/mountain.jpg',
      'description': '여기는 오스트리아의 운터스베르크입니다.\n'
          '왼쪽 위에 무지개 구름이 보이시나요? 실제로 봤을때는 훨씬 더 멋있었답니다.'
    },
    {
      'url': 'assets/venezia.jpg',
      'description': '여기는 베네치아입니다! 마치 동화속에 들어와있는 기분이었어요.'
    },
    {
      'url': 'assets/venezia2.jpg',
      'description': '이 사진도 베네치아입니다! 야경이 너무 이뻐서 찍어봤어요!.'
    },
    {
      'url': 'assets/river2.jpg',
      'description': '여기는 영화 사운드 오브 뮤직의 촬영지로 유명한\n'
          '오스트리아 잘츠부르크의 미라벨 정원입니다!\n'
          '추운 겨울이라 꽃은 없었지만 그대로도 너무 이뻤습니다.'
    },
    // Add more videos and images as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Icon(Icons.memory, size: 50, color: Colors.blueAccent),
          Text(
            'My Memories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '사진이나 비디오를 클릭하면 내용을 보실 수 있습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: mediaList.length,
              itemBuilder: (context, index) {
                // Determine if it's a video or image based on the file extension
                String url = mediaList[index]['url']!;
                if (url.endsWith('.mp4')) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 500,
                                  height: 400,
                                  child: VideoWidget(videoUrl: url),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  mediaList[index]['description']!,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'assets/profile.jpg', // Placeholder image for video
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  // Display image
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: 300,
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  mediaList[index]['description']!,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  VideoWidget({required this.videoUrl});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      widget.videoUrl,
    );

    // Initialize chewieController
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: _controller.value.aspectRatio,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      placeholder: Container(
        color: Colors.grey,
      ),
    );

    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    await _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}

//.................................Contact...................................
class ContactPage extends StatelessWidget {
  final String phoneNumber = '010-4377-4910';
  final String email = 'joomog4910@naver.com';
  final String instagramUrl =
      'https://www.instagram.com/_jvhyvn.p?igsh=aXR0Y29vdzR0OW12&utm_source=qr';

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 82, 138, 165), // 배경색 설정
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Phone: $phoneNumber',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 10),
              Text('Email: $email',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Instagram: ',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  GestureDetector(
                    onTap: () => _launchURL(instagramUrl),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Color.fromARGB(255, 43, 33, 117),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(click the mark)',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  ContactItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.purple),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
