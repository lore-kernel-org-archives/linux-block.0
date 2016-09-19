Return-Path: <Damien.LeMoal@hgst.com>
From: Damien Le Moal <damien.lemoal@hgst.com>
To: <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <martin.petersen@oracle.com>, <axboe@kernel.dk>, <hare@suse.de>,
	<shaun.tancheff@seagate.com>, Hannes Reinecke <hare@suse.com>, Damien Le Moal
	<damien.lemoal@hgst.com>
Subject: [PATCH 7/9] block: Add 'BLK_MQ_RQ_QUEUE_DONE' return value
Date: Tue, 20 Sep 2016 06:27:32 +0900
Message-ID: <1474320454-5264-8-git-send-email-damien.lemoal@hgst.com>
In-Reply-To: <1474320454-5264-1-git-send-email-damien.lemoal@hgst.com>
References: <1474320454-5264-1-git-send-email-damien.lemoal@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@hgst.com
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

Add a return value BLK_MQ_RQ_QUEUE_DONE to terminate a request
without error.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
---
 block/blk-mq.c          | 1 +
 drivers/scsi/scsi_lib.c | 3 +++
 include/linux/blk-mq.h  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 13f5a6c..6300629 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -851,6 +851,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 			pr_err("blk-mq: bad return on queue: %d\n", ret);
 		case BLK_MQ_RQ_QUEUE_ERROR:
 			rq->errors = -EIO;
+		case BLK_MQ_RQ_QUEUE_DONE:
 			blk_mq_end_request(rq, rq->errors);
 			break;
 		}
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f99504d..793b791 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1805,6 +1805,8 @@ static inline int prep_to_mq(int ret)
 		return 0;
 	case BLKPREP_DEFER:
 		return BLK_MQ_RQ_QUEUE_BUSY;
+	case BLKPREP_DONE:
+		return BLK_MQ_RQ_QUEUE_DONE;
 	default:
 		return BLK_MQ_RQ_QUEUE_ERROR;
 	}
@@ -1948,6 +1950,7 @@ out:
 			blk_mq_delay_queue(hctx, SCSI_QUEUE_DELAY);
 		break;
 	case BLK_MQ_RQ_QUEUE_ERROR:
+	case BLK_MQ_RQ_QUEUE_DONE:
 		/*
 		 * Make sure to release all allocated ressources when
 		 * we hit an error, as we will never see this command
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e43bbff..07b4888 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -153,6 +153,7 @@ enum {
 	BLK_MQ_RQ_QUEUE_OK	= 0,	/* queued fine */
 	BLK_MQ_RQ_QUEUE_BUSY	= 1,	/* requeue IO for later */
 	BLK_MQ_RQ_QUEUE_ERROR	= 2,	/* end IO with error */
+	BLK_MQ_RQ_QUEUE_DONE	= 3,	/* end IO w/o error */
 
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
