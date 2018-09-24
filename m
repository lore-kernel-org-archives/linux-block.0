Return-Path: <BATV+afefc9c3360d6e01bea6+5510+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/10] block: move req_gap_back_merge to blk.h
Date: Mon, 24 Sep 2018 09:43:49 +0200
Message-Id: <20180924074355.2802-5-hch@lst.de>
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

No need to expose these helpers outside the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h            | 19 +++++++++++++++++++
 include/linux/blkdev.h | 19 -------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 441c2de1d4b9..63035c95689c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -149,6 +149,25 @@ static inline void blk_queue_enter_live(struct request_queue *q)
 	percpu_ref_get(&q->q_usage_counter);
 }
 
+static inline bool __bvec_gap_to_prev(struct request_queue *q,
+		struct bio_vec *bprv, unsigned int offset)
+{
+	return offset ||
+		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
+}
+
+/*
+ * Check if adding a bio_vec after bprv with offset would create a gap in
+ * the SG list. Most drivers don't care about this, but some do.
+ */
+static inline bool bvec_gap_to_prev(struct request_queue *q,
+		struct bio_vec *bprv, unsigned int offset)
+{
+	if (!queue_virt_boundary(q))
+		return false;
+	return __bvec_gap_to_prev(q, bprv, offset);
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b7e676bb01bc..1d5e14139795 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1676,25 +1676,6 @@ static inline void put_dev_sector(Sector p)
 	put_page(p.v);
 }
 
-static inline bool __bvec_gap_to_prev(struct request_queue *q,
-				struct bio_vec *bprv, unsigned int offset)
-{
-	return offset ||
-		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
-}
-
-/*
- * Check if adding a bio_vec after bprv with offset would create a gap in
- * the SG list. Most drivers don't care about this, but some do.
- */
-static inline bool bvec_gap_to_prev(struct request_queue *q,
-				struct bio_vec *bprv, unsigned int offset)
-{
-	if (!queue_virt_boundary(q))
-		return false;
-	return __bvec_gap_to_prev(q, bprv, offset);
-}
-
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_work_on(int cpu, struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
-- 
2.19.0
