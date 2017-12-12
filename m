Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33633 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdLLPvA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 10:51:00 -0500
Received: by mail-pg0-f68.google.com with SMTP id g7so13687671pgs.0
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2017 07:51:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171204092632.mh772rjaqahgslvp@mwanda>
References: <f403043d11ccfea019055f705d18@google.com> <20171203201608.GC844@zzz.localdomain>
 <20171204081408.oyp46roxbkjbxxkw@mwanda> <CACT4Y+aE-Q-PeUaY99d2UbK4BHnf18OoV0MBXyOXzXttf1=nYw@mail.gmail.com>
 <20171204092632.mh772rjaqahgslvp@mwanda>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 12 Dec 2017 16:50:39 +0100
Message-ID: <CACT4Y+YHN_3O+s5vP_oA2AngidJ0oVZcNb3NWaCBVqoF+VfYTw@mail.gmail.com>
Subject: Re: WARNING in kmalloc_slab (3)
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Eric Biggers <ebiggers3@gmail.com>,
        syzbot
        <bot+2797c18fc195e3e240c3c3e7837a14130e157fb0@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, dave.jiang@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Dec 4, 2017 at 10:26 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Dec 04, 2017 at 09:18:05AM +0100, Dmitry Vyukov wrote:
>> On Mon, Dec 4, 2017 at 9:14 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> > On Sun, Dec 03, 2017 at 12:16:08PM -0800, Eric Biggers wrote:
>> >> Looks like BLKTRACESETUP doesn't limit the '.buf_nr' parameter, allowing anyone
>> >> who can open a block device to cause an extremely large kmalloc.  Here's a
>> >> simplified reproducer:
>> >>
>> >
>> > There are lots of places which allow people to allocate as much as they
>> > want.  With Syzcaller, you might want to just hard code a __GFP_NOWARN
>> > in to disable it.
>>
>> Hi,
>>
>> Hard code it where?
>
> My idea was to just make warn_alloc() a no-op.

Yes, but how?
We specifically don't have any private patches, etc. That would cause
a bunch of much more serious problems. The system tracks HEAD of
multiple upstream repositories.
Starting testing non-upstream branches with all bad consequences,
especially for something that has an official solution and that
solution is very simple (adding __GFP_NOWARN), looks like a wrong
direction.


>> User-controllable allocation are supposed to use __GFP_NOWARN.
>
> No that's not right.  What we don't want is unprivileged users to use
> all the memory and we don't want unprivileged users to spam
> /var/log/messages.  But you have to have slightly elevated permissions
> to open block devices right?  The warning is helpful.  Admins should
> "don't do that" if they don't want the warning.
>
> The kernel really isn't designed to work with Oops on Warn.  I try to
> tell people simple thinks like not printing a warning when
> copy_from_user() fails because I don't want /var/log/messages to get
> spammed.  But there are lots and lots of places which generate warnings.


Yes, but we also want kernel to be testable. And preferably in mostly
automated way to not hire an army of monkeys to sort out all crash
reports (we currently hit around 14 crashes per minute).

I don't question that notifying user about incorrect arguments is
useful (though, kernel generally don't do for every "return -EINVAL").
But that doesn't need to be WARNING. pr_err can do. And if we are
talking about end user, pr_err can actually provide an much better
error message (for a non-kernel developer "WARNING: CPU: 0 PID: 3081
at mm/slab_common.c:971 kmalloc_slab+0x5d/0x70 mm/slab_common.c:971"
is like wat?).
