Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.13-rc
Message-ID: <bb0bbe97-b705-133f-e3dd-5ac512efb6c1@kernel.dk>
Date: Fri, 25 Aug 2017 09:51:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Small batch of fixes that should be included for the 4.13 release. This
pull request contains:

- Revert of the 4k loop blocksize support. Even with a recent batch of 4
  fixes, we're still not really happy with it. Rather than be stuck with
  an API issue, let's revert it and get it right for 4.14.

- Trivial patch from Bart, adding a few flags to the blk-mq debugfs
  exports that were added in this release, but not to the debugfs parts.

- Regression fix for bsg, fixing a potential kernel panic. From
  Benjamin.

- Tweak for the blk throttling, improving how we account discards. From
  Shaohua.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
      blk-mq-debugfs: Add names for recently added flags

Benjamin Block (1):
      bsg-lib: fix kernel panic resulting from missing allocation of reply-buffer

Omar Sandoval (1):
      Revert "loop: support 4k physical blocksize"

Shaohua Li (1):
      blk-throttle: cap discard request size

 block/blk-mq-debugfs.c    |  3 ++
 block/blk-throttle.c      | 18 +++++++++---
 block/bsg-lib.c           | 74 ++++++++++++++++++++++++++++-------------------
 drivers/block/loop.c      | 42 ++++-----------------------
 drivers/block/loop.h      |  1 -
 include/linux/blkdev.h    |  1 -
 include/linux/bsg-lib.h   |  2 ++
 include/uapi/linux/loop.h |  3 --
 8 files changed, 69 insertions(+), 75 deletions(-)

-- 
Jens Axboe
