Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE34BC4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 09:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77026138B
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 09:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhG0Jhi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 05:37:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3498 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbhG0Jhi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 05:37:38 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYrxm1wx6z6L9ks;
        Tue, 27 Jul 2021 17:25:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:37:37 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 10:37:35 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <osandov@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq-sched: Fix blk_mq_sched_alloc_tags() error handling
Date:   Tue, 27 Jul 2021 17:32:53 +0800
Message-ID: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the blk_mq_sched_alloc_tags() -> blk_mq_alloc_rqs() call fails, then we
call blk_mq_sched_free_tags() -> blk_mq_free_rqs().

It is incorrect to do so, as any rqs would have already been freed in the
blk_mq_alloc_rqs() call.

Fix by calling blk_mq_free_rq_map() only directly.

Fixes: 6917ff0b5bd41 ("blk-mq-sched: refactor scheduler initialization")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c838d81ac058..0f006cabfd91 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -515,17 +515,6 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 	percpu_ref_put(&q->q_usage_counter);
 }
 
-static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
-				   struct blk_mq_hw_ctx *hctx,
-				   unsigned int hctx_idx)
-{
-	if (hctx->sched_tags) {
-		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
-		blk_mq_free_rq_map(hctx->sched_tags, set->flags);
-		hctx->sched_tags = NULL;
-	}
-}
-
 static int blk_mq_sched_alloc_tags(struct request_queue *q,
 				   struct blk_mq_hw_ctx *hctx,
 				   unsigned int hctx_idx)
@@ -539,8 +528,10 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
 		return -ENOMEM;
 
 	ret = blk_mq_alloc_rqs(set, hctx->sched_tags, hctx_idx, q->nr_requests);
-	if (ret)
-		blk_mq_sched_free_tags(set, hctx, hctx_idx);
+	if (ret) {
+		blk_mq_free_rq_map(hctx->sched_tags, set->flags);
+		hctx->sched_tags = NULL;
+	}
 
 	return ret;
 }
-- 
2.26.2

