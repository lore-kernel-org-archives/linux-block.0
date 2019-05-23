Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC44CC282CE
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 02:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D46C21019
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 02:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfEWCAU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 22:00:20 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:45868 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWCAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 22:00:20 -0400
X-QQ-mid: bizesmtp7t1558576811tm45urlaf
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 23 May 2019 10:00:09 +0800 (CST)
X-QQ-SSF: 01400000002000Q0VN60000A0000000
X-QQ-FEAT: cChytmQu3w5NbIuudOesP11nzK7+6M+yS3Vi9p4GyQZDn8xlrNsC/3phz+gSd
        iHehXYAwyh22d6wEjKXVAFN/LWV0My3U59bprLAcSgNH1ZEonpdSMDuCjAZJ+1X7sFe0rjY
        niipjV3Nf8pETj72qk3TkQ1Pt3cDRSMK6fYvdfNbI4rNyQaTSEaiN7BLeP1JEaLWYQtlOy8
        wVMs4Lgl8DW7KZFGvuO1ZPsST7V70Ec7lG0frwwD+Ca5I/+HFGVPRtXE1jaccdvpdbTRFsC
        sti+dI0gDM5+7fUY+BVagjgcJfRg14V4ddUUVq0dPwamBUOQRvfOuR+aXzqSEGQksZHe406
        2GQQ1uh
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 1/3] io_uring: free memory immediately when io_mem_alloc failed
Date:   Thu, 23 May 2019 09:59:45 +0800
Message-Id: <1558576787-18310-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In extreme cases, memory may not be available. so we should
be clean up memory.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 310f8d1..4430429 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2951,6 +2951,7 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	struct io_sq_ring *sq_ring;
 	struct io_cq_ring *cq_ring;
 	size_t size;
+	int ret;
 
 	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
 	if (!sq_ring)
@@ -2963,16 +2964,22 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	ctx->sq_entries = sq_ring->ring_entries;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
-	if (size == SIZE_MAX)
-		return -EOVERFLOW;
+	if (size == SIZE_MAX) {
+		ret = -EOVERFLOW;
+		goto err;
+	}
 
 	ctx->sq_sqes = io_mem_alloc(size);
-	if (!ctx->sq_sqes)
-		return -ENOMEM;
+	if (!ctx->sq_sqes) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	cq_ring = io_mem_alloc(struct_size(cq_ring, cqes, p->cq_entries));
-	if (!cq_ring)
-		return -ENOMEM;
+	if (!cq_ring) {
+		ret = -ENOMEM;
+		goto err1;
+	}
 
 	ctx->cq_ring = cq_ring;
 	cq_ring->ring_mask = p->cq_entries - 1;
@@ -2980,6 +2987,12 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	ctx->cq_mask = cq_ring->ring_mask;
 	ctx->cq_entries = cq_ring->ring_entries;
 	return 0;
+
+err1:
+	io_mem_free(ctx->sq_sqes);
+err:
+	io_mem_free(ctx->sq_ring);
+	return ret;
 }
 
 /*
-- 
2.7.4




