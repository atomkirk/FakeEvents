//
//  FEFakeData.m
//  fakeevents
//
//  Created by Adam Kirk on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FEFakeData.h"

static FEFakeData *sharedInstance = nil;

@implementation FEFakeData

@synthesize wdArray;
@synthesize fnArray;
@synthesize lnArray;
@synthesize snArray;
@synthesize cities;
@synthesize states;


+ (FEFakeData *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super alloc] init];
    }
    return sharedInstance;
}








+ (NSArray *)generateRandomAlarms
{
	NSMutableArray *alarms = [NSMutableArray array];
	int alarmCount = rand() % 6;
    for (int i = 0; i < alarmCount; i++) {
        [alarms addObject:[FEFakeData generateRandomAlarm]];
    }
    return alarms;
}

+ (EKAlarm *)generateRandomAlarm {
	int r = rand() % 15;
	int array[15];
	array[0] = 0;
	array[1] = 300;
	array[2] = 900;
	array[3] = 1800;
	array[4] = 3600;
	array[5] = 7200;
	array[6] = 21600;
	array[7] = 43200;
	array[8] = 86400;
	array[9] = 172800;
	array[10] = 259200;
	array[11] = 432000;
	array[12] = 604800;
	array[13] = 1209600;
	array[14] = 2592000;
    return [EKAlarm alarmWithRelativeOffset:-array[r]];
}

+ (BOOL)generateRandomAllDay {
    int r = rand() % 2;
    return r == 0 ? YES : NO;
}

+ (EKEventAvailability)generateRandomAvailability {
    int r = rand() % 5;
	EKEventAvailability array[5];
	array[0] = EKEventAvailabilityNotSupported;
	array[1] = EKEventAvailabilityBusy;
	array[2] = EKEventAvailabilityFree;
	array[3] = EKEventAvailabilityTentative;
	array[4] = EKEventAvailabilityUnavailable;
    return array[r];
}

+ (NSDate *)generateRandomStartDate {
    NSDate *minDate = [FEEventStore getMinDate];
    NSDate *maxDate = [FEEventStore getMaxDate];
    int minUnix = [minDate timeIntervalSince1970];
    int maxUnix = [maxDate timeIntervalSince1970];
    int range = maxUnix - minUnix;
    int r = rand() % range;
    int randUnix = minUnix + r;
    NSDate *randDate = [NSDate dateWithTimeIntervalSince1970:randUnix];
    return randDate;
}

+ (NSDate *)generateRandomEndDateGivenStartDate:(NSDate *)startDate {
	int r = rand() % 13;
	int array[13];
	array[0] = 0;
	array[1] = 900;
	array[2] = 1800;
	array[3] = 2700;
	array[4] = 3600;
	array[5] = 5400;
	array[6] = 7200;
	array[7] = 10800;
	array[8] = 14400;
	array[9] = 18000;
	array[10] = 21600;
	array[11] = 86400;
	array[12] = 172800;
    NSDate *endDate = [startDate dateByAddingTimeInterval:array[r]];
    return endDate;
}

+ (NSString *)generateRandomLocation {
    NSString *location = [NSString stringWithFormat:@"%@, %@, %@  %@",  [FEFakeData generateRandomStreet],
                                                                        [FEFakeData generateRandomCity],
                                                                        [FEFakeData generateRandomState],
                                                                        [FEFakeData generateRandomZipCode]];

    return location;
}

+ (NSString *)generateRandomNote
{
    FEFakeData *instance = [FEFakeData sharedInstance];
    if (!instance.wdArray) {
        NSString *words = @"Apple,today,introduced,iCloud,a,breakthrough,set,of,free,new,cloud,services,that,work,seamlessly,with,applications,on,your,iPhone,iPad,iPod,touch,Mac,or,PC,to,automatically,and,wirelessly,store,your,content,in,iCloud,and,automatically,and,wirelessly,push,it,to,all,your,devices,When,anything,changes,on,one,of,your,devices,all,of,your,devices,are,wirelessly,updated,almost,instantly,Today,it,is,a,real,hassle,and,very,frustrating,to,keep,all,your,information,and,content,up-to-date,across,all,your,devices,said,Steve,Jobs,Apple's,CEO,iCloud,keeps,your,important,information,and,content,up,to,date,across,all,your,devices,All,of,this,happens,automatically,and,wirelessly,and,because,it's,integrated,into,our,apps,you,don't,even,need,to,think,about,it—it,all,just,works,The,free,iCloud,services,include,The,former,MobileMe,services—Contacts,Calendar,and,Mail—all,completely,re-architected,and,rewritten,to,work,seamlessly,with,iCloud,Users,can,share,calendars,with,friends,and,family,and,the,ad-free,push,Mail,account,is,hosted,at,Your,inbox,and,mailboxes,are,kept,up-to-date,across,all,your,iOS,devices,and,computers,The,App,Store™,and,iBookstore℠,now,download,purchased,iOS,apps,and,books,to,all,your,devices,not,just,the,device,they,were,purchased,on,In,addition,the,App,Store,and,iBookstore,now,let,you,see,your,purchase,history,and,simply,tapping,the,iCloud,icon,will,download,any,apps,and,books,to,any,iOS,device,up,to,10,devices,at,no,additional,cost,iCloud,Backup,automatically,and,securely,backs,up,your,iOS,devices,to,iCloud,daily,over,Wi-Fi,when,you,charge,your,iPhone,iPad,or,iPod,touch,Backed,up,content,includes,purchased,music,apps,and,books,Camera,Roll,photos,and,videos,device,settings,and,app,data,If,you,replace,your,iOS,device,just,enter,your,Apple,ID,and,password,during,setup,and,iCloud,restores,your,new,device,iCloud,Storage,seamlessly,stores,all,documents,created,using,iCloud,Storage,APIs,and,automatically,pushes,them,to,all,your,devices,When,you,change,a,document,on,any,device,iCloud,automatically,pushes,the,changes,to,all,your,devices,Apple's,Pages,Numbers,and,Keynote,apps,already,take,advantage,of,iCloud,Storage,Users,get,up,to,5GB,of,free,storage,for,their,mail,documents,and,backup—which,is,more,amazing,since,the,storage,for,music,apps,and,books,purchased,from,Apple,and,the,storage,required,by,Photo,Stream,doesn't,count,towards,this,5GB,total,Users,will,be,able,to,buy,even,more,storage,with,details,announced,when,iCloud,ships,this,fall,iCloud's,innovative,Photo,Stream,service,automatically,uploads,the,photos,you,take,or,import,on,any,of,your,devices,and,wirelessly,pushes,them,to,all,your,devices,and,computers,So,you,can,use,your,iPhone,to,take,a,dozen,photos,of,your,friends,during,the,afternoon,baseball,game,and,they,will,be,ready,to,share,with,the,entire,group,on,your,iPad,or,even,Apple,TV,when,you,return,home,Photo,Stream,is,built,into,the,photo,apps,on,all,iOS,devices,iPhoto,on,Macs,and,saved,to,the,Pictures,folder,on,a,PC,To,save,space,the,last,1000,photos,are,stored,on,each,device,so,they,can,be,viewed,or,moved,to,an,album,to,save,forever,Macs,and,PCs,will,store,all,photos,from,the,Photo,Stream,since,they,have,more,storage,iCloud,will,store,each,photo,in,the,cloud,for,30,days,which,is,plenty,of,time,to,connect,your,devices,to,iCloud,and,automatically,download,the,latest,photos,from,Photo,Stream,via,Wi-Fi,iTunes,in,the,Cloud,lets,you,download,your,previously,purchased,iTunes,music,to,all,your,iOS,devices,at,no,additional,cost,and,new,music,purchases,can,be,downloaded,automatically,to,all,your,devices,In,addition,music,not,purchased,from,iTunes,can,gain,the,same,benefits,by,using,iTunes,Match,a,service,that,replaces,your,music,with,a,256,kbps,AAC,DRM-free,version,if,we,can,match,it,to,the,over,18,million,songs,in,the,iTunes,Store,it,makes,the,matched,music,available,in,minutes,instead,of,weeks,to,upload,your,entire,music,library,and,uploads,only,the,small,percentage,of,unmatched,music,iTunes,Match,will,be,available,this,fall,for,a,$2499,annual,fee,Apple,today,is,releasing,a,free,beta,version,of,iTunes,in,the,Cloud,without,iTunes,Match,for,iPhone,iPad,and,iPod,touch,users,running,iOS,43,iTunes,in,the,Cloud,will,support,all,iPhones,that,iOS,5,supports,this,fall,Apple,is,ready,to,ramp,iCloud,in,its,three,data,centers,including,the,third,recently,completed,in,Maiden,NC,Apple,has,invested,over,$500,million,in,its,Maiden,data,center,to,support,the,expected,customer,demand,for,the,free,iCloud,services,Pricing,&,Availability,The,iCloud,beta,and,Cloud,Storage,APIs,are,available,immediately,to,iOS,and,Mac,Developer,Program,members,at,iCloud,will,be,available,this,fall,concurrent,with,iOS,5,Users,can,sign,up,for,iCloud,for,free,on,an,iPhone,iPad,or,iPod,touch,running,iOS,5,or,a,Mac,running,Mac,OS,X,Lion,with,a,valid,Apple,ID,iCloud,includes,5GB,of,free,cloud,storage,for,Mail,Document,Storage,and,Backup,Purchased,music,apps,books,and,Photo,Stream,do,not,count,against,the,storage,limit,iTunes,Match,will,be,available,for,$2499,per,year,US,only,iTunes,in,the,Cloud,is,available,today,in,the,US,and,requires,iTunes,103,and,iOS,433,Automatic,download,of,apps,and,books,is,available,today,Using,iCloud,with,a,PC,requires,Windows,Vista,or,Windows,7;,Outlook,2010,or,2007,is,recommended,for,accessing,contacts,and,calendars,Apple,designs,Macs,the,best,personal,computers,in,the,world,along,with,OS,X,iLife,iWork,and,professional,software,Apple,leads,the,digital,music,revolution,with,its,iPods,and,iTunes,online,store,Apple,has,reinvented,the,mobile,phone,with,its,revolutionary,iPhone,and,App,Store,and,has,recently,introduced,iPad,2,which,is,defining,the,future,of,mobile,media,and,computing,devices";
		instance.wdArray = [words componentsSeparatedByString:@","];
    }
    
	NSMutableString *note = [NSMutableString string];
	int words = (rand() % 40) + 1;
	for (int i = 0; i < words; i++) {
		int i = rand() % instance.wdArray.count;
		NSString *randomWord = [instance.wdArray objectAtIndex:i];
		[note appendString:randomWord];
        if (i != 0) [note appendString:@" "];
	}
	return note;
}


