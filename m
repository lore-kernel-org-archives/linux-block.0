Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET/RFC v2] blk-mq scheduling framework
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1481228005-9245-1-git-send-email-axboe@fb.com>
Date: Tue, 13 Dec 2016 10:26:28 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 osandov@fb.com
Message-Id: <9D1F7CB5-4043-448B-A553-D6A9804D5089@linaro.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 08 dic 2016, alle ore 21:13, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> As a followup to this posting from yesterday:
>=20
> https://marc.info/?l=3Dlinux-block&m=3D148115232806065&w=3D2
>=20
> this is version 2. I wanted to post a new one fairly quickly, as there
> ended up being a number of potential crashes in v1. This one should be
> solid, I've run mq-deadline on both NVMe and regular rotating storage,
> and we handle the various merging cases correctly.
>=20
> You can download it from git as well:
>=20
> git://git.kernel.dk/linux-block blk-mq-sched.2
>=20
> Note that this is based on for-4.10/block, which is in turn based on
> v4.9-rc1. I suggest pulling it into my for-next branch, which would
> then merge nicely with 'master' as well.
>=20

Hi Jens,
this is just to tell you that I have finished running some extensive
tests on this patch series (throughput, responsiveness, low latency
for soft real time).  No regression w.r.t. blk detected, and no
crashes or other anomalies.

Starting to work on BFQ port.  Please be patient with my little
expertise on mq environment, and with my next silly questions!

Thanks,
Paolo


> Changes since v1:
>=20
> - Add Kconfig entries to allow the user to choose what the default
>  scheduler should be for blk-mq, and whether that depends on the
>  number of hardware queues.
>=20
> - Properly abstract the whole get/put of a request, so we can manage
>  the life time properly.
>=20
> - Enable full merging on mq-deadline (front/back, bio-to-rq, =
rq-to-rq).
>  Has full feature parity with deadline now.
>=20
> - Export necessary symbols for compiling mq-deadline as a module.
>=20
> - Various API adjustments for the mq schedulers.
>=20
> - Various cleanups and improvements.
>=20
> - Fix a lot of bugs. A lot. Upgrade!
>=20
> block/Kconfig.iosched    |   37 ++
> block/Makefile           |    3=20
> block/blk-core.c         |    9=20
> block/blk-exec.c         |    3=20
> block/blk-flush.c        |    7=20
> block/blk-merge.c        |    3=20
> block/blk-mq-sched.c     |  265 +++++++++++++++++++
> block/blk-mq-sched.h     |  188 +++++++++++++
> block/blk-mq-tag.c       |    1=20
> block/blk-mq.c           |  254 ++++++++++--------
> block/blk-mq.h           |   35 +-
> block/elevator.c         |  194 ++++++++++----
> block/mq-deadline.c      |  647 =
+++++++++++++++++++++++++++++++++++++++++++++++
> drivers/nvme/host/pci.c  |    1=20
> include/linux/blk-mq.h   |    4=20
> include/linux/elevator.h |   34 ++
> 16 files changed, 1495 insertions(+), 190 deletions(-)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
