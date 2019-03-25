Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B60FC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 19:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0666D206C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 19:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfCYTJe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:09:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729489AbfCYTJe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 15:09:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23ACBAF26;
        Mon, 25 Mar 2019 19:09:33 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/1] io_uring: offload write to async worker in case of -EAGAIN
Date:   Mon, 25 Mar 2019 20:09:24 +0100
Message-Id: <20190325190924.11174-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of direct write -EAGAIN will be returned if page cache was
previously populated.  To avoid immediate completion of a request
with -EAGAIN error write has to be offloaded to the async worker,
like io_read() does.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 fs/io_uring.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6aaa30580a2b..ccb656168ae4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1022,6 +1022,8 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 
 	ret = rw_verify_area(WRITE, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
+		ssize_t ret2;
+
 		/*
 		 * Open-code file_start_write here to grab freeze protection,
 		 * which will be released by another thread in
@@ -1036,7 +1038,19 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 						SB_FREEZE_WRITE);
 		}
 		kiocb->ki_flags |= IOCB_WRITE;
-		io_rw_done(kiocb, call_write_iter(file, kiocb, &iter));
+
+		ret2 = call_write_iter(file, kiocb, &iter);
+		if (!force_nonblock || ret2 != -EAGAIN) {
+			io_rw_done(kiocb, ret2);
+		} else {
+			/*
+			 * If ->needs_lock is true, we're already in async
+			 * context.
+			 */
+			if (!s->needs_lock)
+				io_async_list_note(WRITE, req, iov_count);
+			ret = -EAGAIN;
+		}
 	}
 out_free:
 	kfree(iovec);
-- 
2.21.0

