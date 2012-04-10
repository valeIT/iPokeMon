//
//  PokemonMoveViewController.m
//  Pokemon
//
//  Created by Kaijie Yu on 2/6/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "SixPokemonsMoveViewController.h"

#import "TrainerTamedPokemon+DataController.h"
#import "Move.h"
#import "PokemonMoveView.h"
#import "PokemonMoveDetailView.h"

@interface SixPokemonsMoveViewController ()

- (void)loadMoveDetailView:(id)sender;
- (void)cancelMoveDetailView;

@end

@implementation SixPokemonsMoveViewController

@synthesize fourMovesPP    = fourMovesPP_;
@synthesize fourMovesView  = fourMovesView_;
@synthesize moveOneView    = moveOneView_;
@synthesize moveTwoView    = moveTwoView_;
@synthesize moveThreeView  = moveThreeView_;
@synthesize moveFourView   = moveFourView_;
@synthesize moveDetailView = moveDetailView_;

- (void)dealloc
{
  [fourMovesPP_    release];
  [fourMovesView_  release];
  [moveOneView_    release];
  [moveTwoView_    release];
  [moveThreeView_  release];
  [moveFourView_   release];
  [moveDetailView_ release];
  
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
  [super loadView];
  
  // Constants
  CGFloat const moveViewHeight = (self.view.frame.size.height - 80.f) / 4.f;
  CGRect  const ppLabelFrame = CGRectMake(200.f, 0.f, 90.f, 20.f);
  CGRect  const fourMovesViewFrame = CGRectMake(0.f, 20.f, self.view.frame.size.width, self.view.frame.size.height);
  CGRect  const moveOneViewFrame   = CGRectMake(0.f, 10.f, 300.f, moveViewHeight);
  CGRect  const moveTwoViewFrame   = CGRectMake(0.f, 10.f + moveViewHeight, 300.f, moveViewHeight);
  CGRect  const moveThreeViewFrame = CGRectMake(0.f, 10.f + moveViewHeight * 2, 300.f, moveViewHeight);
  CGRect  const moveFourViewFrame  = CGRectMake(0.f, 10.f + moveViewHeight * 3, 300.f, moveViewHeight);
  
  // PP
  UILabel * ppLabel = [[UILabel alloc] initWithFrame:ppLabelFrame];
  [ppLabel setBackgroundColor:[UIColor clearColor]];
  [ppLabel setTextAlignment:UITextAlignmentRight];
  [ppLabel setTextColor:[GlobalRender textColorTitleWhite]];
  [ppLabel setFont:[GlobalRender textFontBoldInSizeOf:16.f]];
  [ppLabel setText:NSLocalizedString(@"PMSLabelPP", nil)];
  [self.view addSubview:ppLabel];
  [ppLabel release];
  
  // Set Four Moves' layout
  fourMovesView_ = [[UIView alloc] initWithFrame:fourMovesViewFrame];
  
  moveOneView_   = [[PokemonMoveView alloc] initWithFrame:moveOneViewFrame];
  moveTwoView_   = [[PokemonMoveView alloc] initWithFrame:moveTwoViewFrame];
  moveThreeView_ = [[PokemonMoveView alloc] initWithFrame:moveThreeViewFrame];
  moveFourView_  = [[PokemonMoveView alloc] initWithFrame:moveFourViewFrame];
  
  [moveOneView_.viewButton   setTag:1];
  [moveTwoView_.viewButton   setTag:2];
  [moveThreeView_.viewButton setTag:3];
  [moveFourView_.viewButton  setTag:4];
  
  [moveOneView_.viewButton   addTarget:self action:@selector(loadMoveDetailView:)
                      forControlEvents:UIControlEventTouchUpInside];
  [moveTwoView_.viewButton   addTarget:self action:@selector(loadMoveDetailView:)
                      forControlEvents:UIControlEventTouchUpInside];
  [moveThreeView_.viewButton addTarget:self action:@selector(loadMoveDetailView:)
                      forControlEvents:UIControlEventTouchUpInside];
  [moveFourView_.viewButton  addTarget:self action:@selector(loadMoveDetailView:)
                      forControlEvents:UIControlEventTouchUpInside];
  
  [fourMovesView_ addSubview:moveOneView_];
  [fourMovesView_ addSubview:moveTwoView_];
  [fourMovesView_ addSubview:moveThreeView_];
  [fourMovesView_ addSubview:moveFourView_];
  [self.view addSubview:fourMovesView_];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // PP for four moves
  self.fourMovesPP = [self.pokemon fourMovesPPInArray];
  
  // Four moves
  Move * move1 = [self.pokemon move1];
  if (move1 != nil) {
    [self.moveOneView.viewButton setEnabled:YES];
    
    [self.moveOneView.type1 setText:
     NSLocalizedString(([NSString stringWithFormat:@"PMSType%.2d", [move1.type intValue]]), nil)];
    [self.moveOneView.name setText:
     NSLocalizedString(([NSString stringWithFormat:@"PMSMove%.3d", [move1.sid intValue]]), nil)];
    [self.moveOneView.pp setText:[NSString stringWithFormat:@"%d / %d",
                                  [[fourMovesPP_ objectAtIndex:0] intValue],
                                  [[fourMovesPP_ objectAtIndex:1] intValue]]];
    move1 = nil;
  }
  else [self.moveOneView.viewButton setEnabled:NO];
  
  Move * move2 = [self.pokemon move2];
  if (move2 != nil) {
    [self.moveTwoView.viewButton setEnabled:YES];
    
    [self.moveTwoView.type1 setText:
     NSLocalizedString(([NSString stringWithFormat:@"PMSType%.2d", [move2.type intValue]]), nil)];
    [self.moveTwoView.name setText:
     NSLocalizedString(([NSString stringWithFormat:@"PMSMove%.3d", [move2.sid intValue]]), nil)];
    [self.moveTwoView.pp setText:[NSString stringWithFormat:@"%d / %d",
                                  [[fourMovesPP_ objectAtIndex:2] intValue],
                                  [[fourMovesPP_ objectAtIndex:3] intValue]]];
    move2 = nil;
  }
  else [self.moveTwoView.viewButton setEnabled:NO];
  
  Move * move3 = [self.pokemon move3];
  if (move3 != nil) {
    [self.moveThreeView.viewButton setEnabled:YES];
    
    [self.moveThreeView.type1 setText:
     NSLocalizedString(([NSString stringWithFormat:@"PMSType%.2d", [move3.type intValue]]), nil)];
    [self.moveThreeView.name setText:
     NSLocalizedString(([NSString stringWithFormat:@"PMSMove%.3d", [move3.sid intValue]]), nil)];
    [self.moveThreeView.pp setText:[NSString stringWithFormat:@"%d / %d",
                                    [[fourMovesPP_ objectAtIndex:4] intValue],
                                    [[fourMovesPP_ objectAtIndex:5] intValue]]];
    move3 = nil;
  }
  else [self.moveThreeView.viewButton setEnabled:NO];
  
  Move * move4 = [self.pokemon move4];
  if (move4 != nil) {
    [self.moveFourView.viewButton setEnabled:YES];
    
    [self.moveFourView.type1 setText:
     NSLocalizedString(([NSString stringWithFormat:@"PMSType%.2d", [move4.type intValue]]), nil)];
    [self.moveFourView.name setText:
     NSLocalizedString(([NSString stringWithFormat:@"PMSMove%.3d", [move4.sid intValue]]), nil)];
    [self.moveFourView.pp setText:[NSString stringWithFormat:@"%d / %d",
                                   [[fourMovesPP_ objectAtIndex:6] intValue],
                                   [[fourMovesPP_ objectAtIndex:7] intValue]]];
    move4 = nil;
  }
  else [self.moveFourView.viewButton setEnabled:NO];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  
  self.fourMovesPP    = nil;
  self.fourMovesView  = nil;
  self.moveOneView    = nil;
  self.moveTwoView    = nil;
  self.moveThreeView  = nil;
  self.moveFourView   = nil;
  self.moveDetailView = nil;
}

