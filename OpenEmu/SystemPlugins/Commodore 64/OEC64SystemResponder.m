/*
 Copyright (c) 2015, OpenEmu Team

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
     * Neither the name of the OpenEmu Team nor the
       names of its contributors may be used to endorse or promote products
       derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY OpenEmu Team ''AS IS'' AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL OpenEmu Team BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "OEC64SystemResponder.h"
#import "OEC64SystemResponderClient.h"

@implementation OEC64SystemResponder
@dynamic client;

+ (Protocol *)gameSystemResponderClientProtocol;
{
    return @protocol(OEC64SystemResponderClient);
}

- (void)HIDKeyDown:(OEHIDEvent *)theEvent
{
    [super HIDKeyDown:theEvent];
    [self.client keyDown:theEvent.keycode];
}

- (void)HIDKeyUp:(OEHIDEvent *)theEvent
{
    [super HIDKeyUp:theEvent];
    [self.client keyUp:theEvent.keycode];
}

- (void)pressEmulatorKey:(OESystemKey *)aKey
{
    OEC64Button button = (OEC64Button)aKey.key;
    
    switch(button)
    {
        case OEC64SwapJoysticks : [self.client swapJoysticks]; break;
        default :
            [self.client didPushC64Button:button forPlayer:aKey.player];
            break;
    }
}

- (void)releaseEmulatorKey:(OESystemKey *)aKey
{
    [self.client didReleaseC64Button:(OEC64Button)aKey.key forPlayer:aKey.player];
}

- (void)mouseMovedAtPoint:(OEIntPoint)aPoint
{
    [self.client mouseMovedAtPoint:aPoint];
}

- (void)mouseDownAtPoint:(OEIntPoint)aPoint
{
    [self.client leftMouseDownAtPoint:aPoint];
}

- (void)mouseUpAtPoint
{
    [self.client leftMouseUp];
}

- (void)rightMouseDownAtPoint:(OEIntPoint)aPoint
{
    [self.client rightMouseDownAtPoint:aPoint];
}

- (void)rightMouseUpAtPoint
{
    [self.client rightMouseUp];
}

@end
