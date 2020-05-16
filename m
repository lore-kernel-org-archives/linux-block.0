Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D4C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC312065C
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bGKnEhYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgEPPen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgEPPen (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 11:34:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06CC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nykX8O4a5LPORTHjZttDKN16tPuVrt2NXmISiHrTOA0=; b=bGKnEhYeBUME/WFuKddQrcRM2s
        9woVwhKt3kxWR8wGSAoD3eSGqu7TWrxIkhn9HZNZhbQ0LjgmGN7xqDEMU7FWQGqjFOmhnIX2R1iNY
        8Px+gPIbsF8K/ngo6EG3JVn/neoGBiKCycolXkDqY9XsRXuU1mZVs2+fLWLP3jImqAaU4PkSJx8pJ
        c/OkgtUeFQU6FjVCBFX3Q4IfYAgCqTDfcEyzmfYfQqgU2ngkxGcLveP0+dp3ykTiMj12feJrjDPLX
        qRmThvX6cFnuxa8oJ6sSGJXfVFWR6sGUVAqAvcGyswsjBdUN2Eu0s29Ta3BkfWvM1RdmzusXbIYuV
        T/pMyYxw==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZypm-000521-OI; Sat, 16 May 2020 15:34:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/4] blk-mq: allow blk_mq_make_request to consume the q_usage_counter reference
Date:   Sat, 16 May 2020 17:34:30 +0200
Message-Id: <20200516153430.294324-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516153430.294324-1-hch@lst.de>
References: <20200516153430.294324-1-hch@lst.de>
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
 block/blk-core.c | 33 ++++++++++++++++++++-------------
 block/blk-mq.c   | 13 +++++++------
 block/blk.h      | 11 -----------
 drivers/md/dm.c  | 11 ++++++++++-
 4 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1e97f99735232..78683ea61c939 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1066,6 +1066,20 @@ generic_make_request_checks(struct bio *bio)
 	return false;
 }
 
+static blk_qc_t do_make_request(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	blk_qc_t ret = BLK_QC_T_NONE;
+
+	if (blk_crypto_bio_prep(&bio)) {
+		if (!q->make_request_fn)
+			return blk_mq_make_request(q, bio);
+		ret = q->make_request_fn(q, bio);
+	}
+	blk_queue_exit(q);
+	return ret;
+}
+
 /**
  * generic_make_request - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -1131,14 +1145,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			if (blk_crypto_bio_prep(&bio)) {
-				if (q->make_request_fn)
-					ret = q->make_request_fn(q, bio);
-				else
-					ret = blk_mq_make_request(q, bio);
-			}
-
-			blk_queue_exit(q);
+			ret = do_make_request(bio);
 
 			/* sort new bios into those for a lower level
 			 * and those for the same level
@@ -1175,7 +1182,6 @@ EXPORT_SYMBOL(generic_make_request);
 blk_qc_t direct_make_request(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	if (WARN_ON_ONCE(q->make_request_fn)) {
 		bio_io_error(bio);
@@ -1185,10 +1191,11 @@ blk_qc_t direct_make_request(struct bio *bio)
 		return BLK_QC_T_NONE;
 	if (unlikely(bio_queue_enter(bio)))
 		return BLK_QC_T_NONE;
-	if (blk_crypto_bio_prep(&bio))
-		ret = blk_mq_make_request(q, bio);
-	blk_queue_exit(q);
-	return ret;
+	if (!blk_crypto_bio_prep(&bio)) {
+		blk_queue_exit(q);
+		return BLK_QC_T_NONE;
+	}
+	return blk_mq_make_request(q, bio);
 }
 EXPORT_SYMBOL_GPL(direct_make_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 69e58cc4244c0..969156e5f7e5b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2025,26 +2025,24 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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
@@ -2131,6 +2129,9 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	}
 
 	return cookie;
+queue_exit:
+	blk_queue_exit(q);
+	return BLK_QC_T_NONE;
 }
 EXPORT_SYMBOL_GPL(blk_mq_make_request); /* only for request based dm */
 
diff --git a/block/blk.h b/block/blk.h
index fc00537026a04..9e6ed5f118239 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -64,17 +64,6 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 
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
index 8921cd79422c6..f215b86664484 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1791,8 +1791,17 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
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

