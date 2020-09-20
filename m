Return-Path: <SRS0=iZfY=C5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30176C43465
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 09:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097FE2158C
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 09:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgITJOh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Sep 2020 05:14:37 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46992 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbgITJOf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 05:14:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U9TYh0l_1600593271;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U9TYh0l_1600593271)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 17:14:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] blk-throttle: Fix IO hang for a corner case
Date:   Sun, 20 Sep 2020 17:14:27 +0800
Message-Id: <605f98f527761d79dea4345976e57566c03afcd4.1600592693.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <a244c9973c6fc0081dba4142625840696b386a0f.1600592693.git.baolin.wang@linux.alibaba.com>
References: <a244c9973c6fc0081dba4142625840696b386a0f.1600592693.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
References: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It can not scale up in throtl_adjusted_limit() if we set bps or iops is
1, which will cause IO hang when enable low limit. Thus we should treat
1 as a illegal value to avoid this issue.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b0d8f7c..0649bce 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1687,13 +1687,13 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			goto out_finish;
 
 		ret = -EINVAL;
-		if (!strcmp(tok, "rbps"))
+		if (!strcmp(tok, "rbps") && val > 1)
 			v[0] = val;
-		else if (!strcmp(tok, "wbps"))
+		else if (!strcmp(tok, "wbps") && val > 1)
 			v[1] = val;
-		else if (!strcmp(tok, "riops"))
+		else if (!strcmp(tok, "riops") && val > 1)
 			v[2] = min_t(u64, val, UINT_MAX);
-		else if (!strcmp(tok, "wiops"))
+		else if (!strcmp(tok, "wiops") && val > 1)
 			v[3] = min_t(u64, val, UINT_MAX);
 		else if (off == LIMIT_LOW && !strcmp(tok, "idle"))
 			idle_time = val;
-- 
1.8.3.1

