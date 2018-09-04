Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeIDXlF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Sep 2018 19:41:05 -0400
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-block@vger.kernel.org, xen-devel@lists.xen.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/13] block: move integrity_req_gap_{back,front}_merge to blk.h
Date: Tue,  4 Sep 2018 12:14:22 -0700
Message-Id: <20180904191431.20102-5-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No need to expose these to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h            | 35 +++++++++++++++++++++++++++++++++--
 include/linux/blkdev.h | 31 -------------------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 9db4e389582c..441c2de1d4b9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -158,7 +158,38 @@ static inline bool bio_integrity_endio(struct bio *bio)
 		return __bio_integrity_endio(bio);
 	return true;
 }
-#else
+
+static inline bool integrity_req_gap_back_merge(struct request *req,
+		struct bio *next)
+{
+	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+	struct bio_integrity_payload *bip_next = bio_integrity(next);
+
+	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
+				bip_next->bip_vec[0].bv_offset);
+}
+
+static inline bool integrity_req_gap_front_merge(struct request *req,
+		struct bio *bio)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bio_integrity_payload *bip_next = bio_integrity(req->bio);
+
+	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
+				bip_next->bip_vec[0].bv_offset);
+}
+#else /* CONFIG_BLK_DEV_INTEGRITY */
+static inline bool integrity_req_gap_back_merge(struct request *req,
+		struct bio *next)
+{
+	return false;
+}
+static inline bool integrity_req_gap_front_merge(struct request *req,
+		struct bio *bio)
+{
+	return false;
+}
+
 static inline void blk_flush_integrity(void)
 {
 }
@@ -166,7 +197,7 @@ static inline bool bio_integrity_endio(struct bio *bio)
 {
 	return true;
 }
-#endif
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0e2b64..bc534c857344 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1843,26 +1843,6 @@ queue_max_integrity_segments(struct request_queue *q)
 	return q->limits.max_integrity_segments;
 }
 
-static inline bool integrity_req_gap_back_merge(struct request *req,
-						struct bio *next)
-{
-	struct bio_integrity_payload *bip = bio_integrity(req->bio);
-	struct bio_integrity_payload *bip_next = bio_integrity(next);
-
-	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
-				bip_next->bip_vec[0].bv_offset);
-}
-
-static inline bool integrity_req_gap_front_merge(struct request *req,
-						 struct bio *bio)
-{
-	struct bio_integrity_payload *bip = bio_integrity(bio);
-	struct bio_integrity_payload *bip_next = bio_integrity(req->bio);
-
-	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
-				bip_next->bip_vec[0].bv_offset);
-}
-
 /**
  * bio_integrity_intervals - Return number of integrity intervals for a bio
  * @bi:		blk_integrity profile for device
@@ -1947,17 +1927,6 @@ static inline bool blk_integrity_merge_bio(struct request_queue *rq,
 	return true;
 }
 
-static inline bool integrity_req_gap_back_merge(struct request *req,
-						struct bio *next)
-{
-	return false;
-}
-static inline bool integrity_req_gap_front_merge(struct request *req,
-						 struct bio *bio)
-{
-	return false;
-}
-
 static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
 						   unsigned int sectors)
 {
-- 
2.18.0