+ (EKRecurrenceRule *)generateRandomRecurrenceRuleWithEndDate:(NSDate *)endDate {
    int r = rand() % 4;
    EKRecurrenceRule *rule;
    if (r == 0) {
        EKRecurrenceFrequency p1    = [FEFakeData generateRandomRecurrenceFrequency];
        int p2                      = [FEFakeData generateRandomRecurrenceInterval];
        NSArray *p3                 = [FEFakeData generateRandomDaysOfTheWeek];
        NSArray *p4                 = [FEFakeData generateRandomDaysOfTheMonth];
        NSArray *p5                 = [FEFakeData generateRandomMonthsOfTheYear];
        NSArray *p6                 = [FEFakeData generateRandomWeeksOfTheYear];
        NSArray *p7                 = [FEFakeData generateRandomDaysOfTheYear];
        EKRecurrenceEnd *p8         = [EKRecurrenceEnd recurrenceEndWithEndDate:endDate];
        
        rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:p1
                                                            interval:p2
                                                       daysOfTheWeek:p3
                                                      daysOfTheMonth:p4
                                                     monthsOfTheYear:p5
                                                      weeksOfTheYear:p6
                                                       daysOfTheYear:p7
                                                        setPositions:nil
                                                                 end:p8];      
    } else if (r == 1) {
        EKRecurrenceFrequency p1    = [FEFakeData generateRandomRecurrenceFrequency];
        int p2                      = [FEFakeData generateRandomRecurrenceInterval];
        NSArray *p3                 = [FEFakeData generateRandomDaysOfTheWeek];
        NSArray *p4                 = [FEFakeData generateRandomDaysOfTheMonth];
        NSArray *p5                 = [FEFakeData generateRandomMonthsOfTheYear];
        NSArray *p6                 = [FEFakeData generateRandomWeeksOfTheYear];
        NSArray *p7                 = [FEFakeData generateRandomDaysOfTheYear];
        EKRecurrenceEnd *p8         = [EKRecurrenceEnd recurrenceEndWithEndDate:endDate];
        
        rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:p1
                                                            interval:p2
                                                       daysOfTheWeek:p3
                                                      daysOfTheMonth:p4
                                                     monthsOfTheYear:p5
                                                      weeksOfTheYear:p6
                                                       daysOfTheYear:p7
                                                        setPositions:nil
                                                                 end:p8];
        
    } else if (r == 2) {
        EKRecurrenceFrequency p1    = [FEFakeData generateRandomRecurrenceFrequency];
        int p2                      = [FEFakeData generateRandomRecurrenceInterval];
        NSArray *p3                 = [FEFakeData generateRandomDaysOfTheWeek];
        NSArray *p4                 = [FEFakeData generateRandomDaysOfTheMonth];
        NSArray *p5                 = [FEFakeData generateRandomMonthsOfTheYear];
        NSArray *p6                 = [FEFakeData generateRandomWeeksOfTheYear];
        NSArray *p7                 = [FEFakeData generateRandomDaysOfTheYear];
        EKRecurrenceEnd *p8         = [EKRecurrenceEnd recurrenceEndWithEndDate:endDate];
        
        rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:p1
                                                              interval:p2
                                                         daysOfTheWeek:p3
                                                        daysOfTheMonth:p4
                                                       monthsOfTheYear:p5
                                                        weeksOfTheYear:p6
                                                         daysOfTheYear:p7
                                                          setPositions:nil
                                                                   end:p8];

    } else if (r == 3) {
        EKRecurrenceFrequency p1    = [FEFakeData generateRandomRecurrenceFrequency];
        int p2                      = [FEFakeData generateRandomRecurrenceInterval];
        NSArray *p3                 = [FEFakeData generateRandomDaysOfTheWeek];
        NSArray *p4                 = [FEFakeData generateRandomDaysOfTheMonth];
        NSArray *p5                 = [FEFakeData generateRandomMonthsOfTheYear];
        NSArray *p6                 = [FEFakeData generateRandomWeeksOfTheYear];
        NSArray *p7                 = [FEFakeData generateRandomDaysOfTheYear];
        EKRecurrenceEnd *p8         = [EKRecurrenceEnd recurrenceEndWithEndDate:endDate];
        
        rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:p1
                                                            interval:p2
                                                       daysOfTheWeek:p3
                                                      daysOfTheMonth:p4
                                                     monthsOfTheYear:p5
                                                      weeksOfTheYear:p6
                                                       daysOfTheYear:p7
                                                        setPositions:nil
                                                                 end:p8];
    }
    return rule;
}



