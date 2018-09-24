Return-Path: <BATV+afefc9c3360d6e01bea6+5510+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/10] block: add a missing BIOVEC_SEG_BOUNDARY check in bio_add_pc_page
Date: Mon, 24 Sep 2018 09:43:51 +0200
Message-Id: <20180924074355.2802-7-hch@lst.de>
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The actual recaculation of segments in __blk_recalc_rq_segments will
do this check, so there is no point in forcing it if we know it won't
succeed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 81d90b839e05..c254e5aa331f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -731,7 +731,9 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 	}
 
 	/* If we may be able to merge these biovecs, force a recount */
-	if (bio->bi_vcnt > 1 && biovec_phys_mergeable(bvec-1, bvec))
+	if (bio->bi_vcnt > 1 &&
+	    biovec_phys_mergeable(bvec - 1, bvec) &&
+	    BIOVEC_SEG_BOUNDARY(q, bvec - 1, bvec))
 		bio_clear_flag(bio, BIO_SEG_VALID);
 
  done:
-- 
2.19.0
