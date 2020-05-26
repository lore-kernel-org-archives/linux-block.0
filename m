Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46E1C433DF
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 01:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83B0207D8
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 01:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbgEZBym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 21:54:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388288AbgEZByl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 21:54:41 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 72725EB45FFA29ED8126;
        Tue, 26 May 2020 09:54:40 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 09:54:39 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Subject: [PATCH] block: account flush request in inflight sysfs files
Date:   Tue, 26 May 2020 10:01:39 +0800
Message-ID: <20200526020139.21464-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So sysfs files which show the number of inflight IOs
(e.g. /sys/block/xxx/inflight) will account the flush
request. It's specially useful for debugging purpose
when the completion of flush request is slow, but
the containing request is fast.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-flush.c |  1 +
 block/blk-mq.c    | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c7f396e3d5e2..14606f1e9273 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -329,6 +329,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->rq_disk = first_rq->rq_disk;
+	flush_rq->part = first_rq->part;
 	flush_rq->end_io = flush_end_io;
 
 	blk_flush_queue_rq(flush_rq, false);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a7785df2c944..1ed420a9a316 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -96,14 +96,22 @@ struct mq_inflight {
 	unsigned int inflight[2];
 };
 
+static inline int op_is_write_or_flush(unsigned int op)
+{
+	return op_is_write(op) || op == REQ_OP_FLUSH;
+}
+
 static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 				  struct request *rq, void *priv,
 				  bool reserved)
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part)
-		mi->inflight[rq_data_dir(rq)]++;
+	if (rq->part == mi->part) {
+		int rw = op_is_write_or_flush(req_op(rq));
+
+		mi->inflight[rw]++;
+	}
 
 	return true;
 }
-- 
2.25.0.4.g0ad7144999

