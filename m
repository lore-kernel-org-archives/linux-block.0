Return-Path: <SRS0=enhP=VS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8AEC76191
	for <linux-block@archiver.kernel.org>; Sun, 21 Jul 2019 15:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C8D2083B
	for <linux-block@archiver.kernel.org>; Sun, 21 Jul 2019 15:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfGUPyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jul 2019 11:54:31 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:39367 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGUPyb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jul 2019 11:54:31 -0400
X-QQ-mid: bizesmtp19t1563724459t5407of5
Received: from localhost.localdomain (unknown [113.240.213.92])
        by esmtp10.qq.com (ESMTP) with 
        id ; Sun, 21 Jul 2019 23:54:08 +0800 (CST)
X-QQ-SSF: 01400000002000H0ZG31000A0000000
X-QQ-FEAT: TGE1LTIrc3il9OjLi/OnKD7jOltGY64btKbHcl/nE5/E3871RAmSZtgj69nPf
        CnMBi0QKdMqJ+CuQRJHkcNhZnKX6sVMaTcKKnSkKv6yhuqPdow0oJZnSNdI1KGnqD3zM9HY
        SRLlcfZ7C1ilug7NUlwLOUQj2dSWCL6RqEdM7kJXsiAtXt4GSpPn5HmbSQt0fNIRi67Q32F
        KhsvSX7WsZnF0hB0+XK89hF+bazRJOO+1ZI9ylHZQFHcuPdsa5LP9dMHXPJxvxSN4J+C7yB
        d/804Ivwxv/MHjAJ/3x8PL+D/cxIbpls72vukncTmvPLkBn5d5wzeFWbo5W/8c7SbfEviPm
        JDIksJdb0Pto6soZ9s=
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] io_uring: use bytes instead of pages to decide len exceeding
Date:   Sun, 21 Jul 2019 23:54:07 +0800
Message-Id: <20190721155408.14009-1-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We are using PAGE_SIZE as the unit to determine if the total len in
async_list has exceeded max_pages, it's not fair for smaller io sizes.
For example, if we are doing 1k-size io streams, we will never exceed
max_pages since len >>= PAGE_SHIFT always gets zero. So use original
bytes to make things fair.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 fs/io_uring.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7e932c572f26..79272cf1ab83 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -202,7 +202,7 @@ struct async_list {
 
 	struct file		*file;
 	off_t			io_end;
-	size_t			io_pages;
+	size_t			io_len;
 };
 
 struct io_ring_ctx {
@@ -1121,28 +1121,27 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
 	off_t io_end = kiocb->ki_pos + len;
 
 	if (filp == async_list->file && kiocb->ki_pos == async_list->io_end) {
-		unsigned long max_pages;
+		unsigned long max_pages, max_bytes;
 
 		/* Use 8x RA size as a decent limiter for both reads/writes */
 		max_pages = filp->f_ra.ra_pages;
 		if (!max_pages)
 			max_pages = VM_READAHEAD_PAGES;
-		max_pages *= 8;
+		max_bytes = (max_pages * 8) << PAGE_SHIFT;
 
-		/* If max pages are exceeded, reset the state */
-		len >>= PAGE_SHIFT;
-		if (async_list->io_pages + len <= max_pages) {
+		/* If max len are exceeded, reset the state */
+		if (async_list->io_len + len <= max_bytes) {
 			req->flags |= REQ_F_SEQ_PREV;
-			async_list->io_pages += len;
+			async_list->io_len += len;
 		} else {
 			io_end = 0;
-			async_list->io_pages = 0;
+			async_list->io_len = 0;
 		}
 	}
 
 	/* New file? Reset state. */
 	if (async_list->file != filp) {
-		async_list->io_pages = 0;
+		async_list->io_len = 0;
 		async_list->file = filp;
 	}
 	async_list->io_end = io_end;
-- 
2.19.1



