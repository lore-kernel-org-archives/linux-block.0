Return-Path: <BATV+efe86d5870596b20d79e+5139+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/9] block: move REQ_NOWAIT
Date: Mon, 18 Sep 2017 16:14:46 -0700
Message-Id: <20170918231453.27128-3-hch@lst.de>
In-Reply-To: <20170918231453.27128-1-hch@lst.de>
References: <20170918231453.27128-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This flag should be before the operation-specific REQ_NOUNMAP bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a2d2aa709cef..acc2f3cdc2fc 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -224,11 +224,11 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
+	__REQ_NOWAIT,           /* Don't wait if request will block */
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	__REQ_NOWAIT,           /* Don't wait if request will block */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -245,9 +245,9 @@ enum req_flag_bits {
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
+#define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
-#define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
-- 
2.14.1
