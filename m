Return-Path: <prvs=5014e5409=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/7] blk-mq: Queue running fixes
Date: Thu, 30 Nov 2017 16:08:41 -0800
Message-Id: <20171201000848.2656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series fixes the issues I came across while reviewing and testing
the v4.15-rc1 block layer. Please consider these patches for v4.15-rc<n> /
v4.16 as appropriate.

Thanks,

Bart.

Bart Van Assche (7):
  blk-mq: Fix spelling in a source code comment
  block: Document more locking requirements
  blk-mq: Make blk_mq_mark_tag_wait() easier to read
  blk-mq: Avoid that request processing stalls when sharing tags
  blk-mq: Avoid that blk_mq_mark_tag_wait() triggers a queue stall
  blk-mq: Rerun hardware queues after having called .put_budget()
  blk-mq: Fix another queue stall

 block/blk-mq-sched.c | 43 ++++++++++++------------
 block/blk-mq-sched.h |  2 +-
 block/blk-mq.c       | 95 +++++++++++++++++++++++++++++++---------------------
 block/blk-mq.h       |  2 ++
 block/blk-timeout.c  |  3 ++
 5 files changed, 85 insertions(+), 60 deletions(-)

-- 
2.15.0
