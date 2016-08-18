//
//  CCTableViewCell.m
//  Drawer3DEffect
//
//  Created by Dryen Siu on 16/8/16.
//  Copyright © 2016年 WeiChao. All rights reserved.
//

#import "CCTableViewCell.h"

@implementation CCTableViewCell

- (void)awakeFromNib {
    
    _showImageView.layer.cornerRadius = 20;
    _showImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
