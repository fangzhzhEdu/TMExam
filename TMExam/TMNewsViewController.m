//
//  TMNewsViewController.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-17.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMNewsViewController.h"

@interface TMNewsViewController ()<PullingRefreshTableViewDelegate>
{
    int currentMaxDisplayedCell; //keep track of the maximum cell index that has been displayed (for the animation, so as we move down the table the cells are animated when they're viewed for the first time - if index is greated than currentMaxDisplayedCell - but then as you scroll back up they're not re-animated.
    int currentMaxDisplayedSection;
}

@property (nonatomic, strong) IBOutlet PullingRefreshTableView *tableView;
@property (nonatomic) BOOL refreshing;

/**  @property cellZoomXScaleFactor
 *   @brief The X Zoom Factor
 *   How much to scale to x axis of the cell before it is animated back to normal size. 1 is normal size. >1 is bigger, <1 is smaller. Default if not set is 1.25 **/
@property (strong, nonatomic) NSNumber* cellZoomXScaleFactor;

/**  @property cellZoomYScaleFactor
 *   @brief The Y Zoom Factor
 *   How much to scale to y axis of the cell before it is animated back to normal size. 1 is normal size. >1 is bigger, <1 is smaller. Default if not set is 1.25 **/
@property (strong, nonatomic) NSNumber* cellZoomYScaleFactor;

/**  @property cellZoomXOffset
 *   @brief Specify an X offset (in pixels) for the animation's initial position
 *   Allows you to specify an X offset (in pixels) for the animation's initial position, so for example if you say -50 this will mean as well as the rest of the animation, the cell also comes in from 50 pixels to the left of the screen. If you say 100 it will come in from 100 pixels to the right of the screen. Combine it with the cellZoomYOffset to get the cell to come in diagonally (see TabThreeViewController in Demo examples). If not set, the default is 0.  **/
@property (strong, nonatomic) NSNumber* cellZoomXOffset;

/**  @property cellZoomYOffset
 *   @brief Specify a Y offset (in pixels). for the animations initial position
 *   Allows you to specify a Y offset (in pixels) for the animation's initial position, so for example if you say -50 this will mean as well as the rest of the animation, the cell also comes in from 50 pixels to the top of the screen. If you say 100 it will come in from 100 pixels to the bottom of the screen. Combine it with the cellZoomXOffset to get the cell to come in diagonally (see TabThreeViewController in Demo examples). If not set, the default is 0.  **/
@property (strong, nonatomic) NSNumber* cellZoomYOffset;

/**  @property cellZoomInitialAlpha
 *   @brief The inital Alpha value of the cell
 *   The initial alpha value of the cell when it starts animation. For example if you set this to be 0 then the cell will begin completely transparent, and will fade into view as well as zooming. Value between 0 and 1. Default if not set is 0.3 **/
@property (strong, nonatomic) NSNumber* cellZoomInitialAlpha;

/**  @property cellZoomAnimationDuration
 *   @brief The Animation Duration
 *   The duration of the animation effect, in seconds. Default if not set is 0.65 seconds **/
@property (strong, nonatomic) NSNumber* cellZoomAnimationDuration;

/*
 Resets the view counter. The animation effect doesnt repeat when you've already seen a cell once, for example if you scroll down past cell #5, then scroll back to the top and down again, the animation won't repeat as you scroll back down past #5. This is by design to make only "new" cells animate as they appear. Call this method to reset the count of which cells have been seen (e.g when you call reload on the table's data)
 */
-(void)resetViewedCells;


@end

@implementation TMNewsViewController

@synthesize cellZoomXScaleFactor = _xZoomFactor;
@synthesize cellZoomYScaleFactor = _yZoomFactor;
@synthesize cellZoomAnimationDuration = _animationDuration;
@synthesize cellZoomInitialAlpha = _initialAlpha;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect bounds = self.view.bounds;
    bounds.origin.y += 42;
    bounds.size.height -= 42;
    self.tableView = [[PullingRefreshTableView alloc] initWithFrame:bounds pullingDelegate:self];
    [self.view addSubview:self.tableView];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.pullingDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    [self.tableView tableViewDidFinishedLoading];
}