+ (NSString *)generateRandomTitle {
    FEFakeData *instance = [FEFakeData sharedInstance];
    if (!instance.wdArray) {
        NSString *activities = @"Be romantic,Fill a whole,Climb a tree,Shave ice,Feed the homeless,Talk politics,Start a band,Lunch,Breakfast,Yoga,Yogurt,Brunch,Astronomy,Dinner,Supper,Elevensies,Biking,Bikini waxing,Metal detecting,Read vegetarian cookbooks,Crying in movies,Emo rocking,Restoring antique ladels,Collect paper clips,Domino toppling,Bubble wrap appreciation,Cry over spilled milk,Talk in an elevator,Eat crackers over the keyboard,Donate plasma,Cuddle,Forage for wild cabbage,Appreciate squirrels,Eat fudge brownies,Aircraft Spotting,Aeromodeling,Amateur Astronomy,Amateur Radio,Art,Backgammon,Baseball,Basketball,Beach/Sun tanning,Beachcombing,Beadwork,Beatboxing,Becoming A Child Advocate,Bell Ringing,Belly Dancing,Bicycling,Bird watching,Birding,BMX,Blogging,BoardGames,Boating,Body Building,Bonsai Tree,Bowling,Brewing Beer,Bridge,Building Dollhouses,Butterfly Watching,Button Collecting,Calligraphy,Camping,Candle Making,Canoeing,Car Racing,Casino Gambling,Cave Diving,Chess,Cloud Watching,Coin Collecting,Compose Music,Computer activities,Cooking,Crafts,Crafts (unspecified),Crochet,Crocheting,Cross-Stitch,Crossword Puzzles,Dancing,Diecast Collectibles,Digital Photography,Dolls,Dominoes,Drawing,Dumpster Diving,Eating out,Educational Courses,Electronics,Embroidery,Entertaining,Exercise (aerobics, weights),Fast cars,Fencing,Fishing,Football,Four Wheeling,Freshwater Aquariums,Frisbee Golf,Frolf,Games,Gardening,Geocaching,Going to a movie,Golf,Go Kart Racing,Grip Strength testing,Guitar,Handwriting Analysis,Hang gliding,Hiking,Home Brewing,Home Repair,Home Theater,Horse riding,Hot air ballooning,Hula Hooping,Hunting,Illusion,Internet browsing,Jet Engines,Jewelry Making,Jigsaw Puzzles,Juggling,Keep A Journal,Kites,Kite Boarding,Knitting,Knotting,Learn to Play Poker,Learning A Foreign Language,Learning An Instrument,Learning To Pilot A Plane,Legos,Listening to music,Macramé,Magic,Making Model Cars,Matchstick Modeling,Meditation,Metal Detecting,Model Rockets,Modeling Ships,Models,Motorcycles,Mountain Biking,Mountain Climbing,Musical Instruments,Needlepoint,Owning An Antique Car,Origami,Painting,Paintball,Papermaking,Papermache,Parachuting,People Watching,Photography,Piano,Pinochle,Playing music,Playing team sports,Pottery,Puppetry,Pyrotechnics,Quilting,Rafting,Railfans,R/C Boats,R/C Cars,R/C Helicopters,R/C Planes,Reading,Relaxing,Renting movies,Robotics,Rock Collecting,Rockets,Running,Saltwater Aquariums,Scrapbooking,Scuba Diving,Sewing,Shark Fishing,Skeet Shooting,Shopping,Singing In Choir,Skateboarding,Sketching,Sky Diving,Sleeping,Snorkeling,Soap Making,Soccer,Socializing,Spelunkering,Spending time,Stamp Collecting,Storytelling,String Figures,Surf Fishing,Swimming,Tea Tasting,Tennis,Tesla Coils,Tetris,Textiles,Tombstone Rubbing,Tool Collecting,Toy Collecting,Train Collecting,Train Spotting,Travel,Traveling,Treasure Hunting,Trekkie,Tutoring Children,TV watching,Urban Exploration,Video Games,Volunteer,Walking,Warhammer,Watching sporting events,Windsurfing,Wine Making,Woodworking,Working In A Food Pantry,Working on cars,Writing,Yoga,YoYo";
		NSString *firstNames = @"Jacob,Isabella,Ethan,Emma,Michael,Olivia,Alexander,Sophia,William,Ava,Joshua,Emily,Daniel,Madison,Jayden,Abigail,Noah,Chloe,Anthony,Mia,Christopher,Elizabeth,Aiden,Addison,Matthew,Alexis,David,Ella,Andrew,Samantha,Joseph,Natalie,Logan,Grace,James,Lily,Ryan,Alyssa,Benjamin,Ashley,Elijah,Sarah,Gabriel,Taylor,Christian,Hannah,Nathan,Brianna,Jackson,Hailey,John,Kaylee,Samuel,Lillian,Tyler,Leah,Dylan,Anna,Jonathan,Allison,Caleb,Victoria,Nicholas,Avery,Gavin,Gabriella,Mason,Nevaeh,Evan,Kayla,Landon,Sofia,Angel,Brooklyn,Brandon,Riley,Lucas,Evelyn,Isaac,Savannah,Isaiah,Aubrey,Jack,Alexa,Jose,Peyton,Kevin,Makayla,Jordan,Layla,Justin,Lauren,Brayden,Zoe,Luke,Sydney,Liam,Audrey,Carter,Julia,Owen,Jasmine,Connor,Arianna,Zachary,Claire,Aaron,Brooke,Robert,Amelia,Hunter,Morgan,Thomas,Destiny,Adrian,Bella,Cameron,Madelyn,Wyatt,Katherine,Chase,Kylie,Julian,Maya,Austin,Aaliyah,Charles,Madeline,Jeremiah,Sophie,Jason,Kimberly,Juan,Kaitlyn,Xavier,Charlotte,Luis,Alexandra,Sebastian,Jocelyn,Henry,Maria,Aidan,Valeria,Ian,Andrea,Adam,Trinity,Diego,Zoey,Nathaniel,Gianna,Brody,Mackenzie,Jesus,Jessica,Carlos,Camila,Tristan,Faith,Dominic,Autumn,Cole,Ariana,Alex,Genesis,Cooper,Payton,Ayden,Bailey,Carson,Angelina,Josiah,Caroline,Levi,Mariah,Blake,Katelyn,Eli,Rachel,Hayden,Vanessa,Bryan,Molly,Colton,Melanie,Brian,Serenity,Eric,Khloe,Parker,Gabrielle,Sean,Paige,Oliver,Mya,Miguel,Eva,Kyle,Isabelle,Jaden,Lucy,Kaden,Mary,Caden,Natalia,Max,Michelle,Antonio,Megan,Steven,Sara,Riley,Naomi,Kaleb,Ruby,Brady,Jennifer,Timothy,Isabel,Bryce,Sadie,Colin,Stephanie,Jesse,Jada,Richard,Kennedy,Joel,Gracie,Ashton,Rylee,Victor,Lilly,Micah,Lydia,Vincent,Nicole,Preston,Liliana,Alejandro,London,Nolan,Jenna,Marcus,Haley,Devin,Jordyn,Jake,Adriana,Jaxon,Stella,Damian,Jayla,Eduardo,Reagan,Patrick,Jade,Santiago,Amy,Oscar,Hayden,Giovanni,Rebecca,Maxwell,Kendall,Collin,Giselle,Cody,Laila,Ivan,Daniela,Edward,Melissa,Kayden,Valerie,Jeremy,Gabriela,Seth,Keira,Gage,Violet,Alan,Angela,Cayden,Katie,Grant,Reese,Ryder,Ellie,Emmanuel,Ashlyn,Peyton,Piper,Jonah,Kylee,Trevor,Marley,Hudson,Jordan,Bryson,Briana,Kenneth,Lyla,Omar,Daisy,Mark,Juliana,Jorge,Mckenzie,Conner,Annabelle,Nicolas,Jillian,Elias,Aliyah,Tanner,Kate,Paul,Leslie,Cristian,Brooklynn,Miles,Jacqueline,George,Izabella,Leonardo,Vivian,Asher,Diana,Jace,Amanda,Malachi,Shelby,Ricardo,Lila,Kaiden,Scarlett,Derek,Danielle,Jaiden,Adrianna,Grayson,Makenzie,Andres,Alana,Braxton,Harper,Jaylen,Summer,Wesley,Angel,Travis,Catherine,Fernando,Alivia,Shane,Mikayla,Maddox,Aniyah,Francisco,Miranda,Jude,Ana,Abraham,Marissa,Garrett,Cheyenne,Braden,Skylar,Alexis,Amber,Javier,Margaret,Lincoln,Jayden,Damien,Miley,Erick,Julianna,Peter,Delilah,Josue,Malia,Edwin,Eliana,Camden,Erin,Rylan,Elena,Manuel,Sienna,Bradley,Nora,Mario,Sierra,Cesar,Clara,Edgar,Alexandria,Stephen,Josephine,Sawyer,Amaya,Jaxson,Valentina,Hector,Breanna,Johnathan,Eden,Roman,Ariel,Landen,Alicia,Trenton,Tessa,Leo,Jazmin,Shawn,Kelsey,Israel,Elise,Brendan,Haylee,Jared,Mckenna,Kai,Sabrina,Donovan,Kathryn,Jeffrey,Carly,Braylon,Aurora,Spencer,Eleanor,Andy,Mariana,Andre,Alexia,Raymond,Lola,Ty,Cadence,Avery,Alondra,Sergio,Jazmine,Kingston,Melody,Tucker,Addyson,Ezekiel,Alison,Keegan,Kayleigh,Mateo,Karen,Drake,Christina,Calvin,Chelsea,Erik,Maggie,Griffin,Hope,Martin,Allie,Zane,Laura,Chance,Bianca,Troy,Jayda,Tyson,Leila,Dalton,Kendra,Zion,Kara,Marco,Delaney,Harrison,Ryleigh,Brennan,Makenna,Xander,Cassidy,Lukas,Brielle,Dominick,Camryn,Roberto,Nadia,Gregory,Alina,Maximus,Callie,Cash,Alaina,Dakota,Allyson,Easton,Penelope,Aden,Kaydence,Silas,Harmony,Malik,Caitlyn,Rafael,Fernanda,Johnny,Abby,Quinn,Alice,Ezra,Lexi,Caiden,Kelly,Skyler,Sasha,Graham,Kyla,Simon,Caylee,Axel,Leilani,Myles,Cecilia,Emanuel,Caitlin,Kyler,Esther,Pedro,Presley,Weston,Ashlynn,Emiliano,Mallory,Aaden,Kyra,Drew,Alejandra,Clayton,Fatima,Charlie,Teagan,Kameron,Heaven,Theodore,Dakota,Devon,Alayna,Corbin,Eliza,Marcos,Veronica,Amir,Tiffany,Ruben,Maddison,Luca,Crystal,Fabian,Jasmin,Colby,Aubree,Dawson,Kiara,Angelo,Macy,Grady,Camille,Anderson,Genevieve,Frank,Madilyn,Zander,Nina,Dante,Kamryn,Dillon,Angelica,Adan,Karina,Joaquin,Hazel,Corey,Karla,Derrick,Maliyah,Elliot,Heidi,Taylor,Esmeralda,Brock,Guadalupe,Amari,Kira,Armando,Joanna,Trent,Carmen,Tristen,Cora,Julio,Aniya,Dean,Lucia,Lane,Daniella,Enrique,Courtney,Declan,Jamie,Bennett,Kyleigh,Braydon,Miriam,Emilio,Ximena,Allen,Emely,Raul,Fiona,Trey,Josie,Julius,Willow,Gael,Katelynn,Danny,Iris,Dustin,Paisley,Jameson,Juliet,Everett,Ivy,Randy,Emerson,Gerardo,Luna,Cohen,Selena,Cade,Anastasia,Jakob,Phoebe,Judah,Lindsey,Paxton,Cassandra,Abel,Savanna,Jaime,Analia,Payton,Kailey,Keith,Madeleine,Emmett,Angie,Holden,Kaelyn,Darius,Janiyah,Lorenzo,Joselyn,Rowan,Emery,Jasper,Georgia,Dallas,Madalyn,Felix,Rylie,Phillip,Monica,Ronald,Kiera,Scott,Bethany,Finn,Brynn,Pablo,Norah,Jayson,Dulce,Cruz,Isla,Greyson,Jaelyn,Reid,Erica,Leland,Julissa,Elliott,Kaylie,Brayan,Adeline,Brenden,Rose,Ryker,April,Louis,Julie,Saul,Audrina,Ismael,Cameron,Jayce,Ruth,Chris,Tatiana,Mitchell,Madisyn,Nehemiah,Kiley,Jalen,Hadley,Gustavo,Cynthia,Dennis,Anya,Donald,Rebekah,Zackary,Ciara,Casey,Lilah,Phoenix,Talia,Dane,Londyn,Jimmy,Adalyn,Colt,Michaela,Jerry,Nayeli,Ali,Kaylin,Rodrigo,Lia,Braeden,Erika,Quentin,Madelynn,Arthur,Lilliana,Tony,Raegan,Arturo,Baylee,Jonas,Danica,Keaton,Holly,Esteban,Paola,Mathew,Annie,Mauricio,Lizbeth,Desmond,Jazlyn,Larry,Janiya,Alberto,Jane,Walter,Carolina,Moises,Rihanna,Rocco,Helen,Jett,Danna,Brett,Jimena,Colten,Nyla,Curtis,Serena,Darren,Shayla,Philip,Tatum,Beau,Sage,Landyn,Ayla,Izaiah,Itzel,Zayden,Sarai,Gunner,Emilia,Byron,Marlee,Uriel,Kadence,Marshall,Brenda,Albert,Janelle,Alec,Adelyn,Jamari,Madyson,Kade,Natasha,Bryant,Lyric,Hugo,Kimora,Orlando,Imani,Romeo,Macie,Braylen,Paris,Beckett,Amiyah,Jay,Estrella,Marvin,Priscilla,Ramon,Annika,Ricky,Ainsley,Jaydon,Lena,Yahir,Skyler,Kobe,Nataly,Issac,Dayana,Reed,Hayley,Alfredo,Harley,Salvador,Bridget,Eddie,Brylee,Jax,Lillie,Davis,Melany,Justice,Kinsley,Kellen,Evangeline,Mohamed,Athena,Reece,Lacey,Zachariah,Addisyn,August,Viviana,Russell,Noelle,Kristopher,Cali,Talon,Lilian,Emerson,Aubrie,Lance,Emilee,Titus,Juliette,Lawrence,Hanna,Maurice,Kayden,Tate,Elle,Nikolas,Kassidy,Jacoby,Brenna,Leon,Kailyn,Mekhi,Desiree,Nickolas,Arabella,River,Lana,Karson,Kenzie,Camron,Denise,Milo,Kinley,Gary,Jadyn,Joe,Logan,Matteo,Alissa,Nasir,Aileen,Brycen,Melina,Morgan,Abbigail,Solomon,Anahi,Walker,Celeste,Maximiliano,Brittany,Ernesto,Annabella,King,Elaina,Warren,Miracle,Douglas,Mila,Bruce,Kennedi,Davion,Lauryn,Kolton,Cara,Sam,Danika,Chandler,Nancy,Leonel,Francesca,Porter,Anaya,Nathanael,Marisol,Alijah,Alessandra,Jaylin,Johanna,Reese,Alanna,Johan,Daphne,Kelvin,Asia,Waylon,Yaretzi,Maximilian,Yasmin,Ahmad,Amira,Pierce,Alyson,Isaias,Claudia,Terrance,Braelyn,Braiden,Amari,Cullen,Nathalie,Kason,Quinn,Jamarion,Jaylynn,Brooks,Meredith,Noel,Nia,Brodie,Jaliyah,Deandre,Skye,Khalil,Isabela,Abram,Rosa,Javon,Meghan,Rodney,Gloria,Roger,Rowan,Skylar,Journey,Shaun,Lexie,Micheal,Kali,Cory,Zariah,Guillermo,Diamond,Kane,Parker,Jonathon,Lesly,Moses,Saniyah,Jadon,Wendy,Tobias,Whitney,Adriel,Aylin,Chad,Mikaela,Dorian,Kaylynn,Kristian,Samara,Melvin,Hailee,Conor,Yareli,Kale,Aria,Keagan,Kamila,Cristopher,Elliana,Kieran,Sandra,London,Amya,Bentley,Perla,Damon,Aleah,Cyrus,Jaida,Dayton,Liberty,Nelson,Lilyana,Carl,Kristina,Quincy,Lindsay,Yandel,Natalee,Ari,Finley,Chace,Joy,Quinton,Casey,Orion,Sidney,Franklin,Dana,Rohan,Cindy,Kamari,Vivienne,Trace,Anika,Isiah,Kristen,Julien,Hallie,Frederick,Myla,Kendrick,Laney,Dominik,Jaden,Wilson,Jaelynn,Boston,Madalynn,Cason,Patricia,Gianni,Sherlyn,Maverick,Sylvia,Noe,Anne,Dexter,Saniya,Jamison,Janessa,Demetrius,Kiana,Finnegan,Skyla,Gideon,Jayleen,Triston,Madilynn,Gunnar,Camilla,Armani,Halle,Asa,Linda,Terry,Elisabeth,Jeffery,Tori,Ariel,Dylan,Allan,Justice,Roy,Heather,Aldo,America,Marc,Anabelle,Tommy,Arielle,Ezequiel,Jaiden,Felipe,Bailee,Ibrahim,Kathleen,Jermaine,Shannon,Ronan,Haven,Barrett,Adelaide,Karter,Gemma,Ryland,Kassandra,Alvin,Lucille,Brendon,Marie,Harley,Gracelyn,Jessie,Ada,Tomas,Brisa,Madden,Helena,Will,Aryanna,Rhys,Kaitlin,Terrence,Taryn,Bobby,Amani,Brennen,Aleena,Giovani,Ryan,Terrell,Eve,Remington,Liana,Ahmed,Marilyn,Nico,Gwendolyn,Xzavier,Amara,Jefferson,Haleigh,Tristin,Olive,Billy,Aspen,Branden,Gia,Kamden,Maeve,Enzo,Maia,Jon,Maleah,Uriah,Myah,Kian,Kaia,Kody,Yesenia,Kole,Catalina,Reginald,Kaliyah,Ulises,Cheyanne,Kendall,Deanna,Omari,Lorelei,Malcolm,Clarissa,Muhammad,Giana,Lucian,Shiloh,Memphis,Zoie,Javion,Alisson,Mohammad,Aiyana,Ace,Bryanna,Atticus,Tiana,Steve,Scarlet,Alonzo,Jaylee,Jamal,Marina,Rene,Rachael,Marquis,Isis,Joey,Allisson,Moshe,Charlie,Kenny,Virginia,Rashad,Jaylin,Urijah,Jaycee,Kasen,Simone,Bradyn,Briley,Aydan,Amiya,Cannon,Christine,Wade,Ashlee,Gerald,Siena,Willie,Irene,Neil,Abril,Toby,Kenya,Brent,Destinee,Jase,Julianne,Jaylon,Kaleigh,Kellan,Paulina,Malakai,Ayanna,Raphael,Kaitlynn,Jadiel,Elisa,Jaeden,Raven,Blaine,Adrienne,Lawson,Carlee,Zachery,Arely,Davin,Jaidyn,Johnathon,Raquel,Markus,Sariah,Mohammed,Mercedes,Jairo,Haylie,Draven,Kailee,Aydin,Nylah,Alfonso,Tabitha,Teagan,Annalise,Alessandro,Kirsten,Harry,Krystal,Amare,Elyse,Sullivan,Jaylene,Ben,Aliya,Layne,Teresa,Luciano,Taliyah,Marlon,Barbara,Aron,Maci,Rhett,Ansley,Alonso,Kenley,Kolby,Dahlia,Lee,Jazlynn,Giovanny,June,Messiah,Mariam,Ronnie,Gisselle,Craig,Carla,Damion,Bristol,Darian,Jakayla,Cale,Mckayla,Jamie,Leighton,Raiden,Jaslene,Tripp,Lea,Ray,Adalynn,Nash,Jolie,Semaj,Karlee,Makai,Amelie,Stanley,Brynlee,Giancarlo,Joslyn,Trevon,Mariyah,Archer,Elsie,Francis,Paityn,Jerome,Kaylen,Deven,Martha,Tyrone,Luciana,Vicente,Maritza,Deacon,Sonia,Heath,Lisa,Santino,Noemi,Layton,Tara,Osvaldo,Carolyn,Rogelio,Adyson,Prince,Elsa,Deshawn,Greta,Jovani,Mollie,Rolando,Cherish,Adrien,Jessie,Camren,Kaya,Dwayne,Lainey,Tristian,Jaqueline,Gavyn,Macey,Sincere,Ellen,Alexzander,Miah,Cedric,Selah,Jorden,Kaylyn,Zechariah,Reyna,Hamza,Giuliana,Knox,Marisa,Davian,Cristina,Clark,Jenny,Elisha,Leanna,Ramiro,Paloma,Zackery,Averie,Jordyn,Cailyn,Kylan,Regina,Matias,Alena,Junior,Emilie,Kaeden,Tania,Gilberto,Carlie,Gauge,Clare,Kash,Iliana,Damarion,Phoenix,Ellis,Rosemary,Finley,Annabel,Quintin,Evie,Aidyn,Regan,Lewis,Tamia,Konner,Charlee,Leonard,Campbell,Rudy,Janae,Arjun,Jaylah,Frankie,Jazmyn,Jamir,Sanaa,Duncan,Zion,Darrell,Amina,Harper,Carley,Maxim,Emmalee,Valentin,Chaya,Darwin,Leyla,Kareem,Cecelia,Korbin,Lilianna,Soren,Marlene,Jasiah,Zaniyah,Samir,Aisha,Daxton,Britney,Eugene,Kallie,Brice,Angelique,Keenan,Natalya,Conrad,Patience,Misael,Yazmin,Randall,Alani,Franco,Kenna,Killian,Luz,Rex,Araceli,Rodolfo,Aryana,Roland,Giada,Jamar,Malaya,Rory,Celia,Aditya,Corinne,Davon,Mara,Wayne,Larissa,Jovanni,Mckinley,Sage,Moriah,Yusuf,Matilda,Zaiden,Susan,Jagger,Abbie,Matthias,Alisha,Nikolai,Armani,Alvaro,Elaine,Valentino,Karma,Van,Judith,Zain,Milagros,Zayne,Alia,Aryan,Kiersten,Dominique,Sharon,Vance,Shaniya,Donte,Milan,Luka,Zara,Lamar,Aliza,Camryn,Brinley,Emery,Lailah,Freddy,Lorelai,Irvin,Renee,Bo,Felicity,Justus,Precious,Adonis,Keyla,Devan,Kierra,Mathias,Paula,Maximo,Yoselin,Yosef,Anabella,Dax,Ayana,Marley,Kaiya,Darnell,Salma,Dillan,Azul,Efrain,Kendal,Antoine,Monserrat,Rayan,Ryann,Rylee,Chanel,Augustus,Giovanna,Jair,Ingrid,Jaydin,Kasey,Tyree,Maliah,Tyrell,Zaria,Agustin,Frances,Kymani,Jamya,Jadyn,Libby,Gilbert,Dayanara,Hassan,Marianna,Jaidyn,Mira,Ean,Shyla,Gaige,Ally,Niko,Eileen,Ronin,Janet,Coleman,Shyanne,Seamus,Yaritza,Aarav,Deborah,Branson,Katrina,Deangelo,Nathaly,Isai,Yuliana,Blaze,Micah,Cael,Aimee,Demarcus,Alma,Talan,Ireland,Vaughn,Leia,Ayaan,Akira,Winston,Amirah,Jeramiah,Stacy,Derick,Belinda,Harold,Isabell,Alfred,Lylah,Deon,Tess,Mike,Chana,Carmelo,Jayde,Jensen,Calleigh,Izayah,Hana,Kadyn,Raina,Abdullah,Karissa,Ignacio,Kourtney,Yair,Angeline,Aedan,Janice,Kadin,Raelynn,Kamron,Rosalie,Fisher,Saige,Marcelo,Shania,Broderick,Adelynn,Cristofer,India,Santos,Pamela,Sidney,Edith,Sylas,Mayra,Beckham,Jacey,Ernest,Kelsie,Yadiel,Laylah,Kael,Marely,Kayson,Tianna,Case,Mylee,Elian,Aracely,Jaxton,Jaylyn,Jaydan,Rubi,Sonny,Taniyah,Elvis,Carissa,Tyrese,Rylan,Nigel,Beatrice,Bruno,Alyvia,Nikhil,Mina,Zavier,Ariella,Kolten,Lillianna,Ishaan,Meadow,Addison,Yadira,Bridger,Hayleigh,Devyn,Millie,Alden,Livia,Arnav,Carina,Callum,Damaris,Jaxen,Elianna,Leandro,Evelin,Adolfo,Jocelynn,Dilan,Bria,Jabari,Charity,Keon,Belen,Hezekiah,Cristal,Krish,Emelia,Lyric,Rayna,Quinten,Taraji,Samson,Abbey,Malaki,Demi,Chaim,Diya,Darien,Ember,Darryl,Jaylen,Keshawn,Payten,Zaire,Karsyn,Marcel,Rayne,Ethen,Marlie,Salvatore,Maryjane,Todd,Jordin,Brenton,Vera,Dangelo,Alexus,Reuben,Destiney,Abdiel,Mattie,Bronson,Sloane,Camilo,Taniya,Dario,Evelynn,Roderick,Savanah,Sterling,Shaylee,Eden,Harlow,Humberto,Alaya,Rey,Jacquelyn,Casen,Caydence,Pranav,Myra,Brogan,Princess,Cortez,Tamara,Dashawn,Xiomara,Demarion,Charlize,Haiden,Sarahi,Kyson,Abagail,Marquise,Aliana,Dale,Emmy,Rigoberto,Janiah,Antwan,Lilia,Jarrett,Eloise,Ross,Yamilet,Braedon,Avah,Jordon,Averi,Kenyon,Kylah,Clinton,Raelyn,Damari,Roselyn,Jovan,Caleigh,Elmer,Karly,Jayvion,Ann,Konnor,Frida,Trystan,Kayley,Vincenzo,Unique,Yael,Yasmine,Fletcher,Jewel,Jaquan,Kamari,Octavio,Keely,Westin,Lara,Houston,Dixie,Isaak,Lorena,Slade,Rory,Zack,Ali,Landin,Hadassah,Royce,Joyce,Bailey,Alisa,Koen,Cayla,Jaron,Rebeca,German,Taya,Howard,Maryam,Kamryn,Nola,Keyon,Theresa,Reynaldo,Aiyanna,Hayes,Charley,Jean,Makena,Lennon,Tia,Ralph,Ashleigh,Garrison,Ashly,Jakobe,Azaria,Jamarcus,Kaelynn,Jovanny,Kamya,Makhi,Lina,Maxx,Maribel,Carsen,Neveah,Clay,River,Dereon,Sanai,Nathen,Dominique,Reagan,Lizeth,Karl,Cassie,Kasey,Ivanna,Savion,Esperanza,Jamel,Thalia,Anton,Ayleen,Geovanni,Devyn,Jaycob,Leona,Josh,Riya,Juelz,Abigale,Kalel,Dalia,Jerimiah,Jaslyn,Mack,Mariela,Remy,Marleigh,Blaise,Miya,Carlo,Reina,Deegan,Deja,Denzel,Heidy,Odin,Kayleen,Leonidas,Magdalena,Maddux,Stephany,Antony,Tiara,Stefan,Azariah,Zavion,Karley,Cain,Reece,Hugh,Karlie,Nick,Sydnee,Zaid,Tanya,Chaz,Alannah,Fredrick,Amiah,Ronaldo,Cambria,Stone,Samiyah,Trevin,Valery,Tyshawn,Gretchen,Amos,Karli,Cassius,Kloe,Eliezer,Lilyanna,Mustafa,Mireya,Tim,Hormell,Harlan,J.,Max,Jheri,Nelle,Gourd,Lang,Jan,Telb,H.,Scott,Ted,Fabergé,Hillshire,Dr.,Ryan,Ascot,Wayne,Ellis,Gery,Johnny,Pete,Darcy,Cambrian,Allen,Jake,Loren,Ryan,Pierpont,Alloy,Hereford,Vernon,Greg,Erica,Lisa,Byron,Sam,Ingrid,Jordache,Kelp,Bourum,Ward,Wallace,Arlen,Vince,Walt,Terry,Brace,Lens,Greg,Rico,Cliff,M.,Lampton,Vernon,Dallas,Paul,Chet,Mac,Tom,Thor,Lance,Dr.,J.,Alan,Stu,Tad,Steve,Henry,Grif,Fallon,Renfro,Tim,Tip,Hardcastle,Kip,Thad,Edgar,Allan,Brie,Fresco,Kurt,P.,Garry,Tish,Grif,Mortimer,F.,Dr.,Peter,Ken,Lash,Derek,Pete,Tim,Brewster,Robin,Biff,Chase,Jan,Cat,Toby,Sanders,Len,Don,Smith,Gordon,Forrest,Beth,Dr.,Drake,Hugh,Glen,Martin,Professor,Nick,York,Franklin,Brandt,Walt,Biff,Tong,Ward,Irene,Parsley,Garr,Alan,Mark,Stu,Chad,Lord,Blaine,Hank,G.,Tobin,Drick,Murphy,Dean,Chelsea,Harry,Chris,T.J.,Ben,Dr.,Gorden,Spaz,Colin,Courtney,Sparks,Pratt,L.,Kissinger,Salleigh,Davis,Brooks,Clancy,Everett,Drake,Hack,Cliche,Ransford,B.,Tairy,Newton,Ed,Cutler,Preston,Geoff,Kirk,Gil,Lemleather,Keefe,Austen,Craigmont,Al,Schlepp,Winstead,Rich,Ben,Dustin,Warren,Bass,Wade,Brett,Art Bunson";
		NSString *lastNames = @"Tim Dickens,Ansley,Wicke,Westen Foam,Greenboard,English,Peeter,Excel,Galley,Olpe,Pinochle,Rowe Torque,Monocle,Sepulchre,Stanton,Toddly,Alan Champion,Mogul,Goudy,Taargüs,Yves,Croutan,Vuvuzela,Hfuhruhurr,Winegale,Diphyls,Houston,Ward,Haze,Oval,Aragorn,Harris,Stazione,Major,Hapsley,Crestfall,Walnut,Van Sfetter,Kresden,Ladlestrap,Fortitude,Fredricks,Seltzer,Ester,Knuckle,Polyester,Column,Bracemender,Mortar,Hyatt,Yentle,Odyssey,Parkinson,Goddard,Todd Seltzer,Enochs,Major,Sbarro,Mignon,Fletcher,Stewart,Codrick,Putman,Nolley,Amanda Rebecca,Philip Bockman,F. Worsley,Hadley,Hansen,Merryweather,Safewood,Tafferts,J. Washington,Gerard,Berbiglia,Ginger,McCormick,Sandwich,Tamladge,Salisbury,Charcoal,Fortune,Port,Lasik,Niles Mango,Effward,Pomfritz,Hansel,Crumb,T. Fernback,Paul Tickle,S. Tallon,Tully,Arbuckle,Breefield,Zah,King,McCracken,Sanka,Niven,Blossom,Wallace,Greenleaf,Klink,Kleinfeld,Cocoa,Fingers,Watercress,Wonders,Yang,Feather,John Vyner,Mallard,Morris,Owen,Blake,Phil Lillian,Wicker,Laurel,Turtleneck,Rocket,Billings,Simmons,Gottlich,Conway,Bruce,Hamble,Hambone,F. Worsley,Chudner,Hadley,Cornucopia,Jeff,Neckrope,Denver,Ryan Francis,Caramel,Burnside,DeMorge,Isotope,Forsythe,Seaward,Grissle,Werner,Mylar,Pete Phong,Flurry,Taffy,Hungerford,Nudo,Zumspeg,Zephyr,Gordon Candace,Utah,Francis,Cedarsuckle,Parkenridge,Muldoons,Hamm,Medium,Jansen,Flatgovern,Gimlittle,Aaron Moon,Islip,Farnsworth,Vanders,Antonio,Seafoam,Wigglesworth,Bindle,Harrison,Martin,Lexus,Benson,Eggbake,Harrington,Arthur,Hubert,Preylant,Danish,Solvent,Able,Ample,Blasingame,Farbman,Bunson";
		instance.wdArray = [activities componentsSeparatedByString:@","];
		instance.fnArray = [firstNames componentsSeparatedByString:@","];
		instance.lnArray = [lastNames componentsSeparatedByString:@","];
    }
    
	// generate the name
	int wdRandNumber = rand() % instance.wdArray.count;
	int fnRandNumber = rand() % instance.fnArray.count;
	int lnRandNumber = rand() % instance.lnArray.count;

	NSString *randomWd = [instance.wdArray objectAtIndex:wdRandNumber];
	NSString *randomFn = [instance.fnArray objectAtIndex:fnRandNumber];
	NSString *randomLn = [instance.lnArray objectAtIndex:lnRandNumber];
	
	return [NSString stringWithFormat:@"%@ with %@ %@", randomWd, randomFn, randomLn];
}

























