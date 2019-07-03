Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7EBC0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 09:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1837F21881
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 09:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGCJ4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:56:04 -0400
Received: from smtpbg65.qq.com ([103.7.28.233]:44268 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfGCJ4E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jul 2019 05:56:04 -0400
X-QQ-mid: bizesmtp24t1562146866tpxkxzzy
Received: from lzy-H3050.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 03 Jul 2019 17:40:32 +0800 (CST)
X-QQ-SSF: 01400000002000H0ZG31000A0000000
X-QQ-FEAT: 8EH74LRXnGwLnYMhBxLZoihOAPbldL3U4Y3zApPHcGm6JahYKgLGg3vUuzxbL
        CSkoH2YXlV+OXyoQHFSql59IXr4qCiVZTN7PPyo3z1XWpw6CZ3MhaFDiKladM6TQ0vzNQd+
        M/8FRCs6HhOhmeKf0chKsQ34QLmFORYBWDCHzyAUwjPA+q4UQfh+ZaVaxZr8G/m1ApeY+6c
        aa+jbrYX+16lKeoa6zGs17BmOfXSw6iBEu/fwytz1C2ogghx3yzy6/KhULRNl4+iq33d9YU
        cPoZ0IisJ9/LOVAlk1jFCYq1UiQkVKwDi7DRRMbgiESwi8bL57maqXaZsiJAnqQlwB30Rjb
        LbzieufWICPQy1uZCkqXJQ9klKBOA==
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     axboe@kernel.dk
Cc:     liuyun01@kylinos.cn, linux-block@vger.kernel.org
Subject: [PATCH] io_uring: fix the expression in io_sequence_defer
Date:   Wed,  3 Jul 2019 17:40:31 +0800
Message-Id: <1562146831-7032-1-git-send-email-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sq and cq are both ring, once sq head gets back and cq not yet then
the expression get wrong.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0fbb486..56fe6e1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -423,7 +423,7 @@ static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
 	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
 		return false;
 
-	return req->sequence > ctx->cached_cq_tail + ctx->sq_ring->dropped;
+	return req->sequence != ctx->cached_cq_tail + ctx->sq_ring->dropped;
 }
 
 static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
-- 
2.7.4



