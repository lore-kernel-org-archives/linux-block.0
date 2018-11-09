Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 7/7] block: remove the BLKPREP_* values.
Date: Fri,  9 Nov 2018 14:42:41 +0100
Message-Id: <20181109134241.29346-8-hch@lst.de>
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9b1f470cc784..55597948868b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -778,16 +778,6 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 	return q->nr_requests;
 }
 
-/*
- * q->prep_rq_fn return values
- */
-enum {
-	BLKPREP_OK,		/* serve it */
-	BLKPREP_KILL,		/* fatal error, kill, return -EIO */
-	BLKPREP_DEFER,		/* leave on queue */
-	BLKPREP_INVALID,	/* invalid command, kill, return -EREMOTEIO */
-};
-
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 /*
-- 
2.19.1
