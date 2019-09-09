Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E2C4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 21:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF20F20863
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 21:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nw0yQAiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfIIVxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 17:53:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41112 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfIIVxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 17:53:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so10138066pfo.8
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2019 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=G7WGPWArajiICHvI2VunmVw0QwxYEtAM+IOlaELcKac=;
        b=nw0yQAiyyfFDlmeQCQeaE5dcexDcNul+klHKnlFzEMC7WhYPFj54vSJRWDxR4KjTMM
         iAKWqYbQBB+XlgmdOdncNP/gGvh/8blthqz5iTHvG5YaSy39c/KQWPzGRA/jSJnHvbYm
         ETO6UM03XR641wiRFRKC54/lt2G9n6d+ne0iAkrNDZFF563jNRVV2bxnYM1AXPHOp8S3
         z7fzHdlg7yZir1hvHirtoCCQiQ+HqbRQ1DiW2b5vwGosYkTe64AxZ7G70EAMNTMYu7RB
         HiSz2E7nmzesan1K6QeKPK/CMIf2ENbsK7N2zPox/EooGtBf3LGOK3yE+GhbsZ/IJsT+
         jETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=G7WGPWArajiICHvI2VunmVw0QwxYEtAM+IOlaELcKac=;
        b=cgeX0wFGW8cXwQuhNL8jLSJDkvCg2a+jMaxoTZoZmryYmNQ5Oy+GX8Txtq5xPzuFf1
         QZCRJ3PEHwFOvVcv3vYDtUM59pZy3fGGkLm7Xp27w/t4DDmS+E9YcfJb9eCP32Bk+C1+
         3mQOqzEstLQwEFKqYrM2dmpBfNv4UrwvcI8EFBCGh3M9mIexIY3lFUdIm09OLSgsCqvE
         oiZmmjcwsM6T5ovhrzJP6/u72X6FekLop4De3A5OBHj3nSnvFyFr8d+dNzbc1IYgd7dp
         iSObNzl1IyvhqaXzbiou4k28kMkYgTASE/EYkMzcr/ayIwE5iBPThImzecztzfkWTa47
         hk0g==
X-Gm-Message-State: APjAAAXL97S1o5havdCC51iUGKm5WyPNBwLMMN2Xz6IX1EkwEzE0PzQD
        kzBfhVktVPgLwhqMQRq3XE+TwaQ+XRPTpg==
X-Google-Smtp-Source: APXvYqw3+TUwr6qK2319yWA3JU9Hq15s/mVfvDazpOqIYA55rn7UPu9gFpIy6h8O13qfInPXaqSgIA==
X-Received: by 2002:a65:6547:: with SMTP id a7mr23679630pgw.65.1568066003540;
        Mon, 09 Sep 2019 14:53:23 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.2])
        by smtp.gmail.com with ESMTPSA id g14sm16159098pfo.133.2019.09.09.14.53.21
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 14:53:22 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: optimize submit_and_wait API
Message-ID: <a04806ef-362e-73c5-148a-6eb3bbe106ee@kernel.dk>
Date:   Mon, 9 Sep 2019 15:53:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For some applications that end up using a submit-and-wait type of
approach for certain batches of IO, we can make that a bit more
efficient by allowing the application to block for the last IO
submission. This prevents an async when we don't need it, as the
application will be blocking for the completion event(s) anyway.

Typical use cases are using the liburing
io_uring_submit_and_wait() API, or just using io_uring_enter()
doing both submissions and completions. As a specific example,
RocksDB doing MultiGet() is sped up quite a bit with this
change.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index be24596e90d7..6587c8f80e81 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2040,7 +2040,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 }
 
 static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			struct sqe_submit *s)
+			struct sqe_submit *s, bool force_nonblock)
 {
 	int ret;
 
@@ -2053,7 +2053,7 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		return 0;
 	}
 
-	ret = __io_submit_sqe(ctx, req, s, true);
+	ret = __io_submit_sqe(ctx, req, s, force_nonblock);
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
 
@@ -2098,7 +2098,8 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
 
 static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
-			  struct io_submit_state *state, struct io_kiocb **link)
+			  struct io_submit_state *state, struct io_kiocb **link,
+			  bool force_nonblock)
 {
 	struct io_uring_sqe *sqe_copy;
 	struct io_kiocb *req;
@@ -2151,7 +2152,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		INIT_LIST_HEAD(&req->link_list);
 		*link = req;
 	} else {
-		io_queue_sqe(ctx, req, s);
+		io_queue_sqe(ctx, req, s, force_nonblock);
 	}
 }
 
@@ -2253,7 +2254,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 		 * that's the end of the chain. Submit the previous link.
 		 */
 		if (!prev_was_link && link) {
-			io_queue_sqe(ctx, link, &link->submit);
+			io_queue_sqe(ctx, link, &link->submit, true);
 			link = NULL;
 		}
 		prev_was_link = (sqes[i].sqe->flags & IOSQE_IO_LINK) != 0;
@@ -2265,13 +2266,13 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			sqes[i].has_user = has_user;
 			sqes[i].needs_lock = true;
 			sqes[i].needs_fixed_file = true;
-			io_submit_sqe(ctx, &sqes[i], statep, &link);
+			io_submit_sqe(ctx, &sqes[i], statep, &link, true);
 			submitted++;
 		}
 	}
 
 	if (link)
-		io_queue_sqe(ctx, link, &link->submit);
+		io_queue_sqe(ctx, link, &link->submit, true);
 	if (statep)
 		io_submit_state_end(&state);
 
@@ -2403,7 +2404,8 @@ static int io_sq_thread(void *data)
 	return 0;
 }
 
-static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
+static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
+			  bool block_for_last)
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
@@ -2416,6 +2418,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	}
 
 	for (i = 0; i < to_submit; i++) {
+		bool force_nonblock = true;
 		struct sqe_submit s;
 
 		if (!io_get_sqring(ctx, &s))
@@ -2426,7 +2429,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		 * that's the end of the chain. Submit the previous link.
 		 */
 		if (!prev_was_link && link) {
-			io_queue_sqe(ctx, link, &link->submit);
+			io_queue_sqe(ctx, link, &link->submit, force_nonblock);
 			link = NULL;
 		}
 		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
@@ -2435,12 +2438,23 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		s.needs_lock = false;
 		s.needs_fixed_file = false;
 		submit++;
-		io_submit_sqe(ctx, &s, statep, &link);
+
+		/*
+		 * The caller will block for events after submit, submit the
+		 * last IO non-blocking. This is either the only IO it's
+		 * submitting, or it already submitted the previous ones. This
+		 * improves performance by avoiding an async punt that we don't
+		 * need to do.
+		 */
+		if (block_for_last && submit == to_submit)
+			force_nonblock = false;
+
+		io_submit_sqe(ctx, &s, statep, &link, force_nonblock);
 	}
 	io_commit_sqring(ctx);
 
 	if (link)
-		io_queue_sqe(ctx, link, &link->submit);
+		io_queue_sqe(ctx, link, &link->submit, false);
 	if (statep)
 		io_submit_state_end(statep);
 
@@ -3208,10 +3222,13 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 
 	ret = 0;
 	if (to_submit) {
+		bool block_for_last;
+
 		to_submit = min(to_submit, ctx->sq_entries);
+		block_for_last = to_submit == min_complete;
 
 		mutex_lock(&ctx->uring_lock);
-		submitted = io_ring_submit(ctx, to_submit);
+		submitted = io_ring_submit(ctx, to_submit, block_for_last);
 		mutex_unlock(&ctx->uring_lock);
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {

-- 
Jens Axboe

