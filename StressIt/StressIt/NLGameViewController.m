//
//  NLGameViewController.m
//  StressIt
//
//  Created by Виталий Давыдов on 19.11.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLGameViewController.h"

#define kDefaultRandomNumberOfWordsToPlay 10

@interface NLGameViewController ()

@end

@implementation NLGameViewController
@synthesize label = _label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NLLabel *)label {
    if (_label) {
        _label = nil;
    }
    NLCD_Word *randomWord = [self.wordsForGame lastObject];
    _label = [[NLLabel alloc] initWithWord:randomWord];
    _label.delegate = self;
    _label.center = self.view.center;

    return _label;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wordsForGame = [NLCD_Word getRandomWordsInAmount:kDefaultRandomNumberOfWordsToPlay];
    self.playerScores = 0;
    self.myScores.text = self.apponentScore.text = [NSString stringWithFormat:@"%d", self.playerScores];
    
    [self.view addSubview:self.label];
    
//    NSLog(@"%g %g %g %g", label.frame.origin.x, label.frame.origin.y, label.frame.size.height, label.frame.size.width);
//    self.word.text = ((NLCD_Word *)[self.wordsForGame lastObject]).text;
    
//    GKPeerPickerController *picker = [[GKPeerPickerController alloc]init];
//    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
//    picker.delegate = self;
//    [picker show];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark navigation

- (IBAction)menuButtonPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark connection

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type {
    GKSession *session = [[GKSession alloc] initWithSessionID:@"Stress It" displayName:nil sessionMode:GKSessionModePeer];
    return session;
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session {
    self.session = session;
    self.session.delegate = self;
    picker.delegate = nil;
    
    NSLog(@"main peer %@ did connect peer %@", self.session.peerID, [self.session peersWithConnectionState:GKPeerStateConnected].lastObject);
    
    [picker dismiss];
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    if (state == GKPeerStateConnected) {
        NSLog(@"succsessful connection");
        [session setDataReceiveHandler:self withContext:NULL];
    }
    else{
        NSLog(@"smth wrong");
        self.session.delegate = nil;
        self.session = nil;
    }
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
    int *arr = (int *)[data bytes];
    BOOL answer = *arr;
    int apponentScore = *(arr+1);
    if (answer) {
        self.apponentScore.text = [NSString stringWithFormat:@"%d", apponentScore];
    }
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
    NSLog(@"user canseled connection");
    picker.delegate =  nil;
    picker = nil;
    [picker dismiss];
    [self menuButtonPressed];
}

#pragma mark send data via NLLabelDelegate

- (void)userTouchedOnLetter:(NSNumber *)letter {
        NSLog(@"letter %@ touched", letter);
}

- (void)userAnsweredWithAnswer:(BOOL)answer {
    if (answer) {
        ++self.playerScores;
        [UIView animateWithDuration:3 animations:^{
            self.myScores.text = [NSString stringWithFormat:@"%d", self.playerScores];
        }];
        NSLog(@"right answer");
    }
    else {
        NSLog(@"wrong answer");
    }

    if (self.session) {
        int arr[2];
        arr[0] = answer;
        arr[1] = self.playerScores;
        
        NSData *data = [[NSData alloc] initWithBytes:arr length:sizeof(arr)];
        NSError *err;
        [self.session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&err];
    }
    else {
        NSLog(@"invalid session");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyScores:nil];
    [self setApponentScore:nil];
    [super viewDidUnload];
}
@end
