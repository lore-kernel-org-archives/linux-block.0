Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH 0/5] Reduce code duplication
Date: Tue, 18 Apr 2017 16:10:32 -0700
Message-ID: <20170418231037.3968-1-bart.vanassche@sandisk.com>
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

Bart Van Assche (5):
  block: Export blk_init_request_from_bio()
  null_blk: Use blk_init_request_from_bio() instead of open-coding it
  lightnvm: Use blk_init_request_from_bio() instead of open-coding it
  block: Inline blk_rq_set_prio()
  block: Optimize ioprio_best()

 block/blk-core.c             | 12 +++++++-----
 block/blk-mq.c               |  2 +-
 block/blk.h                  |  1 -
 block/ioprio.c               | 12 +-----------
 drivers/block/null_blk.c     |  9 +--------
 drivers/nvme/host/lightnvm.c |  6 +-----
 include/linux/blkdev.h       | 15 +--------------
 7 files changed, 12 insertions(+), 45 deletions(-)

-- 
2.12.2
