Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 02/14] blk-mq: Fix timeout and state order
Date: Tue, 29 May 2018 15:52:27 +0200
Message-Id: <20180529135239.27005-3-hch@lst.de>
In-Reply-To: <20180529135239.27005-1-hch@lst.de>
References: <20180529135239.27005-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Keith Busch <keith.busch@intel.com>

The block layer had been setting the state to in-flight prior to updating
the timer. This is the wrong order since the timeout handler could observe
the in-flight state with the older timeout, believing the request had
expired when in fact it is just getting started.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df928200b17e..3581a1e5c8a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -697,8 +697,8 @@ void blk_mq_start_request(struct request *rq)
 	preempt_disable();
 	write_seqcount_begin(&rq->gstate_seq);
 
-	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
 	blk_add_timer(rq);
+	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
 
 	write_seqcount_end(&rq->gstate_seq);
 	preempt_enable();
-- 
2.17.0
