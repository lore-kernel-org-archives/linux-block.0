Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41522C32753
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F34C2063F
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 09:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHNJfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:35:44 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:58239 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfHNJfo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 05:35:44 -0400
X-QQ-mid: bizesmtp11t1565775332tp22b2eg
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 14 Aug 2019 17:35:32 +0800 (CST)
X-QQ-SSF: 01400000000000R0XR80000A0000000
X-QQ-FEAT: qgc7OCN9DHhPswKvEJwLIovxOkB73FBNv5A+lUNs7ysXMGmXIWVcSXd3sdoQC
        4QNGjR4cHRuYqVqoUVBaAzOHOmfKkRVZuiUNNJxAR97oUo8Tf6+/ts5Vu89VjwYOgVnJjob
        QsapwREBOMQMjKNesE+jNSLrnjjaKrkXLuXp32Byyoh4ErGHH0a5jZUZhg3fMWpdueIcuaN
        JtKJZ0KPdpd2NeqtStz2HYiO7GeEE5hTOGhixBwAWUgfXbqBpJokvPBVn3mE5/VLSwFQ4JU
        Rj6dnHHF5uLMavl2pUDM57rYXdck8k+uJZ4A+Woc2dnFj23RKr9+ZW6YV280zV2j/gBlBPJ
        UHLTxZNOm8IWAFUJG8=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 2/2] io_uring: fix an issue when IOSQE_IO_LINK is inserted into defer list
Date:   Wed, 14 Aug 2019 17:35:22 +0800
Message-Id: <1565775322-10296-2-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
References: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch may fix two issues:

First, when IOSQE_IO_DARIN set, the next IOs need to be inserted into defer
list to delay execution, but link io will be actively scheduled to run by
calling io_queue_sqe.

Second, when multiple LINK_IOs are inserted together with defer_list, the
LINK_IO is no longer keep order.

   |-------------|
   |   LINK_IO   |      ----> insert to defer_list  -----------
   |-------------|                                            |
   |   LINK_IO   |      ----> insert to defer_list  ----------|
   |-------------|                                            |
   |   LINK_IO   |      ----> insert to defer_list  ----------|
   |-------------|                                            |
   |   NORMAL_IO |      ----> insert to defer_list  ----------|
   |-------------|                                            |
                                                              |
                              queue_work at same time   <-----|

Fixes: 9e645e1105c ("io_uring: add support for sqe links")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 05ee628..405134d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2025,6 +2025,15 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 {
 	int ret;
 
+	ret = io_req_defer(ctx, req, s->sqe);
+	if (ret) {
+		if (ret != -EIOCBQUEUED) {
+			io_free_req(req);
+			io_cqring_add_event(ctx, s->sqe->user_data, ret);
+		}
+		return 0;
+	}
+
 	ret = __io_submit_sqe(ctx, req, s, true);
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
@@ -2102,13 +2111,6 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		return;
 	}
 
-	ret = io_req_defer(ctx, req, s->sqe);
-	if (ret) {
-		if (ret != -EIOCBQUEUED)
-			goto err_req;
-		return;
-	}
-
 	/*
 	 * If we already have a head request, queue this one for async
 	 * submittal once the head completes. If we don't have a head but
-- 
2.7.4



