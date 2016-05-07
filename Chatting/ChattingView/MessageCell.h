//
//  MessageCell.h
//  Chatting
//
//  Created by VicChan on 4/22/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MessageCellStyle) {
    MessageCellStyleLeft,
    MessageCellStyleRight,
    MessageCellStyleImageLeft,
    MessageCellStyleImageRight
};

/*
typedef NS_ENUM(NSInteger, MessageCellWidthStyle) {
    MessageCellWidthStyleDefault,
    MessageCellWidthStyleCustom
};
*/


@interface MessageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) MessageCellStyle style;
@property (nonatomic, strong) UIImageView *contentImage;


- (id)initWithFrame:(CGRect)frame;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setContent:(NSString *)content withStyle:(MessageCellStyle)style userImage:(NSString *)imageName;

- (void)setTimeLabelWithTime:(NSString *)time;

- (void)setImageWithImage:(UIImage *)image withStyle:(MessageCellStyle)style userImage:(NSString *)userImage;


@end
