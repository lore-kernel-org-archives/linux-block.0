Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36266 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdAXKSX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 05:18:23 -0500
Received: by mail-lf0-f53.google.com with SMTP id z134so108127486lff.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 02:18:22 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/6] mmc: block: introduce new_areq and old_areq
Date: Tue, 24 Jan 2017 11:17:56 +0100
Message-Id: <20170124101757.19676-6-linus.walleij@linaro.org>
In-Reply-To: <20170124101757.19676-1-linus.walleij@linaro.org>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Recycling the same variable in an x=x+1 fashion may seem
clever here but it makes the code terse and hard to follow
for humans. Introduce a new_areq and old_areq variable so
we see what is going on.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4bbb3d16c09b..f3e0c778cdbd 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1631,7 +1631,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	enum mmc_blk_status status;
 	struct mmc_queue_req *mq_rq;
 	struct request *req;
-	struct mmc_async_req *areq;
+	struct mmc_async_req *new_areq;
+	struct mmc_async_req *old_areq;
 
 	if (!rqc && !mq->mqrq_prev->req)
 		return 0;
@@ -1651,11 +1652,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			}
 
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-			areq = &mq->mqrq_cur->mmc_active;
+			new_areq = &mq->mqrq_cur->mmc_active;
 		} else
-			areq = NULL;
-		areq = mmc_start_req(card->host, areq, &status);
-		if (!areq) {
+			new_areq = NULL;
+
+		old_areq = mmc_start_req(card->host, new_areq, &status);
+		if (!old_areq) {
 			/*
 			 * We have just put the first request into the pipeline
 			 * and there is nothing more to do until it is
@@ -1670,7 +1672,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		 * An asynchronous request has been completed and we proceed
 		 * to handle the result of it.
 		 */
-		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
+		mq_rq =	container_of(old_areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
 		req = mq_rq->req;
 		type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
-- 
2.9.3

