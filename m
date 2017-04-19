Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH v2 0/5] Reduce code duplication
Date: Wed, 19 Apr 2017 14:01:23 -0700
Message-ID: <20170419210128.28374-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This series contains three patches intended to reduce code duplication
and two patches that simplify / optimize I/O priority handling. Please
consider these patches for kernel v4.12.

Thanks,

Bart.

Changes compared to v1:
- Converted ternary operators into an if/then/else-sequence.
- Used EXPORT_SYMBOL_GPL() to export block layer internals.

Bart Van Assche (5):
  block: Export blk_init_request_from_bio()
  null_blk: Use blk_init_request_from_bio() instead of open-coding it
  lightnvm: Use blk_init_request_from_bio() instead of open-coding it
  block: Inline blk_rq_set_prio()
  block: Optimize ioprio_best()

 block/blk-core.c             | 12 +++++++++---
 block/blk-mq.c               |  2 +-
 block/blk.h                  |  1 -
 block/ioprio.c               | 12 +-----------
 drivers/block/null_blk.c     |  9 +--------
 drivers/nvme/host/lightnvm.c |  6 +-----
 include/linux/blkdev.h       | 15 +--------------
 7 files changed, 14 insertions(+), 43 deletions(-)

-- 
2.12.2
