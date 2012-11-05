//
//  NLLearningManager.m
//  StressIt
//
//  Created by Alexey Goncharov on 28.10.12.
//  Copyright (c) 2012 NIALSoft. All rights reserved.
//

#import "NLLearningManager.h"
#define kDefaultNumberOfWordsPerDay 10

static int trainingTimePeriod;
static int numberOfWordsPerDay;

@implementation NLLearningManager

// В начале работы с приложением мы предлагаем выбрать определенный срок (в днях), за который
// пользователь хотел бы освоить весь предложенный нами материал. Метод может вызываться не
// только при первом запуске, но и в любой момент (например, внесены изменения в настройки). При
// этом, каждый раз должны корректно пересчитываться сроки, а также ежедневная выдача новых слов.
+ (void)makeDayAmountForTime:(int)days {
    trainingTimePeriod = days;
    if (!trainingTimePeriod) {
        numberOfWordsPerDay = kDefaultNumberOfWordsPerDay;
    }
    else {
        //посчитать выдачу слов при непервом запуске программы
    }
}

// Метод, возвращяет массив из (NLWordBock *) для сегодняшнего изучения. В нем могут быть только
// новые слова.
+ (NSArray *)newWordsForToday {
    if (!numberOfWordsPerDay) {
        numberOfWordsPerDay = kDefaultNumberOfWordsPerDay;
    }
    return [NLWord newWordBlockToStudyTodayInAmount:numberOfWordsPerDay];
}

// Аналогичный предыдущему метод. Возвращает массив слов для теста. Может содержать как только
// что пройденные, так и слова для работы над ошибками. При ответе вызывается следующий за этим метод. В массиве (NLWord *)
+ (NSArray *)testWordsForToday {
    if (!numberOfWordsPerDay) {
        numberOfWordsPerDay = kDefaultNumberOfWordsPerDay;
    }
    return [NLWord newWordsForTodaysTest:numberOfWordsPerDay];
}

// Вызывается при ответе на слово. Должна создаваться пометка о том, что слово пройдено,
// пройдено не до конца, помещено в работу над ошибками и т.п.
+ (void)userAnsweredWord:(NLWord *)word answer:(BOOL)answer {
    if (!answer) {
        word.state = [NSNumber numberWithInt:NLWordStateRight];
        NSLog(@"wrong answer, add to correct list");
    }
    else {
        word.state = [NSNumber numberWithInt:NLWordStateWrong];
        NSLog(@"right answer");
    }
}

// Слово в избраннном = человек хочет изучить это слово => добавляем в список на изучение
+ (void)addToFavouritesWord:(NLWord *)word {
    word.state = NLWordStateFavourite;
}

// Формат словаря пока не определен (возможно, будут отдельные методы для каждой из требуемых величин).
+ (NSDictionary *)getUserStatistic {
    
}

@end
