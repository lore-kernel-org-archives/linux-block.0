Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32843 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdAXKSO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 05:18:14 -0500
Received: by mail-lf0-f48.google.com with SMTP id x1so21438761lff.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 02:18:13 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6] mmc: block: break out mmc_blk_rw_start_new()
Date: Tue, 24 Jan 2017 11:17:53 +0100
Message-Id: <20170124101757.19676-3-linus.walleij@linaro.org>
In-Reply-To: <20170124101757.19676-1-linus.walleij@linaro.org>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As a step toward breaking apart the very complex function
mmc_blk_issue_rw_rq() we break out the code to start a new
request.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 14efe92a14ef..b60d1fb3a07a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1609,6 +1609,22 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
 				      blk_rq_cur_bytes(req));
 }
 
+static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
+				 struct request *req)
+{
+	if (!req)
+		return;
+
+	if (mmc_card_removed(card)) {
+		req->rq_flags |= RQF_QUIET;
+		blk_end_request_all(req, -EIO);
+	} else {
+		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
+		mmc_start_req(card->host,
+			      &mq->mqrq_cur->mmc_active, NULL);
+	}
+}
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->blkdata;
@@ -1751,16 +1767,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	mmc_blk_rw_cmd_abort(card, req);
 
  start_new_req:
-	if (rqc) {
-		if (mmc_card_removed(card)) {
-			rqc->rq_flags |= RQF_QUIET;
-			blk_end_request_all(rqc, -EIO);
-		} else {
-			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-			mmc_start_req(card->host,
-				      &mq->mqrq_cur->mmc_active, NULL);
-		}
-	}
+	mmc_blk_rw_start_new(mq, card, rqc);
 
 	return 0;
 }
-- 
2.9.3

