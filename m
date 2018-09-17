Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v7 4/6] block: Schedule runtime resume earlier
Date: Mon, 17 Sep 2018 13:11:18 -0700
Message-Id: <20180917201124.26161-6-bvanassche@acm.org>
In-Reply-To: <20180917201124.26161-1-bvanassche@acm.org>
References: <20180917201124.26161-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Instead of scheduling runtime resume of a request queue after a
request has been queued, schedule asynchronous resume during request
allocation. The new pm_request_resume() calls occur after
blk_queue_enter() has increased the q_usage_counter request queue
member. This change is needed for a later patch that will make request
allocation block while the queue status is not RPM_ACTIVE.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c | 2 ++
 block/elevator.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fd91e9bf2893..18b874d5c9c9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -942,6 +942,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		if (success)
 			return 0;
 
+		blk_pm_request_resume(q);
+
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
diff --git a/block/elevator.c b/block/elevator.c
index 1c992bf6cfb1..e18ac68626e3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,7 +601,6 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 	trace_block_rq_insert(q, rq);
 
 	blk_pm_add_request(q, rq);
-	blk_pm_request_resume(q);
 
 	rq->q = q;
 
-- 
2.18.0
