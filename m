Return-Path: <prvs=550bc9d12=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/3] Avoid that blk_mq_delay_run_hw_queue() introduces unintended delays
Date: Fri, 19 Jan 2018 08:58:53 -0800
Message-Id: <20180119165856.17677-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Earlier today it was agreed that a blk_mq_delay_run_hw_queue() call followed
by a blk_mq_run_hw_queue() call should result in an immediate queue run. Hence
this patch series. Please consider this patch series for kernel v4.16.

Thanks,

Bart.

Bart Van Assche (3):
  blk-mq: Rename blk_mq_request_direct_issue() into
    blk_mq_request_issue_directly()
  blk-mq: Avoid that blk_mq_delay_run_hw_queue() introduces unintended
    delays
  block: Remove kblockd_schedule_delayed_work{,_on}()

 block/blk-core.c       | 16 +---------------
 block/blk-mq.c         | 11 +++++------
 block/blk-mq.h         |  2 +-
 include/linux/blkdev.h |  2 --
 4 files changed, 7 insertions(+), 24 deletions(-)

-- 
2.15.1
