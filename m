Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F95FC4360C
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 01:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB6E21871
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 01:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfJIBUJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:20:09 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:45812 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfJIBUJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Oct 2019 21:20:09 -0400
X-QQ-mid: bizesmtp27t1570584002tnd1qdfu
Received: from Macbook.pro (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 09 Oct 2019 09:20:00 +0800 (CST)
X-QQ-SSF: 01400000002000S0ZT90B00A0000000
X-QQ-FEAT: lm51M56XDGxiNAZ1yohJfrwpvy6CGGHuuQVvmkhr4lJ1ihaAQ56a2nAPXF0zr
        sae9wnP0MjenQup+Hvl7Lj2h4fiENeM8qlv9uTX5Mmb4+ui/gs/+ZcD6QtL18mDF6HJdOYc
        J0hJk7y0FdupaU/sKBrLWeW+SZdRZqSXCk3YHmBfTsMF+DCtKHYrGllbA+Y3VH0om0CXlOP
        T/RSsiQnXErFG9QLlw78dF4qs7DkOC5jvlutYZBzpd1+2BRmQ5lgutIC+Xq6Rs7cl7n2HxI
        OZacKnaN+9+1SWN+EeSrs4KVplhL4xQdwZ+bLWrKDBeXlSgLElcwUImXZCaDccvEa3S4YbG
        +CP5bFj
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] io_uring: make the logic clearer for io_sequence_defer
Date:   Wed,  9 Oct 2019 09:19:58 +0800
Message-Id: <20191009011959.2203-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__io_get_deferred_req is used to get all defer lists, including defer_list
and timeout_list, but io_sequence_defer should be only cares about the sequence.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8a0381f1a43b..8ec2443eb019 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
 				     struct io_kiocb *req)
 {
-	/* timeout requests always honor sequence */
-	if (!(req->flags & REQ_F_TIMEOUT) &&
-	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
+	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
 		return false;
 
 	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
@@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
 		return NULL;
 
 	req = list_first_entry(list, struct io_kiocb, list);
-	if (!io_sequence_defer(ctx, req)) {
-		list_del_init(&req->list);
-		return req;
-	}
+	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
+		return NULL;
 
-	return NULL;
+	list_del_init(&req->list);
+	return req;
 }
 
 static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
-- 
2.23.0



