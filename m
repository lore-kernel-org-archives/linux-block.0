Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57227 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932239AbcJGSka (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Oct 2016 14:40:30 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Block changes for 4.9-rc1
Message-ID: <26e64a8c-b8a5-4b45-eb8d-8ca81f14dd93@fb.com>
Date: Fri, 7 Oct 2016 12:40:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Finally back from a bunch of travel and out-of-office. This is the main
pull request for block layer changes in 4.9. As mentioned at the last
merge window, I've changed things up and now do just one branch for core
block layer changes, and driver changes. This avoids dependencies
between the two branches. Outside of this main pull request, there are
two topical branches coming as well.

This pull request contains:

- A set of fixes, and a conversion to blk-mq, of nbd. From Josef.

- Set of fixes and updates for lightnvm from Matias, Simon, and Arnd.
   Followup dependency fix from Geert.

- General fixes from Bart, Baoyou, Guoqing, and Linus W.

- CFQ async write starvation fix from Glauber.

- Add supprot for delayed kick of the requeue list, from Mike.

- Pull out the scalable bitmap code from blk-mq-tag.c and make it
   generally available under the name of sbitmap. Only blk-mq-tag uses it
   for now, but the blk-mq scheduling bits will use it as well. From Omar.

- bdev thaw error progagation from Pierre.

- Improve the blk polling statistics, and allow the user to clear them.
   From Stephen.

- Set of minor cleanups from Christoph in block/blk-mq.

- Set of cleanups and optimizations from me for block/blk-mq.

- Various nvme/nvmet/nvmeof fixes from the various folks.

Please pull!


   git://git.kernel.dk/linux-block.git for-4.9/block


----------------------------------------------------------------
Alexander Solganik (1):
       nvmet: Make dsm number of ranges zero based

Andy Lutomirski (2):
       nvme/scsi: Remove power management support
       nvme: Pass pointers, not dma addresses, to nvme_get/set_features()

Arnd Bergmann (1):
       lightnvm: propagate device_add() error code

Baoyou Xie (1):
       mtip32xx: mark symbols static where possible

Bart Van Assche (4):
       block: Document that bio_op() uses the data type of bio.bi_opf
       block, dm-crypt, btrfs: Introduce bio_flags()
       block: Improve bio_set_op_attrs() robustness
       blkcg: Annotate blkg_hint correctly

Chaitanya Kulkarni (1):
       admin-cmd: Added smart-log command support.

Christoph Hellwig (5):
       block_dev: remove DAX leftovers
       block: remove bio_destructor_t
       bio.h: remove a very outdated comment
       block: remove IOPRIO_BITS
       blk-mq: remove non-blocking pass in blk_mq_map_request

Colin Ian King (1):
       sbitmap: initialize weight to zero

Geert Uytterhoeven (1):
       lightnvm: NVM should depend on HAS_DMA

Glauber Costa (1):
       cfq: fix starvation of asynchronous writes

Guoqing Jiang (1):
       block: export bio_free_pages to other modules

James Smart (3):
       nvme-fabrics: rework nvmf_get_address() for variable options
       nvme-fabrics: revise host transport option descriptions
       nvme-fabrics: Add host_traddr options field to host infrastructure

Jens Axboe (8):
       workqueue: add cancel_work()
       block: add kblockd_schedule_work_on()
       blk-mq: turn hctx->run_work into a regular work struct
       blk-mq: improve layout of blk_mq_hw_ctx
       blk-mq: prefetch request in blk_mq_tag_to_rq()
       blk-mq: account higher order dispatch
       blk-mq: get rid of manual run of queue with __blk_mq_run_hw_queue()
       blk-mq: add flag for drivers wanting blocking ->queue_rq()

Josef Bacik (5):
       nbd: convert to blkmq
       nbd: don't shutdown sock with irq's disabled
       nbd: use flags instead of bool
       nbd: allow block mq to deal with timeouts
       nbd: use BLK_MQ_F_BLOCKING

Linus Walleij (2):
       block: remove blk_mq_alloc_single_hw_queue() prototype
       block: remove remnant refs to hardsect

Matias Bjørling (4):
       nvme: refactor namespaces to support non-gendisk devices
       null_blk: refactor to support non-gendisk devices
       blk-mq: register device instead of disk
       lightnvm: control life of nvm_dev in driver

Mike Snitzer (1):
       blk-mq: introduce blk_mq_delay_kick_requeue_list()

Omar Sandoval (7):
       blk-mq: abstract tag allocation out into sbitmap library
       sbitmap: allocate wait queues on a specific node
       sbitmap: push per-cpu last_tag into sbitmap_queue
       sbitmap: push alloc policy into sbitmap_queue
       sbitmap: randomize initial alloc_hint values
       sbitmap: re-initialize allocation hints after resize
       sbitmap: don't update the allocation hint on clear after resize

Pierre Morel (1):
       fs/block_dev.c: return the right error in thaw_bdev()

Sagi Grimberg (1):
       nvmet: Use direct IO for writes

Simon A. F. Lund (1):
       lightnvm: expose device geometry through sysfs

Stephen Bates (2):
       block: add poll_considered statistic
       block: enable zeroing of io_poll statistics

  Documentation/block/biodoc.txt    |   4 +-
  MAINTAINERS                       |   1 +
  block/Kconfig                     |   1 +
  block/bio.c                       |   5 +-
  block/blk-core.c                  |  16 +-
  block/blk-mq-sysfs.c              |  40 +--
  block/blk-mq-tag.c                | 503 
+++++++++-----------------------------
  block/blk-mq-tag.h                |  42 +---
  block/blk-mq.c                    | 183 +++++---------
  block/blk-mq.h                    |  11 -
  block/blk-sysfs.c                 |   4 +-
  block/cfq-iosched.c               |  13 +-
  drivers/block/mtip32xx/mtip32xx.c |   2 +-
  drivers/block/nbd.c               | 411 ++++++++++++-------------------
  drivers/block/null_blk.c          | 128 ++++++----
  drivers/lightnvm/Kconfig          |   2 +-
  drivers/lightnvm/Makefile         |   2 +-
  drivers/lightnvm/core.c           |  55 ++---
  drivers/lightnvm/lightnvm.h       |  35 +++
  drivers/lightnvm/sysfs.c          | 198 +++++++++++++++
  drivers/md/bcache/btree.c         |   6 +-
  drivers/md/bcache/debug.c         |   6 +-
  drivers/md/bcache/movinggc.c      |   5 +-
  drivers/md/bcache/request.c       |   9 +-
  drivers/md/bcache/writeback.c     |   5 +-
  drivers/md/dm-crypt.c             |   2 +-
  drivers/md/dm-log-writes.c        |   6 +-
  drivers/md/dm-rq.c                |   2 +-
  drivers/md/raid1.c                |   8 +-
  drivers/nvme/host/core.c          | 155 +++++++-----
  drivers/nvme/host/fabrics.c       |  25 +-
  drivers/nvme/host/fabrics.h       |  11 +-
  drivers/nvme/host/lightnvm.c      |  33 ++-
  drivers/nvme/host/nvme.h          |  30 ++-
  drivers/nvme/host/scsi.c          |  80 +-----
  drivers/nvme/target/admin-cmd.c   |  88 +++++++
  drivers/nvme/target/io-cmd.c      |   3 +-
  fs/befs/linuxvfs.c                |   2 +-
  fs/block_dev.c                    |  18 +-
  fs/btrfs/inode.c                  |   5 +-
  include/linux/bio.h               |   3 +-
  include/linux/blk-cgroup.h        |   2 +-
  include/linux/blk-mq.h            |  28 +--
  include/linux/blk_types.h         |  21 +-
  include/linux/blkdev.h            |   4 +-
  include/linux/ioprio.h            |   1 -
  include/linux/lightnvm.h          |  18 +-
  include/linux/sbitmap.h           | 373 ++++++++++++++++++++++++++++
  include/linux/workqueue.h         |   1 +
  kernel/workqueue.c                |  40 +--
  lib/Kconfig                       |   3 +
  lib/Makefile                      |   2 +
  lib/sbitmap.c                     | 347 ++++++++++++++++++++++++++
  53 files changed, 1828 insertions(+), 1170 deletions(-)
  create mode 100644 drivers/lightnvm/lightnvm.h
  create mode 100644 drivers/lightnvm/sysfs.c
  create mode 100644 include/linux/sbitmap.h
  create mode 100644 lib/sbitmap.c

-- 
Jens Axboe

