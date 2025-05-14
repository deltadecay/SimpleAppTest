
#include <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

// Need custom app delegate to close app when red close button clicked on the window
@interface AppDelegate : NSResponder <NSApplicationDelegate>
@end
@implementation AppDelegate
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}
@end


int main(int argc, const char * argv[]) 
{
	AppDelegate *appDelegate = [AppDelegate new];
	NSApplication *app = [NSApplication sharedApplication];
	app.delegate = appDelegate;

	// menu bar
	NSMenu *menubar = [NSMenu new];
	[app setMainMenu:menubar];
	// app menu
	NSMenuItem *appMenuItem = [NSMenuItem new];
	NSMenu *appMenu = [NSMenu new];
	[appMenu addItemWithTitle: @"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
	[appMenuItem setSubmenu:appMenu];
	[menubar addItem:appMenuItem];

	NSFont *font = [NSFont systemFontOfSize:20.0f];
	NSTextView *textView = [[NSTextView alloc] initWithFrame:NSMakeRect(300, 300, 200, 30)];
	textView.string = @"Hello World";
	textView.editable = NO;
	textView.selectable = NO;
	textView.font = font;
	textView.alignment = NSTextAlignmentCenter;
	textView.textColor = [NSColor redColor];
	textView.backgroundColor = [NSColor clearColor];
	textView.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;

	NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 800, 600)];
	view.autoresizesSubviews = YES;
	[view addSubview:textView];

	NSViewController *viewController = [[NSViewController alloc] init];
	viewController.view = view;
	// If NSViewController subclassed and init done in viewDidLoad need to call it manually
	[viewController viewDidLoad];

	NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 500, 400) 
		styleMask:NSWindowStyleMaskResizable|NSWindowStyleMaskTitled|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskClosable 
		backing:NSBackingStoreBuffered defer:YES];
	window.title = @"SimpleAppTest";

	
	window.contentViewController = viewController;
	window.contentView = viewController.view;

	NSWindowController *winController = [[NSWindowController alloc] initWithWindow:window];
	//winController.contentViewController = window.contentViewController;
	//winController.window = window;
	[winController showWindow:app];

	

	[window center];
	[window makeKeyAndOrderFront:window];

	[app run];

	return 0;
}


