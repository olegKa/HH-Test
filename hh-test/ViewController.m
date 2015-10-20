//
//  ViewController.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "ViewController.h"
#import "HHVacancyTableViewCell.h"
#import "HHPaginator.h"
#import "HHVacancy.h"

NSString *const cellIdentifier = @"cellVacancy";

@interface ViewController ()
<
    HHPaginatorDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>
{
    NSIndexPath *visibleIndexPath;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HHPaginator *paginator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _paginator = [HHPaginator sharedPaginator];
    _paginator.delegate = self;

    [_paginator nextPage];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self.tableView scrollToRowAtIndexPath:visibleIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        visibleIndexPath = nil;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _paginator.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    HHVacancyTableViewCell *vacancyCell = (HHVacancyTableViewCell *)cell;
    if (!vacancyCell.vacancy) {
        [self configureCell:(HHVacancyTableViewCell *)cell forIndexPath:indexPath];
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

- (void)configureCell:(HHVacancyTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    [_paginator requestVacancyAtIndex:indexPath.row withCompletion:^(HHVacancy *vacancy) {
//        if (vacancy) {
//            cell.textLabel.text = vacancy.name;
//            cell.detailTextLabel.text = vacancy.employer.name;
//        }
//    }];
    HHVacancy *vacancy = (HHVacancy *)[_paginator objectAtIndex:indexPath.row];
    if (vacancy) {
        cell.vacancy = vacancy;
//        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", vacancy.id, vacancy.name];
//        cell.detailTextLabel.text = vacancy.employer.name;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
