Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH 0/6] Six more patches for Linux kernel v4.12
Date: Thu, 27 Apr 2017 08:54:31 -0700
Message-ID: <20170427155437.23228-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Since the merge window will open soon, do you still accept patches for
Linux kernel v4.12? If so, please consider the six patches in this series.
This series contains one bug fix, one comment fix and four patches that
extend the blk-mq-debugfs functionality further.

Thanks,

Bart.

Bart Van Assche (6):
  blk-mq: Make blk_mq_quiesce_queue() wait for all .queue_rq() calls
  blk-mq: Fix the comment above blk_mq_quiesce_queue()
  blk-mq-debugfs: Show atomic request flags
  blk-mq-debugfs: Show requeue list
  blk-mq-debugfs: Show busy requests
  blk-mq-debugfs: Add 'kick' operation

 block/blk-mq-debugfs.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq.c         |  8 ++---
 2 files changed, 98 insertions(+), 5 deletions(-)

-- 
2.12.2
