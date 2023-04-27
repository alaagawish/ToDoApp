//
//  TableViewCell.h
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@end

NS_ASSUME_NONNULL_END
