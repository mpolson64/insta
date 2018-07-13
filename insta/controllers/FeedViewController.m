//
//  FeedViewController.m
//  insta
//
//  Created by Miles Olson on 7/9/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "FeedViewController.h"
#import "Parse.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "PostCell.h"
#import "PostViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *posts;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    PFUser *asdf= PFUser.currentUser;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self loadData:refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    cell.post = self.posts[indexPath.row];
    
    return cell;
}

- (IBAction)onLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [UIApplication sharedApplication].delegate.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }];
}

- (void)loadData:(UIRefreshControl *)refreshControl {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
        [self.tableView reloadData];
        [refreshControl endRefreshing];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([sender isKindOfClass:[PostCell class]]) {
        PostViewController *postViewController = [segue destinationViewController];
        postViewController.post = self.posts[[self.tableView indexPathForCell:sender].row];
    }
    
}


@end
