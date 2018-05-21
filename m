Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCH 2/3] blk-mq: Fix timeout and state order
Date: Mon, 21 May 2018 17:11:30 -0600
Message-Id: <20180521231131.6685-3-keith.busch@intel.com>
In-Reply-To: <20180521231131.6685-1-keith.busch@intel.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The block layer had been setting the state to in-flight prior to updating
the timer. This is the wrong order since the timeout handler could observe
the in-flight state with the older timeout, believing the request had
expired when in fact it is just getting started.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8b370ed75605..66e5c768803f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -713,8 +713,8 @@ void blk_mq_start_request(struct request *rq)
 	preempt_disable();
 	write_seqcount_begin(&rq->gstate_seq);
 
-	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
 	blk_add_timer(rq);
+	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
 
 	write_seqcount_end(&rq->gstate_seq);
 	preempt_enable();
-- 
2.14.3
