Return-Path: <BATV+a3f5f3e6054314e6ea5e+5058+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 6/9] block: guard bvec iteration logic
Date: Thu, 29 Jun 2017 11:31:13 -0700
Message-Id: <20170629183116.28685-7-hch@lst.de>
In-Reply-To: <20170629183116.28685-1-hch@lst.de>
References: <20170629183116.28685-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Dmitry Monakhov <dmonakhov@openvz.org>

Currently if some one try to advance bvec beyond it's size we simply
dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
This simply means that we endup dereferencing/corrupting random memory
region.

Sane reaction would be to propagate error back to calling context
But bvec_iter_advance's calling context is not always good for error
handling. For safity reason let truncate iterator size to zero which
will break external iteration loop which prevent us from unpredictable
memory range corruption. And even it caller ignores an error, it will
corrupt it's own bvecs, not others.

This patch does:
- Return error back to caller with hope that it will react on this
- Truncate iterator size

Code was added long time ago here 4550dd6c, luckily no one hit it
in real life :)

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
[hch: switch to true/false returns instead of errno values]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/blk.c |  3 ++-
 drivers/nvdimm/btt.c |  3 ++-
 include/linux/bio.h  |  4 +++-
 include/linux/bvec.h | 14 +++++++++-----
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 1a578b2a437b..345acca576b3 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -106,7 +106,8 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
 
 		len -= cur_len;
 		dev_offset += cur_len;
-		bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
+		if (!bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len))
+			return -EIO;
 	}
 
 	return err;
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index b5caaee78bbf..d00c10f382f0 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -985,7 +985,8 @@ static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
 
 		len -= cur_len;
 		meta_nsoff += cur_len;
-		bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
+		if (!bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len))
+			return -EIO;
 	}
 
 	return ret;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a3743b748a62..f27b22330ae7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -167,8 +167,10 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -= bytes;
-	else
+	else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 89b65b82d98f..de317b4c13c1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -22,6 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/errno.h>
 
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
@@ -66,12 +67,14 @@ struct bvec_iter {
 	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
 })
 
-static inline void bvec_iter_advance(const struct bio_vec *bv,
-				     struct bvec_iter *iter,
-				     unsigned bytes)
+static inline bool bvec_iter_advance(const struct bio_vec *bv,
+		struct bvec_iter *iter, unsigned bytes)
 {
-	WARN_ONCE(bytes > iter->bi_size,
-		  "Attempted to advance past end of bvec iter\n");
+	if (WARN_ONCE(bytes > iter->bi_size,
+		     "Attempted to advance past end of bvec iter\n")) {
+		iter->bi_size = 0;
+		return false;
+	}
 
 	while (bytes) {
 		unsigned iter_len = bvec_iter_len(bv, *iter);
@@ -86,6 +89,7 @@ static inline void bvec_iter_advance(const struct bio_vec *bv,
 			iter->bi_idx++;
 		}
 	}
+	return true;
 }
 
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
-- 
2.11.0
