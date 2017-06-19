Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: martin.petersen@oracle.com,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove the unused bio_to_phys macro
Date: Mon, 19 Jun 2017 09:24:40 +0200
Message-Id: <20170619072441.12835-2-hch@lst.de>
In-Reply-To: <20170619072441.12835-1-hch@lst.de>
References: <20170619072441.12835-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 40d054185277..83f9edb39d3f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -118,7 +118,6 @@ static inline void *bio_data(struct bio *bio)
 /*
  * will die
  */
-#define bio_to_phys(bio)	(page_to_phys(bio_page((bio))) + (unsigned long) bio_offset((bio)))
 #define bvec_to_phys(bv)	(page_to_phys((bv)->bv_page) + (unsigned long) (bv)->bv_offset)
 
 /*
-- 
2.11.0
