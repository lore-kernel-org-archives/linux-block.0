Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v10 6/8] block: Allow unfreezing of a queue while requests are in progress
Date: Fri, 21 Sep 2018 13:31:20 -0700
Message-Id: <20180921203122.49743-7-bvanassche@acm.org>
In-Reply-To: <20180921203122.49743-1-bvanassche@acm.org>
References: <20180921203122.49743-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

A later patch will call blk_freeze_queue_start() followed by
blk_mq_unfreeze_queue() without waiting for q_usage_counter to drop
to zero. Make sure that this doesn't cause a kernel warning to appear
by switching from percpu_ref_reinit() to percpu_ref_resurrect(). The
former namely requires that the refcount it operates on is zero.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..96d501e8663c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -198,7 +198,7 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 	freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
-		percpu_ref_reinit(&q->q_usage_counter);
+		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
 }
-- 
2.19.0.444.g18242da7ef-goog
