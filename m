Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [GIT PULL] Block fixes for 4.17-rc2
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
Date: Wed, 25 Apr 2018 19:03:44 +0200
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <E045C6CF-0E1E-44DB-B82B-43932F76A327@linaro.org>
References: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 25 apr 2018, alle ore 18:50, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> Hi Linus,
>=20
> I ended up sitting on this about a week longer than I wanted to,
> since we were hashing out details with a timeout change. I've now
> killed that patch, so we can flush the existing queue in due time.
>=20
> This pull request contains:
>=20
> - Fix for an old regression, where entering the queue can be disturbed
>  by a signal to the process. This can cause spurious EIO. Fix from =
Alan
>  Jenkins.
>=20
> - cdrom information leak fix from Dan.
>=20
> - Trivial helper for testing queue FUA from Dave Chinner, part of his
>  O_DIRECT FUA series.
>=20
> - Series of swim fixes from Finn that actually makes it work again.
>=20
> - Loop O_DIRECT corruption fix, which caused data corruption in
>  production for us. =46rom me.
>=20
> - BFQ crash fix from me.
>=20

For what it's worth, I disagree with this patch.  This change is based
on an apparently buggy motivation, as I wrote in my reply in the
thread where Jens proposed it.  As such, I think it might even bury
more deeply the actual bug that causes the crash (although of course
this patch does eliminate the crash for the use case reported in that
thread).

Thanks,
Paolo

> - bcache maintainer update. Michael no longer has the time to do it,
>  Coly has stepped up to serve as the new maintainer.
>=20
> - blkcg locking fixes from Jiang Biao.
>=20
> - Revert of a change from this merge window from Ming, that causes an
>  issue on some hardware.
>=20
> - Minor clarification doc addition from Linus Walleij.
>=20
> Please pull!
>=20
>=20
>  git://git.kernel.dk/linux-block.git tags/for-linus-20180425
>=20
>=20
> ----------------------------------------------------------------
> Alan Jenkins (1):
>      block: do not use interruptible wait anywhere
>=20
> Dan Carpenter (1):
>      cdrom: information leak in cdrom_ioctl_media_changed()
>=20
> Dave Chinner (1):
>      block: add blk_queue_fua() helper function
>=20
> Finn Thain (8):
>      m68k/mac: Don't remap SWIM MMIO region
>      block/swim: Fix array bounds check
>      block/swim: Remove extra put_disk() call from error path
>      block/swim: Don't log an error message for an invalid ioctl
>      block/swim: Rename macros to avoid inconsistent inverted logic
>      block/swim: Check drive type
>      block/swim: Fix IO error at end of medium
>      block/swim: Select appropriate drive on device open
>=20
> Jens Axboe (4):
>      loop: remove cmd->rq member
>      loop: handle short DIO reads
>      bfq-iosched: ensure to clear bic/bfqq pointers when preparing =
request
>      bcache: mark Coly Li as bcache maintainer
>=20
> Jianchao Wang (1):
>      blk-mq: start request gstate with gen 1
>=20
> Jiang Biao (3):
>      blkcg: don't hold blkcg lock when deactivating policy
>      blkcg: small fix on comment in blkcg_init_queue
>      blkcg: init root blkcg_gq under lock
>=20
> Linus Walleij (1):
>      block: mq: Add some minor doc for core structs
>=20
> Michael Lyle (1):
>      MAINTAINERS: Remove me as maintainer of bcache
>=20
> Ming Lei (1):
>      Revert "blk-mq: remove code for dealing with remapping queue"
>=20
> MAINTAINERS            |  2 +-
> block/bfq-iosched.c    | 10 +++++++-
> block/blk-cgroup.c     | 28 ++++++++++------------
> block/blk-core.c       | 15 ++++++------
> block/blk-mq.c         | 41 +++++++++++++++++++++++++++++---
> block/blk-mq.h         |  3 +++
> drivers/block/loop.c   | 64 =
+++++++++++++++++++++++++++++++++-----------------
> drivers/block/loop.h   |  1 -
> drivers/block/swim.c   | 49 +++++++++++++++++---------------------
> drivers/block/swim3.c  |  6 ++---
> drivers/cdrom/cdrom.c  |  2 +-
> include/linux/blk-mq.h |  3 +++
> include/linux/blkdev.h |  1 +
> 13 files changed, 144 insertions(+), 81 deletions(-)
>=20
> --=20
> Jens Axboe
>=20
