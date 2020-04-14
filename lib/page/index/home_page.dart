import 'package:cyoga/dao/home_hot_dao.dart';
import 'package:cyoga/models/courses_entity.dart';
import 'package:cyoga/res/yoga_iconfont.dart';
import 'package:cyoga/widget/common/custom_view.dart';
import 'package:cyoga/widget/common/scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/widget/common/app_topbar.dart';
import 'package:cyoga/utils/constants.dart';
import 'package:cyoga/widget/common/customize_appbar.dart';
import 'package:cyoga/res/theme_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: HomeTopBar(),
        ),
        body : ScrollWidget(
          extra: true,
          builder: (BuildContext context, int index, List list){
            if(index==0) {
              return createHeadNav();
            }else {
              if(index==1){
                return Container(
                  child: Column(
                    children: <Widget>[
                      createCourseTitle(),
                      createNearbyStoreItem(list[index-1] as CoursesModel, index)
                    ],
                  ),
                );
              }
              return createNearbyStoreItem(list[index-1] as CoursesModel, index);
            }
          },
          loadFunc: (int type, int minId) async {
            var data =  await HomeHotDao.fetch(type, minId);
            return data.courses;
          }
        ),
    );
  }
  getHeadNavImgBtns() {
    int i =0;
    var iconBtns = List<Widget>();

    for (; i < HEAD_NAV_TEXT.length; i++) {
      int c = i;
      var j = HEAD_NAV_TEXT[i];
      var link = Web_Links[j];
      var iconColor = link.length>2 ? ThemeColor.appMain : ThemeColor.textCustomColor;
      var textColor = link.length>2 ? ThemeColor.hintTextColor : ThemeColor.textCustomColor;
      iconBtns.add(
          IconBtn(link[1],
              func: navigateTo,
              index: j,
              text: link[0],
              iconColor: iconColor,
              textStyle: TextStyle(fontSize: AppSize.sp(36),color: textColor)));
    }
    return iconBtns;
  }
  createHeadNav() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: AppSize.height(430),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  "images/banner.png",
                  fit: BoxFit.cover,
                );
              },
              itemCount: 3,
              pagination: SwiperPagination(margin: EdgeInsets.all(1.0)),
              scale: 0.9,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: AppSize.height(40)),
            child: GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 1,
                childAspectRatio: 1.8,
              ),
              children: getHeadNavImgBtns()
          )
          )
        ],
      ),
    );
  }

  createCourseTitle() {
    return Container(
          padding: EdgeInsets.only(left:10, top:10, right:40, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("热门课程"),
              InkWell(
                onTap: ()=>{

                },
                child: Icon(YogaIcons.more, size: AppSize.width(65),color: ThemeColor.subTextColor,),
              )
            ],
          )
      );
  }

  getNearbyStoreImgBtn(_item) {
    return Container(
        height: AppSize.height(280),
        child:InkWell(
          onTap: ()=>onItemClick(_item),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: AppSize.height(280),
                  child: ClipRRect(child: CachedNetworkImage(imageUrl:
                  _item.picUrl, fit: BoxFit.cover,),
                      borderRadius: BorderRadius.circular(6)
                  )
              ),
              Container(
                width: AppSize.sp(20),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(_item.name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("¥"+_item.counterPrice,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: ThemeTextStyle.mainStyle),
                          Text(_item.partnum.toString() + "人参加", style: ThemeTextStyle.cardNumStyle,)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(YogaIcons.shop, size: AppSize.sp(50), color: ThemeColor.appMain),
                              Text(_item.store, style: ThemeTextStyle.cardNumStyle)
                            ],
                          ),
                          Text(_item.addr.toString(), style: ThemeTextStyle.cardNumStyle,)
                        ],
                      )
                    ],
                  )
              ),
              Container(
                width: AppSize.sp(20),
              ),
            ],
          ),
        )
    );
  }

  // 热门课程
  createNearbyStoreItem(CoursesModel item, int type) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: AppSize.sp(20)),
      padding: EdgeInsets.only(left:AppSize.sp(20), bottom: AppSize.sp(20),top:AppSize.sp(20)),
      child: getNearbyStoreImgBtn(item),
    );
  }

  void navigateTo(String index){
    if(Web_Links[index]!=null) {
      var links = Web_Links[index];
      if(links.length >2) {
        Routes.instance.navigateTo(context, links[2], index);
      }
    }
  }

  void onItemClick(CoursesModel model){
    int id = model.id;
    Routes.instance.navigateTo(context, Routes.COURSE_DETAILS,id.toString());
  }
}

