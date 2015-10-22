//
//  HHVacancyTableViewCell.m
//  hh-test
//
//  Created by OLEG KALININ on 20.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHVacancyTableViewCell.h"
#import "HHAPIClient.h"


@interface HHVacancyTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageViewLogo;
@property (nonatomic, weak) IBOutlet UILabel *labelVacancyName;
@property (nonatomic, weak) IBOutlet UILabel *labelEmployerName;
@property (nonatomic, weak) IBOutlet UILabel *labelSalary;

@end

@implementation HHVacancyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVacancy:(HHVacancy *)vacancy {
    _labelVacancyName.text = vacancy.name;
    _labelEmployerName.text = vacancy.employer.name;
    //_labelSalary.text = (vacancy.salary)? vacancy.salary.description: @"з/п не указана";
    _labelSalary.text = (vacancy.salary)? vacancy.salary.description: nil;
    if (vacancy.employer.logo) {
        HHAPIClient *apiClient = [HHAPIClient sharedClient];
        __weak typeof(_imageViewLogo) _weakImageViewLogo = _imageViewLogo;
        [apiClient loadImageUrl:vacancy.employer.logo withCompletion:^(BOOL success, UIImage *image) {
            if (success) {
                _weakImageViewLogo.image = image;
            }
        }];
    } else {
        _imageViewLogo.image = nil;
    }
}

@end
