Return-Path: <prvs=1147fe7fca=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>
Subject: [PATCHSET/RFC v2] Make legacy IO schedulers work with blk-mq
Date: Mon, 5 Dec 2016 11:26:59 -0700
Message-ID: <1480962426-15767-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Version 2 of the hack/patchset, that enables blk-mq to use the legacy
IO schedulers with single queue devices. Original posting is here:

https://marc.info/?l=linux-block&m=148073493203664&w=2

You can also found this version in the following git branch:

git://git.kernel.dk/linux-block blk-mq-legacy-sched.2

and new developments/fixes will happen in the 'blk-mq-legacy-sched'
branch.

Changes since v1:

- Remove the default 'deadline' hard wiring, and provide Kconfig
  entries to set the blk-mq scheduler. This now works like for legacy
  devices.

- Rename blk_use_mq_path() to blk_use_sched_path() to make it more
  clear. Suggested by Johannes Thumshirn.

- Fixup a spot where we did not use the accessor function to determine
  what path to use.

- Flush mq software queues, even if IO scheduler managed. This should
  make paths work that are MQ aware, and using only MQ interfaces.

- Cleanup free path of MQ request.

- Account when IO was queued to a hardware context, similarly to the
  regular MQ path.

- Add BLK_MQ_F_NO_SCHED flag, so that drivers can explicitly ask for
  no scheduling on a queue. Add this for NVMe admin queues.

- Kill BLK_MQ_F_SCHED, since we now have Kconfig entries for setting
  the desired IO scheduler.

- Fix issues with live scheduler switching through sysfs. Should now
  be solid, even with lots of IO running on the device.

- Drop null_blk and SCSI changes, not needed anymore.


 block/Kconfig.iosched   |   29 ++++
 block/blk-core.c        |   77 ++++++-----
 block/blk-exec.c        |   12 +
 block/blk-flush.c       |   40 +++--
 block/blk-merge.c       |    5 
 block/blk-mq.c          |  332 +++++++++++++++++++++++++++++++++++++++++++++---
 block/blk-mq.h          |    1 
 block/blk-sysfs.c       |    2 
 block/blk.h             |   16 ++
 block/cfq-iosched.c     |   22 ++-
 block/elevator.c        |  125 ++++++++++++------
 drivers/nvme/host/pci.c |    1 
 include/linux/blk-mq.h  |    1 
 include/linux/blkdev.h  |    2 
 14 files changed, 555 insertions(+), 110 deletions(-)
