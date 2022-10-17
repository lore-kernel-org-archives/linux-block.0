Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6783C433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 02:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJQCAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJQCAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 22:00:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BEF248E0;
        Sun, 16 Oct 2022 19:00:20 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrKp14d6czmVCT;
        Mon, 17 Oct 2022 09:55:37 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:00:17 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shikemeng@huawei.com>
Subject: [PATCH 7/8] blk-iocost: Remove redundant initialization of struct ioc_gq
Date:   Mon, 17 Oct 2022 10:00:10 +0800
Message-ID: <20221017020011.25016-8-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221017020011.25016-1-shikemeng@huawei.com>
References: <20221017020011.25016-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some member of struct ioc_gq will not be accessed before it's
first activation and will be initialized again in it's first
activation after ioc_pd_init. To be more specific:
1)Member iocg->vtime and iocg->done_vtime will set to target in
activation which only expects vtime is equal to done_vtime in
first activation.
2)Member iocg->active_period will be set with ioc->cur_period
again in first activation.

Remove the redundant initialization to improve ioc_pd_init a
littile bit.

The parameter now of weight_updated will not be used if iocg is
not active, so pass NULL to weight_update here is safe and we
can remove call to ioc_now.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-iocost.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index fa90f471dfdc..4815e676733d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2946,16 +2946,10 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 	struct blkcg_gq *blkg = pd_to_blkg(&iocg->pd);
 	struct ioc *ioc = q_to_ioc(blkg->q);
-	struct ioc_now now;
 	struct blkcg_gq *tblkg;
 	unsigned long flags;
 
-	ioc_now(ioc, &now);
-
 	iocg->ioc = ioc;
-	atomic64_set(&iocg->vtime, now.vnow);
-	atomic64_set(&iocg->done_vtime, now.vnow);
-	atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
 	INIT_LIST_HEAD(&iocg->active_list);
 	INIT_LIST_HEAD(&iocg->walk_list);
 	INIT_LIST_HEAD(&iocg->surplus_list);
@@ -2974,7 +2968,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	}
 
 	spin_lock_irqsave(&ioc->lock, flags);
-	weight_updated(iocg, &now);
+	weight_updated(iocg, NULL);
 	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
-- 
2.30.0

