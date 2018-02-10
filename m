Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.16-rc1
Message-ID: <02e0617e-39cd-1ded-6da0-6ba1826010a0@kernel.dk>
Date: Sat, 10 Feb 2018 10:31:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A few fixes to round off the merge window on the block side. This pull
request contains:

- Set of bcache fixes by way of Michael Lyle, from the usual bcache
  suspects.

- Addition of a simple-to-hook-into function for bpf EIO error
  injection.

- Fix for blk-wbt that mischarectized flushes as reads. Improve the
  logic so that flushes and writes are accounted as writes, and only
  reads as reads. From me.

- Fix for requeue crash in BFQ, from Paolo.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180210


----------------------------------------------------------------
Coly Li (3):
      bcache: properly set task state in bch_writeback_thread()
      bcache: set error_limit correctly
      bcache: set writeback_rate_update_seconds in range [1, 60] seconds

Howard McLauchlan (1):
      block: Add should_fail_bio() for bpf error injection

Jens Axboe (1):
      blk-wbt: account flush requests correctly

Paolo Valente (1):
      block, bfq: add requeue-request hook

Tang Junhui (5):
      bcache: add journal statistic
      bcache: fix high CPU occupancy during journal
      bcache: fix for allocator and register thread race
      bcache: return attach error when no cache set exist
      bcache: fix for data collapse after re-attaching an attached device

 block/bfq-iosched.c           | 107 ++++++++++++++++++++++++++++++++----------
 block/blk-core.c              |  11 ++++-
 block/blk-wbt.c               |  10 +++-
 drivers/md/bcache/alloc.c     |   4 +-
 drivers/md/bcache/bcache.h    |   9 +++-
 drivers/md/bcache/btree.c     |   9 ++--
 drivers/md/bcache/journal.c   |  52 ++++++++++++++------
 drivers/md/bcache/super.c     |  25 +++++++---
 drivers/md/bcache/sysfs.c     |  34 +++++++++++---
 drivers/md/bcache/util.h      |   2 +
 drivers/md/bcache/writeback.c |   9 ++--
 drivers/md/bcache/writeback.h |   3 ++
 12 files changed, 212 insertions(+), 63 deletions(-)

-- 
Jens Axboe
