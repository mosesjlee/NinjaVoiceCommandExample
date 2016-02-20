//
//  PocketSphinxWrapper.cpp
//  NinjaExample
//
//  Created by Moses Lee on 2/19/16.
//  Copyright © 2016 Moses Lee. All rights reserved.
//

#include "PocketSphinxWrapper.hpp"

PocketSphinxWrapper::PocketSphinxWrapper(string path){
    //Get the bundle path
    bundlePath = path;
    
    if (initializeConfigureAndDecoder()) {
        cout << "Initialized the decoder and configurator" << endl;
    } else {
        cout << "Failed to initialize the decoder and configurator" << endl;
    }
    
    bufIndex = 0;
}

PocketSphinxWrapper::~PocketSphinxWrapper(){
    
}

//Returns 1 for sucess and 0 for failure
int PocketSphinxWrapper::initializeConfigureAndDecoder(){
    
#if AUDIO_READ_MODE
    config = cmd_ln_init(NULL, ps_args(), TRUE,
                         "-hmm", bundlePath.c_str(),
                         "-allphone", (bundlePath + "/en-us-phone.lm.bin").c_str(),
                         "-backtrace", "yes", "-beam", "1e-20", "-pbeam", "1e-20", "-lw", "2.0", NULL);
#else
    config = cmd_ln_init(NULL, ps_args(), TRUE,
                         "-hmm", bundlePath.c_str(),
                         "-lm", (bundlePath + "/en-us.lm.bin").c_str(),
                         "-dict", (bundlePath + "/cmudict-en-us.dict").c_str(), NULL);
#endif
    
    if(config == NULL)
        return 0;
    
    //Initialize
    ps = ps_init(config);
    
    if (ps == NULL)
        return 0;
    
    return 1;
}

void PocketSphinxWrapper::listenForInputStream(float * data, int numFrames, int numChannels, int * flag){
    //Before check
    if (bufIndex >=  SR/2) return;
    for(int i = 0; i < numFrames; i++){
        
        //I only care about 1 channel anyway
        for(int j = 0; j < 1; j++){
            buf[bufIndex] = data[i * numChannels + j] * CONVER_FACTOR;
            bufIndex++;
            //During Check
            if (bufIndex >=  SR/2) {
                *flag = 1;
                return;
            }
        }
    }
    printf("flag: %d bufIndex: %d\n", *flag, bufIndex);
}

string PocketSphinxWrapper::getTheWord(){
    return theWord;
}

void PocketSphinxWrapper::processTheInputStream(){
    printf("Process the inputstream\n");
    rv = ps_start_utt(ps);
    if (rv < 0) {
        cout << "Could not understand samples" << endl;
        bufIndex = 0;
        return;
    }
    
    printf("Reading the buffer the inputstream\n");
    int16 * ptr = buf;
    while (ptr < &buf[SR/2]){
        //size_t nsamp; nsamp = fread(buf, 2, 512, ptr);
        rv = ps_process_raw(ps, buf, 512, FALSE, FALSE);
        ptr += 512;
    }
    
    rv = ps_end_utt(ps);
    if (rv < 0) {
        cout << "Could not get the last utterance " << endl;
        bufIndex = 0;
        return;
    }
    
    hyp = ps_get_hyp(ps, &score);
    if (hyp == NULL){
        cout << "Could not get the word" << endl;
        bufIndex = 0;
        return;
    }
    
    printf("Reading the buffer the inputstream\n");
    theWord = string(hyp);
    bufIndex = 0;
}

void PocketSphinxWrapper::readAndProcessFromFile(){
    fh = fopen((bundlePath + "/fire.raw").c_str(), "rb");
    
    if (fh == NULL)
    {
        cout << "could not open file" << endl;
    } else {
        rv = ps_start_utt(ps);
        if (rv < 0) {
            cout << "Could not understand samples" << endl;
            return;
        }
        
        while (!feof(fh)){
            size_t nsamp; nsamp = fread(buf, 2, 512, fh);
            rv = ps_process_raw(ps, buf, nsamp, FALSE, FALSE);
        }
        
        rv = ps_end_utt(ps);
        if (rv < 0) {
            cout << "Could not get the last utterance " << endl;
            return;
        }
        
        hyp = ps_get_hyp(ps, &score);
        if (hyp == NULL){
            cout << "Could not get the word" << endl;
            return;
        }
        theWord = string(hyp);
    }
}
