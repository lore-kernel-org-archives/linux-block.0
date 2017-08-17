Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 03/12] blk-mq: Explain when 'active_queues' is decremented
Date: Thu, 17 Aug 2017 16:23:02 -0700
Message-Id: <20170817232311.25948-4-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

It is nontrivial to derive from the blk-mq source code when
blk_mq_tags.active_queues is decremented. Hence add a comment that
explains this.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f84d145490bf..b86d2cafc355 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -834,6 +834,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	} else {
 		struct blk_mq_hw_ctx *hctx;
 
+		/*
+		 * All requests finished (latest request timeout) seconds ago,
+		 * so mark each hctx as idle.
+		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			/* the hctx may be unmapped, so check it here */
 			if (blk_mq_hw_queue_mapped(hctx))
-- 
2.14.0
