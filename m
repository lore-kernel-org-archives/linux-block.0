Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CEC433E6
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D4364E68
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCACKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 21:10:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13009 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhCACKs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 21:10:48 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DpkFM0MYhzjTZY;
        Mon,  1 Mar 2021 10:08:23 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Mar 2021
 10:09:54 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <josef@toxicpanda.com>, <ming.lei@redhat.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <yuyufen@huawei.com>
Subject: [RFC PATCH 2/2] blk-mq: blk_mq_tag_to_rq() always return null for sched_tags
Date:   Sun, 28 Feb 2021 21:14:44 -0500
Message-ID: <20210301021444.4134047-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210301021444.4134047-1-yuyufen@huawei.com>
References: <20210301021444.4134047-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We just set hctx->tags->rqs[tag] when get driver tag, but will
not set hctx->sched_tags->rqs[tag] when get sched tag.
So, blk_mq_tag_to_rq() always return NULL for sched_tags.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5362a7958b74..424afe112b58 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -846,6 +846,7 @@ static int blk_mq_test_tag_bit(struct blk_mq_tags *tags, unsigned int tag)
 
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
+	/* if tags is hctx->sched_tags, it always return NULL */
 	if (tag < tags->nr_tags && blk_mq_test_tag_bit(tags, tag)) {
 		prefetch(tags->rqs[tag]);
 		return tags->rqs[tag];
@@ -3845,17 +3846,8 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 
 	if (!blk_qc_t_is_internal(cookie))
 		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return false;
-	}
+	else
+		return false;
 
 	return blk_mq_poll_hybrid_sleep(q, rq);
 }
-- 
2.25.4

