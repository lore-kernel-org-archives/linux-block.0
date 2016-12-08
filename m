Return-Path: <prvs=11505706e0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
Subject: [PATCHSET/RFC v2] blk-mq scheduling framework
Date: Thu, 8 Dec 2016 13:13:18 -0700
Message-ID: <1481228005-9245-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

As a followup to this posting from yesterday:

https://marc.info/?l=linux-block&m=148115232806065&w=2

this is version 2. I wanted to post a new one fairly quickly, as there
ended up being a number of potential crashes in v1. This one should be
solid, I've run mq-deadline on both NVMe and regular rotating storage,
and we handle the various merging cases correctly.

You can download it from git as well:

git://git.kernel.dk/linux-block blk-mq-sched.2

Note that this is based on for-4.10/block, which is in turn based on
v4.9-rc1. I suggest pulling it into my for-next branch, which would
then merge nicely with 'master' as well.

Changes since v1:

- Add Kconfig entries to allow the user to choose what the default
  scheduler should be for blk-mq, and whether that depends on the
  number of hardware queues.

- Properly abstract the whole get/put of a request, so we can manage
  the life time properly.

- Enable full merging on mq-deadline (front/back, bio-to-rq, rq-to-rq).
  Has full feature parity with deadline now.

- Export necessary symbols for compiling mq-deadline as a module.

- Various API adjustments for the mq schedulers.

- Various cleanups and improvements.

- Fix a lot of bugs. A lot. Upgrade!

 block/Kconfig.iosched    |   37 ++
 block/Makefile           |    3 
 block/blk-core.c         |    9 
 block/blk-exec.c         |    3 
 block/blk-flush.c        |    7 
 block/blk-merge.c        |    3 
 block/blk-mq-sched.c     |  265 +++++++++++++++++++
 block/blk-mq-sched.h     |  188 +++++++++++++
 block/blk-mq-tag.c       |    1 
 block/blk-mq.c           |  254 ++++++++++--------
 block/blk-mq.h           |   35 +-
 block/elevator.c         |  194 ++++++++++----
 block/mq-deadline.c      |  647 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c  |    1 
 include/linux/blk-mq.h   |    4 
 include/linux/elevator.h |   34 ++
 16 files changed, 1495 insertions(+), 190 deletions(-)
