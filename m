Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC18CA9EAE
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD312084C
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 06:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbfJWGst (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:48:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389335AbfJWGst (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 02:48:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A720A873D06817A3774E;
        Wed, 23 Oct 2019 14:48:43 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 14:48:38 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH 2/2] io_uring: correct timeout req sequence when inserting a new entry
Date:   Wed, 23 Oct 2019 15:10:09 +0800
Message-ID: <20191023071009.13891-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191023071009.13891-1-yi.zhang@huawei.com>
References: <20191023071009.13891-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The sequence number of the timeout req (req->sequence) indicate the
expected completion request. Because of each timeout req consume a
sequence number, so the sequence of each timeout req on the timeout
list shouldn't be the same. But now, we may get the same number (also
incorrect) if we insert a new entry before the last one, such as submit
such two timeout reqs on a new ring instance below.

                    req->sequence
 req_1 (count = 2):       2
 req_2 (count = 1):       2

Then, if we submit a nop req, req_2 will still timeout even the nop req
finished. This patch fix this problem by adjust the sequence number of
each reordered reqs when inserting a new entry.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/io_uring.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e7a856392a23..4a395a7a36c1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1912,6 +1912,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_ring_ctx *ctx = req->ctx;
 	struct list_head *entry;
 	struct timespec64 ts;
+	unsigned span = 0;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -1960,9 +1961,17 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		if (ctx->cached_sq_head < nxt_sq_head)
 			tmp += UINT_MAX;
 
-		if (tmp >= tmp_nxt)
+		if (tmp > tmp_nxt)
 			break;
+
+		/*
+		 * Sequence of reqs after the insert one and itself should
+		 * be adjusted because each timeout req consumes a slot.
+		 */
+		span++;
+		nxt->sequence++;
 	}
+	req->sequence -= span;
 	list_add(&req->list, entry);
 	spin_unlock_irq(&ctx->completion_lock);
 
-- 
2.17.2

