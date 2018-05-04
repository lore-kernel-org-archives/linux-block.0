Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block IO fixes for 4.17-rc4
Message-ID: <d50dcb55-caea-348a-4e87-3ee0df7dd727@kernel.dk>
Date: Fri, 4 May 2018 09:13:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A collection of fixes that should to into this release. This pull
request contains:

- Set of bcache fixes from Coly, fixing regression in patches that went
  into this series.

- Set of NVMe fixes by way of Keith.

- Set of bdi related fixes, one from Jan and two from Tetsuo Handa,
  fixing various issues around device addition/removal.

- Two block inflight fixes from Omar, fixing issues around the
  transition to using tags for blk-mq inflight accounting that we did a
  few releases ago.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180504


----------------------------------------------------------------
Chengguang Xu (1):
      nvme: fix potential memory leak in option parsing

Coly Li (6):
      bcache: store disk name in struct cache and struct cached_dev
      bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()
      bcache: count backing device I/O error for writeback I/O
      bcache: add wait_for_kthread_stop() in bch_allocator_thread()
      bcache: set dc->io_disable to true in conditional_stop_bcache_device()
      bcache: use pr_info() to inform duplicated CACHE_SET_IO_DISABLE set

Jan Kara (1):
      bdi: Fix oops in wb_workfn()

Johannes Thumshirn (1):
      nvmet: switch loopback target state to connecting when resetting

Keith Busch (3):
      nvme: Set integrity flag for user passthrough commands
      nvme/multipath: Disable runtime writable enabling parameter
      nvme/multipath: Fix multipath disabled naming collisions

Omar Sandoval (2):
      blk-mq: count allocated but not started requests in iostats inflight
      blk-mq: fix sysfs inflight counter

Tetsuo Handa (2):
      bdi: wake up concurrent wb_shutdown() callers.
      bdi: Fix use after free bug in debugfs_remove()

 block/blk-mq.c                | 40 ++++++++++++++++-------
 block/blk-mq.h                |  4 ++-
 block/genhd.c                 | 12 +++++++
 block/partition-generic.c     | 10 +++---
 drivers/md/bcache/alloc.c     |  5 ++-
 drivers/md/bcache/bcache.h    |  4 +++
 drivers/md/bcache/debug.c     |  3 +-
 drivers/md/bcache/io.c        |  8 ++---
 drivers/md/bcache/request.c   |  5 +--
 drivers/md/bcache/super.c     | 75 ++++++++++++++++++++++++++++++-------------
 drivers/md/bcache/writeback.c |  4 ++-
 drivers/nvme/host/core.c      | 27 ++--------------
 drivers/nvme/host/fabrics.c   |  6 ++++
 drivers/nvme/host/multipath.c | 24 +++++++++++++-
 drivers/nvme/host/nvme.h      | 12 +++++++
 drivers/nvme/target/loop.c    |  6 ++++
 fs/fs-writeback.c             |  2 +-
 include/linux/genhd.h         |  4 ++-
 include/linux/wait_bit.h      | 17 ++++++++++
 mm/backing-dev.c              |  3 +-
 20 files changed, 189 insertions(+), 82 deletions(-)

-- 
Jens Axboe
