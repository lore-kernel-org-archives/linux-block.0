Return-Path: <prvs=708eb8c04=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] block: Fix blk_rq_payload_bytes()
Date: Mon, 25 Jun 2018 17:10:07 -0700
Message-Id: <20180626001009.16557-2-bart.vanassche@wdc.com>
In-Reply-To: <20180626001009.16557-1-bart.vanassche@wdc.com>
References: <20180626001009.16557-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The SCSI sd driver converts a block layer request into a SCSI WRITE
SAME command in the following cases:
1. REQ_OP_DISCARD if the sd driver has been configured to translate
   this request type into WRITE SAME.
2. REQ_OP_WRITE_SAME.
The SCSI sd driver sets RQF_SPECIAL_PAYLOAD in case (1) but not in
case (2). Make sure that blk_rq_payload_bytes() handles both cases
correctly.

Fixes: 2e3258ecfaeb ("block: add blk_rq_payload_bytes")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dcf5e0990bfa..b7519a5c1002 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1091,15 +1091,19 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 /*
- * Some commands like WRITE SAME have a payload or data transfer size which
- * is different from the size of the request.  Any driver that supports such
- * commands using the RQF_SPECIAL_PAYLOAD flag needs to use this helper to
- * calculate the data transfer size.
+ * Some commands like DISCARD and WRITE SAME have a payload size which is
+ * different from the number of bytes affected on the storage medium. Any
+ * driver that supports such commands needs to use this helper to calculate
+ * the data buffer size.
  */
-static inline unsigned int blk_rq_payload_bytes(struct request *rq)
+static inline unsigned int blk_rq_payload_bytes(const struct request *rq)
 {
 	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
 		return rq->special_vec.bv_len;
+	if (req_op(rq) == REQ_OP_WRITE_SAME) {
+		WARN_ON_ONCE(rq->bio->bi_vcnt != 1);
+		return rq->bio->bi_io_vec->bv_len;
+	}
 	return blk_rq_bytes(rq);
 }
 
-- 
2.17.1
