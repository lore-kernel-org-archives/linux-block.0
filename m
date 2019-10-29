Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E29CA9EC0
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 03:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7541321479
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 03:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfJ2DRJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 23:17:09 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:53524 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfJ2DRI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 23:17:08 -0400
X-QQ-mid: bizesmtp20t1572319013tnm21do0
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 29 Oct 2019 11:16:53 +0800 (CST)
X-QQ-SSF: 01400000002000S0ZU90B00A0000000
X-QQ-FEAT: EWlPDqVqcOf1YHSW8J2zIAG9bnVWk8lz6+GoiWoA0JXcJseJW3vstMXq8lR35
        ImviT3+v5xrDXKgFfyOXnD1Plc7C1XeBSdIvBOu/EFzW8SNhbnPhS4BZ8zAScLDWvr8i+u0
        eWu6R8UtQynHeF6y3z+2+qKgn/ywvLc9x28AUZ/51mvQK3TBVW/bQJNVlCk77MFhl4HK0Bm
        bGZxYzfV+j9jOafOPkI7YqaozLqJaZqlp8HonVLC/2l+7ig2V0r+AVrT9marYltEN+wN30n
        b+aOSyleuhzh6KMco5eVpL3zIxW8dzNqZRRAzH3jSnd3h0LT06iEDqi0fqzZhoSD2MKE5K8
        4BN0ExLFnzEbnWGrKE=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     liuyun01@kylinos.cn, linux-block@vger.kernel.org
Subject: [PATCH] io_uring: set -EINTR directly when a signal wakes up in io_cqring_wait
Date:   Tue, 29 Oct 2019 11:16:42 +0800
Message-Id: <1572319002-9943-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We didn't use -ERESTARTSYS to tell the application layer to restart the
system call, but instead return -EINTR. we can set -EINTR directly when
wakeup by the signal, which can help us save an assignment operation and
comparison operation.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a30c4f6..63eee7e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2878,7 +2878,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 		.to_wait	= min_events,
 	};
 	struct io_rings *rings = ctx->rings;
-	int ret;
+	int ret = 0;
 
 	if (io_cqring_events(rings) >= min_events)
 		return 0;
@@ -2896,7 +2896,6 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	ret = 0;
 	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
 	do {
 		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
@@ -2905,15 +2904,13 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			break;
 		schedule();
 		if (signal_pending(current)) {
-			ret = -ERESTARTSYS;
+			ret = -EINTR;
 			break;
 		}
 	} while (1);
 	finish_wait(&ctx->wait, &iowq.wq);
 
-	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
-	if (ret == -ERESTARTSYS)
-		ret = -EINTR;
+	restore_saved_sigmask_unless(ret == -EINTR);
 
 	return READ_ONCE(rings->cq.head) == READ_ONCE(rings->cq.tail) ? ret : 0;
 }
-- 
2.7.4



