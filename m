Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fixes for the updating nr_hw_queues
Date: Wed, 15 Aug 2018 15:25:13 +0800
Message-Id: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Two fixes for updating nr_hw_queues.

The first patch fixes the following scenario:
Kyber depends on the mapping between cpu and nr_hw_queues. When
update nr_hw_queues, elevator_type->ops.mq.init_hctx will be
invoked before the mapping is adapted correctly, this would cause
panic in kyber.

The second patch fixes the following scenario:
part_in_flight/rw will invoke blk_mq_in_flight/rw to account the
inflight requests. It will access the queue_hw_ctx and nr_hw_queues
w/o any protection. When updating nr_hw_queues and blk_mq_in_flight
/rw occur concurrently, panic comes up.

Jianchao Wang (2)
blk-mq: init hctx sched after update cpu & nr_hw_queues
blk-mq: sync the update nr_hw_queues with part_in_flight

 block/blk-mq.c         | 40 ++++++++++++++++++++++++++++++++--------
 block/blk.h            |  2 ++
 block/elevator.c       | 20 ++++++++++++--------
 block/genhd.c          | 10 ++++++++--
 include/linux/blkdev.h |  4 ++++
 5 files changed, 58 insertions(+), 18 deletions(-)

Thanks
Jianchao