+ (NSString *)generateRandomStreet
{
    FEFakeData *instance = [FEFakeData sharedInstance];
	NSString *streetNames = @"Main Street,Church Street,High Street,Chestnut Street,Broad Street,Elm Street,Walnut Street,2nd Street,Maple Avenue,Maple Street,Washington Street,River Road,Center Street,Main Street North,Pine Street,Main Street South,Union Street,Park Avenue,Water Street,South Street,Main Street East,Main Street West,Market Street,Oak Street,Spring Street,School Street,Front Street,Prospect Street,3rd Street,Park Street,Washington Avenue,North Street,Cedar Street,Court Street,Highland Avenue,Spruce Street,Central Avenue,Franklin Street,Church Road,Pleasant Street,Ridge Road,State Street,West Street,Locust Street,Winding Way,4th Street,Cherry Street,Cherry Lane,Lincoln Avenue,Mill Street,1st Street,Bridge Street,Dogwood Drive,East Street,Holly Drive,Park Place,Pennsylvania Avenue,2nd Avenue,5th Street,Adams Street,Arch Street,Green Street,Heather Lane,Liberty Street,Meadow Lane,Pearl Street,River Street,Route 32,Route 6,Valley Road,3rd Avenue,Academy Street,Canterbury Court,Hickory Lane,Jefferson Avenue,Railroad Street,Route 1,Route 30,Beech Street,Clinton Street,Creek Road,Division Street,Durham Road,Fairview Avenue,Lincoln Street,Madison Avenue,Windsor Drive,Woodland Drive,1st Avenue,4th Avenue,5th Avenue,Buckingham Drive,College Avenue,Colonial Drive,Delaware Avenue,Devon Road,Garfield Avenue,Grove Street,Hamilton Street,Jackson Street,Jefferson Street,John Street,Lake Street,Laurel Lane,Mill Road,New Street,Oxford Court,12th Street,Broadway,Canal Street,Cedar Lane,Cottage Street,Eagle Road,Elizabeth Street,Forest Drive,Franklin Avenue,Franklin Court,Heritage Drive,Hillside Avenue,Jefferson Court,Prospect Avenue,Railroad Avenue,Route 29,Route 44,Summit Avenue,Valley View Drive,York Road,11th Street,13th Street,5th Street North,Brook Lane,Buttonwood Drive,Cambridge Court,Devonshire Drive,Dogwood Lane,Elm Avenue,Elmwood Avenue,Fairway Drive,Garden Street,Grove Avenue,Hillside Drive,King Street,Lantern Lane,Laurel Drive,Locust Lane,Madison Street,Mulberry Court,Oak Avenue,Oak Lane,Penn Street,Ridge Avenue,Route 20,Sherwood Drive,Smith Street,Street Road,Surrey Lane,Tanglewood Drive,Vine Street,Walnut Avenue,Willow Street,10th Street,4th Street North,Andover Court,Ashley Court,Aspen Court,Belmont Avenue,Bridle Lane,Brookside Drive,Cambridge Road,Cedar Avenue,Cobblestone Court,Durham Court,Essex Court,Fawn Lane,Front Street North,George Street,Grant Avenue,Hawthorne Lane,Henry Street,Highland Drive,Hillcrest Avenue,Lafayette Avenue,Lake Avenue,Laurel Street,Lilac Lane,Magnolia Court,Old York Road,Orchard Avenue,Orchard Street,Pheasant Run,Pin Oak Drive,Rosewood Drive,Route 11,Route 9,Sheffield Drive,Sunset Drive,Victoria Court,Wall Street,Westminster Drive,Windsor Court,Woodland Avenue,Woodland Road";
	instance.snArray = [streetNames componentsSeparatedByString:@","];
	
	int snRandNumber = rand() % instance.snArray.count;
	
	NSString *randomSn = [instance.snArray objectAtIndex:snRandNumber];
	
	int houseNumber = rand() % 1000;
	
	return [NSString stringWithFormat:@"%d %@", houseNumber, randomSn];
}


