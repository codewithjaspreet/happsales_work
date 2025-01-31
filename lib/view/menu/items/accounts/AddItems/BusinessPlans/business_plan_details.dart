import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/color.dart';
import '../../../contacts/widgets/CustomAppBar.dart';
import '../../../contacts/widgets/HDivider.dart';
import '../BuyingProcess/widgets/buy_sec_row.dart';
class BusinessPlanDetails extends StatelessWidget {
  const BusinessPlanDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(

        children: [

          Container(
            padding: EdgeInsets.symmetric(horizontal : 20.w,vertical: 5.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business Process Code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'HAPPSALES-ACBPL-00000000034',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: 25.w,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/contacts/edit.png'),
                )
              ],
            ),
          ),
          const BuySecondRow(
            compTitle: "Account Name",
            compSubTitle: "ABC Logistics",
          ),

          const BuySecondRow(
            compTitle: "Business Plan",
            compSubTitle: "kishore",
          ),
          const BuySecondRow(
            compTitle: "Customer Target Date",
            compSubTitle: "16 Feb 2022",
          ),


          Hdivider(),

          const BuySecondRow(compTitle: 'Is Active', compSubTitle: 'Yes'),
          Hdivider(),

          Container(
            padding: EdgeInsets.all(20.sp),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created By',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'deepak',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modified By',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created On',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '21 Sep 2022',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modified On',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

        ],
      ),





    );
  }
}
