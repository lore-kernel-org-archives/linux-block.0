Return-Path: <BATV+97b555f176c451e34851+5490+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/13] arm: remove the unused BIOVEC_MERGEABLE define
Date: Tue,  4 Sep 2018 12:14:19 -0700
Message-Id: <20180904191431.20102-2-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/io.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 2cfbc531f63b..6774553dc214 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -459,13 +459,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 
 #include <asm-generic/io.h>
 
-/*
- * can the hardware map this into one segment or not, given no other
- * constraints.
- */
-#define BIOVEC_MERGEABLE(vec1, vec2)	\
-	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
-
 struct bio_vec;
 extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 				      const struct bio_vec *vec2);
-- 
2.18.0