+ (NSString *)generateRandomCity
{
    FEFakeData *instance = [FEFakeData sharedInstance];
	if (!instance.cities) {
		NSString *citiesString = @"New York,Los Angeles,Chicago,Houston,Phoenix,Philadelphia,San Antonio,San Diego,Dallas,San Jose,Detroit,San Francisco,Jacksonville,Indianapolis,Austin,Columbus,Fort Worth,Charlotte,Memphis,Boston,Baltimore,El Paso,Seattle,Denver,Nashville,Milwaukee,Washington,Las Vegas,Louisville,Portland,Oklahoma City,Tucson,Atlanta,Albuquerque,Kansas City,Fresno,Mesa,Sacramento,Long Beach,Omaha,Virginia Beach,Miami,Cleveland,Oakland,Raleigh,Colorado Springs,Tulsa,Minneapolis,Arlington,Honolulu,Wichita,St. Louis,New Orleans,Tampa,Santa Ana,Anaheim,Cincinnati,Bakersfield,Aurora,Toledo,Pittsburgh,Riverside,Lexington,Stockton,Corpus Christi,Anchorage,St. Paul,Newark,Plano,Buffalo,Henderson,Fort Wayne,Greensboro,Lincoln,Glendale,Chandler,St. Petersburg,Jersey City,Scottsdale,Orlando,Madison,Norfolk,Birmingham,Winston-Salem,Durham,Laredo,Lubbock,Baton Rouge,North Las Vegas,Chula Vista,Chesapeake,Gilbert,Garland,Reno,Hialeah,Arlington,Irvine,Rochester,Akron,Boise,Irving,Fremont,Richmond,Spokane,Modesto,Montgomery,Yonkers,Des Moines,Tacoma,Shreveport,San Bernardino,Fayetteville,Glendale,Augusta,Grand Rapids,Huntington Beach,Mobile,Newport News,Little Rock,Moreno Valley,Columbus,Amarillo,Fontana,Oxnard,Knoxville,Fort Lauderdale,Salt Lake City,Worcester,Huntsville,Tempe,Brownsville,Jackson,Overland Park,Aurora,Oceanside,Tallahassee,Providence,Rancho Cucamonga,Ontario,Chattanooga,Santa Clarita,Garden Grove,Vancouver,Grand Prairie,Peoria,Sioux Falls,Springfield,Santa Rosa,Rockford,Springfield,Salem,Port St. Lucie,Cape Coral,Dayton,Eugene,Pomona,Corona,Alexandria,Joliet,Pembroke Pines,Paterson,Pasadena,Lancaster,Hayward,Salinas,Hampton,Palmdale,Pasadena,Naperville,Kansas City,Hollywood,Lakewood,Torrance,Escondido,Fort Collins,Syracuse,Bridgeport,Orange,Cary,Elk Grove,Savannah,Sunnyvale,Warren,Mesquite,Fullerton,McAllen,Columbia,Carrollton,Cedar Rapids,McKinney,Sterling Heights,Bellevue,Coral Springs,Waco,Elizabeth,West Valley City,Clarksville,Topeka,Hartford,Thousand Oaks,New Haven,Denton,Concord,Visalia,Olathe,El Monte,Independence,Stamford,Simi Valley,Provo,Killeen,Springfield,Thornton,Abilene,Gainesville,Evansville,Roseville,Charleston,Peoria,Athens,Lafayette,Vallejo,Lansing,Ann Arbor,Inglewood,Santa Clara,Flint,Victorville,Costa Mesa,Beaumont,Miami Gardens,Manchester,Westminster,Miramar,Norman,Cambridge,Midland,Arvada,Allentown,Elgin,Waterbury,Downey,Clearwater,Billings,West Covina,Round Rock,Murfreesboro,Lewisville,West Jordan,Pueblo,San Buenaventura (Ventura),Lowell,South Bend,Fairfield,Erie,Rochester,High Point,Richardson,Richmond,Burbank,Berkeley,Pompano Beach,Norwalk,Frisco,Columbia,Gresham,Daly City,Green Bay,Wilmington,Davenport,Wichita Falls,Antioch,Palm Bay,Odessa,Centennial,Boulder,Colorado";
		instance.cities = [citiesString componentsSeparatedByString:@","];
	}
	
	int cityRandNumber = rand() % instance.cities.count;
	return [instance.cities objectAtIndex:cityRandNumber];
}

