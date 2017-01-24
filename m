Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36233 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdAXKSR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 05:18:17 -0500
Received: by mail-lf0-f46.google.com with SMTP id z134so108126192lff.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 02:18:16 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/6] mmc: block: do not assign mq_rq when aborting command
Date: Tue, 24 Jan 2017 11:17:54 +0100
Message-Id: <20170124101757.19676-4-linus.walleij@linaro.org>
In-Reply-To: <20170124101757.19676-1-linus.walleij@linaro.org>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The code in mmc_blk_issue_rq_rq() aborts a command if the request
is not properly aligned on large sectors. As part of the path
jumping out, it assigns the local variable mq_rq reflecting
a MMC queue request to the current MMC queue request, which is
confusing since the variable is not used after this jump.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b60d1fb3a07a..13e6fe060f26 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1649,7 +1649,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				!IS_ALIGNED(blk_rq_sectors(rqc), 8)) {
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
 					rqc->rq_disk->disk_name);
-				mq_rq = mq->mqrq_cur;
 				req = rqc;
 				rqc = NULL;
 				goto cmd_abort;
-- 
2.9.3

