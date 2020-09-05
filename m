Return-Path: <SRS0=kuF4=CO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B46AC433E2
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A372074B
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 11:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgIEL1w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:27:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728472AbgIEL1e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Sep 2020 07:27:34 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 41F7DFADDC2DB11BBDDD;
        Sat,  5 Sep 2020 19:26:40 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 5 Sep 2020 19:26:29 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>, <hch@lst.de>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
Subject: [PATCH v2] blk-mq: call commit_rqs while list empty but error happen
Date:   Sat, 5 Sep 2020 19:25:56 +0800
Message-ID: <20200905112556.1735962-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Blk-mq should call commit_rqs once 'bd.last != true' and no more
request will come(so virtscsi can kick the virtqueue, e.g.). We already
do that in 'blk_mq_dispatch_rq_list/blk_mq_try_issue_list_directly' while
list not empty and 'queued > 0'. However, we can seen the same scene
once the last request in list call queue_rq and return error like
BLK_STS_IOERR which will not requeue the request, and lead that list
empty but need call commit_rqs too(Or the request for virtscsi will stay
timeout until other request kick virtqueue).

We found this problem by do fsstress test with offline/online virtscsi
device repeat quickly.

Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
Reported-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 block/blk-mq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

v1->v2: delete the comment

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3d2785eefe9..cdced4aca2e8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1412,6 +1412,11 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 
 	hctx->dispatched[queued_to_index(queued)]++;
 
+	/* If we didn't flush the entire list, we could have told the driver
+	 * there was more coming, but that turned out to be a lie.
+	 */
+	if ((!list_empty(list) || errors) && q->mq_ops->commit_rqs && queued)
+		q->mq_ops->commit_rqs(hctx);
 	/*
 	 * Any items that need requeuing? Stuff them into hctx->dispatch,
 	 * that is where we will continue on next queue run.
@@ -1425,14 +1430,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 
 		blk_mq_release_budgets(q, nr_budgets);
 
-		/*
-		 * If we didn't flush the entire list, we could have told
-		 * the driver there was more coming, but that turned out to
-		 * be a lie.
-		 */
-		if (q->mq_ops->commit_rqs && queued)
-			q->mq_ops->commit_rqs(hctx);
-
 		spin_lock(&hctx->lock);
 		list_splice_tail_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
@@ -2079,6 +2076,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
 	int queued = 0;
+	int errors = 0;
 
 	while (!list_empty(list)) {
 		blk_status_t ret;
@@ -2095,6 +2093,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				break;
 			}
 			blk_mq_end_request(rq, ret);
+			errors++;
 		} else
 			queued++;
 	}
@@ -2104,7 +2103,8 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 	 * the driver there was more coming, but that turned out to
 	 * be a lie.
 	 */
-	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs && queued)
+	if ((!list_empty(list) || errors) &&
+	     hctx->queue->mq_ops->commit_rqs && queued)
 		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
-- 
2.25.4

