Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C6C04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 03:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C232087B
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 03:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEPDrO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 23:47:14 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:40072 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfEPDrO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 23:47:14 -0400
X-QQ-mid: bizesmtp18t1557978424tjaxdklb
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 16 May 2019 11:47:03 +0800 (CST)
X-QQ-SSF: 01400000002000Q0VN60B00A0000000
X-QQ-FEAT: s8YYpWqVDddWzOmnxU9WCnkPrNb4QHFfdkMcWx8xA45oyqjJENJibBMpdymdP
        ZKnnsYaD0HX3JrAh76hxi2BDjPjZAJR3ufXNuX+8AgACwtwRWd2/XZZr1whvMmTUHzn7yB9
        lBoReYD9BXus/jZq/vSWOyusaD2Fy3zi+NY4QDsqj5gq0rnb1n1u3PlpDygGgv3UsrcUGlC
        Dm23GoesbzOjtsEMNhKpRpv3yCnJzC6u9mJOtD2edND8G3o83cVm/Zs5lLVtBFQjKxUCOlC
        m4tpVa+BkYAihR9WB+phmEmkJeQPyYJ4Ty2gY0tEJglSUL1Nz11hznM8ihI2Q6MxdlHkVQR
        gisRHuB
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 1/2] io_uring: adjust smp_rmb inside io_cqring_events
Date:   Thu, 16 May 2019 11:46:30 +0800
Message-Id: <1557978391-26300-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Whenever smp_rmb is required to use io_cqring_events,
keep smp_rmb inside the function io_cqring_events.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 84efb89..516f036 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2044,6 +2044,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 
 static unsigned io_cqring_events(struct io_cq_ring *ring)
 {
+	/* See comment at the top of this file */
+	smp_rmb();
 	return READ_ONCE(ring->r.tail) - READ_ONCE(ring->r.head);
 }
 
@@ -2059,8 +2061,6 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	DEFINE_WAIT(wait);
 	int ret;
 
-	/* See comment at the top of this file */
-	smp_rmb();
 	if (io_cqring_events(ring) >= min_events)
 		return 0;
 
@@ -2082,8 +2082,6 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 		prepare_to_wait(&ctx->wait, &wait, TASK_INTERRUPTIBLE);
 
 		ret = 0;
-		/* See comment at the top of this file */
-		smp_rmb();
 		if (io_cqring_events(ring) >= min_events)
 			break;
 
-- 
2.7.4



