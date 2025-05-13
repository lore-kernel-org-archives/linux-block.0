Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9F13FEE
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120479; cv=none; b=Imh5KApXNoRehZqAMTUTrncSUDhN4q+bdpmxV+TbX/sIP3624W1VoERF+DqtRihQHXgOHZE/JqKcr/uCmkX0gxLYqOIlrvtPSb14qll13qbWsHn1mn7TWI66A+0tLUtLB6EhKps0fDElAy0qo1/f9JacwlRU+HYKtomLcMfu68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120479; c=relaxed/simple;
	bh=0fDnjpc4mbNWwNq3KtjXq0wcy/7aDGthBuDcqD4uJlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nxzf79AJHhjFNwjDDah/gWNRdIFRTf0jcDD6g9u6nN1IS0lyVXAubM3yUmSNGawKrprKYtHP2peAK6tnI9GC4ECaGuopnAL4Nd8zcVvT7icW83Ljj/0IMb+NSp2gTz35J+i47oNdHMncljvO4RiKH/d4d2imy1fFH1PgYkRs72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=biC9Q4Lu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="biC9Q4Lu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Zdiyep4YeG0ZxYTEatKxVSVbVZB5yeH9mmAUQyNuNM8=; b=biC9Q4Luauvv8NJUYMnwlgMtdf
	KS2X0BfM8PCzDibcZZ20rgvMz9QT0Z9UkC9KbU0XRmc3K93wzAqMSjva/IT6jWxLd6oExUIA4LCl4
	DD3YiWhF18PjaKrfnjsD2VusyYCzrAIvlZf1wMLKviG5JR28p4oruWK3sfszVygvbPBlG/7VA1mRZ
	9aeV8IT3a0RshS5MVqIMj1bEPYPTz02jX9g7+Hx2ER3k4JpGSyyDTeNTmCxjLRnpR1Wsai4eJso/R
	7xta5PUES3u9CbaVFyLszVznBHT3BcdZGEiMtUl7c+XyO6+nIovcZvs5VAJIzmTU7JbeLEtZcH9j8
	sV69dx0g==;
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjqX-0000000BauB-01Od;
	Tue, 13 May 2025 07:14:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: move the DMA mapping code to a separate file
Date: Tue, 13 May 2025 09:14:32 +0200
Message-ID: <20250513071433.836797-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

While working on the new DMA API I kept getting annoyed how it was placed
right in the middle of the bio splitting code in blk-merge.c.
Split it out into a separate file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile     |   4 +-
 block/blk-merge.c  | 133 ---------------------------------------------
 block/blk-mq-dma.c | 113 ++++++++++++++++++++++++++++++++++++++
 block/blk.h        |  21 +++++++
 4 files changed, 136 insertions(+), 135 deletions(-)
 create mode 100644 block/blk-mq-dma.c

diff --git a/block/Makefile b/block/Makefile
index 36033c0f07bc..c65f4da93702 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -5,8 +5,8 @@
 
 obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
-			blk-merge.o blk-timeout.o \
-			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
+			blk-merge.o blk-timeout.o blk-lib.o blk-mq.o \
+			blk-mq-tag.o blk-mq-dma.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
 			disk-events.o blk-ia-ranges.o early-lookup.o
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 782308b73b53..3af1d284add5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -7,7 +7,6 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
-#include <linux/scatterlist.h>
 #include <linux/part_stat.h>
 #include <linux/blk-cgroup.h>
 
@@ -225,27 +224,6 @@ static inline unsigned get_max_io_size(struct bio *bio,
 	return max_sectors & ~(lbs - 1);
 }
 
