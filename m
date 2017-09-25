Return-Path: <BATV+21c581e1042956a70a85+5146+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/9] block: add a blk_steal_bios helper
Date: Mon, 25 Sep 2017 15:40:26 +0200
Message-Id: <20170925134031.10548-5-hch@lst.de>
In-Reply-To: <20170925134031.10548-1-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This helpers allows to bounce steal the uncompleted bios from a request so
that they can be reissued on another path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-core.c       | 20 ++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d7b5d392b550..856fb626d9fe 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2727,6 +2727,26 @@ struct request *blk_fetch_request(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_fetch_request);
 
+/*
+ * Steal bios from a request.  The request must not have been partially
+ * completed before.
+ */
+void blk_steal_bios(struct bio_list *list, struct request *rq)
+{
+	if (rq->bio) {
+		if (list->tail)
+			list->tail->bi_next = rq->bio;
+		else
+			list->head = rq->bio;
+		list->tail = rq->biotail;
+	}
+
+	rq->bio = NULL;
+	rq->biotail = NULL;
+	rq->__data_len = 0;
+}
+EXPORT_SYMBOL_GPL(blk_steal_bios);
+
 /**
  * blk_update_request - Special helper function for request stacking drivers
  * @req:      the request being processed
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 780f01db5899..45c63764a14e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1110,6 +1110,8 @@ extern struct request *blk_peek_request(struct request_queue *q);
 extern void blk_start_request(struct request *rq);
 extern struct request *blk_fetch_request(struct request_queue *q);
 
+void blk_steal_bios(struct bio_list *list, struct request *rq);
+
 /*
  * Request completion related functions.
  *
-- 
2.14.1
