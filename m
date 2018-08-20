Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/2] fixes for the updating nr_hw_queues
Date: Mon, 20 Aug 2018 15:20:04 +0800
Message-Id: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com>
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

V3:
 - move the rcu and q_usage_counter checking into blk_mq_queue_tag_busy_iter
   as suggestion of Ming.
 - Add more comment about the __module_get in 1st patch.
 - Add Ming's Reviewd-by on 1st patch.

V2:
 - remove blk_mq_sched_init/exit_hctx in patch 1.
 - use q_usage_counter instead of adding new member suggested by
   Ming in patch 2.
 - comment modification.

Jianchao Wang(2)
blk-mq: init hctx sched after update ctx and hctx
blk-mq: sync the update nr_hw_queues with

 block/blk-mq-sched.c   | 44 --------------------------------------------
 block/blk-mq-sched.h   |  5 -----
 block/blk-mq-tag.c     | 14 +++++++++++++-
 block/blk-mq.c         | 43 +++++++++++++++++++++++++++++++++++--------
 block/blk.h            |  2 ++
 block/elevator.c       | 20 ++++++++++++--------
 include/linux/blkdev.h |  3 +++
 7 files changed, 65 insertions(+), 66 deletions(-)

Thanks
Jianchao
