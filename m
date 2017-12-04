Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:33107 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdLDLXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 06:23:03 -0500
Date: Mon, 4 Dec 2017 11:14:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: syzbot
        <bot+2797c18fc195e3e240c3c3e7837a14130e157fb0@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org, arnd@arndb.de,
        dave.jiang@intel.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org
Subject: Re: WARNING in kmalloc_slab (3)
Message-ID: <20171204081408.oyp46roxbkjbxxkw@mwanda>
References: <f403043d11ccfea019055f705d18@google.com>
 <20171203201608.GC844@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171203201608.GC844@zzz.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Dec 03, 2017 at 12:16:08PM -0800, Eric Biggers wrote:
> Looks like BLKTRACESETUP doesn't limit the '.buf_nr' parameter, allowing anyone
> who can open a block device to cause an extremely large kmalloc.  Here's a
> simplified reproducer:
> 

There are lots of places which allow people to allocate as much as they
want.  With Syzcaller, you might want to just hard code a __GFP_NOWARN
in to disable it.

regards,
dan carpenter
