Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.12-rc1
Message-ID: <634cb6d2-a66b-9971-71ea-f179b7a831ee@kernel.dk>
Date: Fri, 5 May 2017 22:25:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Some fixes and followup features/changes that should go in, in this
merge window. This pull request contains:

- Two fixes for lightnvm from Javier, fixing problems in the new code
  merge previously in this merge window.

- A fix from Jan for the backing device changes, fixing an issue in NFS
  that causes a failure to mount on certain setups.

- A change from Christoph, cleaning up the blk-mq init and exit request
  paths.

- Remove elevator_change(), which is now unused. From Bart.

- A fix for queue operation invocation on a dead queue, from Bart.

- A series fixing up mtip32xx for blk-mq scheduling, removing a bandaid
  we previously had in place for this. From me.

- A regression fix for this series, fixing a case where we wait on
  workqueue flushing from an invalid (non-blocking) context. From me.

- A fix/optimization from Ming, ensuring that we don't both quiesce and
  freeze a queue at the same time.

- A fix from Peter on lock ordering for CPU hotplug. Not a real problem
  right now, but will be once the CPU hotplug rework goes in.

- A series from Omar, cleaning up out blk-mq debugfs support, and adding
  support for exporting info from schedulers in debugfs as well. This is
  really useful in debugging stalls or livelocks. From Omar.

Please pull this for 4.12-rc, thanks!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (2):
      block: Remove elevator_change()
      blk-mq: Do not invoke queue operations on a dead queue

Christoph Hellwig (1):
      blk-mq: update ->init_request and ->exit_request prototypes

Jan Kara (1):
      nfs: Fix bdi handling for cloned superblocks

Javier González (2):
      lightnvm: create cmd before allocating request
      lightnvm: fix bad back free on error path

Jens Axboe (9):
      mtip32xx: get rid of 'atomic' argument to mtip_exec_internal_command()
      mtip32xx: kill atomic argument to mtip_quiesce_io()
      mtip32xx: abstract out "are any commands active" helper
      mtip32xx: convert internal command issue to block IO path
      blk-mq-sched: remove hack that bypasses scheduler for reserved requests
      Revert "mtip32xx: pass BLK_MQ_F_NO_SCHED"
      mtip32xx: cleanup internal tag assumptions
      mtip32xx: convert internal commands to regular block infrastructure
      blk-mq: don't use sync workqueue flushing from drivers

Ming Lei (1):
      block: don't call blk_mq_quiesce_queue() after queue is frozen

Omar Sandoval (11):
      blk-mq-debugfs: separate flags with |
      blk-mq-debugfs: clean up flag definitions
      blk-mq-debugfs: error on long write to queue "state" file
      blk-mq-debugfs: don't open code strstrip()
      blk-mq-debugfs: rename hw queue directories from <n> to hctx<n>
      blk-mq-debugfs: get rid of a bunch of boilerplate
      blk-mq: move debugfs declarations to a separate header file
      blk-mq: untangle debugfs and sysfs
      blk-mq-debugfs: allow schedulers to register debugfs attributes
      kyber: add debugfs attributes
      mq-deadline: add debugfs attributes

Peter Zijlstra (1):
      block/mq: Cure cpu hotplug lock inversion

 block/blk-core.c                  |   8 +-
 block/blk-mq-debugfs.c            | 870 +++++++++++++++++---------------------
 block/blk-mq-debugfs.h            |  82 ++++
 block/blk-mq-sched.c              |  30 +-
 block/blk-mq-sysfs.c              |  10 -
 block/blk-mq.c                    |  54 ++-
 block/blk-mq.h                    |  28 --
 block/blk-sysfs.c                 |   3 +
 block/elevator.c                  |  16 -
 block/kyber-iosched.c             | 130 ++++++
 block/mq-deadline.c               | 123 ++++++
 drivers/block/loop.c              |   5 +-
 drivers/block/mtip32xx/mtip32xx.c | 490 +++++++--------------
 drivers/block/mtip32xx/mtip32xx.h |  10 -
 drivers/block/nbd.c               |   7 +-
 drivers/block/rbd.c               |   5 +-
 drivers/block/virtio_blk.c        |   7 +-
 drivers/lightnvm/core.c           |   4 +-
 drivers/md/dm-rq.c                |   7 +-
 drivers/mtd/ubi/block.c           |   7 +-
 drivers/nvme/host/fc.c            |  20 +-
 drivers/nvme/host/lightnvm.c      |   4 +-
 drivers/nvme/host/pci.c           |  15 +-
 drivers/nvme/host/rdma.c          |  28 +-
 drivers/nvme/target/loop.c        |  17 +-
 drivers/scsi/scsi_lib.c           |  13 +-
 fs/nfs/internal.h                 |   6 +-
 fs/nfs/super.c                    |  28 +-
 include/linux/blk-mq.h            |   9 +-
 include/linux/blkdev.h            |   2 +-
 include/linux/elevator.h          |   8 +-
 31 files changed, 1035 insertions(+), 1011 deletions(-)
 create mode 100644 block/blk-mq-debugfs.h

-- 
Jens Axboe
