Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04495C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B446920880
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uAIwjxgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B446920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeLKAQe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36109 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbeLKAQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so6032917plo.3
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/oAfHym5lithpgO5SQjc7fd2In+73xfaMkIl93wN+2Y=;
        b=uAIwjxgB2KwmX6ouR91PO3/TvYZ3ghpPaB/aBfojSmZ15L8N0EGuNrfncH5tK6KDoj
         aIKHA3q+QU/3lvGf/rB2ANFITWB5+/uMW8ebTfTHVV5K8eo+GZn7giEzuJ5Wlwm/ECcM
         Gj7TmgM4A1nVGHSpw6LC7i4oQVUAXfqRfIp3VLyjD5mLYdYt1YfUJV9QnyAU2DUkcGz1
         hrHWfhUfAGxJ4c2koUap6Yd0lIpjPi+zyJhTY9u0nrjmV0KBI/9WHIYNl+2hR8BRmZHR
         Fi0VbRlwEt1ph4lguH9cGqd1qsYFSX4jHvtOoAUuPPh66RITVH/PD5Li7qL9cBKSJTyz
         v+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/oAfHym5lithpgO5SQjc7fd2In+73xfaMkIl93wN+2Y=;
        b=GN0UxEPsX+wAMsk302565cc1yzIye5RpcWH4pFghlahTUa+HMGpO4+qECf2b3CUlSo
         US96PPhRevMgwLnM89/QayeE7GZhzYNrREbDKpctaNan9KzC/MRm8cEHjz3BYdtLOYYq
         XR6n4V9MoioCc03evA2nQjFddDZQRDrxVE3J4iZG55eTPi6d2o7rHFHMykRXs1XNF03I
         lCS0h3/xWChXdvQCvLz4R5OLMcr2vrS7Y74MSRFnwD9jZSpT1u/tKJqtfg0EGtLxLI9I
         ScmZ11vced60P++4ji98wawS4wvkBXXcHZD6jRUAob7Qdxzq6WOt3VQWCPfGIus4J5i5
         wzkA==
X-Gm-Message-State: AA+aEWaTgZXIFNOBUH+rrz9ZFwWLAhGgfig5XEQzVA31HlOTRVZIxC2Y
        +8JstLJzJ8p8puRWUA9rwCqjWOaR5sQk4w==
X-Google-Smtp-Source: AFSGD/XCo3anE255QRMJyLxsI7gc3jcVFkxlY9+ayQnnJo5PlsiENRdndWBUGyt9z8NN9aw1ja8DAg==
X-Received: by 2002:a17:902:4827:: with SMTP id s36mr13550144pld.168.1544487392422;
        Mon, 10 Dec 2018 16:16:32 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/27] aio: use fget/fput_many() for file references
Date:   Mon, 10 Dec 2018 17:15:40 -0700
Message-Id: <20181211001549.30085-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On the submission side, add file reference batching to the
aio_submit_state. We get as many references as the number of iocbs we
are submitting, and drop unused ones if we end up switching files. The
assumption here is that we're usually only dealing with one fd, and if
there are multiple, hopefuly they are at least somewhat ordered. Could
trivially be extended to cover multiple fds, if needed.

On the completion side we do the same thing, except this is trivially
done just locally in aio_iopoll_reap().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 15 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 2e8cde976cb4..6cbfe9905637 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -253,6 +253,15 @@ struct aio_submit_state {
 	 */
 	struct list_head req_list;
 	unsigned int req_count;
+
+	/*
+	 * File reference cache
+	 */
+	struct file *file;
+	unsigned int fd;
+	unsigned int has_refs;
+	unsigned int used_refs;
+	unsigned int ios_left;
 };
 
 /*------ sysctl variables----*/
