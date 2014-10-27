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


/////////////////////////////
//@class EditableCollectionViewCell;
//
//@protocol EditableCollectionViewCellDelegate <NSObject>
//
//@optional
//// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
//- (BOOL)editableCellDeleteModeShouldBegin:(EditableCollectionViewCell*)editableCell;
//- (void)editableCellDelButtonDidTap:(EditableCollectionViewCell*)editableCell;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//@end
//
//@interface EditableCollectionViewCell : UICollectionViewCell <UIGestureRecognizerDelegate>
//
//@property (getter=isDeleteMode) BOOL deleteMode;
//@property(nonatomic, assign) id<EditableCollectionViewCellDelegate> delegate;
//
//@end
///////////////////////////////////////////////
@end

@interface EditableCollectionView : UICollectionView <EditableCollectionViewCellDelegate>

@property (nonatomic, assign) id <UICollectionViewDelegate,EditableCollectionViewDelegate> delegate;

@end
