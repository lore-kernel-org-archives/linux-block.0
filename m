Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20439 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041383AbdDUQjh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 12:39:37 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: for-4.12/block branch
Date: Fri, 21 Apr 2017 16:31:19 +0000
Message-ID: <1492792278.2550.5.camel@sandisk.com>
References: <1492788745.2550.1.camel@sandisk.com>
         <f6e71f2a-ad0b-c884-1e16-a2062c70b6cf@fb.com>
In-Reply-To: <f6e71f2a-ad0b-c884-1e16-a2062c70b6cf@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-21 at 10:25 -0600, Jens Axboe wrote:
> On 04/21/2017 09:32 AM, Bart Van Assche wrote:
> > Hello Jens,
> >=20
> > Since yesterday the following complaint is reported frequently after ha=
ving
> > installed the for-4.12/block branch on my test setup. Unless someone ha=
s a
> > better proposal, I will run a bisect.
> >=20
> > BUG: sleeping function called from invalid context at ./include/linux/b=
uffer_head.h:349
> > in_atomic(): 1, irqs_disabled(): 0, pid: 8019, name: find
> > CPU: 10 PID: 8019 Comm: find Tainted: G        W I     4.11.0-rc4-dbg+ =
#2
> > Call Trace:
> >  dump_stack+0x68/0x93
> >  ___might_sleep+0x16e/0x230
> >  __might_sleep+0x4a/0x80
> >  __ext4_get_inode_loc+0x1e0/0x4e0
> >  ext4_iget+0x70/0xbc0
> >  ext4_iget_normal+0x2f/0x40
> >  ext4_lookup+0xb6/0x1f0
> >  lookup_slow+0x104/0x1e0
> >  walk_component+0x19a/0x330
> >  path_lookupat+0x4b/0x100
> >  filename_lookup+0x9a/0x110
> >  user_path_at_empty+0x36/0x40
> >  vfs_statx+0x67/0xc0
> >  SYSC_newfstatat+0x20/0x40
> >  SyS_newfstatat+0xe/0x10
> >  entry_SYSCALL_64_fastpath+0x18/0xad
>=20
> How are you reproducing this? I've been running testing on the test box
> and I run it on my laptop as well, but I haven't seen anything odd.

Hello Jens,

All I have to do to reproduce this is to build, install and boot the kernel=
.
Maybe we are using a different kernel config?

Bart.=
