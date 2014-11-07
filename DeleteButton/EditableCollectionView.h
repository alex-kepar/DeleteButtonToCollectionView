//
//  EditableCollectionView2.h
//  DeleteButton
//
//  Created by Oleksandr Kiporenko on 11/4/14.
//  Copyright (c) 2014 Oleksandr Kiporenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditableCollectionView;
@protocol EditableCollectionViewDelegate <NSObject>
@optional
- (void)collectionView:(UICollectionView*)collectionView shouldDeleteItemAtIndexPath:(NSIndexPath*)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView canEditCellAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface EditableCollectionView : UICollectionView

@property (nonatomic, assign) id <UICollectionViewDelegate,EditableCollectionViewDelegate> delegate;
@property (nonatomic) CGFloat buttonHeight;
@property (nonatomic) BOOL isEditMode;


@end
