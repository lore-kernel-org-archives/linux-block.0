Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:44348 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbdLDIS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 03:18:27 -0500
Received: by mail-pf0-f176.google.com with SMTP id m26so7960795pfj.11
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2017 00:18:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171204081408.oyp46roxbkjbxxkw@mwanda>
References: <f403043d11ccfea019055f705d18@google.com> <20171203201608.GC844@zzz.localdomain>
 <20171204081408.oyp46roxbkjbxxkw@mwanda>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 4 Dec 2017 09:18:05 +0100
Message-ID: <CACT4Y+aE-Q-PeUaY99d2UbK4BHnf18OoV0MBXyOXzXttf1=nYw@mail.gmail.com>
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

On Mon, Dec 4, 2017 at 9:14 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Sun, Dec 03, 2017 at 12:16:08PM -0800, Eric Biggers wrote:
>> Looks like BLKTRACESETUP doesn't limit the '.buf_nr' parameter, allowing anyone
>> who can open a block device to cause an extremely large kmalloc.  Here's a
>> simplified reproducer:
>>
>
> There are lots of places which allow people to allocate as much as they
> want.  With Syzcaller, you might want to just hard code a __GFP_NOWARN
> in to disable it.

Hi,

Hard code it where?

User-controllable allocation are supposed to use __GFP_NOWARN.
