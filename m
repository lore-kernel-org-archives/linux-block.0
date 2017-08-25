Return-Path: <prvs=403a468a2=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/4] skd: Remove SKD_ID_INCR
Date: Fri, 25 Aug 2017 14:24:14 -0700
Message-Id: <20170825212414.28322-5-bart.vanassche@wdc.com>
In-Reply-To: <20170825212414.28322-1-bart.vanassche@wdc.com>
References: <20170825212414.28322-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The SKD_ID_INCR flag in skd_request_context.id duplicates information
that is already available otherwise, e.g. through the block layer
request state and through skd_request_context.state. Hence remove
the code that manipulates this flag and also the flag itself.
Since skd_isr_completion_posted() only uses the lower bits of
skd_request_context.id as hardware tag, this patch does not change
the behavior of the skd driver. I'm referring to the following code:

    tag = req_id & SKD_ID_SLOT_AND_TABLE_MASK;

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 34188a600bfa..00a86252b3c5 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -89,7 +89,6 @@ MODULE_DESCRIPTION("STEC s1120 PCIe SSD block driver");
 	  sizeof(struct fit_comp_error_info)) * SKD_N_COMPLETION_ENTRY)
 
 /* 5 bits of uniqifier, 0xF800 */
-#define SKD_ID_INCR             (0x400)
 #define SKD_ID_TABLE_MASK       (3u << 8u)
 #define  SKD_ID_RW_REQUEST      (0u << 8u)
 #define  SKD_ID_INTERNAL        (1u << 8u)
@@ -921,9 +920,7 @@ static void skd_send_internal_skspcl(struct skd_device *skdev,
 		 */
 		return;
 
-	SKD_ASSERT((skspcl->req.id & SKD_ID_INCR) == 0);
 	skspcl->req.state = SKD_REQ_STATE_BUSY;
-	skspcl->req.id += SKD_ID_INCR;
 
 	scsi = &skspcl->msg_buf->scsi[0];
 	scsi->hdr.tag = skspcl->req.id;
@@ -1044,7 +1041,6 @@ static void skd_complete_internal(struct skd_device *skdev,
 
 	skspcl->req.completion = *skcomp;
 	skspcl->req.state = SKD_REQ_STATE_IDLE;
-	skspcl->req.id += SKD_ID_INCR;
 
 	status = skspcl->req.completion.status;
 
@@ -1451,7 +1447,6 @@ static void skd_release_skreq(struct skd_device *skdev,
 	 * Reclaim the skd_request_context
 	 */
 	skreq->state = SKD_REQ_STATE_IDLE;
-	skreq->id += SKD_ID_INCR;
 }
 
 static int skd_isr_completion_posted(struct skd_device *skdev,
-- 
2.14.1
