Return-Path: <SRS0=S7xR=XV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C234C47E48
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE81A222C4
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfIZJuP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:50:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49450 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfIZJuP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 05:50:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iDQPc-0005BW-TY; Thu, 26 Sep 2019 09:50:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] io_uring: ensure variable ret is initialized to zero
Date:   Thu, 26 Sep 2019 10:50:12 +0100
Message-Id: <20190926095012.31826-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where sig is NULL the error variable ret is not initialized
and may contain a garbage value on the final checks to see if ret is
-ERESTARTSYS.  Best to initialize ret to zero before the do loop to
ensure the ret does not accidentially contain -ERESTARTSYS before the
loop.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: dd671c79e40b ("io_uring: make CQ ring wakeups be more efficient")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7b5710e3a18c..aa8ac557493c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2835,6 +2835,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
+	ret = 0;
 	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
 	do {
 		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
-- 
2.20.1

