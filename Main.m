%{
    EC503 - Learning from Data
    March 2018
    Word Embeddings De-biasing
    Main script
    Work by: Frank Tranghese, Nidhi Tiwari, Aditya Singh
%}

% CODE GOES HERE
fileID = fopen('w2v_gnews_small.txt');
fmt = ['%s ' repmat('%f ',1,300)];
words = textscan(fileID,fmt);
fclose('all');
wordvecs = cell2mat(words(:,2:end));
words = words(:,1);
words_part = {};
for p = 1:length(words{:})
    words_part{p,1} = words{1,1}{p,1};
end
wordIndex = containers.Map(words_part, (1:length(words_part)));
% Normalising the word vectors
norms = zeros(size(wordvecs,1),1);
for j = 1:size(wordvecs,1)
    vector = wordvecs(j,:);
    % Normalising
    norms(j,:) = vector./norm(vector);
end

g = getGenderDirection(norms,wordIndex);

% Getting the normalised vectors of the occupation words list
[occupationWords, occupationVectors] = getVectorsOfType('occupations.json',norms,wordIndex,words_part)
 