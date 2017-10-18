Return-Path: <BATV+33c0a560d8cf4f6c9bdc+5169+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 02/17] block: add REQ_DRV bit
Date: Wed, 18 Oct 2017 18:52:43 +0200
Message-Id: <20171018165258.23212-3-hch@lst.de>
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Set aside a bit in the request/bio flags for driver use.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/blk_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index acc2f3cdc2fc..7ec2ed097a8a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -229,6 +229,9 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
+	/* for driver use */
+	__REQ_DRV,
+
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -249,6 +252,8 @@ enum req_flag_bits {
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
+#define REQ_DRV			(1ULL << __REQ_DRV)
+
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
 
-- 
2.14.1
