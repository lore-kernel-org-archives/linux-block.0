Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42664 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753451AbdHQUP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 16:15:28 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Akhil Bhansali <Akhil.Bhansali@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 12/55] skd: Remove set-but-not-used local variables
Date: Thu, 17 Aug 2017 13:12:55 -0700
Message-Id: <20170817201338.16537-13-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

These variables have been detected by building with W=1. Declare
'acc' as __maybe_unused because most access_ok() implementations
ignore their first argument. This patch does not change any
functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 5a88116efc97..ef7c0384e9a8 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -537,8 +537,6 @@ static void skd_request_fn(struct request_queue *q)
 	u32 lba;
 	u32 count;
 	int data_dir;
-	u32 be_lba;
-	u32 be_count;
 	u64 be_dmaa;
 	u64 cmdctxt;
 	u32 timo_slot;
@@ -676,8 +674,6 @@ static void skd_request_fn(struct request_queue *q)
 		cmd_ptr = &skmsg->msg_buf[skmsg->length];
 		memset(cmd_ptr, 0, 32);
 
-		be_lba = cpu_to_be32(lba);
-		be_count = cpu_to_be32(count);
 		be_dmaa = cpu_to_be64((u64)skreq->sksg_dma_address);
 		cmdctxt = skreq->id + SKD_ID_INCR;
 
@@ -889,7 +885,6 @@ static void skd_postop_sg_list(struct skd_device *skdev,
 static void skd_request_fn_not_online(struct request_queue *q)
 {
 	struct skd_device *skdev = q->queuedata;
-	int error;
 
 	SKD_ASSERT(skdev->state != SKD_DRVR_STATE_ONLINE);
 
@@ -919,7 +914,6 @@ static void skd_request_fn_not_online(struct request_queue *q)
 	case SKD_DRVR_STATE_FAULT:
 	case SKD_DRVR_STATE_DISAPPEARED:
 	default:
-		error = -EIO;
 		break;
 	}
 
@@ -943,7 +937,6 @@ static void skd_timer_tick(ulong arg)
 	struct skd_device *skdev = (struct skd_device *)arg;
 
 	u32 timo_slot;
-	u32 overdue_timestamp;
 	unsigned long reqflags;
 	u32 state;
 
@@ -976,8 +969,6 @@ static void skd_timer_tick(ulong arg)
 		goto timer_func_out;
 
 	/* Something is overdue */
-	overdue_timestamp = skdev->timeout_stamp - SKD_N_TIMEOUT_SLOT;
-
 	pr_debug("%s:%s:%d found %d timeouts, draining busy=%d\n",
 		 skdev->name, __func__, __LINE__,
 		 skdev->timeout_slot[timo_slot], skdev->in_flight);
@@ -1297,7 +1288,7 @@ static int skd_sg_io_get_and_check_args(struct skd_device *skdev,
 					struct skd_sg_io *sksgio)
 {
 	struct sg_io_hdr *sgp = &sksgio->sg;
-	int i, acc;
+	int i, __maybe_unused acc;
 
 	if (!access_ok(VERIFY_WRITE, sksgio->argp, sizeof(sg_io_hdr_t))) {
 		pr_debug("%s:%s:%d access sg failed %p\n",
-- 
2.14.0
