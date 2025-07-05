import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TrackTile extends StatelessWidget {

  final String subjectName;
  final VoidCallback onTap;
  final VoidCallback settingsTap;
  final int timeSpent;
  final int timeGoal;
  final bool timerStart;


  const TrackTile({super.key,required this.subjectName, required this.onTap , required this.settingsTap, required this.timeSpent, required this.timeGoal, required this.timerStart});
  
  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.only(top: 15, left: 10,right: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Row(children: [
                  GestureDetector(
                    onTap: onTap,
                child: CircularPercentIndicator(radius: 40, center:Icon(timerStart ? Icons.pause : Icons.play_arrow,size: 40,)),),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(subjectName,style: TextStyle(fontSize: 30, fontFamily: "Oswald"),),
                    Text( timeSpent.toString()+ '/' +timeGoal.toString(),
                    style: TextStyle(color:Colors.grey[600] ,fontSize: 15, fontFamily: "Oswald"),),
                  ],
                ),
                ],),
                
                GestureDetector(
                  onTap: settingsTap,
                  child: Icon(Icons.settings))
              ],
            ),
          ),
        );
  }
}