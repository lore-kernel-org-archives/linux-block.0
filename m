Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752587AbdFZMPe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:15:34 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 16/51] block: bounce: avoid direct access to bvec table
Date: Mon, 26 Jun 2017 20:09:59 +0800
Message-Id: <20170626121034.3051-17-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We will support multipage bvecs in the future, so change to
iterator way for getting bv_page of bvec from original bio.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bounce.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 916ee9a9a216..4eea1b2d8618 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -135,21 +135,22 @@ static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
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
+		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
+		if (bvec->bv_page == orig_vec.bv_page)
+			goto next;
 
 		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
 		mempool_free(bvec->bv_page, pool);
+ next:
+		bio_advance_iter(bio_orig, &orig_iter, orig_vec.bv_len);
 	}
 
 	bio_orig->bi_status = bio->bi_status;
-- 
2.9.4
