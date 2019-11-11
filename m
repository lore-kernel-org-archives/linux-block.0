Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F56CC43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334DE2084F
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 07:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfKKHhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:37:23 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:48113 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfKKHhX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 02:37:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Thkqbn._1573457839;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0Thkqbn._1573457839)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Nov 2019 15:37:20 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH] iocost: treat as root level when parents are activated
Date:   Mon, 11 Nov 2019 15:37:18 +0800
Message-Id: <1573457838-121361-1-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Internal nodes that issued IOs are treated as root when leaves are
activated. However, leaf nodes can still be activated when internal
nodes are active, leaving the sum of hweights exceeds HWEIGHT_WHOLE.

I think we should also treat the leaf nodes as root while leaf-only
constraint broken.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a7ed434..d3ca6e8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1057,8 +1057,8 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	atomic64_set(&iocg->active_period, cur_period);
 
 	/* already activated or breaking leaf-only constraint? */
-	for (i = iocg->level; i > 0; i--)
-		if (!list_empty(&iocg->active_list))
+	for (i = iocg->level - 1; i > 0; i--)
+		if (!list_empty(&iocg->ancestors[i]->active_list))
 			goto fail_unlock;
 	if (iocg->child_active_sum)
 		goto fail_unlock;
-- 
1.8.3.1

