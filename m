Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C59C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F2064EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhBBFiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:38:10 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8090 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhBBFiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244290; x=1643780290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3l4UcK4KfI5R3RyjBTsVpzeqWQLuT2XH/48XL/4l/s=;
  b=ckYGFa8HFJ6CNvL8k2IQgp2H+8M4STGb17Sac8rkcOXxIYMKogTJBlft
   yeGb73V+3sSYGN+2UHdYHzXFX0PgvfplUeAHu17ilcHM6sObngPyh1cuT
   U7zdMZAG21MTj/up6QQPy++mNh/JNDa3RLHPwl9pzyHhigDIEVJtLkLSv
   iE9wJvXCjOBG8dKFImv1+UTwHGgJhhw7vFRRDaRrrLQtycg1b6wdju6WM
   wE+Ed+NGM1EY4sCFMm9Mw+UIu5EVXCQLPeZBeGwwtGPYGEJep6cc0nBBx
   GoYDh2+9Z+JEE6Sv/a14XfWe8PZ07JJZR8udcR06WD4M1U1/e8sQfhElp
   g==;
IronPort-SDR: xQIOLm8heO2AyoMiiJ5a4ZsmcrUVGQ5idxrFfcA7si2HArAxGTmCKeovQp2ygg2yFc/G9Cah0l
 jY2vOw4PUq7KNuf51Bl4pkg32Ge09Q6GUYed9CJBSEFrei6jBSeM7WRFmMg32mkoYvJjh4zPuX
 mChiNzoMFP/kRuxZ9oSvtYNvhRPLjOBE3R3suTxylj3zn4LMwlRkZ8xZxFctEBDUEWj4O7Grmf
 Y9rf1/2SvhXi/ImGrB1ostFQE+weKsZz90/oXk3nVLME9qYLXlYqgxtXzH2HfhpZBJs3INIrDb
 e0s=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160067153"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:37:05 +0800
IronPort-SDR: t+XFUycY1WtLI2BSkqDPi7Jk8t6GV52Gnb0qTqvGRoeSUdIg7KinohQjzAmEuTtOLztBelbzR2
 wSKy5tf/aHlD8OHJVklHymRRkh1HiPWxYREn22npVs5qEiqwBiCJiV4YOHziQuIuO0MvvKksd2
 b2jA7pHkouEDalPp3dlkOp8uGfANAkRSbpDeaL1JqwdfDfJBMI8WRADqfoaZLkQss5YVstlcOH
 SmNUU91ZYnuz01b5Jn5c6SIU8GpeZLhf2N/eW0Gx5+vZwhtC3ZHCccNesHZCd+Hj6u9C1DSECJ
 UX5C8x01EUC/W7rnDCnL5Q1k
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:19:13 -0800
IronPort-SDR: pRwzTFY4tW2qX7Z1LUpQzPDTTeYjkv/ZYrcCchQi3N7g0HB30Z8ec6xV1PrVpD8AeKfa1LWIYC
 HeVL+afdYGjBTWizeliGYZMPFMBYtK22CQbfNGw0yAsYk9Ug3tbwrehQngXYJEVYNCy1VCI0Ed
 eycz5E91lPOq7Wsy9xURA7f2O5WKD2fzsZd/PR0jAat4xkOQe5jMMy4ZFpFvgY4iduq/liMx4B
 7q/vFDiRadLYk/Yj2vVG/Jg+KfHe42YRaqtKtTNJ/9Mx8p9b1FKK5GxyvcJX+qletjdpwLnHla
 P/Y=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:37:04 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 09/20] loop: remove extra variable in lo_fallocate()
Date:   Mon,  1 Feb 2021 21:35:41 -0800
Message-Id: <20210202053552.4844-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable q is used to pass it to the blk_queue_discard(). We
can get away with using lo->lo_queue instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b0a8d5b0641f..f9f352c7a56f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -434,12 +434,11 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * information.
 	 */
 	struct file *file = lo->lo_backing_file;
-	struct request_queue *q = lo->lo_queue;
 	int ret;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!blk_queue_discard(q)) {
+	if (!blk_queue_discard(lo->lo_queue)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.22.1

