Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23408 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041443AbdDUQlA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 12:41:00 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: for-4.12/block branch
Date: Fri, 21 Apr 2017 16:40:52 +0000
Message-ID: <1492792852.2550.7.camel@sandisk.com>
References: <1492788745.2550.1.camel@sandisk.com>
         <f6e71f2a-ad0b-c884-1e16-a2062c70b6cf@fb.com>
         <1492792278.2550.5.camel@sandisk.com>
         <b248fae1-c51f-be03-d27c-a9730b65132a@fb.com>
In-Reply-To: <b248fae1-c51f-be03-d27c-a9730b65132a@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-21 at 10:33 -0600, Jens Axboe wrote:
> On 04/21/2017 10:31 AM, Bart Van Assche wrote:
> > On Fri, 2017-04-21 at 10:25 -0600, Jens Axboe wrote:
> > > On 04/21/2017 09:32 AM, Bart Van Assche wrote:
> > > > Hello Jens,
> > > >=20
> > > > Since yesterday the following complaint is reported frequently afte=
r having
> > > > installed the for-4.12/block branch on my test setup. Unless someon=
e has a
> > > > better proposal, I will run a bisect.
> > > >=20
> > > > BUG: sleeping function called from invalid context at ./include/lin=
ux/buffer_head.h:349
> > > > in_atomic(): 1, irqs_disabled(): 0, pid: 8019, name: find
> > > > CPU: 10 PID: 8019 Comm: find Tainted: G        W I     4.11.0-rc4-d=
bg+ #2
> > > > Call Trace:
> > > >  dump_stack+0x68/0x93
> > > >  ___might_sleep+0x16e/0x230
> > > >  __might_sleep+0x4a/0x80
> > > >  __ext4_get_inode_loc+0x1e0/0x4e0
> > > >  ext4_iget+0x70/0xbc0
> > > >  ext4_iget_normal+0x2f/0x40
> > > >  ext4_lookup+0xb6/0x1f0
> > > >  lookup_slow+0x104/0x1e0
> > > >  walk_component+0x19a/0x330
> > > >  path_lookupat+0x4b/0x100
> > > >  filename_lookup+0x9a/0x110
> > > >  user_path_at_empty+0x36/0x40
> > > >  vfs_statx+0x67/0xc0
> > > >  SYSC_newfstatat+0x20/0x40
> > > >  SyS_newfstatat+0xe/0x10
> > > >  entry_SYSCALL_64_fastpath+0x18/0xad
> > >=20
> > > How are you reproducing this? I've been running testing on the test b=
ox
> > > and I run it on my laptop as well, but I haven't seen anything odd.
> >=20
> > Hello Jens,
> >=20
> > All I have to do to reproduce this is to build, install and boot the ke=
rnel.
> > Maybe we are using a different kernel config?
>=20
> I'd say odds are good we are not using an identical kernel config :-)
> What is your root device? Is it using mq and scheduling, or what's
> the config?

Hello Jens,

The boot device is a SATA disk:
# lsscsi
[0:0:0:0]=A0=A0=A0=A0disk=A0=A0=A0=A0ATA=A0=A0=A0=A0=A0=A0ST1000NM0033-9ZM =
GA67=A0=A0/dev/sda=A0

SCSI-mq is enabled and the default I/O scheduler is the deadline scheduler.
>From the kernel .config:
CONFIG_DEFAULT_IOSCHED=3D"deadline"
CONFIG_SCSI_MQ_DEFAULT=3Dy

The bisect I started earlier this morning is nearing completion - three ste=
ps
are left. These are the steps I performed so far:

$ git bisect log
git bisect start
# good: [c02ed2e75ef4c74e41e421acb4ef1494671585e8] Linux 4.11-rc4
git bisect good c02ed2e75ef4c74e41e421acb4ef1494671585e8
# bad: [95c55ff425faa190fd8ba55090fbdf33d8b2f0ae] mtip32xx: fix dereference=
 of stack garbage
git bisect bad 95c55ff425faa190fd8ba55090fbdf33d8b2f0ae
# good: [65f619d2535197d97067eeeef75a40f25b552e69] Merge branch 'for-linus'=
 into for-4.12/block
git bisect good 65f619d2535197d97067eeeef75a40f25b552e69
# good: [c074170e65995706be78e8c57ed2017c638d5464] block, bfq: add more fai=
rness with writes and slow processes
git bisect good c074170e65995706be78e8c57ed2017c638d5464
# good: [c7f014771b18e002fed373838fe14cf2065f3499] exofs: Convert to separa=
tely allocated bdi
git bisect good c7f014771b18e002fed373838fe14cf2065f3499
# good: [e0af413a45cbbf179a87fef0576882a8e6006244] dm rq: don't pass irrele=
vant error code to blk_mq_complete_request
git bisect good e0af413a45cbbf179a87fef0576882a8e6006244

Bart.=
