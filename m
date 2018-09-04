Return-Path: <BATV+97b555f176c451e34851+5490+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/13] block: add a missing BIOVEC_SEG_BOUNDARY check in bio_add_pc_page
Date: Tue,  4 Sep 2018 12:14:26 -0700
Message-Id: <20180904191431.20102-9-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The actual recaculation of segments in __blk_recalc_rq_segments will
do this check, so there is no point in forcing it if we know it won't
succeed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 7f7230140b66..d15a228d1bfc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -729,7 +729,9 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 	}
 
 	/* If we may be able to merge these biovecs, force a recount */
-	if (bio->bi_vcnt > 1 && biovec_phys_mergeable(bvec-1, bvec))
+	if (bio->bi_vcnt > 1 &&
+	    biovec_phys_mergeable(bvec - 1, bvec) &&
+	    BIOVEC_SEG_BOUNDARY(q, bvec - 1, bvec))
 		bio_clear_flag(bio, BIO_SEG_VALID);
 
  done:
-- 
2.18.0
