Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.11-rc
Message-ID: <14098b6d-8eb1-0990-49dc-1cb911179456@kernel.dk>
Date: Wed, 15 Mar 2017 15:06:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Four small fixes for this cycle. This pull request contains:

- Followup fix from Neil for a fix that went in before -rc2, ensuring
  that we always see the full per-task bio_list.

- Fix for blk-mq-sched from me that ensures that we retain similar
  direct-to-issue behavior on running the queue.

- Fix from Sagi fixing a potential NULL pointer dereference in blk-mq on
  spurious CPU unplug.

- A memory leak fix in writeback from Tahsin, fixing a case where device
  removal of a mounted device can leak a struct wb_writeback_work.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jens Axboe (1):
      blk-mq-sched: don't run the queue async from blk_mq_try_issue_directly()

NeilBrown (1):
      blk: Ensure users for current->bio_list can see the full list.

Sagi Grimberg (1):
      blk-mq: Fix tagset reinit in the presence of cpu hot-unplug

Tahsin Erdogan (1):
      writeback: fix memory leak in wb_queue_work()

 block/bio.c         | 12 +++++++++---
 block/blk-core.c    | 30 ++++++++++++++++++------------
 block/blk-mq-tag.c  |  3 +++
 block/blk-mq.c      |  9 +++++----
 drivers/md/dm.c     | 29 ++++++++++++++++-------------
 drivers/md/raid10.c |  3 ++-
 fs/fs-writeback.c   | 35 +++++++++++++++++++++--------------
 7 files changed, 74 insertions(+), 47 deletions(-)

-- 
Jens Axboe
