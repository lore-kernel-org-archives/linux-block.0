Return-Path: <BATV+afefc9c3360d6e01bea6+5510+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/10] block: remove bvec_to_phys
Date: Mon, 24 Sep 2018 09:43:53 +0200
Message-Id: <20180924074355.2802-9-hch@lst.de>
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

We only use it in biovec_phys_mergeable and a m68k paravirt driver,
so just opencode it there.  Also remove the pointless unsigned long cast
for the offset in the opencoded instances.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/emu/nfblock.c | 2 +-
 block/blk.h             | 4 ++--
 include/linux/bio.h     | 5 -----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index e9110b9b8bcd..38049357d6d3 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -73,7 +73,7 @@ static blk_qc_t nfhd_make_request(struct request_queue *queue, struct bio *bio)
 		len = bvec.bv_len;
 		len >>= 9;
 		nfhd_read_write(dev->id, 0, dir, sec >> shift, len >> shift,
-				bvec_to_phys(&bvec));
+				page_to_phys(bvec.bv_page) + bvec.bv_offset);
 		sec += len;
 	}
 	bio_endio(bio);
diff --git a/block/blk.h b/block/blk.h
index 8f7229b6f63e..50f74ce60453 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -157,8 +157,8 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
 	unsigned long mask = queue_segment_boundary(q);
-	phys_addr_t addr1 = bvec_to_phys(vec1);
-	phys_addr_t addr2 = bvec_to_phys(vec2);
+	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
+	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
 
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9b580e1cb2e8..9ad4b0a487a4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -132,11 +132,6 @@ static inline bool bio_full(struct bio *bio)
 	return bio->bi_vcnt >= bio->bi_max_vecs;
 }
 
-/*
- * will die
- */
-#define bvec_to_phys(bv)	(page_to_phys((bv)->bv_page) + (unsigned long) (bv)->bv_offset)
-
 /*
  * drivers should _never_ use the all version - the bio may have been split
  * before it got to the driver and the driver won't own all of it
-- 
2.19.0
