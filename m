Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A35ECA9EB9
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 06:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0072A2084C
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 06:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbfJWGsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:48:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWGsu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 02:48:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A10E148BAB5BDD4AFAC2;
        Wed, 23 Oct 2019 14:48:43 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 14:48:37 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH 1/2] io_uring : correct timeout req sequence when waiting timeout
Date:   Wed, 23 Oct 2019 15:10:08 +0800
Message-ID: <20191023071009.13891-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The sequence number of reqs on the timeout_list before the timeout req
should be adjusted in io_timeout_fn(), because the current timeout req
will consumes a slot in the cq_ring and cq_tail pointer will be
increased, otherwise other timeout reqs may return in advance without
waiting for enough wait_nr.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/io_uring.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 67dbe0201e0d..e7a856392a23 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1877,7 +1877,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 {
 	struct io_ring_ctx *ctx;
-	struct io_kiocb *req;
+	struct io_kiocb *req, *prev;
 	unsigned long flags;
 
 	req = container_of(timer, struct io_kiocb, timeout.timer);
@@ -1885,6 +1885,15 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	atomic_inc(&ctx->cq_timeouts);
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
+	/*
+	 * Adjust the reqs sequence before the current one because it
+	 * will consume a slot in the cq_ring and the the cq_tail pointer
+	 * will be increased, otherwise other timeout reqs may return in
+	 * advance without waiting for enough wait_nr.
+	 */
+	prev = req;
+	list_for_each_entry_continue_reverse(prev, &ctx->timeout_list, list)
+		prev->sequence++;
 	list_del(&req->list);
 
 	io_cqring_fill_event(ctx, req->user_data, -ETIME);
-- 
2.17.2

