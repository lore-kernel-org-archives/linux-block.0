Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE5DC65BAF
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4AB22513
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LBD5ajXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4AB22513
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLFPxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeLFPxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xzG/MS4S7QUyhssDZ7M2koQJkI7TFHyupbImITh5kEA=; b=LBD5ajXU/DXbtJHTa3MW8fLTxJ
        CacR2fhKn+G23vHSoizwadySqpI+7DgEFmNYWj+TM9TXffV5za/SFzHqm6mHrAYkyRJMpddhrt5dW
        8MY42yp+6x7d6zVfHa1x0dVWtNVONLIWvAk+Wmot0XZfjfjliQ5/8chjKLmZGtqG+UDzoVFGKfm8s
        lErfaR8rapddJ7w8YFWgtrAWERoDNFDZpTJSP5YL/uKpiiSKzPXeU7U/q4Ydn0Et6uzJV0FYHSGtG
        pjnIsllMbqEInT9/KlTYI/mEQ74rxHi6T/slV3rbOKFAOv7lWZya9r9bSfGrX/rJGHhNSP2rV62le
        8jygN6Vw==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxV-0008N7-Di; Thu, 06 Dec 2018 15:53:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 9/9] block: remove the cluster flag
Date:   Thu,  6 Dec 2018 07:52:58 -0800
Message-Id: <20181206155258.11465-10-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206155258.11465-1-hch@lst.de>
References: <20181206155258.11465-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that the the SCSI layer replaced the use of the cluster flag with
segment size limits and the DMA boundary we can remove the cluster
flag from the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c      | 18 +++++++-----------
 block/blk-settings.c   |  3 ---
 block/blk-sysfs.c      |  5 +----
 include/linux/blkdev.h |  6 ------
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6b5ad275ed56..4478d53cc6ee 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -194,7 +194,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			goto split;
 		}
 
-		if (bvprvp && blk_queue_cluster(q)) {
+		if (bvprvp) {
 			if (seg_size + bv.bv_len > queue_max_segment_size(q))
 				goto new_segment;
 			if (!biovec_phys_mergeable(q, bvprvp, &bv))
@@ -294,7 +294,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 					     bool no_sg_merge)
 {
 	struct bio_vec bv, bvprv = { NULL };
-	int cluster, prev = 0;
+	int prev = 0;
 	unsigned int seg_size, nr_phys_segs;
 	struct bio *fbio, *bbio;
 	struct bvec_iter iter;
@@ -312,7 +312,6 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	}
 
 	fbio = bio;
-	cluster = blk_queue_cluster(q);
 	seg_size = 0;
 	nr_phys_segs = 0;
 	for_each_bio(bio) {
@@ -324,7 +323,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 			if (no_sg_merge)
 				goto new_segment;
 
-			if (prev && cluster) {
+			if (prev) {
 				if (seg_size + bv.bv_len
 				    > queue_max_segment_size(q))
 					goto new_segment;
@@ -395,9 +394,6 @@ static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
 {
 	struct bio_vec end_bv = { NULL }, nxt_bv;
 
-	if (!blk_queue_cluster(q))
-		return 0;
-
 	if (bio->bi_seg_back_size + nxt->bi_seg_front_size >
 	    queue_max_segment_size(q))
 		return 0;
@@ -414,12 +410,12 @@ static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
 static inline void
 __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 		     struct scatterlist *sglist, struct bio_vec *bvprv,
-		     struct scatterlist **sg, int *nsegs, int *cluster)
+		     struct scatterlist **sg, int *nsegs)
 {
 
 	int nbytes = bvec->bv_len;
 
-	if (*sg && *cluster) {
+	if (*sg) {
 		if ((*sg)->length + nbytes > queue_max_segment_size(q))
 			goto new_segment;
 		if (!biovec_phys_mergeable(q, bvprv, bvec))
@@ -465,12 +461,12 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 {
 	struct bio_vec bvec, bvprv = { NULL };
 	struct bvec_iter iter;
-	int cluster = blk_queue_cluster(q), nsegs = 0;
+	int nsegs = 0;
 
 	for_each_bio(bio)
 		bio_for_each_segment(bvec, bio, iter)
 			__blk_segment_map_sg(q, &bvec, sglist, &bvprv, sg,
-					     &nsegs, &cluster);
+					     &nsegs);
 
 	return nsegs;
 }
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 696c04c1ab6c..9c8b62f8c180 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -109,7 +109,6 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->alignment_offset = 0;
 	lim->io_opt = 0;
 	lim->misaligned = 0;
-	lim->cluster = 1;
 	lim->zoned = BLK_ZONED_NONE;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
@@ -602,8 +601,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->io_min = max(t->io_min, b->io_min);
 	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
 
-	t->cluster &= b->cluster;
-
 	/* Physical block size a multiple of the logical block size? */
 	if (t->physical_block_size & (t->logical_block_size - 1)) {
 		t->physical_block_size = t->logical_block_size;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 844a454a7b3a..5144707f25ea 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -136,10 +136,7 @@ static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *
 
 static ssize_t queue_max_segment_size_show(struct request_queue *q, char *page)
 {
-	if (blk_queue_cluster(q))
-		return queue_var_show(queue_max_segment_size(q), (page));
-
-	return queue_var_show(PAGE_SIZE, (page));
+	return queue_var_show(queue_max_segment_size(q), (page));
 }
 
 static ssize_t queue_logical_block_size_show(struct request_queue *q, char *page)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4293dc1cd160..653ae90eec0b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -389,7 +389,6 @@ struct queue_limits {
 
 	unsigned char		misaligned;
 	unsigned char		discard_misaligned;
-	unsigned char		cluster;
 	unsigned char		raid_partial_stripes_expensive;
 	enum blk_zoned_model	zoned;
 };
@@ -785,11 +784,6 @@ static inline bool queue_is_rq_based(struct request_queue *q)
 	return q->request_fn || q->mq_ops;
 }
 
-static inline unsigned int blk_queue_cluster(struct request_queue *q)
-{
-	return q->limits.cluster;
-}
-
 static inline enum blk_zoned_model
 blk_queue_zoned_model(struct request_queue *q)
 {
-- 
2.19.1

