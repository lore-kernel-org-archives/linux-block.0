Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689B6C2D0FC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4401820740
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="swMNEqhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgEMLEd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbgEMLEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:04:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9278C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XBJbHCdKTrs8VtkKoo2JLMZMWOTm0U8cqXynPIp1d9Y=; b=swMNEqhuhrO8mFbY5+IniUxVuL
        JOCWIvgXhOmjmYu1IjLhA29y2c0kJtgVFrb4ih7e2aOyt8Bu8tdcmbjl/ZHw4ODZTlXTBVhYEfvkL
        QNtpP1wCijGIAOVAsil+B8D2c05NXZPYiUS35nggtlwd19Mc6GUFJclRuDGwQ+ujue51BawFuR5sj
        zxtqb85U6FhpkVj+mxPaKcqwJBBxi55rM55n9UobgcYUpEMtTT+zgDf5dFlP1w5Si7hpPpykR9PCn
        vb1OYpuJhO5ColMSpXY14StEnEoyVKflNrqvyyivNt8ZtqNjiBw/xFmrsGJgAyFP8lkhW9J76MP5Z
        EwInjKXg==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYpBg-0006jI-EP; Wed, 13 May 2020 11:04:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: allow blk_mq_make_request to consume the q_usage_counter reference
Date:   Wed, 13 May 2020 13:04:19 +0200
Message-Id: <20200513110419.2362556-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513110419.2362556-1-hch@lst.de>
References: <20200513110419.2362556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_make_request currently needs to grab an q_usage_counter
reference when allocating a request.  This is because the block layer
grabs one before calling blk_mq_make_request, but also releases it as
soon as blk_mq_make_request returns.  Remove the blk_queue_exit call
after blk_mq_make_request returns, and instead let it consume the
reference.  This works perfectly fine for the block layer caller, just
device mapper needs an extra reference as the old problem still
persists there.  Open code blk_queue_enter_live in device mapper,
as there should be no other callers and this allows better documenting
why we do a non-try get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 13 +++++--------
 block/blk-mq.c   | 13 +++++++------
 block/blk.h      | 11 -----------
 drivers/md/dm.c  | 11 ++++++++++-
 4 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cf5b2163edfef..e303687811bb3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1124,12 +1124,12 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			if (q->make_request_fn)
+			if (q->make_request_fn) {
 				ret = q->make_request_fn(q, bio);
-			else
+				blk_queue_exit(q);
+			} else {
 				ret = blk_mq_make_request(q, bio);
-
-			blk_queue_exit(q);
+			}
 
 			/* sort new bios into those for a lower level
 			 * and those for the same level
@@ -1166,7 +1166,6 @@ EXPORT_SYMBOL(generic_make_request);
 blk_qc_t direct_make_request(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	blk_qc_t ret;
 
 	if (WARN_ON_ONCE(q->make_request_fn)) {
 		bio_io_error(bio);
@@ -1176,9 +1175,7 @@ blk_qc_t direct_make_request(struct bio *bio)
 		return BLK_QC_T_NONE;
 	if (unlikely(bio_queue_enter(bio)))
 		return BLK_QC_T_NONE;
-	ret = blk_mq_make_request(q, bio);
-	blk_queue_exit(q);
-	return ret;
+	return blk_mq_make_request(q, bio);
 }
 EXPORT_SYMBOL_GPL(direct_make_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 81b7af7be70b5..33538cce22fa6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2024,26 +2024,24 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	__blk_queue_split(q, &bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
-		return BLK_QC_T_NONE;
+		goto queue_exit;
 
 	if (!is_flush_fua && !blk_queue_nomerges(q) &&
 	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
-		return BLK_QC_T_NONE;
+		goto queue_exit;
 
 	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
-		return BLK_QC_T_NONE;
+		goto queue_exit;
 
 	rq_qos_throttle(q, bio);
 
 	data.cmd_flags = bio->bi_opf;
-	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
-		blk_queue_exit(q);
 		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
-		return BLK_QC_T_NONE;
+		goto queue_exit;
 	}
 
 	trace_block_getrq(q, bio, bio->bi_opf);
@@ -2122,6 +2120,9 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	}
 
 	return cookie;
+queue_exit:
+	blk_queue_exit(q);
+	return BLK_QC_T_NONE;
 }
 EXPORT_SYMBOL_GPL(blk_mq_make_request); /* only for request based dm */
 
diff --git a/block/blk.h b/block/blk.h
index e5cd350ca3798..cd1b516bf20b5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -62,17 +62,6 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
 
-static inline void blk_queue_enter_live(struct request_queue *q)
-{
-	/*
-	 * Given that running in generic_make_request() context
-	 * guarantees that a live reference against q_usage_counter has
-	 * been established, further references under that same context
-	 * need not check that the queue has been frozen (marked dead).
-	 */
-	percpu_ref_get(&q->q_usage_counter);
-}
-
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0eb93da44ea2a..88d3fb3d876d8 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1788,8 +1788,17 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 	int srcu_idx;
 	struct dm_table *map;
 
-	if (dm_get_md_type(md) == DM_TYPE_REQUEST_BASED)
+	if (dm_get_md_type(md) == DM_TYPE_REQUEST_BASED) {
+		/*
+		 * We are called with a live reference on q_usage_counter, but
+		 * that one will be released as soon as we return.  Grab an
+		 * extra one as blk_mq_make_request expects to be able to
+		 * consume a reference (which lives until the request is freed
+		 * in case a request is allocated).
+		 */
+		percpu_ref_get(&q->q_usage_counter);
 		return blk_mq_make_request(q, bio);
+	}
 
 	map = dm_get_live_table(md, &srcu_idx);
 
-- 
2.26.2

