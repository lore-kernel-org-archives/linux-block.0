Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 50/51] block: enable multipage bvecs
Date: Mon, 26 Jun 2017 20:10:33 +0800
Message-Id: <20170626121034.3051-51-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

This patch pulls the trigger for multipage bvecs.

Now any request queue which supports queue cluster
will see multipage bvecs.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c460888f14b5..436305cde045 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -839,6 +839,11 @@ int bio_add_page(struct bio *bio, struct page *page,
 	 * a consecutive offset.  Optimize this special case.
 	 */
 	if (bio->bi_vcnt > 0) {
+		struct request_queue *q = NULL;
+
+		if (bio->bi_bdev)
+			q = bdev_get_queue(bio->bi_bdev);
+
 		bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page == bv->bv_page &&
@@ -846,6 +851,14 @@ int bio_add_page(struct bio *bio, struct page *page,
 			bv->bv_len += len;
 			goto done;
 		}
+
+		/* disable multipage bvec too if cluster isn't enabled */
+		if (q && blk_queue_cluster(q) &&
+		    (bvec_to_phys(bv) + bv->bv_len ==
+		     page_to_phys(page) + offset)) {
+			bv->bv_len += len;
+			goto done;
+		}
 	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
-- 
2.9.4
