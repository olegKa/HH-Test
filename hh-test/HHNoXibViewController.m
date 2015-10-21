//
//  HHNoXibViewController.m
//  hh-test
//
//  Created by OLEG KALININ on 21.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHNoXibViewController.h"
#import "HHPaginator.h"
#import "HHVacancyNoXibCell.h"

NSString *const cellNoXibIdentifier = @"cellVacancyNoXib";

@interface HHNoXibViewController ()
<
    HHPaginatorDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>
{
    NSIndexPath *visibleIndexPath;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HHPaginator *paginator;

@end

@implementation HHNoXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureControls];
    
    _paginator = [HHPaginator sharedPaginator];
    _paginator.delegate = self;
    
    // запрос первой страницы
    [_paginator nextPage];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureControls {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _tableView.estimatedRowHeight = 44;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:_tableView];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bottomLayoutGuide
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view updateConstraints];
}


#pragma mark - HHPaginatorDelegate
- (void)paginatorWillChangeContent:(HHPaginator *)paginator {
    [self.tableView beginUpdates];
}


- (void)paginator:(HHPaginator *)paginator didChangeObject:(id)anObject atIndex:(NSInteger)index {
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]  withRowAnimation:UITableViewRowAnimationNone];
}

- (void)paginatorDidChangeContent:(HHPaginator *)paginator {
    [self.tableView endUpdates];
    if (visibleIndexPath) {
        [self.tableView scrollToRowAtIndexPath:visibleIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        visibleIndexPath = nil;
    }
}

#pragma mark - UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 88;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _paginator.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNoXibIdentifier];
    if (!cell) {
        cell = [[HHVacancyNoXibCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellNoXibIdentifier];
    }
    
    HHVacancyNoXibCell *vacancyCell = (HHVacancyNoXibCell *)cell;
    if (!vacancyCell.vacancy) {
        [self configureCell:(HHVacancyNoXibCell *)cell forIndexPath:indexPath];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self configureCell:(HHVacancyTableViewCell *)cell forIndexPath:indexPath];
    if (indexPath.row == _paginator.count - 1) {
        visibleIndexPath = indexPath;
        [_paginator nextPage];
    }
}

- (void)configureCell:(HHVacancyNoXibCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    HHVacancy *vacancy = (HHVacancy *)[_paginator objectAtIndex:indexPath.row];
    if (vacancy) {
        cell.vacancy = vacancy;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
