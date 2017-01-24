Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:32907 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdAXKS0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 05:18:26 -0500
Received: by mail-lf0-f42.google.com with SMTP id x1so21441422lff.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 02:18:25 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/6] mmc: block: stop passing around pointless return values
Date: Tue, 24 Jan 2017 11:17:57 +0100
Message-Id: <20170124101757.19676-7-linus.walleij@linaro.org>
In-Reply-To: <20170124101757.19676-1-linus.walleij@linaro.org>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The mmc_blk_issue_rq() function is called in exactly one place
in queue.c and there the return value is ignored. So the
functions called from that function that also meticulously
return 0/1 do so for no good reason.

Error reporting on the asynchronous requests are done upward to
the block layer when the requests are eventually completed or
fail, which may happen during the flow of the mmc_blk_issue_*
functions directly (for "special commands") or later, when an
asynchronous read/write request is completed.

The issuing functions do not give rise to errors on their own,
and there is nothing to return back to the caller in queue.c.
Drop all return values and make the function return void.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 38 ++++++++++++++------------------------
 drivers/mmc/core/block.h |  2 +-
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f3e0c778cdbd..ede759dda395 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1149,7 +1149,7 @@ int mmc_access_rpmb(struct mmc_queue *mq)
 	return false;
 }
 
-static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1187,11 +1187,9 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 		mmc_blk_reset_success(md, type);
 fail:
 	blk_end_request(req, err, blk_rq_bytes(req));
-
-	return err ? 0 : 1;
 }
 
-static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
+static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 				       struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
@@ -1254,11 +1252,9 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 		mmc_blk_reset_success(md, type);
 out:
 	blk_end_request(req, err, blk_rq_bytes(req));
-
-	return err ? 0 : 1;
 }
 
-static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1269,8 +1265,6 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 		ret = -EIO;
 
 	blk_end_request_all(req, ret);
-
-	return ret ? 0 : 1;
 }
 
 /*
@@ -1622,7 +1616,7 @@ static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
 	}
 }
 
-static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
+static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1635,7 +1629,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct mmc_async_req *old_areq;
 
 	if (!rqc && !mq->mqrq_prev->req)
-		return 0;
+		return;
 
 	do {
 		if (rqc) {
@@ -1648,7 +1642,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
 					rqc->rq_disk->disk_name);
 				mmc_blk_rw_cmd_abort(card, rqc);
-				return 0;
+				return;
 			}
 
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
@@ -1665,7 +1659,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 */
 			if (status == MMC_BLK_NEW_REQUEST)
 				mq->flags |= MMC_QUEUE_NEW_REQUEST;
-			return 0;
+			return;
 		}
 
 		/*
@@ -1699,7 +1693,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				       __func__, blk_rq_bytes(req),
 				       brq->data.bytes_xfered);
 				mmc_blk_rw_cmd_abort(card, req);
-				return 0;
+				return;
 			}
 			break;
 		case MMC_BLK_CMD_ERR:
@@ -1767,18 +1761,16 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		}
 	} while (ret);
 
-	return 1;
+	return;
 
  cmd_abort:
 	mmc_blk_rw_cmd_abort(card, req);
 
  start_new_req:
 	mmc_blk_rw_start_new(mq, card, rqc);
-
-	return 0;
 }
 
-int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
+void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
 	int ret;
 	struct mmc_blk_data *md = mq->blkdata;
@@ -1794,7 +1786,6 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		if (req) {
 			blk_end_request_all(req, -EIO);
 		}
-		ret = 0;
 		goto out;
 	}
 
@@ -1803,19 +1794,19 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		/* complete ongoing async transfer before issuing discard */
 		if (card->host->areq)
 			mmc_blk_issue_rw_rq(mq, NULL);
-		ret = mmc_blk_issue_discard_rq(mq, req);
+		mmc_blk_issue_discard_rq(mq, req);
 	} else if (req && req_op(req) == REQ_OP_SECURE_ERASE) {
 		/* complete ongoing async transfer before issuing secure erase*/
 		if (card->host->areq)
 			mmc_blk_issue_rw_rq(mq, NULL);
-		ret = mmc_blk_issue_secdiscard_rq(mq, req);
+		mmc_blk_issue_secdiscard_rq(mq, req);
 	} else if (req && req_op(req) == REQ_OP_FLUSH) {
 		/* complete ongoing async transfer before issuing flush */
 		if (card->host->areq)
 			mmc_blk_issue_rw_rq(mq, NULL);
-		ret = mmc_blk_issue_flush(mq, req);
+		mmc_blk_issue_flush(mq, req);
 	} else {
-		ret = mmc_blk_issue_rw_rq(mq, req);
+		mmc_blk_issue_rw_rq(mq, req);
 	}
 
 out:
@@ -1827,7 +1818,6 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
 		 */
 		mmc_put_card(card);
-	return ret;
 }
 
 static inline int mmc_blk_readonly(struct mmc_card *card)
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 00b7483f2d6e..860ca7c8df86 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -4,6 +4,6 @@
 struct mmc_queue;
 struct request;
 
-int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
+void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
 
 #endif
-- 
2.9.3

