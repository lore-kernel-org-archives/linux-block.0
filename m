Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDF1C83000
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 01:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F0B2070B
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 01:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgD2B3c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:29:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbgD2B3c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 21:29:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2E4526A54B010EB47AA9;
        Wed, 29 Apr 2020 09:29:30 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 09:29:23 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] blk-mq: make function '__blk_mq_sched_dispatch_requests' static
Date:   Wed, 29 Apr 2020 09:36:32 +0800
Message-ID: <20200429013632.38276-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix sparse warnings:

block/blk-mq-sched.c:209:5: warning: symbol '__blk_mq_sched_dispatch_requests' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 block/blk-mq-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 702ce525933c..fdcc2c1dd178 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -206,7 +206,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	return ret;
 }

-int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
--
2.26.0.106.g9fadedd

