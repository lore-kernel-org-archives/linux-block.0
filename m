Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:38530 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbdLLVWw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 16:22:52 -0500
Date: Tue, 12 Dec 2017 13:22:48 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot
        <bot+2797c18fc195e3e240c3c3e7837a14130e157fb0@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, dave.jiang@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
Subject: Re: WARNING in kmalloc_slab (3)
Message-ID: <20171212212248.GD185376@gmail.com>
References: <f403043d11ccfea019055f705d18@google.com>
 <20171203201608.GC844@zzz.localdomain>
 <20171204081408.oyp46roxbkjbxxkw@mwanda>
 <CACT4Y+aE-Q-PeUaY99d2UbK4BHnf18OoV0MBXyOXzXttf1=nYw@mail.gmail.com>
 <20171204092632.mh772rjaqahgslvp@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171204092632.mh772rjaqahgslvp@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Dec 04, 2017 at 12:26:32PM +0300, Dan Carpenter wrote:
> On Mon, Dec 04, 2017 at 09:18:05AM +0100, Dmitry Vyukov wrote:
> > On Mon, Dec 4, 2017 at 9:14 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > On Sun, Dec 03, 2017 at 12:16:08PM -0800, Eric Biggers wrote:
> > >> Looks like BLKTRACESETUP doesn't limit the '.buf_nr' parameter, allowing anyone
> > >> who can open a block device to cause an extremely large kmalloc.  Here's a
> > >> simplified reproducer:
> > >>
> > >
> > > There are lots of places which allow people to allocate as much as they
> > > want.  With Syzcaller, you might want to just hard code a __GFP_NOWARN
> > > in to disable it.
> > 
> > Hi,
> > 
> > Hard code it where?
> 
> My idea was to just make warn_alloc() a no-op.
> 
> > 
> > User-controllable allocation are supposed to use __GFP_NOWARN.
> 
> No that's not right.  What we don't want is unprivileged users to use
> all the memory and we don't want unprivileged users to spam
> /var/log/messages.  But you have to have slightly elevated permissions
> to open block devices right?  The warning is helpful.  Admins should
> "don't do that" if they don't want the warning.

WARN_ON() should only be used for kernel bugs.  printk can be a different story.
If it's a "userspace shouldn't do this" kind of thing, then if there is any
message at all it should be a rate-limited printk that actually explains what
the problem is, not a random WARN_ON() that can only be interpreted by kernel
developers.

And yes, the fact that anyone with read access to any block device, even e.g. a
loop device, can cause the kernel to do an unbounded kmalloc *is* a bug.  It
needs to have a reasonable limit.  It is not a problem on all systems, but on
some systems "the admin" might give users read access to some block devices.

Eric
