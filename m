Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>
Subject: Re: I/O hangs after resuming from suspend-to-ram
Date: Sun, 24 Sep 2017 19:33:00 +0200
Message-ID: <9658713.A4bv0G9Yjl@merkaba>
In-Reply-To: <20170920221703.GA5105@ming.t460p>
References: <3926917.BCSovyVWdL@natalenko.name> <2260365.vTb2K2ZmgF@merkaba> <20170920221703.GA5105@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Ming Lei - 21.09.17, 06:17:
> On Wed, Sep 20, 2017 at 07:25:02PM +0200, Martin Steigerwald wrote:
> > Ming Lei - 28.08.17, 21:32:
> > > On Mon, Aug 28, 2017 at 03:10:35PM +0200, Martin Steigerwald wrote:
> > > > Ming Lei - 28.08.17, 20:58:
> > > > > On Sun, Aug 27, 2017 at 09:43:52AM +0200, Oleksandr Natalenko wro=
te:
> > > > > > Hi.
> >=20
> > > > > > Here is disk setup for QEMU VM:
> > [=E2=80=A6]
> >=20
> > > > > > In words: 2 virtual disks, RAID10 setup with far-2 layout, LUKS=
 on
> > > > > > it,
> > > > > > then
> > > > > > LVM, then ext4 for boot, swap and btrfs for /.
> > > > > >=20
> > > > > > I couldn't reproduce the issue with single disk without RAID.
> > > > >=20
> > > > > Could you verify if the following patch fixes your issue?
> > > >=20
> > > > Could this also apply to non MD RAID systems? I am using BTRFS RAID
> > > > 1 with two SSDs. So far with CFQ it runs stable.
> > >=20
> > > It is for fixing Oleksandr's issue wrt. blk-mq, and looks not for you.
> >=20
> > My findings are different:
> >=20
> > On 4.12.10 with CONFIG_HZ=3D1000, CONFIG_PREEMPT=3Dy and optimizations =
for
> > Intel Core/newer Xeon I see this:
> >=20
> > 1) Running with CFQ: No hang after resume
> >=20
> > 2) Running with scsi_mod.use_blk_mq=3D1 + BFQ: Hang after resume within
> > first 1-2 days.
>=20
> Hi Martin,
>=20
> Thanks for your report!
>=20
> Could you test the following patchset to see if it fixes your issue?
>=20
> 	https://marc.info/?l=3Dlinux-block&m=3D150579298505484&w=3D2

Testing with https://github.com/ming1/linux.git, my_v4.13-safe-scsi-
quiesce_V5_for_test branch as of 53954fd58fb9fe6894b1635dad1acec96ca51a2f I=
=20
now have a bit more than three days and 8 hours of uptime without a hang on=
=20
resume from memory or disk, despite using blk-mq + BFQ.

So it looks like this patch set fixes the issue for me. To say for sure I=
=C2=B4d say=20
some more days of testing are needed. But it looks like the hang on resume =
is=20
fixed by this patch set.

Thanks,
=2D-=20
Martin
