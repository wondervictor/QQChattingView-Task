//
//  ViewController.m
//  Chatting
//
//  Created by VicChan on 4/19/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "ViewController.h"
#import "MessageCell.h"


#define  MAIN_WIDTH   (self.view.frame.size.width)
#define  MAIN_HEIGHT  (self.view.frame.size.height)

static CGFloat keyboardHeight = 216;
static NSString *const cellIdentifierOne = @"MessageCellOne";
static NSString *const cellIdentifierTwo = @"MessageCellTwo";
static NSString *const cellIdentifierThree = @"MessageCellThree";
static NSString *const cellIdentifierFour = @"MessageCellFour";


@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSLayoutConstraint *contentBottomConstraint;
}
@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UITableView *messageTableView;

@property (nonatomic, strong) NSMutableArray *messageListArray;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UITextField *messageText;

@property (nonatomic, assign) BOOL keyboardShow;

@property (nonatomic, assign) BOOL menuShow;

@property (nonatomic, strong) UITapGestureRecognizer *tapKeyBoardGesture;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当前聊天";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *pictureButton = [[UIButton alloc]init];
    [self.view addSubview:pictureButton];
    pictureButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self setLayoutForButton:pictureButton number:0];
    [pictureButton setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    pictureButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [pictureButton addTarget:self action:@selector(openPhotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *phototTakeButton = [[UIButton alloc]init];
    [self.view addSubview:phototTakeButton];
    phototTakeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self setLayoutForButton:phototTakeButton number:1];
    [phototTakeButton setBackgroundImage:[UIImage imageNamed:@"picture"] forState:UIControlStateNormal];
    phototTakeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [phototTakeButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT - 64)];
    [self.view addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];

    
    self.messageListArray = [NSMutableArray new];
    
    //[self.view addSubview:[self loadToolBar]];
    [self loadToolBar];
    
    [self.messageListArray addObject:@"主要问题在于TabelView第一次进入和每次reloadData时，都会先GetTabelCount，然后对每一项GetCellHeight，然后对显示的的每一项去GetCellData于是，我找到的几乎所有的cell高度自动适应内容的处理办法，其核心思路都是在GetCellHeight时候进行预先计算。这个也能理解。但是大多数是基于"];
    [self.messageListArray addObject:@"[label.text sizeWithFont:label.font]，这要求对cell的style指定要精确，而且重复工作，计算复杂而结果不精确。我想找到一种直接根据cell的子视图，填充上data就能自动生成高度的方法。我看到过这样的代码："];
    [self.messageListArray addObject:@"注意语句1和2，1是不可行的，原因如前所提，会造成getcount和getheight间的递归调用直到栈溢出。但是2可行，我没有想明白是怎么回事，我原以为2和1一样都可能栈溢出？问题：1／语句2为什么不会出错，和语句1有什么区别"];
    [self.messageListArray addObject:@"  2／语句3原先是为了自动取得赋值后的cell高度，但是却失败了。我还尝试过其它方法，比如访问frame／bounds等等，也不行。有没有什么好的预先自动计算高度的方法？不使用语句2也行的。3／如果成功预计算出了不同cell的高度，那么在GetCellData中，对于reuse和createNewCell是否需要不同的IdentifyId，即使style相同。对于不是自己create的而是从nib中读取cell的这种，又是怎么设置高度不同的的IdentifyId呢？IdentifyId到底是根据什么而变化的？"];
    [self.messageListArray addObject:@"wferwg"];
    [self.messageListArray addObject:@"dd"];
    [self.messageListArray addObject:@"掐指算下来做iOS开发也是有两年多的时间了，然后今天一个超级常用的控件让我颜面大跌，于是我准备把自己的丢人行径公之于众。如果您看到我这篇文章时和我一样，也是刚刚知道这项功能，那么您就当收获了一个。。。（其实不算什么），如果您早就知道了 ，那您可以无限的嘲笑我了首先交代一下事情的前因 就是 我有个位置要显示图片，但是美工的图片和我的位置无论大小还是比例 都是不对的，但是同事说这样就可以了 自己处理一下就行 这地方要求不高，但是我就不知道怎么处理才行，于是乎还是请教了同事 最后发现 哎 这东西真的是早就该知道的呀。　我发现自己很是喜欢说废话 说问题之前先介绍一下UIView的contente属性我这次用的时候主要是UIImageView用来显示图片的  这个属性的默认是 UIViewContentModeScaleToFill 这个就是常看到的图片会变形填满；主要说一下这两个属性"];
    [self.messageListArray addObject:@"看来这样我就只好用［string SizeWithFont font］来慢慢算"];
    [self.messageListArray addObject:@" 哎 这东西真的是早就该知道的呀。　我发现自己很是喜欢说废话 说问题之前先介绍一下UIView的contente属性我这次用的时候主要是UIImageView用来显示图片的  这个属性的默认是 UIViewContentModeScaleToFill 这个就是常看到的图片会变形填满；主要说一下这两个属性"];
    [self.messageListArray addObject:@" 哎 这东西真的是早就该知道的呀。　我发现自己很是喜欢说废话 说问题之前先介绍一下UIView的contente属性我这次用的时候主要是UIImageView用来显示图片的  这个属性的默认是 UIViewContentModeScaleToFill 这个就是常看到的图片会变形填满；主要说一下这两个属性"];
    self.messageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT-108) style:UITableViewStylePlain];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageTableView.estimatedRowHeight = 80;
    self.messageTableView.allowsSelection = NO;

    [self.contentView addSubview:self.messageTableView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    self.keyboardShow = NO;
    self.menuShow = NO;
    self.tapKeyBoardGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shutKeyBoard:)];
    self.tapKeyBoardGesture.numberOfTapsRequired = 1;
    self.tapKeyBoardGesture.numberOfTouchesRequired = 1;
    [self.messageTableView addGestureRecognizer:self.tapKeyBoardGesture ];
    
    

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messageListArray count];
}

