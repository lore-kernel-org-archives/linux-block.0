Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35252 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbdAZPE4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 10:04:56 -0500
Received: by mail-lf0-f46.google.com with SMTP id n124so146579125lfd.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 07:04:55 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/6] mmc: block: refactor mmc_blk_rw_try_restart()
Date: Thu, 26 Jan 2017 16:04:31 +0100
Message-Id: <20170126150433.14038-4-linus.walleij@linaro.org>
In-Reply-To: <20170126150433.14038-1-linus.walleij@linaro.org>
References: <20170126150433.14038-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The mmc_blk_rw_start_new() was named after the label inside
mmc_blk_issue_rw_rq() but is really a confusing name for this
function: what it does is to try to restart the latest issued
command on the host and card of the current MMC queue.

So rename it mmc_blk_rw_try_restart() that reflects what it
is doing and at this point also refactore the function to
treat the removed card as an exception and just exit if this
happens and run on in the function if that is not happening.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index de9200470c13..14c33f57776c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1603,17 +1603,24 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
 				      blk_rq_cur_bytes(req));
 }
 
-static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
-				 struct request *req)
+/**
+ * mmc_blk_rw_try_restart() - tries to restart the current async request
+ * @mq: the queue with the card and host to restart
+ * @req: a new request that want to be started after the current one
+ */
+static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req)
 {
-	if (mmc_card_removed(card)) {
+	/*
+	 * If the card was removed, just cancel everything and return.
+	 */
+	if (mmc_card_removed(mq->card)) {
 		req->rq_flags |= RQF_QUIET;
 		blk_end_request_all(req, -EIO);
-	} else {
-		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-		mmc_start_areq(card->host,
-			       &mq->mqrq_cur->mmc_active, NULL);
+		return;
 	}
+	/* Else proceed and try to restart the current async request */
+	mmc_blk_rw_rq_prep(mq->mqrq_cur, mq->card, 0, mq);
+	mmc_start_areq(mq->card->host, &mq->mqrq_cur->mmc_active, NULL);
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
@@ -1700,11 +1707,11 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			ret = mmc_blk_cmd_err(md, card, brq, old_req, ret);
 			if (mmc_blk_reset(md, card->host, type)) {
 				mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_start_new(mq, card, new_req);
+				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
 			if (!ret) {
-				mmc_blk_rw_start_new(mq, card, new_req);
+				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
 			break;
@@ -1717,7 +1724,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			if (!mmc_blk_reset(md, card->host, type))
 				break;
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_start_new(mq, card, new_req);
+			mmc_blk_rw_try_restart(mq, new_req);
 			return;
 		case MMC_BLK_DATA_ERR: {
 			int err;
@@ -1727,7 +1734,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 				break;
 			if (err == -ENODEV) {
 				mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_start_new(mq, card, new_req);
+				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
 			/* Fall through */
@@ -1748,19 +1755,19 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			ret = blk_end_request(old_req, -EIO,
 						brq->data.blksz);
 			if (!ret) {
-				mmc_blk_rw_start_new(mq, card, new_req);
+				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
 			break;
 		case MMC_BLK_NOMEDIUM:
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_start_new(mq, card, new_req);
+			mmc_blk_rw_try_restart(mq, new_req);
 			return;
 		default:
 			pr_err("%s: Unhandled return value (%d)",
 					old_req->rq_disk->disk_name, status);
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_start_new(mq, card, new_req);
+			mmc_blk_rw_try_restart(mq, new_req);
 			return;
 		}
 
-- 
2.9.3

