Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 4.12-rc
Message-ID: <a9be8db3-e7ac-9dc1-502d-56929388ebfc@kernel.dk>
Date: Thu, 15 Jun 2017 11:16:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Just a single fix this week, fixing a regression introduced in this
series. When we put the final reference to the queue, we may need to
block. Ensure that we can safely do so. From Bart.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
      block: Fix a blk_exit_rl() regression

 block/blk-sysfs.c      | 34 ++++++++++++++++++++++------------
 include/linux/blkdev.h |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

-- 
Jens Axboe