- (void)setLayoutForButton:(UIButton *)button number:(NSInteger)num {
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:60];
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:60];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-120];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:(num * 60 + 40)];
    
    constraintWidth.active = YES;
    bottomConstraint.active = YES;
    constraintHeight.active = YES;
    leftConstraint.active = YES;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger index = [indexPath row];
    if (index%2 == 0) {
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierTwo];
        if (cell == nil) {
            cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTwo];
        }
        [cell setContent:[self.messageListArray objectAtIndex:index] withStyle:MessageCellStyleRight userImage:@"cat"];
        return cell;
        
    }
    else if (index%2 == 1) {
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierOne];
        if (cell == nil) {
            cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierOne];
        }
        [cell setContent:[self.messageListArray objectAtIndex:index] withStyle:MessageCellStyleLeft userImage:@"dog"];
        return cell;
    }
    return nil;
    /*
    else if (index%4==2) {
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierTwo];
        if (cell == nil) {
            cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierThree];
        }
        [cell setImageWithImage:[UIImage imageNamed:@"yose2"] withStyle:MessageCellStyleImageRight userImage:@"cat"];
        
        return cell;
    }
    else {
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierTwo];
        if (cell == nil) {
            cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierFour];
        }
        [cell setImageWithImage:[UIImage imageNamed:@"wdc"] withStyle:MessageCellStyleImageLeft userImage:@"dog"];

        return cell;
        
        
    }
     */

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageCell *cell = (MessageCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *reuseIdentifier = [cell reuseIdentifier];
    NSInteger index = [indexPath row];
    if ([reuseIdentifier isEqualToString:cellIdentifierOne] || [reuseIdentifier isEqualToString:cellIdentifierTwo]) {
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
        CGRect contentRect = [[self.messageListArray objectAtIndex:index] boundingRectWithSize:CGSizeMake(MAIN_WIDTH-140, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        NSLog(@"wid %f",contentRect.size.width);
        return contentRect.size.height + 55;
    }
    else if ([reuseIdentifier isEqualToString:cellIdentifierFour] || [reuseIdentifier isEqualToString:cellIdentifierThree]) {
        
    }
    return 150;
    
}



- (void)loadToolBar {
    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, MAIN_HEIGHT-108, MAIN_WIDTH, 44)];
    self.toolBar.tintColor = [UIColor groupTableViewBackgroundColor];
    
    self.messageText = [[UITextField alloc]initWithFrame:CGRectMake(10, 4.5, MAIN_WIDTH - 65, 35)];
    self.messageText.backgroundColor = [UIColor whiteColor];
    [self.toolBar addSubview:self.messageText];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.messageText.leftView = leftView;
    self.messageText.leftViewMode = UITextFieldViewModeAlways;
    self.messageText.layer.cornerRadius = 4;
    self.messageText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.messageText.layer.borderWidth = 0.3;
    

    self.messageText.tintColor = [UIColor blueColor];
    self.messageText.returnKeyType = UIReturnKeySend;
    
    self.messageText.delegate = self;
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(MAIN_WIDTH-50, 2, 40, 40)];
    [addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addPics:) forControlEvents:UIControlEventTouchUpInside];
    addButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.toolBar addSubview:addButton];

    [self.contentView addSubview:self.toolBar];
    
    
    
}

