Return-Path: <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.19-rc6
Message-ID: <7a9020a9-171b-3ef0-cb49-0c157ca9902b@kernel.dk>
Date: Sat, 29 Sep 2018 15:12:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Greg,

A set of fixes that should go into this release. This pull request
contains:

- A fix (hopefully) for the persistent grants for xen-blkfront. A
  previous fix from this series wasn't complete, hence reverted, and
  this one should hopefully be it. (Boris Ostrovsky)

- Fix for an elevator drain warning with SMR devices, which is triggered
  when you switch schedulers (Damien)

- bcache deadlock fix (Guoju Fang)

- Fix for the block unplug tracepoint, which has had the timer/explicit
  flag reverted since 4.11 (Ilya)

- Fix a regression in this series where the blk-mq timeout hook is
  invoked with the RCU read lock held, hence preventing it from blocking
  (Keith)

- NVMe pull from Christoph, with a single multipath fix (Susobhan Dey)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180929


----------------------------------------------------------------
Boris Ostrovsky (1):
      xen/blkfront: When purging persistent grants, keep them in the buffer

Damien Le Moal (1):
      block: fix deadline elevator drain for zoned block devices

Guoju Fang (1):
      bcache: add separate workqueue for journal_write to avoid deadlock

Ilya Dryomov (1):
      blk-mq: I/O and timer unplugs are inverted in blktrace

Jens Axboe (2):
      Revert "xen/blkfront: When purging persistent grants, keep them in the buffer"
      Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-linus

Juergen Gross (1):
      xen/blkfront: correct purging of persistent grants

Keith Busch (1):
      blk-mq: Allow blocking queue tag iter callbacks

Susobhan Dey (1):
      nvme: properly propagate errors in nvme_mpath_init

 block/blk-mq-tag.c            | 13 ++++---------
 block/blk-mq.c                |  4 ++--
 block/elevator.c              |  2 +-
 drivers/block/xen-blkfront.c  |  4 ++--
 drivers/md/bcache/bcache.h    |  1 +
 drivers/md/bcache/journal.c   |  6 +++---
 drivers/md/bcache/super.c     |  8 ++++++++
 drivers/nvme/host/multipath.c |  6 ++++--
 8 files changed, 25 insertions(+), 19 deletions(-)

-- 
Jens Axboe