#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date = [df dateFromString:@"2012-05-03 10:10"];
    return date;
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TBCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"TBCell" owner:self options:nil];
        cell = (UITableViewCell *)[nibArray objectAtIndex:0];
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((indexPath.section == 0 && currentMaxDisplayedCell == 0) || indexPath.section > currentMaxDisplayedSection){ //first item in a new section, reset the max row count
        currentMaxDisplayedCell = -1; //-1 because the check for currentMaxDisplayedCell has to be > rather than >= (otherwise the last cell is ALWAYS animated), so we need to set this to -1 otherwise the first cell in a section is never animated.
    }
    
    if (indexPath.section >= currentMaxDisplayedSection && indexPath.row > currentMaxDisplayedCell){ //this check makes cells only animate the first time you view them (as you're scrolling down) and stops them re-animating as you scroll back up, or scroll past them for a second time.
        
        //now make the image view a bit bigger, so we can do a zoomout effect when it becomes visible
        cell.contentView.alpha = self.cellZoomInitialAlpha.floatValue;
        
        CGAffineTransform transformScale = CGAffineTransformMakeScale(self.cellZoomXScaleFactor.floatValue, self.cellZoomYScaleFactor.floatValue);
        CGAffineTransform transformTranslate = CGAffineTransformMakeTranslation(self.cellZoomXOffset.floatValue, self.cellZoomYOffset.floatValue);
        
        cell.contentView.transform = CGAffineTransformConcat(transformScale, transformTranslate);
        
        [self.tableView bringSubviewToFront:cell.contentView];
        [UIView animateWithDuration:self.cellZoomAnimationDuration.floatValue animations:^{
            cell.contentView.alpha = 1;
            //clear the transform
            cell.contentView.transform = CGAffineTransformIdentity;
        } completion:nil];
        
        
        currentMaxDisplayedCell = indexPath.row;
        currentMaxDisplayedSection = indexPath.section;
    }
}

-(void)resetViewedCells{
    currentMaxDisplayedSection = 0;
    currentMaxDisplayedCell = 0;
}

#pragma -mark Setters for four customisable variables
-(void)setCellZoomXScaleFactor:(NSNumber *)xZoomFactor{
    _xZoomFactor = xZoomFactor;
}
-(void)setCellZoomYScaleFactor:(NSNumber *)yZoomFactor{
    _yZoomFactor = yZoomFactor;
}
-(void)setCellZoomAnimationDuration:(NSNumber *)animationDuration{
    _animationDuration = animationDuration;
}
-(void)setCellZoomInitialAlpha:(NSNumber *)initialAlpha{
    _initialAlpha = initialAlpha;
}

#pragma -mark Getters for four customisable variable. Provide default if not set.
-(NSNumber *)cellZoomXScaleFactor{
    if (_xZoomFactor == nil){
        _xZoomFactor = [NSNumber numberWithFloat:1.25];
    }
    return _xZoomFactor;
}
-(NSNumber *)cellZoomXOffset{
    if (_cellZoomXOffset == nil){
        _cellZoomXOffset = [NSNumber numberWithFloat:0];
    }
    return _cellZoomXOffset;
}
-(NSNumber *)cellZoomYOffset{
    if (_cellZoomYOffset == nil){
        _cellZoomYOffset = [NSNumber numberWithFloat:0];
    }
    return _cellZoomYOffset;
}
-(NSNumber *)cellZoomYScaleFactor{
    if (_yZoomFactor == nil){
        _yZoomFactor = [NSNumber numberWithFloat:1.25];
    }
    return _yZoomFactor;
}
-(NSNumber *)cellZoomAnimationDuration{
    if (_animationDuration == nil){
        _animationDuration = [NSNumber numberWithFloat:0.65];
    }
    return _animationDuration;
}
-(NSNumber *)cellZoomInitialAlpha{
    if (_initialAlpha == nil){
        _initialAlpha = [NSNumber numberWithFloat:0.3];
    }
    return _initialAlpha;
}


@end