-/**
- * get_max_segment_size() - maximum number of bytes to add as a single segment
- * @lim: Request queue limits.
- * @paddr: address of the range to add
- * @len: maximum length available to add at @paddr
- *
- * Returns the maximum number of bytes of the range starting at @paddr that can
- * be added to a single segment.
- */
-static inline unsigned get_max_segment_size(const struct queue_limits *lim,
-		phys_addr_t paddr, unsigned int len)
-{
-	/*
-	 * Prevent an overflow if mask = ULONG_MAX and offset = 0 by adding 1
-	 * after having calculated the minimum.
-	 */
-	return min_t(unsigned long, len,
-		min(lim->seg_boundary_mask - (lim->seg_boundary_mask & paddr),
-		    (unsigned long)lim->max_segment_size - 1) + 1);
-}
-
 /**
  * bvec_split_segs - verify whether or not a bvec should be split in the middle
  * @lim:      [in] queue limits to split based on
@@ -473,117 +451,6 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	return nr_phys_segs;
 }
 
-struct phys_vec {
-	phys_addr_t	paddr;
-	u32		len;
-};
-
-static bool blk_map_iter_next(struct request *req,
-		struct req_iterator *iter, struct phys_vec *vec)
-{
-	unsigned int max_size;
-	struct bio_vec bv;
-
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		vec->paddr = bvec_phys(&req->special_vec);
-		vec->len = req->special_vec.bv_len;
-		iter->bio = NULL;
-		return true;
-	}
-
-	if (!iter->iter.bi_size)
-		return false;
-
-	bv = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
-	vec->paddr = bvec_phys(&bv);
-	max_size = get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX);
-	bv.bv_len = min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
-
-	/*
-	 * If we are entirely done with this bi_io_vec entry, check if the next
-	 * one could be merged into it.  This typically happens when moving to
-	 * the next bio, but some callers also don't pack bvecs tight.
-	 */
-	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
-		struct bio_vec next;
-
-		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
-				break;
-			iter->bio = iter->bio->bi_next;
-			iter->iter = iter->bio->bi_iter;
-		}
-
-		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
-		if (bv.bv_len + next.bv_len > max_size ||
-		    !biovec_phys_mergeable(req->q, &bv, &next))
-			break;
-
-		bv.bv_len += next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
-	}
-
-	vec->len = bv.bv_len;
-	return true;
-}
-
-static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
-		struct scatterlist *sglist)
-{
-	if (!*sg)
-		return sglist;
-
-	/*
-	 * If the driver previously mapped a shorter list, we could see a
-	 * termination bit prematurely unless it fully inits the sg table
-	 * on each mapping. We KNOW that there must be more entries here
-	 * or the driver would be buggy, so force clear the termination bit
-	 * to avoid doing a full sg_init_table() in drivers for each command.
-	 */
-	sg_unmark_end(*sg);
-	return sg_next(*sg);
-}
-
-/*
- * Map a request to scatterlist, return number of sg entries setup. Caller
- * must make sure sg can hold rq->nr_phys_segments entries.
- */
-int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
-		    struct scatterlist **last_sg)
-{
-	struct req_iterator iter = {
-		.bio	= rq->bio,
-	};
-	struct phys_vec vec;
-	int nsegs = 0;
-
-	/* the internal flush request may not have bio attached */
-	if (iter.bio)
-		iter.iter = iter.bio->bi_iter;
-
-	while (blk_map_iter_next(rq, &iter, &vec)) {
-		*last_sg = blk_next_sg(last_sg, sglist);
-		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
-				offset_in_page(vec.paddr));
-		nsegs++;
-	}
-
-	if (*last_sg)
-		sg_mark_end(*last_sg);
-
-	/*
-	 * Something must have been wrong if the figured number of
-	 * segment is bigger than number of req's physical segments
-	 */
-	WARN_ON(nsegs > blk_rq_nr_phys_segments(rq));
-
-	return nsegs;
-}
-EXPORT_SYMBOL(__blk_rq_map_sg);
-
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 						  sector_t offset)
 {
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
new file mode 100644
index 000000000000..5822b8898bdd
--- /dev/null
+++ b/block/blk-mq-dma.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "blk.h"
+
+struct phys_vec {
+	phys_addr_t	paddr;
+	u32		len;
+};
+
+static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
+			      struct phys_vec *vec)
+{
+	unsigned int max_size;
+	struct bio_vec bv;
+
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		if (!iter->bio)
+			return false;
+		vec->paddr = bvec_phys(&req->special_vec);
+		vec->len = req->special_vec.bv_len;
+		iter->bio = NULL;
+		return true;
+	}
+
+	if (!iter->iter.bi_size)
+		return false;
+
+	bv = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	vec->paddr = bvec_phys(&bv);
+	max_size = get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX);
+	bv.bv_len = min(bv.bv_len, max_size);
+	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+
+	/*
+	 * If we are entirely done with this bi_io_vec entry, check if the next
+	 * one could be merged into it.  This typically happens when moving to
+	 * the next bio, but some callers also don't pack bvecs tight.
+	 */
+	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
+		struct bio_vec next;
+
+		if (!iter->iter.bi_size) {
+			if (!iter->bio->bi_next)
+				break;
+			iter->bio = iter->bio->bi_next;
+			iter->iter = iter->bio->bi_iter;
+		}
+
+		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		if (bv.bv_len + next.bv_len > max_size ||
+		    !biovec_phys_mergeable(req->q, &bv, &next))
+			break;
+
+		bv.bv_len += next.bv_len;
+		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+	}
+
+	vec->len = bv.bv_len;
+	return true;
+}
+
+static inline struct scatterlist *
+blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
+{
+	if (!*sg)
+		return sglist;
+
+	/*
+	 * If the driver previously mapped a shorter list, we could see a
+	 * termination bit prematurely unless it fully inits the sg table
+	 * on each mapping. We KNOW that there must be more entries here
+	 * or the driver would be buggy, so force clear the termination bit
+	 * to avoid doing a full sg_init_table() in drivers for each command.
+	 */
+	sg_unmark_end(*sg);
+	return sg_next(*sg);
+}
+
+/*
+ * Map a request to scatterlist, return number of sg entries setup. Caller
+ * must make sure sg can hold rq->nr_phys_segments entries.
+ */
+int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
+		    struct scatterlist **last_sg)
+{
+	struct req_iterator iter = {
+		.bio	= rq->bio,
+	};
+	struct phys_vec vec;
+	int nsegs = 0;
+
+	/* the internal flush request may not have bio attached */
+	if (iter.bio)
+		iter.iter = iter.bio->bi_iter;
+
+	while (blk_map_iter_next(rq, &iter, &vec)) {
+		*last_sg = blk_next_sg(last_sg, sglist);
+		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
+				offset_in_page(vec.paddr));
+		nsegs++;
+	}
+
+	if (*last_sg)
+		sg_mark_end(*last_sg);
+
+	/*
+	 * Something must have been wrong if the figured number of
+	 * segment is bigger than number of req's physical segments
+	 */
+	WARN_ON(nsegs > blk_rq_nr_phys_segments(rq));
+
+	return nsegs;
+}
+EXPORT_SYMBOL(__blk_rq_map_sg);
diff --git a/block/blk.h b/block/blk.h
index 665b3d1fb504..d05f7f4ad5b3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -405,6 +405,27 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
 	}
 }
 
+/**
+ * get_max_segment_size() - maximum number of bytes to add as a single segment
+ * @lim: Request queue limits.
+ * @paddr: address of the range to add
+ * @len: maximum length available to add at @paddr
+ *
+ * Returns the maximum number of bytes of the range starting at @paddr that can
+ * be added to a single segment.
+ */
+static inline unsigned get_max_segment_size(const struct queue_limits *lim,
+		phys_addr_t paddr, unsigned int len)
+{
+	/*
+	 * Prevent an overflow if mask = ULONG_MAX and offset = 0 by adding 1
+	 * after having calculated the minimum.
+	 */
+	return min_t(unsigned long, len,
+		min(lim->seg_boundary_mask - (lim->seg_boundary_mask & paddr),
+		    (unsigned long)lim->max_segment_size - 1) + 1);
+}
+
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
-- 
2.47.2

