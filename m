Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB0C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C244E61108
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJNFmz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 01:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhJNFmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 01:42:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273CC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 22:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7r10trWrIFSRHWaqwHrGxYFcpkGvl1i9cftra+pWWNU=; b=mVNQKN12pM8+3L2di1ospuzT06
        pDsfX42704gtXxl+h8L5UQswYZulvXC4Cq4/vYRLq9bVShc8R7fen2aKhrEhbKQk8amQqMfYUF9Kr
        3lHhva5H3vd1TTdSjuJ328PlUkpj/vBekSKT7Z360NIY/bOkgXgbkqMTJoo1eWJwORCk82DD9LC8/
        wnEuaJd+S5LKcVVG8ajHJEVRgU8GGnw+o2TNbf8dTpMShOzmXNIRypz5rJTf6kqIQt5EzySbihvuS
        +jQa1C4sG3W+XVzmAQe+sVloS62N1kX7bZpQq1qaoegsQ/WVEbbNSyGO/PPksBrEg8imWazOWaJAm
        kp9FTADA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1matRz-0083jE-M5; Thu, 14 Oct 2021 05:39:05 +0000
Date:   Thu, 14 Oct 2021 06:38:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: handle fast path of bio splitting inline
Message-ID: <YWfCY7LuCldVANXj@infradead.org>
References: <30045b11-0064-1849-5b10-f8fa05c6958d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30045b11-0064-1849-5b10-f8fa05c6958d@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 02:44:14PM -0600, Jens Axboe wrote:
> The fast path is no splitting needed. Separate the handling into a
> check part we can inline, and an out-of-line handling path if we do
> need to split.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

What about something like this version instead?

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9a55b50708293..f333afb45eb15 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -353,21 +353,6 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 				nr_segs);
 		break;
 	default:
-		/*
-		 * All drivers must accept single-segments bios that are <=
-		 * PAGE_SIZE.  This is a quick and dirty check that relies on
-		 * the fact that bi_io_vec[0] is always valid if a bio has data.
-		 * The check might lead to occasional false negatives when bios
-		 * are cloned, but compared to the performance impact of cloned
-		 * bios themselves the loop below doesn't matter anyway.
-		 */
-		if (!q->limits.chunk_sectors &&
-		    (*bio)->bi_vcnt == 1 &&
-		    ((*bio)->bi_io_vec[0].bv_len +
-		     (*bio)->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
-			*nr_segs = 1;
-			break;
-		}
 		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
 		break;
 	}
@@ -399,7 +384,8 @@ void blk_queue_split(struct bio **bio)
 {
 	unsigned int nr_segs;
 
-	__blk_queue_split(bio, &nr_segs);
+	if (blk_may_split(*bio))
+		__blk_queue_split(bio, &nr_segs);
 }
 EXPORT_SYMBOL(blk_queue_split);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 608b270a7f6b8..7c82e052ca83f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2251,11 +2251,12 @@ void blk_mq_submit_bio(struct bio *bio)
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct request *rq;
 	struct blk_plug *plug;
-	unsigned int nr_segs;
+	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
 	blk_queue_bounce(q, &bio);
-	__blk_queue_split(&bio, &nr_segs);
+	if (blk_may_split(bio))
+		__blk_queue_split(&bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
diff --git a/block/blk.h b/block/blk.h
index 0afee3e6a7c1e..34b31baf51324 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -262,6 +262,31 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
+static inline bool blk_may_split(struct bio *bio)
+{
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_WRITE_SAME:
+		return true; /* non-trivial splitting decisions */
+	default:
+		break;
+	}
+
+	/*
+	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
+	 * This is a quick and dirty check that relies on the fact that
+	 * bi_io_vec[0] is always valid if a bio has data.  The check might
+	 * lead to occasional false negatives when bios are cloned, but compared
+	 * to the performance impact of cloned bios themselves the loop below
+	 * doesn't matter anyway.
+	 */
+	return bio->bi_bdev->bd_disk->queue->limits.chunk_sectors ||
+		bio->bi_vcnt != 1 ||
+		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset >PAGE_SIZE;
+}
+
 void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
