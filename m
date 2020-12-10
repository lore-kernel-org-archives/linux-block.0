Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2CCC0018C
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B56323C82
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbgLJK5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:57:41 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49964 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389254AbgLJK5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:57:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UI8pCt1_1607597813;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UI8pCt1_1607597813)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Dec 2020 18:56:53 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-iocost: Use alloc_percpu_gfp() to simplify the code
Date:   Thu, 10 Dec 2020 18:56:45 +0800
Message-Id: <aa518c5b5c7185e660a1c8515c10d9513fe92132.1607591591.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use alloc_percpu_gfp() with __GFP_ZERO flag, which can remove
some explicit initialization code.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ac6078a..52ce2e3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2819,28 +2819,19 @@ static int blk_iocost_init(struct request_queue *q)
 {
 	struct ioc *ioc;
 	struct rq_qos *rqos;
-	int i, cpu, ret;
+	int ret;
+	gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
 
 	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
 	if (!ioc)
 		return -ENOMEM;
 
-	ioc->pcpu_stat = alloc_percpu(struct ioc_pcpu_stat);
+	ioc->pcpu_stat = alloc_percpu_gfp(struct ioc_pcpu_stat, gfp);
 	if (!ioc->pcpu_stat) {
 		kfree(ioc);
 		return -ENOMEM;
 	}
 
-	for_each_possible_cpu(cpu) {
-		struct ioc_pcpu_stat *ccs = per_cpu_ptr(ioc->pcpu_stat, cpu);
-
-		for (i = 0; i < ARRAY_SIZE(ccs->missed); i++) {
-			local_set(&ccs->missed[i].nr_met, 0);
-			local_set(&ccs->missed[i].nr_missed, 0);
-		}
-		local64_set(&ccs->rq_wait_ns, 0);
-	}
-
 	rqos = &ioc->rqos;
 	rqos->id = RQ_QOS_COST;
 	rqos->ops = &ioc_rqos_ops;
-- 
1.8.3.1

