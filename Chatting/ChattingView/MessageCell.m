//
//  MessageCell.m
//  Chatting
//
//  Created by VicChan on 4/22/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "MessageCell.h"

#define VIEW_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define VIEW_HEIGHT  (self.frame.size.height)



@interface MessageCell()


@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSLayoutConstraint *constriaint3;
@property (nonatomic, strong) NSLayoutConstraint *constriaint4;

@end


@implementation MessageCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        // Default State
        
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.contentView addSubview:self.headImage];
        
        
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.timeLabel];
        
        
        self.backgroundImageView = [[UIImageView alloc]init];
        
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        [self.contentView addSubview:self.backgroundImageView];
    
    
        NSLayoutConstraint *constraint1 =[NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:-20];
        constraint1.active = YES;
        
        NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:5];
        constraint2.active = YES;

        
        
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.backgroundImageView addSubview:self.contentLabel];
        self.contentLabel.font = [UIFont systemFontOfSize:18];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        
        NSLayoutConstraint *contentTop = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.backgroundImageView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:15];
        contentTop.active = YES;
        
        NSLayoutConstraint *contentBottom = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.backgroundImageView
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1
                                                                       constant:-15];
        contentBottom.active = YES;
        
        
        NSLayoutConstraint *contentRight = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                      attribute:NSLayoutAttributeRight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.backgroundImageView
                                                                      attribute:NSLayoutAttributeRight
                                                                     multiplier:1
                                                                       constant:-20];
        contentRight.active = YES;
        
        
        NSLayoutConstraint *contentLeft = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.backgroundImageView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:20];
        contentLeft.active = YES;
        
        self.contentImage = [UIImageView new];
        self.contentImage.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.backgroundImageView addSubview:self.contentImage];
        //self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        self.contentImage.backgroundColor = [UIColor clearColor];
        
        NSLayoutConstraint *imageTop = [NSLayoutConstraint constraintWithItem:self.contentImage
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.backgroundImageView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:15];
        imageTop.active = YES;
        
        NSLayoutConstraint *imageBottom = [NSLayoutConstraint constraintWithItem:self.contentImage
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.backgroundImageView
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1
                                                                          constant:-15];
        imageBottom.active = YES;
        
        
        NSLayoutConstraint *imageRight = [NSLayoutConstraint constraintWithItem:self.contentImage
                                                                        attribute:NSLayoutAttributeRight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.backgroundImageView
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:-20];
        imageRight.active = YES;
        
        
        NSLayoutConstraint *imageLeft = [NSLayoutConstraint constraintWithItem:self.contentImage
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.backgroundImageView
                                                                       attribute:NSLayoutAttributeLeft
                                                                      multiplier:1
                                                                        constant:20];
        imageLeft.active = YES;

        
    }
    return self;
}


- (UIImage *)resizeImageWithImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat height = image.size.height;
    CGFloat width = image.size.width;
    UIEdgeInsets edge = UIEdgeInsetsMake(height/2.0, width/2.0, height/2.0, width/2.0);

    UIImage *resizeImage = [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeTile];
    return resizeImage;
}

- (void)setContent:(NSString *)content withStyle:(MessageCellStyle)style userImage:(NSString *)imageName{
    [self.contentImage removeFromSuperview];
    
    self.headImage.image = [UIImage imageNamed:imageName];
    self.contentLabel.text = content;
    // 
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.numberOfLines = 0;
    
   CGFloat offset = [self getTextWidthWithText:content];
    // 头像在左边
    
    if (style == MessageCellStyleLeft) {
        // ImageLabel
        [self layoutBackImageLeftWithOffSet:offset];
        [self setNeedsUpdateConstraints];
        
    }  // 头像在右边
    else if (style == MessageCellStyleRight) {
        [self layoutBackImageRightWithOffSet:offset];
        [self setNeedsUpdateConstraints];

        
    }

}



- (void)setImageWithImage:(UIImage *)image withStyle:(MessageCellStyle)style userImage:(NSString *)userImage {
    [self.contentLabel removeFromSuperview];
    self.headImage.image = [UIImage imageNamed:userImage];    
    
    if (style == MessageCellStyleImageLeft) {
        [self layoutBackImageLeftWithOffSet:0];
        
        
    }
    else if (style == MessageCellStyleImageRight) {
        [self layoutBackImageRightWithOffSet:0];
        
    }

    self.contentImage.image = [self scaleImageWithImage:image];

}

- (void)layoutBackImageRightWithOffSet:(CGFloat)offset {
    NSLog(@"offset %f",offset);
    self.headImage.frame = CGRectMake(VIEW_WIDTH-50, 10, 40, 40);
    self.backgroundImageView.image = [self resizeImageWithImage:@"sendMessage"];
    _constriaint3 = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.headImage
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.0
                                                                     constant:0];
    _constriaint3.active = YES;
    
    [self.contentView removeConstraint:_constriaint4];

    _constriaint4 = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.contentView
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.0
                                                                     constant:50+offset];
    _constriaint4.active = YES;
    [self.backgroundImageView updateConstraints];
    [self.contentView updateConstraints];
    [self.contentView layoutSubviews];
   

    
}

- (void)layoutBackImageLeftWithOffSet:(CGFloat)offset {
    self.headImage.frame = CGRectMake(10, 10, 40, 40);
    self.backgroundImageView.image = [self resizeImageWithImage:@"receiveMessage"];
    
    _constriaint3 = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.headImage
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:0];
    _constriaint3.active = YES;
    
    
    [self.contentView removeConstraint:_constriaint4];
    _constriaint4 = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.contentView
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:-50-offset];
    _constriaint4.active = YES;
    
    [self.contentView updateConstraints];
    [self.backgroundImageView updateConstraints];
    [self.contentView layoutSubviews];



}







- (CGFloat)getTextWidthWithText:(NSString *)text {
    CGFloat width = 0.0;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};

    CGRect contentRect = [text boundingRectWithSize:CGSizeMake(VIEW_WIDTH-140, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    NSLog(@"%@",text);
    width = contentRect.size.width;
    NSLog(@"wid %f",contentRect.size.width);
    width = VIEW_WIDTH-140-width;
    NSLog(@"width %f",width);

    if (width < 5) {
        return 0;
    }
    return width;
}



- (UIImage *)scaleImageWithImage:(UIImage *)image {
    CGSize size = CGSizeMake(VIEW_WIDTH-140, 0);
    
    CGFloat imageHeight = image.size.height;
    CGFloat imageWidth = image.size.width;
    size.height = imageHeight * size.width / imageWidth;
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}




- (void)setTimeLabelWithTime:(NSString *)time {
    self.timeLabel.text = time;
}


@end
