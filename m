Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Follow up block changes for this merge window
Message-ID: <5ba8d7db-03fe-4983-5636-78f0ff6881bb@kernel.dk>
Date: Wed, 22 Aug 2018 11:54:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

As mentioned in my initial pull, there would be a followup with
some later incoming fixes and changes. This pull request contains:

- Set of bcache fixes and changes (Coly)

- The flush warn fix (me)

- Small series of BFQ fixes (Paolo)

- wbt hang fix (Ming)

- blktrace fix (Steven)

- blk-mq hardware queue count update fix (Jianchao)

- Various little fixes

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-4.19/post-20180822


----------------------------------------------------------------
Chaitanya Kulkarni (1):
      block: remove duplicate initialization

Chengguang Xu (1):
      block: change return type to bool

Colin Ian King (1):
      block/DAC960.c: make some arrays static const, shrinks object size

Coly Li (17):
      bcache: style fix to replace 'unsigned' by 'unsigned int'
      bcache: style fix to add a blank line after declarations
      bcache: add identifier names to arguments of function definitions
      bcache: style fixes for lines over 80 characters
      bcache: replace Symbolic permissions by octal permission numbers
      bcache: replace printk() by pr_*() routines
      bcache: fix indent by replacing blank by tabs
      bcache: replace '%pF' by '%pS' in seq_printf()
      bcache: fix typo 'succesfully' to 'successfully'
      bcache: prefer 'help' in Kconfig
      bcache: do not check NULL pointer before calling kmem_cache_destroy
      bcache: fix code comments style
      bcache: add static const prefix to char * array declarations
      bcache: move open brace at end of function definitions to next line
      bcache: add missing SPDX header
      bcache: remove unnecessary space before ioctl function pointer arguments
      bcache: add the missing comments for smp_mb()/smp_wmb()

Jens Axboe (2):
      block: don't warn for flush on read-only device
      pktcdvd: fix setting of 'ret' error return for a few cases

Jianchao Wang (2):
      blk-mq: init hctx sched after update ctx and hctx mapping
      blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter

Maciej S. Szmigiero (1):
      block, bfq: return nbytes and not zero from struct cftype .write() method

Ming Lei (1):
      blk-wbt: fix IO hang in wbt_wait()

Paolo Valente (4):
      block, bfq: readd missing reset of parent-entity service
      block, bfq: always update the budget of an entity when needed
      block, bfq: reduce write overcharge
      block, bfq: improve code of bfq_bfqq_charge_time

Steven Rostedt (VMware) (1):
      tracing/blktrace: Fix to allow setting same value

 block/bfq-cgroup.c            |   3 +-
 block/bfq-iosched.c           |  54 ++++++++---
 block/bfq-wf2q.c              |  22 ++---
 block/blk-core.c              |   5 +-
 block/blk-mq-sched.c          |  44 ---------
 block/blk-mq-sched.h          |   5 -
 block/blk-mq-tag.c            |  14 ++-
 block/blk-mq.c                |  96 +++++++++++++++++--
 block/blk-wbt.c               |   6 +-
 block/blk.h                   |   4 +-
 block/elevator.c              |  20 ++--
 drivers/block/DAC960.c        |  42 +++++----
 drivers/block/pktcdvd.c       |   1 +
 drivers/md/bcache/Kconfig     |   6 +-
 drivers/md/bcache/alloc.c     |  39 ++++----
 drivers/md/bcache/bcache.h    | 210 ++++++++++++++++++++++--------------------
 drivers/md/bcache/bset.c      | 142 +++++++++++++++-------------
 drivers/md/bcache/bset.h      | 146 ++++++++++++++++-------------
 drivers/md/bcache/btree.c     |  72 +++++++++------
 drivers/md/bcache/btree.h     |  86 ++++++++---------
 drivers/md/bcache/closure.c   |   6 +-
 drivers/md/bcache/closure.h   |   6 +-
 drivers/md/bcache/debug.c     |  23 ++---
 drivers/md/bcache/debug.h     |   6 +-
 drivers/md/bcache/extents.c   |  37 ++++----
 drivers/md/bcache/extents.h   |   6 +-
 drivers/md/bcache/io.c        |  24 ++---
 drivers/md/bcache/journal.c   |  27 +++---
 drivers/md/bcache/journal.h   |  28 +++---
 drivers/md/bcache/movinggc.c  |  14 +--
 drivers/md/bcache/request.c   |  61 ++++++------
 drivers/md/bcache/request.h   |  18 ++--
 drivers/md/bcache/stats.c     |  15 +--
 drivers/md/bcache/stats.h     |  15 +--
 drivers/md/bcache/super.c     | 107 ++++++++++++---------
 drivers/md/bcache/sysfs.c     |  36 +++++---
 drivers/md/bcache/sysfs.h     |   6 +-
 drivers/md/bcache/util.c      |   2 +
 drivers/md/bcache/util.h      |  24 ++---
 drivers/md/bcache/writeback.c |  30 +++---
 drivers/md/bcache/writeback.h |  19 ++--
 include/uapi/linux/bcache.h   |   8 +-
 kernel/trace/blktrace.c       |   4 +
 43 files changed, 881 insertions(+), 658 deletions(-)

-- 
Jens Axboe
