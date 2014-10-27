//
//  EditableCollectionView.h
//  DeleteButton
//
//  Created by Oleksandr Kiporenko on 10/24/14.
//  Copyright (c) 2014 Oleksandr Kiporenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableCollectionViewCell.h"

@class EditableCollectionView;
@protocol EditableCollectionViewDelegate <NSObject>
@optional
- (void)collectionView:(UICollectionView*)collectionView shouldDeleteItemAtIndexPath:(NSIndexPath*)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView canEditCellAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface EditableCollectionView : UICollectionView <EditableCollectionViewCellDelegate>

@property (nonatomic, assign) id <UICollectionViewDelegate,EditableCollectionViewDelegate> delegate;

@end
