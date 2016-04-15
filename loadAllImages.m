function allImages = loadAllImages(subDir)
    listing = dir(subDir);
    fileNames = {};
    for i = 3:length(listing)
        fileNames{i-2} = [subDir '/'  listing(i).name];
    end

    allImages = {};
    for i = 1:length(fileNames)
        allImages{i} = imread(fileNames{i});
    end
end

