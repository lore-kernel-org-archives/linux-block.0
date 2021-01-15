Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD8FC433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 06:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7170723436
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 06:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbhAOGmu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:42:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10658 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOGmt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jan 2021 01:42:49 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DHBQn2JR0z15sm0;
        Fri, 15 Jan 2021 14:41:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Fri, 15 Jan 2021
 14:42:06 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [PATCH] block: quiesce queue before freeing queue
Date:   Fri, 15 Jan 2021 01:43:52 -0500
Message-ID: <20210115064352.532534-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a race beteewn blk_mq_run_hw_queue() and cleanup queue,
which can cause use-after-free as following:

cpu1                              cpu2
queue_state_write()
                                  blk_release_queue
                                    blk_exit_queue
  blk_mq_run_hw_queue
    blk_mq_hctx_has_pending
      e = q->elevator
                                    q->elevator = NULL
                                    free(q->elevator)
      e && e->type->ops.has_work //use-after-free

Fix this bug by adding quiesce before freeing queue. Then, anyone
who tries to run hw queue will be safe.

This is basically revert of 662156641bc4 ("block: don't drain
in-progress dispatch in blk_cleanup_queue()")

Fixes: 662156641bc4 ("block: don't drain in-progress dispatch in blk_cleanup_queue()")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7663a9b94b80..f8a038d19c89 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -392,6 +392,18 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
+	/*
+	 * make sure all in-progress dispatch are completed because
+	 * blk_freeze_queue() can only complete all requests, and
+	 * dispatch may still be in-progress since we dispatch requests
+	 * from more than one contexts.
+	 *
+	 * We rely on driver to deal with the race in case that queue
+	 * initialization isn't done.
+	 */
+	if (queue_is_mq(q) && blk_queue_init_done(q))
+		blk_mq_quiesce_queue(q);
+
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
 	blk_flush_integrity();
 
-- 
2.25.4

