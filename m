Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 22/55] skd: Simplify the code for deciding whether or not to send a FIT msg
Date: Thu, 17 Aug 2017 13:13:05 -0700
Message-Id: <20170817201338.16537-23-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Due to the previous patch it is guaranteed that the FIT msg contains
at least one request after the for-loop has finished. Use this to
simplify the code.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index cbebaf4b0878..3fc6ec9477c7 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -693,36 +693,17 @@ static void skd_request_fn(struct request_queue *q)
 		/*
 		 * If the FIT msg buffer is full send it.
 		 */
-		if (skmsg->length >= SKD_N_FITMSG_BYTES ||
-		    fmh->num_protocol_cmds_coalesced >= skd_max_req_per_msg) {
+		if (fmh->num_protocol_cmds_coalesced >= skd_max_req_per_msg) {
 			skd_send_fitmsg(skdev, skmsg);
 			skmsg = NULL;
 			fmh = NULL;
 		}
 	}
 
-	/*
-	 * Is a FIT msg in progress? If it is empty put the buffer back
-	 * on the free list. If it is non-empty send what we got.
-	 * This minimizes latency when there are fewer requests than
-	 * what fits in a FIT msg.
-	 */
-	if (skmsg != NULL) {
-		/* Bigger than just a FIT msg header? */
-		if (skmsg->length > sizeof(struct fit_msg_hdr)) {
-			dev_dbg(&skdev->pdev->dev, "sending msg=%p, len %d\n",
-				skmsg, skmsg->length);
-			skd_send_fitmsg(skdev, skmsg);
-		} else {
-			/*
-			 * The FIT msg is empty. It means we got started
-			 * on the msg, but the requests were rejected.
-			 */
-			skmsg->state = SKD_MSG_STATE_IDLE;
-			skmsg->id += SKD_ID_INCR;
-			skmsg->next = skdev->skmsg_free_list;
-			skdev->skmsg_free_list = skmsg;
-		}
+	/* If the FIT msg buffer is not empty send what we got. */
+	if (skmsg) {
+		WARN_ON_ONCE(!fmh->num_protocol_cmds_coalesced);
+		skd_send_fitmsg(skdev, skmsg);
 		skmsg = NULL;
 		fmh = NULL;
 	}
-- 
2.14.0
