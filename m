Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.11-rc
Message-ID: <79350b18-c4c9-b445-66f4-7c614f57c180@kernel.dk>
Date: Wed, 29 Mar 2017 15:27:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

5 fixes for this series. This pull request contains:

- A fix from me to ensure that blk-mq drivers that terminate IO in their
  ->queue_rq() handler by returning QUEUE_ERROR don't stall with a
  scheduler enabled.

- 4 nbd fixes from Josef and Ratna, fixing various problems that are
  critical enough to go in for this cycle. They have been well tested.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jens Axboe (1):
      blk-mq: include errors in did_work calculation

Josef Bacik (3):
      nbd: handle ERESTARTSYS properly
      nbd: set rq->errors to actual error code
      nbd: set queue timeout properly

Ratna Manoj Bolla (1):
      nbd: replace kill_bdev() with __invalidate_device()

 block/blk-mq.c      |   7 +--
 drivers/block/nbd.c | 136 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 107 insertions(+), 36 deletions(-)

-- 
Jens Axboe
