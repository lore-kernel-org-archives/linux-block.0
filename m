Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C07C4CECE
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 11:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2838320673
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 11:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfJNLa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:30:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729363AbfJNLa3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 07:30:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 261322F663F8F099FC6D;
        Mon, 14 Oct 2019 19:30:27 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 14 Oct 2019 19:30:18 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH V2] io_uring: consider the overflow of sequence for timeout req
Date:   Mon, 14 Oct 2019 19:51:56 +0800
Message-ID: <20191014115156.43151-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The sequence for timeout req may overflow, and it will lead to wrong
order of timeout req list. And we should consider two situation:

1. ctx->cached_sq_head + count - 1 may overflow;
2. cached_sq_head of now may overflow compare with before
cached_sq_head.

Fix the wrong logic by add record of count and use type long long to
record the overflow.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/io_uring.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 76fdbe84aff5..c8dbf85c1c91 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -288,6 +288,7 @@ struct io_poll_iocb {
 struct io_timeout {
 	struct file			*file;
 	struct hrtimer			timer;
+	unsigned			count;
 };
 
 /*
@@ -1884,7 +1885,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 
 static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	unsigned count, req_dist, tail_index;
+	unsigned count;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct list_head *entry;
 	struct timespec64 ts;
@@ -1907,21 +1908,39 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		count = 1;
 
 	req->sequence = ctx->cached_sq_head + count - 1;
+	req->timeout.count = count;
 	req->flags |= REQ_F_TIMEOUT;
 
 	/*
 	 * Insertion sort, ensuring the first entry in the list is always
 	 * the one we need first.
 	 */
-	tail_index = ctx->cached_cq_tail - ctx->rings->sq_dropped;
-	req_dist = req->sequence - tail_index;
 	spin_lock_irq(&ctx->completion_lock);
 	list_for_each_prev(entry, &ctx->timeout_list) {
 		struct io_kiocb *nxt = list_entry(entry, struct io_kiocb, list);
-		unsigned dist;
+		unsigned nxt_sq_head;
+		long long tmp, tmp_nxt;
 
-		dist = nxt->sequence - tail_index;
-		if (req_dist >= dist)
+		/* count bigger than before should break directly. */
+		if (count >= nxt->timeout.count)
+			break;
+
+		/*
+		 * Since cached_sq_head + count - 1 can overflow, use type long
+		 * long to store it.
+		 */
+		tmp = (long long)ctx->cached_sq_head + count - 1;
+		nxt_sq_head = nxt->sequence - nxt->timeout.count + 1;
+		tmp_nxt = (long long)nxt_sq_head + nxt->timeout.count - 1;
+
+		/*
+		 * cached_sq_head may overflow, and it will never overflow twice
+		 * once there is some timeout req still be valid.
+		 */
+		if (ctx->cached_sq_head < nxt_sq_head)
+			tmp += UINT_MAX;
+
+		if (tmp >= tmp_nxt)
 			break;
 	}
 	list_add(&req->list, entry);
-- 
2.17.2

