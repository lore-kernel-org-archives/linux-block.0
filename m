Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26933 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdDCUyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 16:54:33 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Jens Axboe <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [PATCH] blk-mq: Remove blk_mq_queue_data.list
Date: Mon, 3 Apr 2017 20:54:30 +0000
Message-ID: <CY1PR0401MB15363601FA034CE8627DA41881080@CY1PR0401MB1536.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The block layer core sets blk_mq_queue_data.list but no block=0A=
drivers read that member. Hence remove it and also the code that=0A=
is used to set this member.=0A=
=0A=
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>=0A=
---=0A=
 block/blk-mq.c         | 17 -----------------=0A=
 include/linux/blk-mq.h |  1 -=0A=
 2 files changed, 18 deletions(-)=0A=
=0A=
diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
index 8fb983e6e2e4..b5580b09b4a5 100644=0A=
--- a/block/blk-mq.c=0A=
+++ b/block/blk-mq.c=0A=
@@ -984,17 +984,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hct=
x, struct list_head *list)=0A=
 {=0A=
 	struct request_queue *q =3D hctx->queue;=0A=
 	struct request *rq;=0A=
-	LIST_HEAD(driver_list);=0A=
-	struct list_head *dptr;=0A=
 	int errors, queued, ret =3D BLK_MQ_RQ_QUEUE_OK;=0A=
 =0A=
 	/*=0A=
-	 * Start off with dptr being NULL, so we start the first request=0A=
-	 * immediately, even if we have more pending.=0A=
-	 */=0A=
-	dptr =3D NULL;=0A=
-=0A=
-	/*=0A=
 	 * Now process all the entries, sending them to the driver.=0A=
 	 */=0A=
 	errors =3D queued =3D 0;=0A=
@@ -1026,7 +1018,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hc=
tx, struct list_head *list)=0A=
 		list_del_init(&rq->queuelist);=0A=
 =0A=
 		bd.rq =3D rq;=0A=
-		bd.list =3D dptr;=0A=
 =0A=
 		/*=0A=
 		 * Flag last if we have no more requests, or if we have more=0A=
@@ -1062,13 +1053,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *h=
ctx, struct list_head *list)=0A=
 =0A=
 		if (ret =3D=3D BLK_MQ_RQ_QUEUE_BUSY)=0A=
 			break;=0A=
-=0A=
-		/*=0A=
-		 * We've done the first request. If we have more than 1=0A=
-		 * left in the list, set dptr to defer issue.=0A=
-		 */=0A=
-		if (!dptr && list->next !=3D list->prev)=0A=
-			dptr =3D &driver_list;=0A=
 	}=0A=
 =0A=
 	hctx->dispatched[queued_to_index(queued)]++;=0A=
@@ -1451,7 +1435,6 @@ static void __blk_mq_try_issue_directly(struct reques=
t *rq, blk_qc_t *cookie,=0A=
 	struct request_queue *q =3D rq->q;=0A=
 	struct blk_mq_queue_data bd =3D {=0A=
 		.rq =3D rq,=0A=
-		.list =3D NULL,=0A=
 		.last =3D 1=0A=
 	};=0A=
 	struct blk_mq_hw_ctx *hctx;=0A=
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h=0A=
index ebeea36ff9cd..90af6a31458d 100644=0A=
--- a/include/linux/blk-mq.h=0A=
+++ b/include/linux/blk-mq.h=0A=
@@ -81,7 +81,6 @@ struct blk_mq_tag_set {=0A=
 =0A=
 struct blk_mq_queue_data {=0A=
 	struct request *rq;=0A=
-	struct list_head *list;=0A=
 	bool last;=0A=
 };=0A=
 =0A=
-- =0A=
2.12.0=0A=
=0A=