#pragma mark - Private Methods

- (void)loadMoveDetailView:(id)sender
{
  if (! moveDetailView_) {
    CGRect const fourMovesViewFrame = CGRectMake(0.f, 5.f, self.view.frame.size.width, self.view.frame.size.height - 5.f);
    PokemonMoveDetailView * moveDetailView = [[PokemonMoveDetailView alloc] initWithFrame:fourMovesViewFrame];
    self.moveDetailView = moveDetailView;
    [moveDetailView release];
    [self.moveDetailView.backButton addTarget:self
                                       action:@selector(cancelMoveDetailView)
                             forControlEvents:UIControlEventTouchUpInside];
  }
  
  // Move tag: one of 1, 2, 3, 4
  NSInteger moveTag = ((UIButton *)sender).tag;
  Move * move = [self.pokemon moveWithIndex:moveTag];
  if (move == nil)
    return;
  
  [self.moveDetailView.moveBaseView.type1 setText:
   NSLocalizedString(([NSString stringWithFormat:@"PMSType%.2d", [move.type intValue]]), nil)];
  [self.moveDetailView.moveBaseView.name setText:
   NSLocalizedString(([NSString stringWithFormat:@"PMSMove%.3d", [move.sid intValue]]), nil)];
  [self.moveDetailView.moveBaseView.pp setText:
   [NSString stringWithFormat:@"%d / %d", [[fourMovesPP_ objectAtIndex:moveTag * 2 - 1] intValue],
                                          [[fourMovesPP_ objectAtIndex:moveTag * 2 - 2] intValue]]];
  [self.moveDetailView.categoryLabelView.value setText:
   NSLocalizedString(([NSString stringWithFormat:@"PMSMoveCategory%d", [move.category intValue]]), nil)];
  [self.moveDetailView.powerLabelView.value setText:
   [[move.baseDamage stringValue] isEqualToString:@"0"] ? @"-" : [move.baseDamage stringValue]];
  [self.moveDetailView.accuracyLabelView.value setText:
   [[move.hitChance stringValue] isEqualToString:@"0"] ? @"-" : [move.hitChance stringValue]];
  [self.moveDetailView.infoTextView setText:
   NSLocalizedString(([NSString stringWithFormat:@"PMSMoveInfo%.3d", [move.sid intValue]]), nil)];
  move = nil;
  
  [UIView transitionFromView:self.fourMovesView
                      toView:self.moveDetailView
                    duration:.6f
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  completion:nil];
}

- (void)cancelMoveDetailView {
  [UIView transitionFromView:self.moveDetailView
                      toView:self.fourMovesView
                    duration:.6f
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  completion:nil];
}

@end
