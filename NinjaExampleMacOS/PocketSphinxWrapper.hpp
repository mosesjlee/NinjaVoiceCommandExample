//
//  PocketSphinxWrapper.hpp
//  NinjaExample
//
//  Created by Moses Lee on 2/19/16.
//  Copyright © 2016 Moses Lee. All rights reserved.
//

#ifndef PocketSphinxWrapper_hpp
#define PocketSphinxWrapper_hpp
#define SR 16000 //16000 For sphinx Sample Rate 16k at 16 bit audio
#define DICT        "cmudict-en-us.dict" //Dictionary to read from
#define PHONE_READ  "en-us-phone.lm.bin" //If you speak in to mic
#define FILE_READ   "en-us.lm.bin"       //If you read from file
#define AUDIO_READ_MODE 0                   //0 for file reading 1 for microphone

#include <stdio.h>
#include <iostream>
#include <string>
#include <pocketsphinx/pocketsphinx.h>

using namespace std;
class PocketSphinxWrapper {
public:
    PocketSphinxWrapper(string path);
    ~PocketSphinxWrapper();
    int initializeConfigureAndDecoder();
    void listenForInputStream(float * data, int numFrames, int numChannels);
    
    string getTheWord();
    //Helper functions. Not sure what the visibility scope should be
protected:
    void readAndProcessFromFile();
    
private:
    ps_decoder_t * ps;
    cmd_ln_t * config;
    char const *hyp, *uttid;
    int16 buf[SR * 2];          //Listen for 2 seconds (2 * 16000) 32000 Samples
    int rv;
    int32 score;
    FILE *fh;
    string bundlePath;
    string theWord;
    
};
#endif /* PocketSphinxWrapper_hpp */
