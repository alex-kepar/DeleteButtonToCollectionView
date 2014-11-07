//
//  ViewController.m
//  DeleteButton
//
//  Created by Oleksandr Kiporenko on 10/21/14.
//  Copyright (c) 2014 Oleksandr Kiporenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellIdentifier = @"editableCell";
    return [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
}

- (void)collectionView:self shouldDeleteItemAtIndexPath:indexPath {
    NSLog(@"%ld", [indexPath row]);
}
@end
