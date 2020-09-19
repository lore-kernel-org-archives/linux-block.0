Return-Path: <SRS0=hgVe=C4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DA5C43464
	for <linux-block@archiver.kernel.org>; Sat, 19 Sep 2020 03:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4DF21897
	for <linux-block@archiver.kernel.org>; Sat, 19 Sep 2020 03:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgISDxW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Sep 2020 23:53:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbgISDxW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 23:53:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6061A16B8741C2C4B7BD;
        Sat, 19 Sep 2020 11:53:19 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 11:53:14 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <yangerkun@huawei.com>
Subject: [PATCH] block-mq: fix comments in blk_mq_queue_tag_busy_iter
Date:   Sat, 19 Sep 2020 11:54:25 +0800
Message-ID: <20200919035425.3316563-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'f5bbbbe4d635 ("blk-mq: sync the update nr_hw_queues with
blk_mq_queue_tag_busy_iter")' introduce a bug what we may sleep between
rcu lock. Then '530ca2c9bd69 ("blk-mq: Allow blocking queue tag iter
callbacks")' fix it by get request_queue's ref. And 'a9a808084d6a ("block:
Remove the synchronize_rcu() call from __blk_mq_update_nr_hw_queues()")'
remove the synchronize_rcu in __blk_mq_update_nr_hw_queues. We need
update the confused comments in blk_mq_queue_tag_busy_iter.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 block/blk-mq-tag.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 32d82e23b095..051227bd5a03 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -398,9 +398,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	/*
 	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
-	 * racing with it. __blk_mq_update_nr_hw_queues() uses
-	 * synchronize_rcu() to ensure this function left the critical section
-	 * below.
+	 * racing with it.
 	 */
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
-- 
2.25.4

