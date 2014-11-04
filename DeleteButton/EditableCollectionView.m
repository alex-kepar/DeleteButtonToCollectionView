//
//  EditableCollectionView.m
//  DeleteButton
//
//  Created by Oleksandr Kiporenko on 10/24/14.
//  Copyright (c) 2014 Oleksandr Kiporenko. All rights reserved.
//

#import "EditableCollectionView.h"

@implementation EditableCollectionView

- (id)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    id cell = [super dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[EditableCollectionViewCell class]]) {
        EditableCollectionViewCell *editableCell = cell;
        editableCell.delegate = self;
    }
    return cell;
}

- (BOOL)editableCellDeleteModeShouldBegin:(EditableCollectionViewCell *)editableCell {
    BOOL ret = ![self resetEditableCells];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(collectionView:canEditCellAtIndexPath:)]) {
            NSIndexPath *indexPath = [self indexPathForCell:editableCell];
            if (![self.delegate collectionView:self canEditCellAtIndexPath:indexPath]) {
                ret = NO;
            }
        }
    }
    return ret;
}

- (void)editableCellDelButtonDidTap:(EditableCollectionViewCell *)editableCell {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(collectionView:shouldDeleteItemAtIndexPath:)]) {
            NSIndexPath *indexPath = [self indexPathForCell:editableCell];
            [self.delegate collectionView:self shouldDeleteItemAtIndexPath:indexPath];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self resetEditableCells];
}

- (BOOL)resetEditableCells {
    BOOL ret = NO;
    for (EditableCollectionViewCell *cell in self.visibleCells) {
        if (cell.isDeleteMode) {
            [cell setDeleteMode:NO];
            ret = YES;
        }
    }
    return ret;
}

@end
