Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] fixes for the updating nr_hw_queues
Date: Fri, 17 Aug 2018 11:54:01 +0800
Message-Id: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

Two fixes for updating nr_hw_queues.

The first patch fixes the following scenario:
io scheduler (kyber) depends on the mapping between ctx and hctx.
When update nr_hw_queues, io scheduler's init_hctx will be
invoked before the mapping is adapted correctly, this would cause
panic in kyber.

The second patch fixes the following scenario:
part_in_flight/rw will invoke blk_mq_in_flight/rw to account the
inflight requests. It will access the queue_hw_ctx and nr_hw_queues
w/o any protection. When updating nr_hw_queues and blk_mq_in_flight
/rw occur concurrently, panic comes up.


V2:
 - remove blk_mq_sched_init/exit_hctx in patch 1.
 - use q_usage_counter instead of adding new member suggested by
   Ming in patch 2.
 - comment modification.

Jianchao Wang(2)
blk-mq: init hctx sched after update ctx and hctx mapping
blk-mq: sync the update nr_hw_queues with part_in_flight

 block/blk-mq-sched.c   | 44 ----------------------------------
 block/blk-mq-sched.h   |  5 ----
 block/blk-mq.c         | 65 +++++++++++++++++++++++++++++++++++++++++++-------
 block/blk.h            |  2 ++
 block/elevator.c       | 20 +++++++++-------
 include/linux/blkdev.h |  3 +++
 6 files changed, 74 insertions(+), 65 deletions(-)

Thanks
Jianchao
