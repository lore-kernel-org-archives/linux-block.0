Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2058C76191
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 02:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA83F218B8
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 02:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfGVCYF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:24:05 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:34788 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbfGVCYF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jul 2019 22:24:05 -0400
X-QQ-mid: bizesmtp23t1563762211tc3fwupe
Received: from lzy-H3050.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Mon, 22 Jul 2019 10:23:28 +0800 (CST)
X-QQ-SSF: 01400000002000H0ZG31000A0000000
X-QQ-FEAT: l6IKqkG+Nbm/dJvggYJThSglvjzSwx5v01vhkGJ/PuRna4mcehEOWZkFkV0Gn
        pPfPF7+d6rIwNx+m6HkRAJtXJw5UGS8SFE57TvWdpmKronRJ7lYAZz31N8RPu5YfNGy5o9F
        HzYexX8PLzjRsCwp5h9gmGXU5meajbQUoOxfqRxCeMzgVxoc6Wt7sa7WBz6Mmr91hBw7N/L
        WA5+5fC9ZXIa3/V8B5Rjv8cBw3/NBYXTwxPNH3YDhlny2N12We8397CYr16mwhDrLKKKrpw
        7JwVQs8ePBEiquad+yShjvhrZZKF8JxaDcBWmAf9E5qit0nKpoUmGSTqHv8CWv6C/2vYd+q
        JKEWI3L
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2] track io length in async_list based on bytes
Date:   Mon, 22 Jul 2019 10:23:27 +0800
Message-Id: <1563762207-749-1-git-send-email-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We are using PAGE_SIZE as the unit to determine if the total len in
async_list has exceeded max_pages, it's not fair for smaller io sizes.
For example, if we are doing 1k-size io streams, we will never exceed
max_pages since len >>= PAGE_SHIFT always gets zero. So use original
bytes to make it more accurate.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 fs/io_uring.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ccc5648..a28fd37 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -202,7 +202,7 @@ struct async_list {
 
 	struct file		*file;
 	off_t			io_end;
-	size_t			io_pages;
+	size_t			io_len;
 };
 
 struct io_ring_ctx {
@@ -1122,28 +1122,26 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
 	off_t io_end = kiocb->ki_pos + len;
 
 	if (filp == async_list->file && kiocb->ki_pos == async_list->io_end) {
-		unsigned long max_pages;
+		unsigned long max_bytes;
 
 		/* Use 8x RA size as a decent limiter for both reads/writes */
-		max_pages = filp->f_ra.ra_pages;
-		if (!max_pages)
-			max_pages = VM_READAHEAD_PAGES;
-		max_pages *= 8;
-
-		/* If max pages are exceeded, reset the state */
-		len >>= PAGE_SHIFT;
-		if (async_list->io_pages + len <= max_pages) {
+		max_bytes = filp->f_ra.ra_pages << (PAGE_SHIFT + 3);
+		if (!max_bytes)
+			max_bytes = VM_READAHEAD_PAGES << (PAGE_SHIFT + 3);
+
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
2.7.4



