Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5540FC04E87
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B3A2173C
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfEUHxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 03:53:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfEUHxo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 03:53:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 89015CEE3586053743CE;
        Tue, 21 May 2019 15:53:42 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 May 2019
 15:53:39 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <osandov@fb.com>, <ming.lei@redhat.com>
Subject: [PATCH 2/2] block: also check RQF_STATS in blk_mq_need_time_stamp()
Date:   Tue, 21 May 2019 15:59:04 +0800
Message-ID: <20190521075904.135060-3-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20190521075904.135060-1-houtao1@huawei.com>
References: <20190521075904.135060-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In __blk_mq_end_request() if block stats needs update, we should
ensure now is valid instead of 0 even when iostat is disabled.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4d1462172f0f..56425e392825 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -281,12 +281,12 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 EXPORT_SYMBOL(blk_mq_can_queue);
 
 /*
- * Only need start/end time stamping if we have stats enabled, or using
- * an IO scheduler.
+ * Only need start/end time stamping if we have iostat or
+ * blk stats enabled, or using an IO scheduler.
  */
 static inline bool blk_mq_need_time_stamp(struct request *rq)
 {
-	return (rq->rq_flags & RQF_IO_STAT) || rq->q->elevator;
+	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS)) || rq->q->elevator;
 }
 
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-- 
2.16.2.dirty

