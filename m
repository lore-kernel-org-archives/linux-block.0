Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4900EC04E87
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 03:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C825205ED
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 03:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEPDrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 23:47:15 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:56019 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfEPDrP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 23:47:15 -0400
X-QQ-mid: bizesmtp18t1557978425tkwj8534
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 16 May 2019 11:47:05 +0800 (CST)
X-QQ-SSF: 01400000002000Q0VN60B00A0000000
X-QQ-FEAT: cTSAXDkpFsb/1Taf/d1xRqJHRp3tBu2fhhHcPKC8iWXbIswlEjyLJMrnNO5Ma
        mdxo37HK+o49qfCQLTBgE24tdW5GhNTpB9zm70DSrnRelex2VXVwK4y+eCog2GuByt/X1fE
        silYYMBnhgKA+BG4kqi8QI2vpO0zmqRfesaw91kViFPo5sjwEnIbjwxPleZ5fxI+tJTfCaN
        t7Oevf/D9OYmZ6ise4+3HdDOIuq35GFDrfYQk3JNz98cCVfKC64DzGVfBVAREt7V833uBsg
        maJYxel7sL4NItqaaHsJ4kcZgzR6lyknNu/KRFfbX+6Odaxoow00Rs6PGVs3YZS651bs4RT
        vCWTahC
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 2/2] io_uring: use wait_event_interruptible for cq_wait conditional wait
Date:   Thu, 16 May 2019 11:46:31 +0800
Message-Id: <1557978391-26300-2-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557978391-26300-1-git-send-email-liuyun01@kylinos.cn>
References: <1557978391-26300-1-git-send-email-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The previous patch has ensured that io_cqring_events contain
smp_rmb memory barriers, Now we can use wait_event_interruptible
to keep the code simple.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 516f036..45df0b4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2058,7 +2058,6 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 {
 	struct io_cq_ring *ring = ctx->cq_ring;
 	sigset_t ksigmask, sigsaved;
-	DEFINE_WAIT(wait);
 	int ret;
 
 	if (io_cqring_events(ring) >= min_events)
@@ -2078,21 +2077,9 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	do {
-		prepare_to_wait(&ctx->wait, &wait, TASK_INTERRUPTIBLE);
-
-		ret = 0;
-		if (io_cqring_events(ring) >= min_events)
-			break;
-
-		schedule();
-
+	ret = wait_event_interruptible(ctx->wait, io_cqring_events(ring) >= min_events);
+	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
-		if (signal_pending(current))
-			break;
-	} while (1);
-
-	finish_wait(&ctx->wait, &wait);
 
 	if (sig)
 		restore_user_sigmask(sig, &sigsaved);
-- 
2.7.4




