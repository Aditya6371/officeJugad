import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimens {
  const Dimens._();

  /// Get the height with the percent value of the screen height.
  static double percentHeight(double percentValue) => percentValue.sh;

  /// Get the width with the percent value of the screen width.
  static double percentWidth(double percentValue) => percentValue.sw;

  static double responsiveFontSize(double size) {
    // Example threshold, adjust based on your needs
    if (ScreenUtil().screenWidth > 600) {
      // Tablet logic
      return size * 0.6; // Reduce the size by 40%
    } else {
      // Phone logic
      return size;
    }
  }

  static double zero = responsiveFontSize(0.sp);
  static double one = responsiveFontSize(1.sp);
  static double two = responsiveFontSize(2.sp);
  static double three = responsiveFontSize(3.sp);
  static double four = responsiveFontSize(4.sp);
  static double five = responsiveFontSize(5.sp);
  static double six = responsiveFontSize(6.sp);
  static double seven = responsiveFontSize(7.sp);
  static double eight = responsiveFontSize(8.sp);
  static double nine = responsiveFontSize(9.sp);
  static double ten = responsiveFontSize(10.sp);
  static double eleven = responsiveFontSize(11.sp);
  static double twelve = responsiveFontSize(12.sp);
  static double thirteen = responsiveFontSize(13.sp);
  static double fourteen = responsiveFontSize(14.sp);
  static double fifteen = responsiveFontSize(15.sp);
  static double sixteen = responsiveFontSize(16.sp);
  static double seventeen = responsiveFontSize(17.sp);
  static double eighteen = responsiveFontSize(18.sp);
  static double nineteen = responsiveFontSize(19.sp);
  static double twenty = responsiveFontSize(20.sp);
  static double twentyOne = responsiveFontSize(21.sp);
  static double twentyTwo = responsiveFontSize(22.sp);
  static double twentyThree = responsiveFontSize(23.sp);
  static double twentyFour = responsiveFontSize(24.sp);
  static double twentyFive = responsiveFontSize(25.sp);
  static double twentySix = responsiveFontSize(26.sp);
  static double twentySeven = responsiveFontSize(27.sp);
  static double twentyEight = responsiveFontSize(28.sp);
  static double twentyNine = responsiveFontSize(29.sp);
  static double thirty = responsiveFontSize(30.sp);
  static double thirtyOne = responsiveFontSize(31.sp);
  static double thirtyTwo = responsiveFontSize(32.sp);
  static double thirtyFour = responsiveFontSize(34.sp);
  static double thirtyFive = responsiveFontSize(35.sp);
  static double thirtySix = responsiveFontSize(36.sp);
  static double thirtyEight = responsiveFontSize(38.sp);
  static double thirtyNine = responsiveFontSize(39.sp);
  static double fourty = responsiveFontSize(40.sp);
  static double fourtyTwo = responsiveFontSize(42.sp);
  static double fourtyFour = responsiveFontSize(44.sp);
  static double fourtyFive = responsiveFontSize(45.sp);
  static double fourtySix = responsiveFontSize(46.sp);
  static double fourtySeven = responsiveFontSize(47.sp);
  static double fourtyEight = responsiveFontSize(48.sp);
  static double fourtyNine = responsiveFontSize(49.sp);
  static double fifty = responsiveFontSize(50.sp);
  static double fiftyTwo = responsiveFontSize(52.sp);
  static double fiftyFour = responsiveFontSize(54.sp);
  static double fiftyFive = responsiveFontSize(55.sp);
  static double fiftySix = responsiveFontSize(56.sp);
  static double sixty = responsiveFontSize(60.sp);
  static double sixtyOne = responsiveFontSize(61.sp);
  static double sixtyFour = responsiveFontSize(64.sp);
  static double sixtyNine = responsiveFontSize(69.sp);
  static double seventy = responsiveFontSize(70.sp);
  static double seventyFour = responsiveFontSize(74.sp);
  static double seventyFive = responsiveFontSize(75.sp);
  static double eighty = responsiveFontSize(80.sp);
  static double eightyFive = responsiveFontSize(85.sp);
  static double eightySix = responsiveFontSize(86.sp);
  static double ninty = responsiveFontSize(90.sp);
  static double nintyFour = responsiveFontSize(94.sp);
  static double nintyFive = responsiveFontSize(95.sp);
  static double hundred = responsiveFontSize(100.sp);
  static double hundredFour = responsiveFontSize(104.sp);
  static double hundredFive = responsiveFontSize(105.sp);
  static double hundredSix = responsiveFontSize(106.sp);
  static double hundredEight = responsiveFontSize(108.sp);
  static double hundredTen = responsiveFontSize(110.sp);
  static double hundredFifteen = responsiveFontSize(115.sp);
  static double hundredTwenty = responsiveFontSize(120.sp);
  static double hundredTwentyFive = responsiveFontSize(125.sp);
  static double hundredTwentyTwo = responsiveFontSize(122.sp);
  static double hundredThirty = responsiveFontSize(130.sp);
  static double hundredThirtyTwo = responsiveFontSize(132.sp);
  static double hundredThirtyFour = responsiveFontSize(134.sp);
  static double hundredThirtyFive = responsiveFontSize(135.sp);
  static double hundredThirtySix = responsiveFontSize(136.sp);
  static double hundredThirtySeven = responsiveFontSize(137.sp);
  static double hundredFourty = responsiveFontSize(140.sp);
  static double hundredFourtyFour = responsiveFontSize(144.sp);
  static double hundredFourtyEight = responsiveFontSize(148.sp);
  static double hundredFifty = responsiveFontSize(150.sp);
  static double hundredFiftyOne = responsiveFontSize(151.sp);
  static double hundredFiftyFive = responsiveFontSize(155.sp);
  static double hundredSixty = responsiveFontSize(160.sp);
  static double hundredSixtyTwo = responsiveFontSize(162.sp);
  static double hundredSixtyFour = responsiveFontSize(164.sp);
  static double hundredSixtySeven = responsiveFontSize(167.sp);
  static double hundredSixtyFive = responsiveFontSize(165.sp);
  static double hundredSeventy = responsiveFontSize(170.sp);
  static double hundredSeventyTwo = responsiveFontSize(172.sp);
  static double hundredEighty = responsiveFontSize(180.sp);
  static double hundredEightyFive = responsiveFontSize(185.sp);
  static double hundredEightyEight = responsiveFontSize(188.sp);
  static double hundredNinty = responsiveFontSize(190.sp);
  static double hundredNintyThree = responsiveFontSize(193.sp);
  static double twoHundred = responsiveFontSize(200.sp);
  static double twoHundredFive = responsiveFontSize(205.sp);
  static double twoHundredTen = responsiveFontSize(210.sp);
  static double twoHundredTwenty = responsiveFontSize(220.sp);
  static double twoHundredTwentyTwo = responsiveFontSize(222.sp);
  static double twoHundredTwentyFive = responsiveFontSize(225.sp);
  static double twoHundredThirty = responsiveFontSize(230.sp);
  static double twoHundredThirtySix = responsiveFontSize(236.sp);
  static double twoHundredFourty = responsiveFontSize(240.sp);
  static double twoHundredFifty = responsiveFontSize(250.sp);
  static double twoHundredFiftyFive = responsiveFontSize(255.sp);
  static double twoHundredEighty = responsiveFontSize(280.sp);
  static double twoHundredNintyOne = responsiveFontSize(291.sp);
  static double twoHundredNintyTwo = responsiveFontSize(292.sp);
  static double threeHundred = responsiveFontSize(300.sp);
  static double threeHundredTwentySix = responsiveFontSize(326.sp);
  static double threeHundredTwentyEight = responsiveFontSize(328.sp);
  static double threeHundredTwentyNine = responsiveFontSize(329.sp);
  static double threeHundredTwentyTwo = responsiveFontSize(332.sp);
  static double threeHundredFourty = responsiveFontSize(340.sp);
  static double threeHundredFourtyThree = responsiveFontSize(343.sp);
  static double threeHundredFifty = responsiveFontSize(350.sp);
  static double threeHundredSeventyTwo = responsiveFontSize(372.sp);
  static double threeHundredSeventyFive = responsiveFontSize(375.sp);
  static double fourHundred = responsiveFontSize(400.sp);
  static double fourHundredFifty = responsiveFontSize(450.sp);
  static double fiveHundred = responsiveFontSize(500.sp);
  static double fiveHundredThirtyEight = responsiveFontSize(538.sp);
  static double fiveHundredFifty = responsiveFontSize(550.sp);
  static double sixHundred = responsiveFontSize(600.sp);
  static double sixHundredFifty = responsiveFontSize(650.sp);
  static double fifteenStatic = responsiveFontSize(15.sp);
  static double twentyStatic = responsiveFontSize(20.sp);
  static double hundredStatic = responsiveFontSize(100.sp);
  static double hundredFiftyStatic = responsiveFontSize(150.sp);
  static double twoHundredStatic = responsiveFontSize(200.sp);
  static double twoHundredFifteen = responsiveFontSize(215.sp);
  static double twoHundredSeventy = responsiveFontSize(270.sp);

  static final Widget box0 = SizedBox(height: zero);

  static final Widget boxHeight2 = SizedBox(height: two);
  static final Widget boxHeight4 = SizedBox(height: four);
  static final Widget boxHeight5 = SizedBox(height: five);
  static final Widget boxHeight8 = SizedBox(height: eight);
  static final Widget boxHeight10 = SizedBox(height: ten);
  static final Widget boxHeight15 = SizedBox(height: fifteen);

  static final Widget boxHeight16 = SizedBox(height: sixteen);
  static final Widget boxHeight20 = SizedBox(height: twenty);
  static final Widget boxHeight24 = SizedBox(height: twentyFour);
  static final Widget boxHeight32 = SizedBox(height: thirtyTwo);
  static final Widget boxHeight50 = SizedBox(height: fifty);
  static final Widget boxHeight100 = SizedBox(height: hundred);

  static final Widget boxWidth2 = SizedBox(width: two);
  static final Widget boxWidth4 = SizedBox(width: four);
  static final Widget boxWidth5 = SizedBox(width: five);
  static final Widget boxWidth8 = SizedBox(width: eight);
  static final Widget boxWidth10 = SizedBox(width: ten);
  static final Widget boxWidth12 = SizedBox(width: twelve);
  static final Widget boxWidth16 = SizedBox(width: sixteen);
  static final Widget boxWidth20 = SizedBox(width: twenty);
  static final Widget boxWidth24 = SizedBox(width: twentyFour);
  static final Widget boxWidth32 = SizedBox(width: thirtyTwo);

  static const EdgeInsets edgeInsets0 = EdgeInsets.zero;
  static final EdgeInsets edgeInsets4 = EdgeInsets.all(four);
  static final EdgeInsets edgeInsets5 = EdgeInsets.all(five);
  static final EdgeInsets edgeInsets6 = EdgeInsets.all(six);
  static final EdgeInsets edgeInsets8 = EdgeInsets.all(eight);
  static final EdgeInsets edgeInsets10 = EdgeInsets.all(ten);
  static final EdgeInsets edgeInsets12 = EdgeInsets.all(twelve);
  static final EdgeInsets edgeInsets16 = EdgeInsets.all(sixteen);
  static final EdgeInsets edgeInsets20 = EdgeInsets.all(twenty);

  static final EdgeInsets edgeInsetsL2 = EdgeInsets.only(left: two);

  static final EdgeInsets edgeInsetsL4 = EdgeInsets.only(left: four);
  static final EdgeInsets edgeInsetsR4 = EdgeInsets.only(right: four);

  static final EdgeInsets edgeInsets2_0 = EdgeInsets.symmetric(horizontal: two);
  static final EdgeInsets edgeInsets4_0 =
      EdgeInsets.symmetric(horizontal: four);
  static final EdgeInsets edgeInsets8_0 =
      EdgeInsets.symmetric(horizontal: eight);
  static EdgeInsets edgeInsets10_0 = EdgeInsets.symmetric(horizontal: ten);
  static EdgeInsets edgeInsets20_0 = EdgeInsets.symmetric(horizontal: twenty);

  static final EdgeInsets edgeInsets0_4 = EdgeInsets.symmetric(vertical: four);
  static final EdgeInsets edgeInsets0_8 = EdgeInsets.symmetric(vertical: eight);

  static final EdgeInsets edgeInsets4_8 =
      EdgeInsets.symmetric(horizontal: four, vertical: eight);
  static final EdgeInsets edgeInsets8_4 =
      EdgeInsets.symmetric(horizontal: eight, vertical: four);

  static final EdgeInsets edgeInsets0_0_0_5 = EdgeInsets.only(
    top: Dimens.zero,
    left: Dimens.zero,
    right: Dimens.zero,
    bottom: Dimens.five,
  );

  static final EdgeInsets edgeInsets0_0_5_0 = EdgeInsets.only(
    top: Dimens.zero,
    left: Dimens.zero,
    right: Dimens.five,
    bottom: Dimens.zero,
  );
  static final EdgeInsets edgeInsets8_0_8_8 = EdgeInsets.only(
    top: Dimens.eight,
    left: Dimens.zero,
    right: Dimens.eight,
    bottom: Dimens.eight,
  );
  static final EdgeInsets edgeInsets5_0_0_0 = EdgeInsets.only(
    top: Dimens.zero,
    left: Dimens.five,
    right: Dimens.zero,
    bottom: Dimens.zero,
  );
  static final EdgeInsets edgeInsets10_5_10_5 = EdgeInsets.only(
    left: Dimens.ten,
    top: Dimens.five,
    right: Dimens.ten,
    bottom: Dimens.five,
  );
  static final EdgeInsets edgeInsets15_5_15_5 = EdgeInsets.only(
    left: Dimens.fifteen,
    top: Dimens.five,
    right: Dimens.fifteen,
    bottom: Dimens.five,
  );
  static final EdgeInsets edgeInsets24_0_0_0 = EdgeInsets.only(
    top: Dimens.zero,
    left: Dimens.twentyFour,
    right: Dimens.zero,
    bottom: Dimens.zero,
  );

  static EdgeInsets edgeInsets16_0_16_10 = EdgeInsets.fromLTRB(
    sixteen,
    zero,
    sixteen,
    ten,
  );

  static EdgeInsets edgeInsets15_15_15_0 = EdgeInsets.fromLTRB(
    fifteen,
    fifteen,
    fifteen,
    zero,
  );

  static EdgeInsets edgeInsets16_20_16_20 = EdgeInsets.fromLTRB(
    sixteen,
    twenty,
    sixteen,
    twenty,
  );

  static EdgeInsets edgeInsets16_40_16_40 = EdgeInsets.fromLTRB(
    sixteen,
    fourty,
    sixteen,
    fourty,
  );

  static EdgeInsets edgeInsets16_25_16_25 = EdgeInsets.fromLTRB(
    sixteen,
    twentyFive,
    sixteen,
    twentyFive,
  );

  static EdgeInsets edgeInsets12_0_0_10 = EdgeInsets.fromLTRB(
    twelve,
    zero,
    zero,
    ten,
  );

  static EdgeInsets edgeInsets12_5_0_10 = EdgeInsets.fromLTRB(
    twelve,
    five,
    zero,
    ten,
  );

  static EdgeInsets edgeInsets11_10_0_5 = EdgeInsets.fromLTRB(
    eleven,
    ten,
    zero,
    five,
  );

  static EdgeInsets edgeInsets16_34_16_30 = EdgeInsets.fromLTRB(
    sixteen,
    thirtyFour,
    sixteen,
    thirty,
  );

  static EdgeInsets edgeInsets16_50_16_0 = EdgeInsets.fromLTRB(
    sixteen,
    fifty,
    sixteen,
    zero,
  );

  static EdgeInsets edgeInsets10_25_15_10 = EdgeInsets.fromLTRB(
    ten,
    twentyFive,
    fifteen,
    ten,
  );

  static EdgeInsets edgeInsets16_20_0_20 = EdgeInsets.fromLTRB(
    sixteen,
    twenty,
    zero,
    twenty,
  );

  static EdgeInsets edgeInsets20_20_20_0 = EdgeInsets.fromLTRB(
    twenty,
    twenty,
    twenty,
    zero,
  );

  static EdgeInsets edgeInsets20_20_20_10 = EdgeInsets.fromLTRB(
    twenty,
    twenty,
    twenty,
    ten,
  );

  static EdgeInsets edgeInsets16_0_16_0 = EdgeInsets.fromLTRB(
    sixteen,
    zero,
    sixteen,
    zero,
  );

  static EdgeInsets edgeInsets16_2_16_2 = EdgeInsets.fromLTRB(
    sixteen,
    two,
    sixteen,
    two,
  );

  static EdgeInsets edgeInsets16_0_16_16 = EdgeInsets.fromLTRB(
    sixteen,
    zero,
    sixteen,
    sixteen,
  );

  static EdgeInsets edgeInsets16_10_16_0 = EdgeInsets.fromLTRB(
    sixteen,
    ten,
    sixteen,
    zero,
  );

  static EdgeInsets edgeInsets16_10_16_10 = EdgeInsets.fromLTRB(
    sixteen,
    ten,
    sixteen,
    ten,
  );

  static EdgeInsets edgeInsets16_12_16_12 = EdgeInsets.fromLTRB(
    sixteen,
    twelve,
    sixteen,
    twelve,
  );

  static EdgeInsets edgeInsets16_10_16_20 = EdgeInsets.fromLTRB(
    sixteen,
    ten,
    sixteen,
    twenty,
  );

  static EdgeInsets edgeInsets15_20_24_20 = EdgeInsets.fromLTRB(
    fifteen,
    twenty,
    twentyFour,
    twenty,
  );

  static EdgeInsets edgeInsets16_16_22_0 = EdgeInsets.fromLTRB(
    sixteen,
    sixteen,
    twentyTwo,
    zero,
  );

  static EdgeInsets edgeInsets16_0_10_0 = EdgeInsets.fromLTRB(
    sixteen,
    zero,
    ten,
    zero,
  );

  static EdgeInsets edgeInsets16_5_16_0 = EdgeInsets.fromLTRB(
    sixteen,
    five,
    sixteen,
    zero,
  );

  static EdgeInsets edgeInsets0_3_0_3 = EdgeInsets.fromLTRB(
    zero,
    three,
    zero,
    three,
  );
  static EdgeInsets edgeInsets0_12_0_0 = EdgeInsets.fromLTRB(
    zero,
    twelve,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets0_15_0_0 = EdgeInsets.fromLTRB(
    zero,
    fifteen,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets16_16_16_25 = EdgeInsets.fromLTRB(
    sixteen,
    sixteen,
    sixteen,
    twentyFive,
  );

  static EdgeInsets edgeInsets24_10_15_10 = EdgeInsets.fromLTRB(
    twentyFour,
    ten,
    fifteen,
    ten,
  );

  static EdgeInsets edgeInsets80_10_80_0 = EdgeInsets.fromLTRB(
    eighty,
    ten,
    eighty,
    ten,
  );

  static EdgeInsets edgeInsets20_0_0_0 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    zero,
    zero,
  );

  static EdgeInsets edgeInsets16_10 = EdgeInsets.symmetric(
    horizontal: Dimens.sixteen,
    vertical: Dimens.ten,
  );

  static EdgeInsets edgeInsets0_16_0_0 = EdgeInsets.fromLTRB(
    zero,
    sixteen,
    zero,
    zero,
  );

  static EdgeInsets edgeInsets12_8_12_8 = EdgeInsets.fromLTRB(
    twelve,
    eight,
    twelve,
    eight,
  );

  static EdgeInsets edgeInsets16_16_0_0 = EdgeInsets.fromLTRB(
    sixteen,
    sixteen,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets16_16_16_0 = EdgeInsets.fromLTRB(
    sixteen,
    sixteen,
    sixteen,
    zero,
  );
  static EdgeInsets edgeInsets16_16_0_16 = EdgeInsets.fromLTRB(
    sixteen,
    sixteen,
    zero,
    sixteen,
  );
  static EdgeInsets edgeInsets0_16_16_0 = EdgeInsets.fromLTRB(
    zero,
    sixteen,
    sixteen,
    zero,
  );
  static EdgeInsets edgeInsets0_8_0_0 = EdgeInsets.fromLTRB(
    zero,
    eight,
    zero,
    zero,
  );

  static EdgeInsets edgeInsets0_5_0_0 = EdgeInsets.fromLTRB(
    zero,
    five,
    zero,
    zero,
  );

  static EdgeInsets edgeInsets16_8_16_8 = EdgeInsets.fromLTRB(
    sixteen,
    eight,
    sixteen,
    eight,
  );

  static EdgeInsets edgeInsets16_8_16_0 = EdgeInsets.fromLTRB(
    sixteen,
    eight,
    sixteen,
    zero,
  );

  static EdgeInsets edgeInsets16_8_16_16 = EdgeInsets.fromLTRB(
    sixteen,
    eight,
    sixteen,
    sixteen,
  );

  static EdgeInsets edgeInsets50_8_50_8 = EdgeInsets.fromLTRB(
    fifty,
    eight,
    fifty,
    eight,
  );

  static EdgeInsets edgeInsets20_0_30_0 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    thirty,
    zero,
  );

  static EdgeInsets edgeInsets40_0_40_0 = EdgeInsets.fromLTRB(
    fourty,
    zero,
    fourty,
    eight,
  );

  static EdgeInsets x = EdgeInsets.fromLTRB(
    sixteen,
    twentyFive,
    sixteen,
    zero,
  );

  static EdgeInsets edgeInsets16_35_16_0 = EdgeInsets.fromLTRB(
    sixteen,
    thirtyFive,
    sixteen,
    zero,
  );

  static EdgeInsets edgeInsets16_20_16_0 = EdgeInsets.fromLTRB(
    sixteen,
    twenty,
    sixteen,
    zero,
  );

  static EdgeInsets edgeInsets0_16_0_16 = EdgeInsets.fromLTRB(
    zero,
    sixteen,
    zero,
    sixteen,
  );

  static EdgeInsets edgeInsets0_6_0_6 = EdgeInsets.fromLTRB(
    zero,
    six,
    zero,
    six,
  );

  static EdgeInsets edgeInsets4_0_4_0 = EdgeInsets.fromLTRB(
    four,
    zero,
    four,
    zero,
  );

  static EdgeInsets edgeInsets4_2_4_2 = EdgeInsets.fromLTRB(
    four,
    two,
    four,
    two,
  );
  static EdgeInsets edgeInsets4_0_0_0 = EdgeInsets.fromLTRB(
    four,
    zero,
    zero,
    zero,
  );

  static EdgeInsets edgeInsets16_0_0_0 = EdgeInsets.fromLTRB(
    sixteen,
    zero,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets16_0_0_16 = EdgeInsets.fromLTRB(
    sixteen,
    zero,
    zero,
    sixteen,
  );
  static EdgeInsets edgeInsets0_0_16_16 = EdgeInsets.fromLTRB(
    zero,
    zero,
    sixteen,
    sixteen,
  );
  static EdgeInsets edgeInsets0_0_16_0 = EdgeInsets.fromLTRB(
    zero,
    zero,
    sixteen,
    zero,
  );
}
