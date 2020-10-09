Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8AEC433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 03:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9AD2222E
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 03:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgJIDXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 23:23:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729318AbgJIDXa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 23:23:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 337152AA26C41366B099;
        Fri,  9 Oct 2020 11:23:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 11:23:23 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [RESEND PATCH v2 4/7] blk-mq: use helper function to test hw stopped
Date:   Thu, 8 Oct 2020 23:26:30 -0400
Message-ID: <20201009032633.83645-5-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201009032633.83645-1-yuyufen@huawei.com>
References: <20201009032633.83645-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have introduced helper function blk_mq_hctx_stopped() to test
BLK_MQ_S_STOPPED.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 47e4d5ce6196..d96292e36a23 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1783,7 +1783,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	/*
 	 * If we are stopped, don't run the queue.
 	 */
-	if (test_bit(BLK_MQ_S_STOPPED, &hctx->state))
+	if (blk_mq_hctx_stopped(hctx))
 		return;
 
 	__blk_mq_run_hw_queue(hctx);
-- 
2.25.4

