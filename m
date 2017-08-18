Return-Path: <prvs=396ff485d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2] blk-mq: Explain when 'active_queues' is decremented
Date: Fri, 18 Aug 2017 08:48:35 -0700
Message-Id: <20170818154835.12034-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

It is nontrivial to derive from the blk-mq source code when
blk_mq_tags.active_queues is decremented. Hence add a comment that
explains this.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---

v2: Rewrote the comment based on feedback from Jens.

 block/blk-mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f84d145490bf..09ee74056f93 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -834,6 +834,12 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	} else {
 		struct blk_mq_hw_ctx *hctx;
 
+		/*
+		 * Request timeouts are handled as a forward rolling timer. If
+		 * we end up here it means that no requests are pending and
+		 * also that no request has been pending for a while. Mark
+		 * each hctx as idle.
+		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			/* the hctx may be unmapped, so check it here */
 			if (blk_mq_hw_queue_mapped(hctx))
-- 
2.14.0
