Return-Path: <Damien.LeMoal@hgst.com>
From: Damien Le Moal <damien.lemoal@hgst.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	Shaun Tancheff <shaun.tancheff@seagate.com>, Damien Le Moal
	<damien.lemoal@hgst.com>
Subject: [PATCH v2 4/7] block: Define zoned block device operations
Date: Mon, 26 Sep 2016 20:14:40 +0900
Message-ID: <1474888483-29762-5-git-send-email-damien.lemoal@hgst.com>
In-Reply-To: <1474888483-29762-1-git-send-email-damien.lemoal@hgst.com>
References: <1474888483-29762-1-git-send-email-damien.lemoal@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@hgst.com
List-ID: <linux-block@vger.kernel.org>

From: Shaun Tancheff <shaun.tancheff@seagate.com>

Define REQ_OP_ZONE_REPORT and REQ_OP_ZONE_RESET for handling zones of
host-managed and host-aware zoned block devices. With with these two
new operations, the total number of operations defined reaches 8 and
still fits with the 3 bits definition of REQ_OP_BITS.

Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
---
 block/blk-core.c          | 4 ++++
 include/linux/blk_types.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14d7c07..e4eda5d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1941,6 +1941,10 @@ generic_make_request_checks(struct bio *bio)
 	case REQ_OP_WRITE_SAME:
 		if (!bdev_write_same(bio->bi_bdev))
 			goto not_supported;
+	case REQ_OP_ZONE_REPORT:
+	case REQ_OP_ZONE_RESET:
+		if (!bdev_is_zoned(bio->bi_bdev))
+			goto not_supported;
 		break;
 	default:
 		break;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cd395ec..dd50dce 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -243,6 +243,8 @@ enum req_op {
 	REQ_OP_SECURE_ERASE,	/* request to securely erase sectors */
 	REQ_OP_WRITE_SAME,	/* write same block many times */
 	REQ_OP_FLUSH,		/* request for cache flush */
+	REQ_OP_ZONE_REPORT,	/* Get zone information */
+	REQ_OP_ZONE_RESET,	/* Reset a zone write pointer */
 };
 
 #define REQ_OP_BITS 3
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
