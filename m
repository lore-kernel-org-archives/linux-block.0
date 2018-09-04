Return-Path: <BATV+97b555f176c451e34851+5490+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/13] block: simplify BIOVEC_PHYS_MERGEABLE
Date: Tue,  4 Sep 2018 12:14:25 -0700
Message-Id: <20180904191431.20102-8-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Turn the macro into an inline, move it to blk.h and take the Xen check
into the core code instead of delegating it to architectures.

Also rename the function to biovec_phys_mergeable as there is no need
to shout.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/io.h   |  4 ----
 arch/arm64/include/asm/io.h |  4 ----
 arch/x86/include/asm/io.h   |  3 ---
 block/bio.c                 |  2 +-
 block/blk-integrity.c       |  4 ++--
 block/blk-merge.c           | 10 +++++-----
 block/blk.h                 | 11 +++++++++++
 drivers/xen/biomerge.c      |  2 +-
 include/linux/bio.h         | 13 -------------
 9 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 9855a4d48956..6ae7674da0d6 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -459,10 +459,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 
 #include <asm-generic/io.h>
 
-#define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
-	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
-	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
-
 #ifdef CONFIG_MMU
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 9bc620c44d32..18f6ae6a43f1 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -205,9 +205,5 @@ extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
 extern int devmem_is_allowed(unsigned long pfn);
 
-#define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
-	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
-	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
-
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_IO_H */
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 193dae6d9c45..232d8e9ee8a0 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -371,9 +371,6 @@ extern bool is_early_ioremap_ptep(pte_t *ptep);
 
 #ifdef CONFIG_XEN
 #include <xen/xen.h>
-#define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
-	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
-	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
 #endif	/* CONFIG_XEN */
 
 #define IO_SPACE_LIMIT 0xffff
diff --git a/block/bio.c b/block/bio.c
index b12966e415d3..7f7230140b66 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -729,7 +729,7 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 	}
 
 	/* If we may be able to merge these biovecs, force a recount */
-	if (bio->bi_vcnt > 1 && (BIOVEC_PHYS_MERGEABLE(bvec-1, bvec)))
+	if (bio->bi_vcnt > 1 && biovec_phys_mergeable(bvec-1, bvec))
 		bio_clear_flag(bio, BIO_SEG_VALID);
 
  done:
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 6121611e1316..0f7267916509 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -49,7 +49,7 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
 	bio_for_each_integrity_vec(iv, bio, iter) {
 
 		if (prev) {
-			if (!BIOVEC_PHYS_MERGEABLE(&ivprv, &iv))
+			if (!biovec_phys_mergeable(&ivprv, &iv))
 				goto new_segment;
 
 			if (!BIOVEC_SEG_BOUNDARY(q, &ivprv, &iv))
@@ -95,7 +95,7 @@ int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
 	bio_for_each_integrity_vec(iv, bio, iter) {
 
 		if (prev) {
-			if (!BIOVEC_PHYS_MERGEABLE(&ivprv, &iv))
+			if (!biovec_phys_mergeable(&ivprv, &iv))
 				goto new_segment;
 
 			if (!BIOVEC_SEG_BOUNDARY(q, &ivprv, &iv))
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ad8a226347a6..5e63e8259f92 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -21,7 +21,7 @@ static inline bool bios_segs_mergeable(struct request_queue *q,
 		struct bio *prev, struct bio_vec *prev_last_bv,
 		struct bio_vec *next_first_bv)
 {
-	if (!BIOVEC_PHYS_MERGEABLE(prev_last_bv, next_first_bv))
+	if (!biovec_phys_mergeable(prev_last_bv, next_first_bv))
 		return false;
 	if (!BIOVEC_SEG_BOUNDARY(q, prev_last_bv, next_first_bv))
 		return false;
@@ -199,7 +199,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		if (bvprvp && blk_queue_cluster(q)) {
 			if (seg_size + bv.bv_len > queue_max_segment_size(q))
 				goto new_segment;
-			if (!BIOVEC_PHYS_MERGEABLE(bvprvp, &bv))
+			if (!biovec_phys_mergeable(bvprvp, &bv))
 				goto new_segment;
 			if (!BIOVEC_SEG_BOUNDARY(q, bvprvp, &bv))
 				goto new_segment;
@@ -332,7 +332,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 				if (seg_size + bv.bv_len
 				    > queue_max_segment_size(q))
 					goto new_segment;
-				if (!BIOVEC_PHYS_MERGEABLE(&bvprv, &bv))
+				if (!biovec_phys_mergeable(&bvprv, &bv))
 					goto new_segment;
 				if (!BIOVEC_SEG_BOUNDARY(q, &bvprv, &bv))
 					goto new_segment;
@@ -414,7 +414,7 @@ static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
 	bio_get_last_bvec(bio, &end_bv);
 	bio_get_first_bvec(nxt, &nxt_bv);
 
-	if (!BIOVEC_PHYS_MERGEABLE(&end_bv, &nxt_bv))
+	if (!biovec_phys_mergeable(&end_bv, &nxt_bv))
 		return 0;
 
 	/*
@@ -439,7 +439,7 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 		if ((*sg)->length + nbytes > queue_max_segment_size(q))
 			goto new_segment;
 
-		if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
+		if (!biovec_phys_mergeable(bvprv, bvec))
 			goto new_segment;
 		if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
 			goto new_segment;
diff --git a/block/blk.h b/block/blk.h
index 63035c95689c..e36395e4c686 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
+#include <xen/xen.h>
 #include "blk-mq.h"
 
 /* Amount of time in which a process may batch requests */
@@ -149,6 +150,16 @@ static inline void blk_queue_enter_live(struct request_queue *q)
 	percpu_ref_get(&q->q_usage_counter);
 }
 
+static inline bool biovec_phys_mergeable(const struct bio_vec *vec1,
+		const struct bio_vec *vec2)
+{
+	if (bvec_to_phys(vec1) + vec1->bv_len != bvec_to_phys(vec2))
+		return false;
+	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2))
+		return false;
+	return true;
+}
+
 static inline bool __bvec_gap_to_prev(struct request_queue *q,
 		struct bio_vec *bprv, unsigned int offset)
 {
diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
index 399c4e30f723..f3fbb700f569 100644
--- a/drivers/xen/biomerge.c
+++ b/drivers/xen/biomerge.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bio.h>
-#include <linux/io.h>
 #include <linux/export.h>
+#include <xen/xen.h>
 #include <xen/page.h>
 
 bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 51371740d2a8..e3d0abb694d4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -140,19 +140,6 @@ static inline bool bio_full(struct bio *bio)
 /*
  * merge helpers etc
  */
-
-/* Default implementation of BIOVEC_PHYS_MERGEABLE */
-#define __BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
-	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
-
-/*
- * allow arch override, for eg virtualized architectures (put in asm/io.h)
- */
-#ifndef BIOVEC_PHYS_MERGEABLE
-#define BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
-	__BIOVEC_PHYS_MERGEABLE(vec1, vec2)
-#endif
-
 #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
 	(((addr1) | (mask)) == (((addr2) - 1) | (mask)))
 #define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
-- 
2.18.0
