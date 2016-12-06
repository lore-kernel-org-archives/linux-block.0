Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET/RFC v2] Make legacy IO schedulers work with blk-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1480962426-15767-1-git-send-email-axboe@fb.com>
Date: Tue, 6 Dec 2016 11:01:31 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>
Message-Id: <EC2ECF84-10DC-4A9C-8951-D87607C492F0@linaro.org>
References: <1480962426-15767-1-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 05 dic 2016, alle ore 19:26, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> Version 2 of the hack/patchset, that enables blk-mq to use the legacy
> IO schedulers with single queue devices. Original posting is here:
>=20
> https://marc.info/?l=3Dlinux-block&m=3D148073493203664&w=3D2
>=20
> You can also found this version in the following git branch:
>=20
> git://git.kernel.dk/linux-block blk-mq-legacy-sched.2
>=20
> and new developments/fixes will happen in the 'blk-mq-legacy-sched'
> branch.
>=20

Hi Jens,
while running some tests, the system hung after a while.

If I'm not mistaken, the above branches contain a (modified) 4.9-rc1.
Maybe instability follows from that?  I have tried a rebase, but
resulting conflicts are non-trivial (for me) to solve.

Meanwhile, if you deem it useful, I can provide you with the oops
message, as I catch it.

As a secondary issue, iostat always reports 0 MB/s for both reads and
writes, while tps are non null.

Thanks,
Paolo

> Changes since v1:
>=20
> - Remove the default 'deadline' hard wiring, and provide Kconfig
>  entries to set the blk-mq scheduler. This now works like for legacy
>  devices.
>=20
> - Rename blk_use_mq_path() to blk_use_sched_path() to make it more
>  clear. Suggested by Johannes Thumshirn.
>=20
> - Fixup a spot where we did not use the accessor function to determine
>  what path to use.
>=20
> - Flush mq software queues, even if IO scheduler managed. This should
>  make paths work that are MQ aware, and using only MQ interfaces.
>=20
> - Cleanup free path of MQ request.
>=20
> - Account when IO was queued to a hardware context, similarly to the
>  regular MQ path.
>=20
> - Add BLK_MQ_F_NO_SCHED flag, so that drivers can explicitly ask for
>  no scheduling on a queue. Add this for NVMe admin queues.
>=20
> - Kill BLK_MQ_F_SCHED, since we now have Kconfig entries for setting
>  the desired IO scheduler.
>=20
> - Fix issues with live scheduler switching through sysfs. Should now
>  be solid, even with lots of IO running on the device.
>=20
> - Drop null_blk and SCSI changes, not needed anymore.
>=20
>=20
> block/Kconfig.iosched   |   29 ++++
> block/blk-core.c        |   77 ++++++-----
> block/blk-exec.c        |   12 +
> block/blk-flush.c       |   40 +++--
> block/blk-merge.c       |    5=20
> block/blk-mq.c          |  332 =
+++++++++++++++++++++++++++++++++++++++++++++---
> block/blk-mq.h          |    1=20
> block/blk-sysfs.c       |    2=20
> block/blk.h             |   16 ++
> block/cfq-iosched.c     |   22 ++-
> block/elevator.c        |  125 ++++++++++++------
> drivers/nvme/host/pci.c |    1=20
> include/linux/blk-mq.h  |    1=20
> include/linux/blkdev.h  |    2=20
> 14 files changed, 555 insertions(+), 110 deletions(-)
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
