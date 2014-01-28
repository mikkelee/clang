// RUN: %clang_cc1 -fobjc-arc -fobjc-arithmetic-overloading %s

#if !__has_extension(objc_arithmetic_overloading)
	#error This code requires Obj-C arithmetic overloading!
#endif

#import <Foundation/Foundation.h>

@interface NSString (MEArithmeticAdditions)

- (instancetype)objectByAddingObject:(NSString *)str;

@end

@implementation NSString (MEArithmeticAdditions)

- (instancetype)objectByAddingObject:(NSString *)str
{
	return [self stringByAppendingString:str];
}

@end

@interface NSNumber (MEArithmeticAdditions)

- (instancetype)objectByAddingObject:(NSNumber *)num;

@end

@implementation NSNumber (MEArithmeticAdditions)

static inline int err() {
	//TODO there's probably a better way.
	NSLog(@"Something is wrong!");
	__builtin_unreachable();
}

- (instancetype)objectByAddingObject:(NSNumber *)num
{
	//TODO handle all cases
	return @((
		strcmp([self objCType], "i")==0 ? [self intValue] :
		strcmp([self objCType], "f")==0 ? [self floatValue] : 
		err()
	) + (
		strcmp([num objCType], "i")==0 ? [num intValue] :
		strcmp([num objCType], "f")==0 ? [num floatValue] : 
		err()
	));
}

@end

int main() {
	NSString *a = @"Hello, ";
	NSString *b = @"World.";
	NSString *helloWorld = a + b;
	
	NSLog(@"%@", helloWorld);
	
	NSNumber *one = @1;
	NSNumber *two = @2;
	NSNumber *three = one + two;
	
	NSLog(@"%@ + %@ = %@", one, two, three);
	
	// If the object does not implement the arithmetic methods, compilation fails with
	// error: no visible @interface for 'NSNumber' declares the selector 'objectBySubtractingObject:'
	// NSNumber *zero = one - one;
}