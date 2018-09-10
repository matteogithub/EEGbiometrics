inDir='/Users/matteo/Desktop/2018_2019/Ricerca/scalp_adjust_ALL/';
outDir='/Users/matteo/Desktop/2018_2019/Ricerca/scalp_adjust_ALL_filtered/';
fs=160;
n_sens=64;
fil='*.edf';
bands={'delta';'theta';'alpha';'beta';'gamma'};
cases=dir(fullfile(inDir,fil));
for i=1:length(cases)
    i
    tic
    EEG=pop_biosig(strcat(inDir,cases(i).name), 'importevent','off','importannot','off');
    for ind=1:size(bands,1)
        switch ind
            case 1
                lf=1;
                hf=4;
            case 2
                lf=4;
                hf=8;
            case 3
                lf=8;
                hf=13;
            case 4
                lf=13;
                hf=30;
            case 5
                lf=30;
                hf=45;
        end
        data=eegfilt(EEG.data(1:64,:),fs,lf,hf,0,[],0,'fir1',0);
        filename=strcat(outDir,bands{ind},'/',cases(i).name);
        save(filename,'data');
    end
    toc
end


