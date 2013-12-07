//
//  PBJHexagonFlowLayout.h
//
//  Created by Patrick Piemonte on 10/30/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBJHexagonFlowLayout : UICollectionViewFlowLayout
{
}

@property (nonatomic) NSInteger itemsPerRow;
@property (nonatomic) NSInteger itemTotalCount;
@property (nonatomic) CGSize hexagonSize;

@end
