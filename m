Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B430C43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 11:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11EF208C2
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 11:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="LAGA5g9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfD0Lid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 07:38:33 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:53798 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD0Lid (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 07:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1556365099;
        bh=vLUFUvpFiIreG6THVGdX48y3hXtx8bK/toBtLsurNdA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=LAGA5g9RhAzBoIFbgORIeCjHXXK6/fquibOISaVMQ5fNTLZbvAlpBxwsRs7GG41Dn
         CADvBzWUAcRuN3yxM78YhPBh+9+xTddOxVL1KiHMgwefI2+Scz/qT0EYem1AS92I6g
         PJQzbVHI3p7BfkghPfj7+hLBVcYco4amyC/DT/08=
X-QQ-mid: esmtp2t1556365097tnkj7r0ra
Received: from localhost.localdomain (unknown [61.48.57.6])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 27 Apr 2019 19:38:07 +0800 (CST)
X-QQ-SSF: 01000000000000F0FH3000000000000
X-QQ-FEAT: 3kJJdZsYhnEmXivFD25zt8z658xCS4w6Wox8ZGa6vDwrxa9FBDSdsTSWH+Fuz
        liXC05jmLk3J1tWotVDEOShAwzFOrJrx7kMyXxVKyw7jSHrRKNrvLm74Vy8oP5FXwR0M+tc
        vnNxFHTt0KpIKFJDHNPMIKOUcC5ZLv9ZUQ4aoS0Po723dQWOecZNW/Rp5CEpNAd6wd2ByoF
        PYTBf2JNCwXGREO/0SHh7rh9ddkHYVQgHBs0CJ6BbOHsuqgXLOjOxknL7r4d7raNSodaZlI
        DEZUVAa++fpYcG1NoK85wWyc3/Ayexzlzg/GYsRcyMnfj9
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] io_uring: unaccount scq mem properly
Date:   Sat, 27 Apr 2019 19:38:06 +0800
Message-Id: <20190427113807.4933-1-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

io_allocate_scq_urings() may fail to allocate scq rings, and fail to
set ctx->sq_entries or ctx->cq_entries. In io_ring_ctx_free(), the code
'
    if (ctx->account_mem)
        io_unaccount_mem(ctx->user,
             ring_pages(ctx->sq_entries, ctx->cq_entries));
'
may not unaccount properly.

E.g, in io_uring_create(), we have ctx allocated with zero filled.
Later, io_allocate_scq_urings() fails, and we may still have
0-valued ctx->sq_entries & ctx->cq_entries. Then the unaccount code
cannot unaccout what io_account_mem() has changed.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f65f85d89217..9d382ac27e63 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2741,7 +2741,6 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	sq_ring->ring_mask = p->sq_entries - 1;
 	sq_ring->ring_entries = p->sq_entries;
 	ctx->sq_mask = sq_ring->ring_mask;
-	ctx->sq_entries = sq_ring->ring_entries;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
 	if (size == SIZE_MAX)
@@ -2764,7 +2763,6 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	cq_ring->ring_mask = p->cq_entries - 1;
 	cq_ring->ring_entries = p->cq_entries;
 	ctx->cq_mask = cq_ring->ring_mask;
-	ctx->cq_entries = cq_ring->ring_entries;
 	return 0;
 }
 
@@ -2854,6 +2852,8 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	ctx->compat = in_compat_syscall();
 	ctx->account_mem = account_mem;
 	ctx->user = user;
+	ctx->sq_entries = p->sq_entries;
+	ctx->cq_entries = p->cq_entries;
 
 	ret = io_allocate_scq_urings(ctx, p);
 	if (ret)
-- 
2.20.1