- (void)keyboardShow:(NSNotification *)notification {
    if (self.keyboardShow == YES) {
        return;
    }

    
    NSLog(@"show");

    
    NSDictionary *info = notification.userInfo;
    CGRect keyboardFrame = [info [UIKeyboardFrameEndUserInfoKey]CGRectValue];
    NSTimeInterval interval  = [info[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    keyboardHeight = keyboardFrame.size.height;
    CGRect rect = self.contentView.frame;
    if (self.menuShow == NO) {
        rect.origin.y -= keyboardHeight;

    } else if (self.menuShow == YES) {
        rect.origin.y -= (keyboardHeight - 200);
    }
    
    [UIView animateWithDuration:interval animations:^{
        self.contentView.frame = rect;
        
    }];
    [self.messageTableView addGestureRecognizer:self.tapKeyBoardGesture];
    self.keyboardShow = YES;
    self.menuShow = NO;
    
    //self.view
    
}

- (void)keyboardHide:(NSNotification *)notification {
    NSLog(@"hide");
    self.keyboardShow = NO;
    if (self.menuShow == YES) {
        return;
    }
    
    NSDictionary *info = notification.userInfo;
    CGRect keyboardFrame = [info [UIKeyboardFrameEndUserInfoKey]CGRectValue];
    NSTimeInterval interval  = [info[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    keyboardHeight = keyboardFrame.size.height;
    NSLog(@"%f",keyboardHeight);
    
    CGRect rect = self.contentView.frame;
    rect.origin.y += keyboardHeight;
    
    [UIView animateWithDuration:interval animations:^{
        self.contentView.frame = rect;
        
    } completion:^(BOOL finished) {
        [self.messageTableView removeGestureRecognizer:self.tapKeyBoardGesture];

            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.messageListArray count]-1 inSection:0];
            [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }];

}

- (void)shutKeyBoard:(UITapGestureRecognizer *)recognizer {
    NSLog(@"saDFSGDHFJK");
    if (self.keyboardShow == YES) {
        [self.messageText resignFirstResponder];
    }
    else if (self.menuShow == YES) {
        CGRect rect = self.contentView.frame;
        rect.origin.y += 200;
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.frame = rect;
        }];
        self.menuShow = NO;
        [self.messageTableView removeGestureRecognizer:self.tapKeyBoardGesture];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.messageListArray addObject:textField.text];
    [self.messageTableView reloadData];
    textField.text = @"";
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.messageListArray count]-1 inSection:0];
    [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    return YES;
}


- (void)addPics:(UIButton *)sender {
    
    [self.messageTableView addGestureRecognizer:self.tapKeyBoardGesture];
    NSLog(@"add pic");
    [self.messageTableView addGestureRecognizer:self.tapKeyBoardGesture];
    CGRect rect = self.contentView.frame;
    if (self.menuShow == YES) {
        return;
    }
    if (self.keyboardShow == YES) {
        [self.messageText resignFirstResponder];
        rect.origin.y += (keyboardHeight - 200);
    }
    else if (self.keyboardShow == NO) {
        rect.origin.y -= 200;
    }
    
    self.menuShow = YES;
    self.keyboardShow = NO;

    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = rect;
    }];
}


- (void)openPhotoLibrary:(UIButton *)sender {
    
}


- (void)takePhoto:(UIButton *)sender {
    
}

@end
