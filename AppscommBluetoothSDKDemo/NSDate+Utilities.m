/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

/*
 #import <humor.h> : Not planning to implement: dateByAskingBoyOut and dateByGettingBabysitter
 ----
 General Thanks: sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki. Emanuele Vulcano, jcromartiej, Blagovest Dachev, Matthias Plappert,  Slava Bushtruk, Ali Servet Donmez, Ricardo1980, pip8786, Danny Thuerin, Dennis Madsen
 
 Include GMT and time zone utilities?
*/

#import "NSDate+Utilities.h"

// Thanks, AshFurrow
static const unsigned componentFlags = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit);

@implementation NSDate (Utilities)

// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        //sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
        //这里要使用公历
        sharedCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    sharedCalendar.timeZone = [NSTimeZone systemTimeZone];
    return sharedCalendar;
}

+(NSString *)currentLanguage{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [def objectForKey:@"AppleLanguages"];
    return  [languages objectAtIndex:0];
}

+(NSLocale *)currentLocale{
    return [[NSLocale alloc] initWithLocaleIdentifier:[NSDate currentLanguage]];
}

#pragma mark - Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *) dateFromString_yyyy_MM_dd_HH_mm_ss:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.calendar = [NSDate currentCalendar];
    dateFormatter.locale = [NSDate currentLocale];
    
    NSDate *destDate= [dateFormatter dateFromString:str];
    return destDate;
}

+ (NSDate *) dateFromString_yyyyMMddHH:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHH"];
    dateFormatter.calendar = [NSDate currentCalendar];
    dateFormatter.locale = [NSDate currentLocale];
    
    NSDate *destDate= [dateFormatter dateFromString:str];
    return destDate;
}

+ (NSDate *) dateFromString_yyyy_MM_dd:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    dateFormatter.calendar = [NSDate currentCalendar];
    dateFormatter.locale = [NSDate currentLocale];
    
    NSDate *destDate= [dateFormatter dateFromString:str];
    return destDate;
}



#pragma mark - String Properties
-(NSString *)chineseStringDate{
    return [self stringWithFormat:@"yyyy年M月d日"];
}
-(NSString *) stringWithFormat_yyyy_MM_dd{
    return [self stringWithFormat:@"yyyy-MM-dd"];
}

-(NSString *) stringWithFormat_yyyy_MM_dd_HH_mm_ss{
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *) stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //增加公历
    formatter.calendar = [NSDate currentCalendar];
    formatter.locale = [NSDate currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //增加公历
    formatter.calendar = [NSDate currentCalendar];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    formatter.locale = [NSDate currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) shortString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortDateString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) mediumString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumDateString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) longString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longDateString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) && 
			(components1.day == components2.day));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if (components1.weekOfYear != components2.weekOfYear) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL) isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL) isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSYearCalendarUnit fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

// Thaks, rsjohnson
- (NSDate *) dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingYears: (NSInteger) dYears
{
    return [self dateByAddingYears:-dYears];
}

- (NSDate *) dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;			
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [[NSDate currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark - Extremes

- (NSDate *) dateAtStartOfDay
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [[NSDate currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *) dateAtEndOfDay
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	components.hour = 23; // Thanks Aleksey Kononov
	components.minute = 59;
	components.second = 59;
	return [[NSDate currentCalendar] dateFromComponents:components];
}

- (NSDate *) dateAtStartOfMonth
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.day = 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates

- (NSInteger) nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [[NSDate currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
	return components.hour;
}

- (NSInteger) hour
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.hour;
}

- (NSInteger) minute
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.minute;
}

- (NSInteger) seconds
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.second;
}

- (NSInteger) day
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.day;
}

- (NSInteger) month
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.month;
}

- (NSInteger) week
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.weekOfYear;
}

- (NSInteger) weekday
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) year
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.year;
}

-(NSString *)weekdayName{
    return [[self stringWithFormat:@"EEEE"] uppercaseString];
}

-(NSString *)getBirthdayFormat{
    NSString *lan = [NSDate currentLanguage];
    
    if ([lan hasPrefix:@"zh"] || [lan hasPrefix:@"ja"]) {//中文
        return [self stringWithFormat:@"yyyy年M月d日"];
    }else if([lan isEqualToString:@"en"]){//英文
        return [self stringWithFormat:@"MM/dd/yyyy"];
    }else{//其他语言
        return [self stringWithFormat:@"dd/MM/yyyy"];
    }
}

//显示详细日期(今天有星期，否则无星期)
-(NSString *)detailDateString{
    NSString *lan = [NSDate currentLanguage];

    if ([lan hasPrefix:@"zh"]) {//中文
        if ([self isToday]) {
            return [NSString stringWithFormat:@"%@, %@",[self weekdayName], [self chineseStringDate]];//星期一, 2014年12月27日
        }else{
            return [self chineseStringDate];//2014年12月27日
        }
    }else if([lan isEqualToString:@"en"]){//英文
        NSString *dateString = [self stringWithFormat:@"EEEE-MMMM-d-yyyy"];//Saturday-November-3-2014
        NSArray *dateArray = [dateString componentsSeparatedByString:@"-"];
        NSString *dayString = @"";
        if (self.day == 1 || self.day == 21 || self.day == 31) {
            dayString = [NSString stringWithFormat:@"%dst", self.day];
        }else if(self.day == 2 || self.day == 22){
            dayString = [NSString stringWithFormat:@"%dnd", self.day];
        }else if(self.day == 3 || self.day == 23){
            dayString = [NSString stringWithFormat:@"%drd", self.day];
        }else{
            dayString = [NSString stringWithFormat:@"%dth", self.day];
        }
        if ([self isToday]) {
            return [NSString stringWithFormat:@"%@, %@ %@ %@",dateArray[0], dateArray[1], dayString, dateArray[3]];//Saturday,November 3rd 2014
        }else{
            return [NSString stringWithFormat:@"%@ %@ %@",dateArray[1], dayString, dateArray[3]];//November 3rd 2014
        }
    }else if([lan isEqualToString:@"ja"]){
        if ([self isToday]) {
            return [self stringWithFormat:@"yyyy年M月d日 EEEE"];//2015年3月7日 土曜日
        }else{
            return [self stringWithFormat:@"yyyy年M月d日"];//2015年3月7日
        }
    }else{//其他语言
        if ([self isToday]) {
            return [self stringWithFormat:@"EEEE d MMMM yyyy"];//Saturday 3 November 2014
        }else{
            return [self stringWithFormat:@"d MMMM yyyy"];//3 November 2014
        }
    }
}

-(NSInteger)daysOfMonth{
    
    return [self getDaysOfMonthWithYear:self.year andMonth:self.month];
}

/**
 * 计算每个月的天数
 *
 * @param year 年份
 * @param month 月份
 * @return  每个月的天数
 */
-(NSInteger) getDaysOfMonthWithYear:(int)year andMonth:(int) month
{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects: @31, @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31, nil];

    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
    {
        arr[1] = @29; // 闰年2月29天
    }
    
    int days = [arr[month - 1] intValue];
    
    return days;
}

+(NSInteger)offsetFromGMTToLocalTimeZone{
    NSDate * originalDate = [NSDate date];
 //   NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
 //   NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:originalDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:originalDate];
    //NSInteger interval = (NSInteger)(destinationGMTOffset - sourceGMTOffset);
   // NSLog(@"相对于零时区便宜的小时:%d", interval / 3600);
    return destinationGMTOffset;
}
@end