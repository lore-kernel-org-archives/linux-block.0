Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C043FC43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B94C2085A
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCQKCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfCQKCC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 06:02:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFF9F753CA;
        Sun, 17 Mar 2019 10:02:01 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4C6960F8D;
        Sun, 17 Mar 2019 10:01:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 07/10] block: enable multi-page bvec for passthrough IO
Date:   Sun, 17 Mar 2019 18:01:09 +0800
Message-Id: <20190317100112.8106-8-ming.lei@redhat.com>
In-Reply-To: <20190317100112.8106-1-ming.lei@redhat.com>
References: <20190317100112.8106-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 17 Mar 2019 10:02:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now block IO stack is basically ready for supporting multi-page bvec,
however it isn't enabled on passthrough IO.

One reason is that passthrough IO is dispatched to LLD directly and bio
split is bypassed, so the bio has to be built correctly for dispatch to
LLD from the beginning.

Implement multi-page support for passthrough IO by limitting each bvec
as block device's segment and applying all kinds of queue limit in
blk_add_pc_page(). Then we don't need to calculate segments any more for
passthrough IO any more, turns out code is simplified much.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 60 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4b37f5173c66..3564a57963fa 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -665,6 +665,27 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return true;
 }
 
+/*
+ * Check if the @page can be added to the current segment(@bv), and make
+ * sure to call it only if page_is_mergeable(@bv, @page) is true
+ */
+static bool can_add_page_to_seg(struct request_queue *q,
+		const struct bio_vec *bv, const struct page *page,
+		unsigned len, unsigned offset)
+{
+	unsigned long mask = queue_segment_boundary(q);
+	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
+	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
+
+	if ((addr1 | mask) != (addr2 | mask))
+		return false;
+
+	if (bv->bv_len + len > queue_max_segment_size(q))
+		return false;
+
+	return true;
+}
+
 /**
  *	__bio_add_pc_page	- attempt to add page to passthrough bio
  *	@q: the target queue
@@ -685,7 +706,6 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		bool put_same_page)
 {
-	int retried_segments = 0;
 	struct bio_vec *bvec;
 
 	/*
@@ -709,6 +729,7 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		    offset == bvec->bv_offset + bvec->bv_len) {
 			if (put_same_page)
 				put_page(page);
+ bvec_merge:
 			bvec->bv_len += len;
 			bio->bi_iter.bi_size += len;
 			goto done;
@@ -720,11 +741,18 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		 */
 		if (bvec_gap_to_prev(q, bvec, offset))
 			return 0;
+
+		if (page_is_mergeable(bvec, page, len, offset, false) &&
+				can_add_page_to_seg(q, bvec, page, len, offset))
+			goto bvec_merge;
 	}
 
 	if (bio_full(bio))
 		return 0;
 
+	if (bio->bi_phys_segments >= queue_max_segments(q))
+		return 0;
+
 	/*
 	 * setup the new entry, we might clear it again later if we
 	 * cannot add the page
@@ -734,38 +762,12 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	bvec->bv_len = len;
 	bvec->bv_offset = offset;
 	bio->bi_vcnt++;
-	bio->bi_phys_segments++;
 	bio->bi_iter.bi_size += len;
 
-	/*
-	 * Perform a recount if the number of segments is greater
-	 * than queue_max_segments(q).
-	 */
-
-	while (bio->bi_phys_segments > queue_max_segments(q)) {
-
-		if (retried_segments)
-			goto failed;
-
-		retried_segments = 1;
-		blk_recount_segments(q, bio);
-	}
-
-	/* If we may be able to merge these biovecs, force a recount */
-	if (bio->bi_vcnt > 1 && biovec_phys_mergeable(q, bvec - 1, bvec))
-		bio_clear_flag(bio, BIO_SEG_VALID);
-
  done:
+	bio->bi_phys_segments = bio->bi_vcnt;
+	bio_set_flag(bio, BIO_SEG_VALID);
 	return len;
-
- failed:
-	bvec->bv_page = NULL;
-	bvec->bv_len = 0;
-	bvec->bv_offset = 0;
-	bio->bi_vcnt--;
-	bio->bi_iter.bi_size -= len;
-	blk_recount_segments(q, bio);
-	return 0;
 }
 EXPORT_SYMBOL(__bio_add_pc_page);
 
-- 
2.9.5

