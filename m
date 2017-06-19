Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: martin.petersen@oracle.com,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: stop using bio_data() in blk_write_same_mergeable
Date: Mon, 19 Jun 2017 09:24:41 +0200
Message-Id: <20170619072441.12835-3-hch@lst.de>
In-Reply-To: <20170619072441.12835-1-hch@lst.de>
References: <20170619072441.12835-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

While the Write Same page currently always is in low-level it is just
as easy and safer to just compare the page and offset directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index db2b7a7450bd..a61907438139 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -815,7 +815,8 @@ static inline bool rq_mergeable(struct request *rq)
 
 static inline bool blk_write_same_mergeable(struct bio *a, struct bio *b)
 {
-	if (bio_data(a) == bio_data(b))
+	if (bio_page(a) == bio_page(b) &&
+	    bio_offset(a) == bio_offset(b))
 		return true;
 
 	return false;
-- 
2.11.0
