Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32874 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdAXKSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 05:18:20 -0500
Received: by mail-lf0-f46.google.com with SMTP id x1so21440045lff.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 02:18:19 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/6] mmc: block: inline command abortions
Date: Tue, 24 Jan 2017 11:17:55 +0100
Message-Id: <20170124101757.19676-5-linus.walleij@linaro.org>
In-Reply-To: <20170124101757.19676-1-linus.walleij@linaro.org>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Setting rqc to NULL followed by a goto to cmd_abort is just a way
to do unconditional abort without starting any new command.
Inline the calls to mmc_blk_rw_cmd_abort() and return immediately
in those cases.

As a result, mmc_blk_rw_start_new() is not called with NULL
requests, and we can remove the NULL check in the beginning of
this function.

Add some comments to the code flow so it is clear that this is
where the asynchronous requests come back in and the result of
them gets handled.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 13e6fe060f26..4bbb3d16c09b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1612,9 +1612,6 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
 static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
 				 struct request *req)
 {
-	if (!req)
-		return;
-
 	if (mmc_card_removed(card)) {
 		req->rq_flags |= RQF_QUIET;
 		blk_end_request_all(req, -EIO);
@@ -1649,9 +1646,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				!IS_ALIGNED(blk_rq_sectors(rqc), 8)) {
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
 					rqc->rq_disk->disk_name);
-				req = rqc;
-				rqc = NULL;
-				goto cmd_abort;
+				mmc_blk_rw_cmd_abort(card, rqc);
+				return 0;
 			}
 
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
@@ -1660,11 +1656,20 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			areq = NULL;
 		areq = mmc_start_req(card->host, areq, &status);
 		if (!areq) {
+			/*
+			 * We have just put the first request into the pipeline
+			 * and there is nothing more to do until it is
+			 * complete.
+			 */
 			if (status == MMC_BLK_NEW_REQUEST)
 				mq->flags |= MMC_QUEUE_NEW_REQUEST;
 			return 0;
 		}
 
+		/*
+		 * An asynchronous request has been completed and we proceed
+		 * to handle the result of it.
+		 */
 		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
 		req = mq_rq->req;
@@ -1691,8 +1696,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				pr_err("%s BUG rq_tot %d d_xfer %d\n",
 				       __func__, blk_rq_bytes(req),
 				       brq->data.bytes_xfered);
-				rqc = NULL;
-				goto cmd_abort;
+				mmc_blk_rw_cmd_abort(card, req);
+				return 0;
 			}
 			break;
 		case MMC_BLK_CMD_ERR:
-- 
2.9.3

