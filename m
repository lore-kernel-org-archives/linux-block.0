Return-Path: <BATV+97b555f176c451e34851+5490+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/13] block: remove bvec_to_phys
Date: Tue,  4 Sep 2018 12:14:28 -0700
Message-Id: <20180904191431.20102-11-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We only use it in biovec_phys_mergeable and a m68k paravirt driver,
so just opencode it there.  Also remove the pointless unsigned long cast
for the offset in the opencoded instances.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index e903ce783624..58c030f727e9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -154,8 +154,8 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
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
index 8bec9f248ab8..fcb5f5618ed4 100644
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
2.18.0
