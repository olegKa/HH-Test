//
//  HHVacancyNoXibCell.m
//  hh-test
//
//  Created by OLEG KALININ on 21.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHVacancyNoXibCell.h"
#import "HHAPIClient.h"

@interface HHVacancyNoXibCell ()

@property (nonatomic, strong) UIImageView *imageViewLogo;
@property (nonatomic, strong) UILabel *labelVacancyName;
@property (nonatomic, strong) UILabel *labelEmployerName;
@property (nonatomic, strong) UILabel *labelSalary;

@end

@implementation HHVacancyNoXibCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _imageViewLogo = [self setupImageView];
    
    _labelVacancyName = [self setupLabelWithTopView:nil];
    _labelVacancyName.textColor = RGB(200, 135, 35);
    _labelVacancyName.numberOfLines = 0;
    
    _labelSalary = [self setupLabelWithTopView:_labelVacancyName];
    [_labelEmployerName setContentHuggingPriority:248 forAxis:UILayoutConstraintAxisVertical];
    
    _labelEmployerName = [self setupLabelWithTopView:_labelSalary];
    [_labelEmployerName setContentHuggingPriority:250 forAxis:UILayoutConstraintAxisVertical];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_labelEmployerName
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:-4];
    
    [self.contentView addConstraint:bottomConstraint];
    
    
}

- (UIImageView *)setupImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setContentCompressionResistancePriority:247 forAxis:UILayoutConstraintAxisVertical];

    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:imageView];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:8]];
    
    NSLayoutConstraint *logoHeight = [NSLayoutConstraint constraintWithItem:imageView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0.9
                                                                   constant:0];
    logoHeight.priority = UILayoutPriorityDefaultHigh;
    [self.contentView addConstraint:logoHeight];
    
    [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:70]];

    
    return imageView;
}

- (UILabel *)setupLabelWithTopView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:label];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:label
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:(view)? view : self.contentView
                                                           attribute:(view)? NSLayoutAttributeBottom : NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:4];
    [self.contentView addConstraint:top];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:-8]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageViewLogo
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:label
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant: -8]];
    
    
    return label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Override
- (void)updateConstraints {
    [self.contentView updateConstraints];
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView updateConstraints];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    // self.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.textLabel.frame);
}


#pragma mark - Properties
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
