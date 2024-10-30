Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22633E7
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265550; cv=none; b=L34amcQaMK8a0YjYRFU9e8llRGGArDNuyTxLfM0+qVyCSzsN+GmfwQwHKHXApCOJrbWfpqSenisyCTalfWZYQXZc9L1l2PAXb0MNLBRNTWGvwtH+vZ3zp85QLr+EO5dGOsJpNkYCI1jPqIT6h6eX9ONAkUkMgtAXUFGrngiGED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265550; c=relaxed/simple;
	bh=JgPU1y0PfWxtZRQua9+iatyXeA00Y7Sk6iZxyAckqeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaxXtCQluPMXx0GtveeXgjtN3h2EmXydXd4JBdceU/rC9I+8+tw7eO6HfxWSeGWOMtHZTDNCxJIFZWsKBBRgwrZDz/h56czO1NVLXO29AnPP9Lq+4bla0J5IJrS4PDkyOVVHduyd/L0ca+wIaatwK1bTIcCxyTH5bIHKUOCgcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tTv1c5kc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTv1c5kc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4L/uPX1lSGaggf7NMMAAzR7YSRs3dmHl+8f/z3Fw6x8=; b=tTv1c5kcPrS6mFwqylMfXGDCfL
	SJmyMNS8W4OIoUE3e+R1ripKi/60NB+68ogNqjmsuclyZQhY/ZFpNsnTlW90FIgg2SP7hOYpyOswp
	BleZbQ1Gijh1sfK/rhdgasChRTOiEKnlftUewtk8+Z+Y+YH8Fil0YHvrFCYe5ZWwG++ORFR1SFW1l
	s9uU4W4C0mVjbGNrE4REjmnbPU3HEsKqntbYgSfMLBmovkX3qTkRovSrPY7Ted7JIj5vKCZf/6IXj
	7vLWHi4QGCxBOz+0C9m3a/zOBVRWgb/Z5uAm9ZhTRKkEmjJKRhj2amYwnYbmfJdVYpiJNkfu9DZet
	rGiBp+JQ==;
Received: from 2a02-8389-2341-5b80-bb25-9391-28eb-c7ed.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:bb25:9391:28eb:c7ed] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t616p-0000000GlQ1-3GTJ;
	Wed, 30 Oct 2024 05:19:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Kundan Kumar <kundan.kumar@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: remove bio_add_zone_append_page
Date: Wed, 30 Oct 2024 06:18:52 +0100
Message-ID: <20241030051859.280923-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030051859.280923-1-hch@lst.de>
References: <20241030051859.280923-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is only used by the nvmet zns passthrough code, which can trivially
just use bio_add_pc_page and do the sanity check for the max zone append
limit itself.

All future zoned file systems should follow the btrfs lead and let the
upper layers fill up bios unlimited by hardware constraints and split
them to the limits in the I/O submission handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c               | 33 ---------------------------------
 drivers/nvme/target/zns.c | 21 +++++++++++++--------
 include/linux/bio.h       |  2 --
 3 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 6a60d62a529d..daceb0a5c1d7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1064,39 +1064,6 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
-/**
- * bio_add_zone_append_page - attempt to add page to zone-append bio
- * @bio: destination bio
- * @page: page to add
- * @len: vec entry length
- * @offset: vec entry offset
- *
- * Attempt to add a page to the bio_vec maplist of a bio that will be submitted
- * for a zone-append request. This can fail for a number of reasons, such as the
- * bio being full or the target block device is not a zoned block device or
- * other limitations of the target block device. The target block device must
- * allow bio's up to PAGE_SIZE, so it is always possible to add a single page
- * to an empty bio.
- *
- * Returns: number of bytes added to the bio, or 0 in case of a failure.
- */
-int bio_add_zone_append_page(struct bio *bio, struct page *page,
-			     unsigned int len, unsigned int offset)
-{
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-	bool same_page = false;
-
-	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
-		return 0;
-
-	if (WARN_ON_ONCE(!bdev_is_zoned(bio->bi_bdev)))
-		return 0;
-
-	return bio_add_hw_page(q, bio, page, len, offset,
-			       queue_max_zone_append_sectors(q), &same_page);
-}
-EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
-
 /**
  * __bio_add_page - add page(s) to a bio in a new segment
  * @bio: destination bio
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index af9e13be7678..3aef35b05111 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -537,6 +537,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
 	struct scatterlist *sg;
+	u32 data_len = nvmet_rw_data_len(req);
 	struct bio *bio;
 	int sg_cnt;
 
@@ -544,6 +545,13 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
+	if (data_len >
+	    bdev_max_zone_append_sectors(req->ns->bdev) << SECTOR_SHIFT) {
+		req->error_loc = offsetof(struct nvme_rw_command, length);
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
 	if (!req->sg_cnt) {
 		nvmet_req_complete(req, 0);
 		return;
@@ -576,20 +584,17 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 		bio->bi_opf |= REQ_FUA;
 
 	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
-		struct page *p = sg_page(sg);
-		unsigned int l = sg->length;
-		unsigned int o = sg->offset;
-		unsigned int ret;
+		unsigned int len = sg->length;
 
-		ret = bio_add_zone_append_page(bio, p, l, o);
-		if (ret != sg->length) {
+		if (bio_add_pc_page(bdev_get_queue(bio->bi_bdev), bio,
+				sg_page(sg), len, sg->offset) != len) {
 			status = NVME_SC_INTERNAL;
 			goto out_put_bio;
 		}
-		total_len += sg->length;
+		total_len += len;
 	}
 
-	if (total_len != nvmet_rw_data_len(req)) {
+	if (total_len != data_len) {
 		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 		goto out_put_bio;
 	}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index faceadb040f9..4a1bf43ca53d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -418,8 +418,6 @@ bool __must_check bio_add_folio(struct bio *bio, struct folio *folio,
 				size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
-int bio_add_zone_append_page(struct bio *bio, struct page *page,
-			     unsigned int len, unsigned int offset);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
-- 
2.45.2

