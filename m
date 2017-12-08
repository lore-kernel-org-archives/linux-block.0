Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753274AbdLHNPM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:12 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 04/10] block: bounce: avoid direct access to bvec table
Date: Fri,  8 Dec 2017 21:14:03 +0800
Message-Id: <20171208131409.11889-5-ming.lei@redhat.com>
In-Reply-To: <20171208131409.11889-1-ming.lei@redhat.com>
References: <20171208131409.11889-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We will support multipage bvecs in the future, so change to iterator way
for getting bv_page of bvec from original bio.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bounce.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index fceb1a96480b..0274c31d6c05 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -137,21 +137,20 @@ static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 static void bounce_end_io(struct bio *bio, mempool_t *pool)
 {
 	struct bio *bio_orig = bio->bi_private;
-	struct bio_vec *bvec, *org_vec;
+	struct bio_vec *bvec, orig_vec;
 	int i;
-	int start = bio_orig->bi_iter.bi_idx;
+	struct bvec_iter orig_iter = bio_orig->bi_iter;
 
 	/*
 	 * free up bounce indirect pages used
 	 */
 	bio_for_each_segment_all(bvec, bio, i) {
-		org_vec = bio_orig->bi_io_vec + i + start;
-
-		if (bvec->bv_page == org_vec->bv_page)
-			continue;
-
-		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
-		mempool_free(bvec->bv_page, pool);
+		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
+		if (bvec->bv_page != orig_vec.bv_page) {
+			dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
+			mempool_free(bvec->bv_page, pool);
+		}
+		bio_advance_iter(bio_orig, &orig_iter, orig_vec.bv_len);
 	}
 
 	bio_orig->bi_status = bio->bi_status;
-- 
2.9.5