@@ -1355,7 +1364,8 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 {
 	void *iocbs[AIO_IOPOLL_BATCH];
 	struct aio_kiocb *iocb, *n;
-	int to_free = 0, ret = 0;
+	int file_count, to_free = 0, ret = 0;
+	struct file *file = NULL;
 
 	/* Shouldn't happen... */
 	if (*nr_events >= max)
@@ -1372,7 +1382,20 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 		list_del(&iocb->ki_list);
 		iocbs[to_free++] = iocb;
 
-		fput(iocb->rw.ki_filp);
+		/*
+		 * Batched puts of the same file, to avoid dirtying the
+		 * file usage count multiple times, if avoidable.
+		 */
+		if (!file) {
+			file = iocb->rw.ki_filp;
+			file_count = 1;
+		} else if (file == iocb->rw.ki_filp) {
+			file_count++;
+		} else {
+			fput_many(file, file_count);
+			file = iocb->rw.ki_filp;
+			file_count = 1;
+		}
 
 		if (evs && copy_to_user(evs + *nr_events, &iocb->ki_ev,
 		    sizeof(iocb->ki_ev))) {
@@ -1382,6 +1405,9 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 		(*nr_events)++;
 	}
 
+	if (file)
+		fput_many(file, file_count);
+
 	if (to_free)
 		iocb_put_many(ctx, iocbs, &to_free);
 
@@ -1818,13 +1844,58 @@ static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
 	}
 }
 
-static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb)
+static void aio_file_put(struct aio_submit_state *state)
+{
+	if (state->file) {
+		int diff = state->has_refs - state->used_refs;
+
+		if (diff)
+			fput_many(state->file, diff);
+		state->file = NULL;
+	}
+}
+
+/*
+ * Get as many references to a file as we have IOs left in this submission,
+ * assuming most submissions are for one file, or at least that each file
+ * has more than one submission.
+ */
+static struct file *aio_file_get(struct aio_submit_state *state, int fd)
+{
+	if (!state)
+		return fget(fd);
+
+	if (!state->file) {
+get_file:
+		state->file = fget_many(fd, state->ios_left);
+		if (!state->file)
+			return NULL;
+
+		state->fd = fd;
+		state->has_refs = state->ios_left;
+		state->used_refs = 1;
+		state->ios_left--;
+		return state->file;
+	}
+
+	if (state->fd == fd) {
+		state->used_refs++;
+		state->ios_left--;
+		return state->file;
+	}
+
+	aio_file_put(state);
+	goto get_file;
+}
+
+static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb,
+		       struct aio_submit_state *state)
 {
 	struct kioctx *ctx = kiocb->ki_ctx;
 	struct kiocb *req = &kiocb->rw;
 	int ret;
 
-	req->ki_filp = fget(iocb->aio_fildes);
+	req->ki_filp = aio_file_get(state, iocb->aio_fildes);
 	if (unlikely(!req->ki_filp))
 		return -EBADF;
 	req->ki_pos = iocb->aio_offset;
@@ -1974,7 +2045,8 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 }
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			bool vectored, bool compat)
+			struct aio_submit_state *state, bool vectored,
+			bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -1982,7 +2054,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -2008,7 +2080,8 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 }
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			 bool vectored, bool compat)
+			 struct aio_submit_state *state, bool vectored,
+			 bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2016,7 +2089,7 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -2327,16 +2400,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	ret = -EINVAL;
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(req, iocb, false, compat);
+		ret = aio_read(req, iocb, state, false, compat);
 		break;
 	case IOCB_CMD_PWRITE:
-		ret = aio_write(req, iocb, false, compat);
+		ret = aio_write(req, iocb, state, false, compat);
 		break;
 	case IOCB_CMD_PREADV:
-		ret = aio_read(req, iocb, true, compat);
+		ret = aio_read(req, iocb, state, true, compat);
 		break;
 	case IOCB_CMD_PWRITEV:
-		ret = aio_write(req, iocb, true, compat);
+		ret = aio_write(req, iocb, state, true, compat);
 		break;
 	case IOCB_CMD_FSYNC:
 		if (ctx->flags & IOCTX_FLAG_IOPOLL)
@@ -2424,17 +2497,20 @@ static void aio_submit_state_end(struct aio_submit_state *state)
 	blk_finish_plug(&state->plug);
 	if (!list_empty(&state->req_list))
 		aio_flush_state_reqs(state->ctx, state);
+	aio_file_put(state);
 }
 
 /*
  * Start submission side cache.
  */
 static void aio_submit_state_start(struct aio_submit_state *state,
-				   struct kioctx *ctx)
+				   struct kioctx *ctx, int max_ios)
 {
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->file = NULL;
+	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
 	state->plug_cb.callback = aio_state_unplug;
 	blk_start_plug(&state->plug);
@@ -2475,7 +2551,7 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
@@ -2519,7 +2595,7 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
-- 
2.17.1

