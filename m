Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Small set of block fixes for 4.19-rc1
Message-ID: <1e119372-0c51-d9f8-20ab-71530b2397c0@kernel.dk>
Date: Sat, 25 Aug 2018 08:53:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A few small fixes for this merge window. This pull request contains:

- Locking imbalance fix for bcache (Shan Hai)

- A few small fixes for wbt. One is a cleanup/prep, one is a fix for an
  existing issue, and the last two are fixes for changes that went into
  this merge window (me)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180825


----------------------------------------------------------------
for-linus-20180825

----------------------------------------------------------------
Jens Axboe (4):
      blk-wbt: move disable check into get_limit()
      blk-wbt: use wq_has_sleeper() for wq active check
      blk-wbt: fix has-sleeper queueing check
      blk-wbt: don't maintain inflight counts if disabled

Shan Hai (1):
      bcache: release dc->writeback_lock properly in bch_writeback_thread()

 block/blk-sysfs.c             | 19 ++++++++++++++++++-
 block/blk-wbt.c               | 37 +++++++++++++++++--------------------
 drivers/md/bcache/writeback.c |  4 +++-
 3 files changed, 38 insertions(+), 22 deletions(-)

-- 
Jens Axboe
