Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93881C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 13:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C33220823
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 13:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbfCZNPJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:15:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfCZNPJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 09:15:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 57AF57A79E6876CB4A47;
        Tue, 26 Mar 2019 21:15:07 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 21:15:05 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <osandov@fb.com>, <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: add trace block plug and unplug for multiple queues
Date:   Tue, 26 Mar 2019 21:19:25 +0800
Message-ID: <20190326131925.60255-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For now, we just trace plug for single queue device or drivers
provide .commit_rqs, and have not trace plug for multiple queues
device. But, unplug events will be recorded when call
blk_mq_flush_plug_list(). Then, trace events will be asymmetrical,
just have unplug and without plug.

This patch add trace plug and unplug for multiple queues device in
blk_mq_make_request(). After that, we can accurately trace plug and
unplug for multiple queues.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5486c7d8b408..4aa673a6d285 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1987,11 +1987,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			plug->rq_count--;
 		}
 		blk_add_rq_to_plug(plug, rq);
+		trace_block_plug(q);
 
 		blk_mq_put_ctx(data.ctx);
 
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
+			trace_block_unplug(q, 1, true);
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie, false, true);
 		}
-- 
2.16.2.dirty

