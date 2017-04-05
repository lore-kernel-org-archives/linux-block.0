Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com,
	agk@redhat.com,
	snitzer@redhat.com,
	shli@kernel.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: [PATCH 02/27] block: renumber REQ_OP_WRITE_ZEROES
Date: Wed,  5 Apr 2017 16:21:40 +0200
Message-Id: <20170405142205.6477-3-hch@lst.de>
In-Reply-To: <20170405142205.6477-1-hch@lst.de>
References: <20170405142205.6477-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Make life easy for implementations that needs to send a data buffer
to the device (e.g. SCSI) by numbering it as a data out command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 67bcf8a5326e..4eae30bfbfca 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -168,7 +168,7 @@ enum req_opf {
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
 	/* write the zero filled sector many times */
-	REQ_OP_WRITE_ZEROES	= 8,
+	REQ_OP_WRITE_ZEROES	= 9,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
-- 
2.11.0
