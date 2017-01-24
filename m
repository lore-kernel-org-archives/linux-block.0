Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34554 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdAXKSL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 05:18:11 -0500
Received: by mail-lf0-f42.google.com with SMTP id v186so108164563lfa.1
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 02:18:10 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/6] mmc: block: break out mmc_blk_rw_cmd_abort()
Date: Tue, 24 Jan 2017 11:17:52 +0100
Message-Id: <20170124101757.19676-2-linus.walleij@linaro.org>
In-Reply-To: <20170124101757.19676-1-linus.walleij@linaro.org>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As a first step toward breaking apart the very complex function
mmc_blk_issue_rw_rq() we break out the command abort code.
This code assumes "ret" is != 0 and then repeatedly hammers
blk_end_request() until the request to the block layer to end
the request succeeds.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7bd03381810d..14efe92a14ef 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1598,6 +1598,17 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 	return ret;
 }
 
+static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
+{
+	int ret = 1;
+
+	if (mmc_card_removed(card))
+		req->rq_flags |= RQF_QUIET;
+	while (ret)
+		ret = blk_end_request(req, -EIO,
+				      blk_rq_cur_bytes(req));
+}
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->blkdata;
@@ -1737,11 +1748,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	return 1;
 
  cmd_abort:
-	if (mmc_card_removed(card))
-		req->rq_flags |= RQF_QUIET;
-	while (ret)
-		ret = blk_end_request(req, -EIO,
-				blk_rq_cur_bytes(req));
+	mmc_blk_rw_cmd_abort(card, req);
 
  start_new_req:
 	if (rqc) {
-- 
2.9.3

