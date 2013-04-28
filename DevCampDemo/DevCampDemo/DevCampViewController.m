//
//  DevCampViewController.m
//  DevCampDemo
//
//  Created by Marcelo Fabri on 27/04/13.
//  Copyright (c) 2013 Marcelo Fabri. All rights reserved.
//

#import "DevCampViewController.h"
#import "Evento.h"
#import "Trilha.h"
#import "EventosAPIClient.h"

@interface DevCampViewController ()

@property (nonatomic, strong) Evento *evento;
@end

@implementation DevCampViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    
    // creating the logo view
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_devcamp"]];
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect frame = logoView.frame;
    frame.size = CGSizeMake(200, 44);
    logoView.frame = frame;
    self.navigationItem.titleView = logoView;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data loading

- (void)reloadData {
    [self.refreshControl beginRefreshing];
    
    [[EventosAPIClient sharedClient] getDevCampInfo:^(Evento *evento) {
        self.evento = evento;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.evento.trilhas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    Trilha *trilha = self.evento.trilhas[section];
    return [trilha.palestrantes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Trilha *trilha = self.evento.trilhas[indexPath.section];
    cell.textLabel.text = trilha.palestrantes[indexPath.row];
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Trilha *trilha = self.evento.trilhas[section];
    return trilha.nome;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
