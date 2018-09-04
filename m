Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeIDXlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Sep 2018 19:41:07 -0400
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-block@vger.kernel.org, xen-devel@lists.xen.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/13] block: move req_gap_back_merge to blk.h
Date: Tue,  4 Sep 2018 12:14:24 -0700
Message-Id: <20180904191431.20102-7-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
2.18.0
