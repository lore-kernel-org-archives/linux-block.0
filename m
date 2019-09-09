Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6346C4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856A7207FC
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfIIMvN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:51:13 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:40043 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfIIMvM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 08:51:12 -0400
X-QQ-mid: bizesmtp11t1568033451t31uxknh
Received: from Macbook.pro (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 09 Sep 2019 20:50:49 +0800 (CST)
X-QQ-SSF: 01400000002000R0YS90000A0000000
X-QQ-FEAT: s8YYpWqVDdeKZvQm2/XS27AJeu3X/4Zgf0YTQwHB5DEpDXklCrQzJ4FGrDeeK
        CpAeUKMwZGOythVitsVZesGI0iIaoJwGDlWnJ+fBSodQn2GAMzyxxg0nW9h37rbWczbre7V
        QJQB19zGHAjrjJUWXwM7Vv3WA6pD/IiGcVAy2+3iS0RLeNwPjBO4sMkqObdLZqgBakU1hPR
        WR9yQYris+4JT41L7RAiR6tjniQ77xDiRODvYTOw1z2hhMw0H8JtRBihjP1nwKdG/BjVdE7
        PdscVvwM1bt0QQhFqhZPe1giOVS5q4PJwH63bIQCqJSp/S4osPgPGuvGb6YvNbt6wYVfSeG
        bTd8C9/YxfcaTBvx9R0I8iyFeGN3w==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 1/2] io_uring: fix wrong sequence setting logic
Date:   Mon,  9 Sep 2019 20:50:39 +0800
Message-Id: <20190909125040.7119-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sqo_thread will get sqring in batches, which will cause
ctx->cached_sq_head to be added in batches. if one of these
sqes is set with the DRAIN flag, then he will never get a
chance to process, and finally sqo_thread will not exit.

Fixes: de0617e4671 ("io_uring: add support for marking commands as draining")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cfb48bd088e1..06d048341fa4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -288,6 +288,7 @@ struct io_ring_ctx {
 struct sqe_submit {
 	const struct io_uring_sqe	*sqe;
 	unsigned short			index;
+	u32				sequence;
 	bool				has_user;
 	bool				needs_lock;
 	bool				needs_fixed_file;
@@ -2040,7 +2041,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 
 	if (flags & IOSQE_IO_DRAIN) {
 		req->flags |= REQ_F_IO_DRAIN;
-		req->sequence = ctx->cached_sq_head - 1;
+		req->sequence = s->sequence;
 	}
 
 	if (!io_op_needs_file(s->sqe))
@@ -2247,6 +2248,7 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	if (head < ctx->sq_entries) {
 		s->index = head;
 		s->sqe = &ctx->sq_sqes[head];
+		s->sequence = ctx->cached_sq_head;
 		ctx->cached_sq_head++;
 		return true;
 	}
-- 
2.23.0