+ (NSString *)generateRandomState
{
    FEFakeData *instance = [FEFakeData sharedInstance];
	if (!instance.states) {
		NSString *statesString = @"AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY";
		instance.states = [statesString componentsSeparatedByString:@","];
	}
	
	int stateRandNumber = rand() % instance.states.count;
	return [instance.states objectAtIndex:stateRandNumber];
}

+ (NSString *)generateRandomZipCode
{
	int n1 = rand() % 10;
	int n2 = rand() % 10;
	int n3 = rand() % 10;
	int n4 = rand() % 10;
	int n5 = rand() % 10;
	
	return [NSString stringWithFormat:@"%d%d%d%d%d",n1,n2,n3,n4,n5];
}





+ (EKRecurrenceFrequency)generateRandomRecurrenceFrequency {
 	int r = rand() % 4;
	int array[4];
	array[0] = EKRecurrenceFrequencyDaily;
	array[1] = EKRecurrenceFrequencyWeekly;
	array[2] = EKRecurrenceFrequencyMonthly;
	array[3] = EKRecurrenceFrequencyYearly;
    return array[r];   
}

+ (NSInteger)generateRandomRecurrenceInterval {
    return (rand() % 7) + 1;
}

+ (NSArray *)generateRandomDaysOfTheWeek {
    NSMutableArray *array = [NSMutableArray array];
    if (rand() % 3 == 0) [array addObject:[EKRecurrenceDayOfWeek dayOfWeek:1]];
    if (rand() % 3 == 0) [array addObject:[EKRecurrenceDayOfWeek dayOfWeek:2]];
    if (rand() % 3 == 0) [array addObject:[EKRecurrenceDayOfWeek dayOfWeek:3]];
    if (rand() % 3 == 0) [array addObject:[EKRecurrenceDayOfWeek dayOfWeek:4]];
    if (rand() % 3 == 0) [array addObject:[EKRecurrenceDayOfWeek dayOfWeek:5]];
    if (rand() % 3 == 0) [array addObject:[EKRecurrenceDayOfWeek dayOfWeek:6]];
    if (rand() % 3 == 0) [array addObject:[EKRecurrenceDayOfWeek dayOfWeek:7]];
    return array;
}

+ (NSArray *)generateRandomDaysOfTheMonth {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 31; i++) {
        if (rand() % 10 == 0) [array addObject:[NSNumber numberWithInt:i+1]];
    }
    return array;
}

+ (NSArray *)generateRandomMonthsOfTheYear {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        if (rand() % 5 == 0) [array addObject:[NSNumber numberWithInt:i+1]];
    }
    return array;
}

+ (NSArray *)generateRandomWeeksOfTheYear {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 53; i++) {
        if (rand() % 5 == 0) [array addObject:[NSNumber numberWithInt:i+1]];
    }
    return array;
}

+ (NSArray *)generateRandomDaysOfTheYear {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 366; i++) {
        if (rand() % 20 == 0) [array addObject:[NSNumber numberWithInt:i+1]];
    }
    return array;
}


@end