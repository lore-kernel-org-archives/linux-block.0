Return-Path: <SRS0=iZfY=C5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2709CC43465
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 09:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F289720672
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 09:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgITJKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Sep 2020 05:10:34 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51474 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgITJKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 05:10:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U9TYg8J_1600593031;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U9TYg8J_1600593031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 17:10:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] blk-throttle: Remove a meaningless parameter for throtl_downgrade_state()
Date:   Sun, 20 Sep 2020 17:10:18 +0800
Message-Id: <fe8fb1acbcfaf5bd9b38787f8c7cc4ae5a301ae9.1600592693.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
References: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
References: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The throtl_downgrade_state() is always used to change to LIMIT_LOW
limitation, thus remove the latter meaningless parameter which
indicates the limitation index.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 36ba61c..4007b26 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1970,7 +1970,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	queue_work(kthrotld_workqueue, &td->dispatch_work);
 }
 
-static void throtl_downgrade_state(struct throtl_data *td, int new)
+static void throtl_downgrade_state(struct throtl_data *td)
 {
 	td->scale /= 2;
 
@@ -1980,7 +1980,7 @@ static void throtl_downgrade_state(struct throtl_data *td, int new)
 		return;
 	}
 
-	td->limit_index = new;
+	td->limit_index = LIMIT_LOW;
 	td->low_downgrade_time = jiffies;
 }
 
@@ -2067,7 +2067,7 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 	 * cgroups
 	 */
 	if (throtl_hierarchy_can_downgrade(tg))
-		throtl_downgrade_state(tg->td, LIMIT_LOW);
+		throtl_downgrade_state(tg->td);
 
 	tg->last_bytes_disp[READ] = 0;
 	tg->last_bytes_disp[WRITE] = 0;
-- 
1.8.3.1

