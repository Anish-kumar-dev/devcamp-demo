//
//  Evento.h
//  DevCampDemo
//
//  Created by Marcelo Fabri on 27/04/13.
//  Copyright (c) 2013 Marcelo Fabri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Evento : NSObject

@property (nonatomic, strong) NSArray *trilhas;
@property (nonatomic, copy) NSString *nome;
@property (nonatomic, copy) NSString *edicao;

@end
