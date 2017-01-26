Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35208 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbdAZPEs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 10:04:48 -0500
Received: by mail-lf0-f43.google.com with SMTP id n124so146577060lfd.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 07:04:47 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6] mmc: block: rename rqc and req
Date: Thu, 26 Jan 2017 16:04:29 +0100
Message-Id: <20170126150433.14038-2-linus.walleij@linaro.org>
In-Reply-To: <20170126150433.14038-1-linus.walleij@linaro.org>
References: <20170126150433.14038-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In the function mmc_blk_issue_rw_rq() the new request coming in
from the block layer is called "rqc" and the old request that
was potentially just returned back from the asynchronous
mechanism is called "req".

This is really confusing when trying to analyze and understand
the code, it becomes a perceptual nightmare to me. Maybe others
have better parserheads but it is not working for me.

Rename "rqc" to "new_req" and "req" to "old_req" to reflect what
is semantically going on into the syntax.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 56 ++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8f91d7ddfc56..aaade079603e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1616,7 +1616,7 @@ static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
 	}
 }
 
-static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
+static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1624,24 +1624,24 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	int ret = 1, disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
 	struct mmc_queue_req *mq_rq;
-	struct request *req;
+	struct request *old_req;
 	struct mmc_async_req *new_areq;
 	struct mmc_async_req *old_areq;
 
-	if (!rqc && !mq->mqrq_prev->req)
+	if (!new_req && !mq->mqrq_prev->req)
 		return;
 
 	do {
-		if (rqc) {
+		if (new_req) {
 			/*
 			 * When 4KB native sector is enabled, only 8 blocks
 			 * multiple read or write is allowed
 			 */
 			if (mmc_large_sector(card) &&
-				!IS_ALIGNED(blk_rq_sectors(rqc), 8)) {
+				!IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
-					rqc->rq_disk->disk_name);
-				mmc_blk_rw_cmd_abort(card, rqc);
+					new_req->rq_disk->disk_name);
+				mmc_blk_rw_cmd_abort(card, new_req);
 				return;
 			}
 
@@ -1668,8 +1668,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		 */
 		mq_rq =	container_of(old_areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
-		req = mq_rq->req;
-		type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+		old_req = mq_rq->req;
+		type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 		mmc_queue_bounce_post(mq_rq);
 
 		switch (status) {
@@ -1680,7 +1680,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 */
 			mmc_blk_reset_success(md, type);
 
-			ret = blk_end_request(req, 0,
+			ret = blk_end_request(old_req, 0,
 					brq->data.bytes_xfered);
 
 			/*
@@ -1690,21 +1690,21 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 */
 			if (status == MMC_BLK_SUCCESS && ret) {
 				pr_err("%s BUG rq_tot %d d_xfer %d\n",
-				       __func__, blk_rq_bytes(req),
+				       __func__, blk_rq_bytes(old_req),
 				       brq->data.bytes_xfered);
-				mmc_blk_rw_cmd_abort(card, req);
+				mmc_blk_rw_cmd_abort(card, old_req);
 				return;
 			}
 			break;
 		case MMC_BLK_CMD_ERR:
-			ret = mmc_blk_cmd_err(md, card, brq, req, ret);
+			ret = mmc_blk_cmd_err(md, card, brq, old_req, ret);
 			if (mmc_blk_reset(md, card->host, type)) {
-				mmc_blk_rw_cmd_abort(card, req);
-				mmc_blk_rw_start_new(mq, card, rqc);
+				mmc_blk_rw_cmd_abort(card, old_req);
+				mmc_blk_rw_start_new(mq, card, new_req);
 				return;
 			}
 			if (!ret) {
-				mmc_blk_rw_start_new(mq, card, rqc);
+				mmc_blk_rw_start_new(mq, card, new_req);
 				return;
 			}
 			break;
@@ -1716,8 +1716,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		case MMC_BLK_ABORT:
 			if (!mmc_blk_reset(md, card->host, type))
 				break;
-			mmc_blk_rw_cmd_abort(card, req);
-			mmc_blk_rw_start_new(mq, card, rqc);
+			mmc_blk_rw_cmd_abort(card, old_req);
+			mmc_blk_rw_start_new(mq, card, new_req);
 			return;
 		case MMC_BLK_DATA_ERR: {
 			int err;
@@ -1726,8 +1726,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			if (!err)
 				break;
 			if (err == -ENODEV) {
-				mmc_blk_rw_cmd_abort(card, req);
-				mmc_blk_rw_start_new(mq, card, rqc);
+				mmc_blk_rw_cmd_abort(card, old_req);
+				mmc_blk_rw_start_new(mq, card, new_req);
 				return;
 			}
 			/* Fall through */
@@ -1736,7 +1736,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			if (brq->data.blocks > 1) {
 				/* Redo read one sector at a time */
 				pr_warn("%s: retrying using single block read\n",
-					req->rq_disk->disk_name);
+					old_req->rq_disk->disk_name);
 				disable_multi = 1;
 				break;
 			}
@@ -1745,22 +1745,22 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 * time, so we only reach here after trying to
 			 * read a single sector.
 			 */
-			ret = blk_end_request(req, -EIO,
+			ret = blk_end_request(old_req, -EIO,
 						brq->data.blksz);
 			if (!ret) {
-				mmc_blk_rw_start_new(mq, card, rqc);
+				mmc_blk_rw_start_new(mq, card, new_req);
 				return;
 			}
 			break;
 		case MMC_BLK_NOMEDIUM:
-			mmc_blk_rw_cmd_abort(card, req);
-			mmc_blk_rw_start_new(mq, card, rqc);
+			mmc_blk_rw_cmd_abort(card, old_req);
+			mmc_blk_rw_start_new(mq, card, new_req);
 			return;
 		default:
 			pr_err("%s: Unhandled return value (%d)",
-					req->rq_disk->disk_name, status);
-			mmc_blk_rw_cmd_abort(card, req);
-			mmc_blk_rw_start_new(mq, card, rqc);
+					old_req->rq_disk->disk_name, status);
+			mmc_blk_rw_cmd_abort(card, old_req);
+			mmc_blk_rw_start_new(mq, card, new_req);
 			return;
 		}
 
-- 
2.9.3

