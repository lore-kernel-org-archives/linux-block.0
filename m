Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0774CC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDA821B25
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KcAKnv3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfBKTBN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:13 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51636 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbfBKTBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:01:12 -0500
Received: by mail-it1-f194.google.com with SMTP id y184so923754itc.1
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fEzXSEdtvemzDNbLLxmW/ZdccZCBI4iAZZs/O1veMj4=;
        b=KcAKnv3dXw+OndwLiUFBHmJ7jkr1b9ANgKXwNXoBCYxfT+lpbn0nEGwKcRd/iHq+3H
         jCCjOv3htCWmSh2eqDUjh12m9hOy8E5lEu5h+WTR4mcU0yAMeG+FlekUtHKupwP2gD7H
         YuA7ZjJ1BlJ4zQIdpGutlWhni6jrb/1+lWGb/vTW3ayCLyNhylEZjLiGpeM/22Y+V7Fo
         t6Mho0Df5gsdJWGz3R5NjRNq1Y9AEscN7xyAIzGyGGfJaghQrlWa5QagQV/IxqDE+EMu
         yWg5/hhRPbuCqW2myRt5PqeObuFIrFc+Eg+OM4qv/IyvaXjIIkyPlhBL4XqJ3EaGF3qG
         becg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fEzXSEdtvemzDNbLLxmW/ZdccZCBI4iAZZs/O1veMj4=;
        b=C+vam8kfTdVIzK4t+v/vbyFzcOzYCGLaHS/iqiiObtnTs0pbNWUSjgBNkxTQp1IUnK
         LipWOfdGhorccQ5jSSPb7oF+LoeOsmYGAtPM0xj0+15fSGovjucRl6+6DUx6MF6LZxNx
         KRIw2F5Y0ewGq4rD1IZshzNHQkZIT0E/wNpbpwMaxw1dUSyyudqYqNTIczwYHvwnptkw
         M+kKchl0T7bIVEMaI7i223+Z8HPlH+jEJ7kNhUvCahqIXOm+RlJdSRw3UNwHj8Zx+b2o
         uaWj+yov9cNKov2T0EwfASJ11RBLQG3pbVwyxJYEgUy48mPsaeq3b1VxLMp8ylXnMAjW
         0N8Q==
X-Gm-Message-State: AHQUAua8+pNMiu2JAVy11woJSvOpV2KrgqNTCSrYu3wo7+Dwh6c+kA44
        Gdd7dQW4hgYmqQiB2gItamPG4Q==
X-Google-Smtp-Source: AHgI3IaRLa40hj/B9u9H+mu3iKONdMvGfZPT037AfFB2R0CHt+3uqWIelgo+MFRwlFg1GDl5zYOFEw==
X-Received: by 2002:a02:7e4b:: with SMTP id h72mr9476566jac.129.1549911671410;
        Mon, 11 Feb 2019 11:01:11 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:01:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/19] io_uring: use fget/fput_many() for file references
Date:   Mon, 11 Feb 2019 12:00:39 -0700
Message-Id: <20190211190049.7888-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a separate io_submit_state structure, to cache some of the things
we need for IO submission.

One such example is file reference batching. io_submit_state. We get as
many references as the number of sqes we are submitting, and drop
unused ones if we end up switching files. The assumption here is that
we're usually only dealing with one fd, and if there are multiple,
hopefuly they are at least somewhat ordered. Could trivially be extended
to cover multiple fds, if needed.

On the completion side we do the same thing, except this is trivially
done just locally in io_iopoll_reap().

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 142 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 121 insertions(+), 21 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 30efe5edf6aa..7358dd1dbf3f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -165,6 +165,19 @@ struct io_kiocb {
 #define IO_PLUG_THRESHOLD		2
 #define IO_IOPOLL_BATCH			8
 
+struct io_submit_state {
+	struct blk_plug		plug;
+
+	/*
+	 * File reference cache
+	 */
+	struct file		*file;
+	unsigned int		fd;
+	unsigned int		has_refs;
+	unsigned int		used_refs;
+	unsigned int		ios_left;
+};
+
 static struct kmem_cache *req_cachep;
 
 static const struct file_operations io_uring_fops;
@@ -332,9 +345,11 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			       struct list_head *done)
 {
 	void *reqs[IO_IOPOLL_BATCH];
+	int file_count, to_free;
+	struct file *file = NULL;
 	struct io_kiocb *req;
-	int to_free = 0;
 
+	file_count = to_free = 0;
 	while (!list_empty(done)) {
 		req = list_first_entry(done, struct io_kiocb, list);
 		list_del(&req->list);
@@ -344,12 +359,28 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		reqs[to_free++] = req;
 		(*nr_events)++;
 
-		fput(req->rw.ki_filp);
+		/*
+		 * Batched puts of the same file, to avoid dirtying the
+		 * file usage count multiple times, if avoidable.
+		 */
+		if (!file) {
+			file = req->rw.ki_filp;
+			file_count = 1;
+		} else if (file == req->rw.ki_filp) {
+			file_count++;
+		} else {
+			fput_many(file, file_count);
+			file = req->rw.ki_filp;
+			file_count = 1;
+		}
+
 		if (to_free == ARRAY_SIZE(reqs))
 			io_free_req_many(ctx, reqs, &to_free);
 	}
 	io_commit_cqring(ctx);
 
+	if (file)
+		fput_many(file, file_count);
 	io_free_req_many(ctx, reqs, &to_free);
 }
 
@@ -530,6 +561,48 @@ static void io_iopoll_req_issued(struct io_kiocb *req)
 		list_add_tail(&req->list, &ctx->poll_list);
 }
 
+static void io_file_put(struct io_submit_state *state, struct file *file)
+{
+	if (!state) {
+		fput(file);
+	} else if (state->file) {
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
+static struct file *io_file_get(struct io_submit_state *state, int fd)
+{
+	if (!state)
+		return fget(fd);
+
+	if (state->file) {
+		if (state->fd == fd) {
+			state->used_refs++;
+			state->ios_left--;
+			return state->file;
+		}
+		io_file_put(state, NULL);
+	}
+	state->file = fget_many(fd, state->ios_left);
+	if (!state->file)
+		return NULL;
+
+	state->fd = fd;
+	state->has_refs = state->ios_left;
+	state->used_refs = 1;
+	state->ios_left--;
+	return state->file;
+}
+
 /*
  * If we tracked the file through the SCM inflight mechanism, we could support
  * any file. For now, just ensure that anything potentially problematic is done
@@ -548,7 +621,7 @@ static bool io_file_supports_async(struct file *file)
 }
 
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
+		      bool force_nonblock, struct io_submit_state *state)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
@@ -560,7 +633,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		return 0;
 
 	fd = READ_ONCE(sqe->fd);
-	kiocb->ki_filp = fget(fd);
+	kiocb->ki_filp = io_file_get(state, fd);
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
 	if (force_nonblock && !io_file_supports_async(kiocb->ki_filp))
@@ -604,7 +677,10 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	fput(kiocb->ki_filp);
+	/* in case of error, we didn't use this file reference. drop it. */
+	if (state)
+		state->used_refs--;
+	io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
 
@@ -650,7 +726,7 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 }
 
 static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
-		       bool force_nonblock)
+		       bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -658,7 +734,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s->sqe, force_nonblock);
+	ret = io_prep_rw(req, s->sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -694,7 +770,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 }
 
 static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
-			bool force_nonblock)
+			bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -702,7 +778,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s->sqe, force_nonblock);
+	ret = io_prep_rw(req, s->sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	/* Hold on to the file for -EAGAIN */
@@ -826,7 +902,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   const struct sqe_submit *s, bool force_nonblock)
+			   const struct sqe_submit *s, bool force_nonblock,
+			   struct io_submit_state *state)
 {
 	ssize_t ret;
 	int opcode;
@@ -841,10 +918,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = io_nop(req, req->user_data);
 		break;
 	case IORING_OP_READV:
-		ret = io_read(req, s, force_nonblock);
+		ret = io_read(req, s, force_nonblock, state);
 		break;
 	case IORING_OP_WRITEV:
-		ret = io_write(req, s, force_nonblock);
+		ret = io_write(req, s, force_nonblock, state);
 		break;
 	case IORING_OP_FSYNC:
 		ret = io_fsync(req, s->sqe, force_nonblock);
@@ -896,7 +973,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	s->needs_lock = true;
 
 	do {
-		ret = __io_submit_sqe(ctx, req, s, false);
+		ret = __io_submit_sqe(ctx, req, s, false, NULL);
 		/*
 		 * We can get EAGAIN for polled IO even though we're forcing
 		 * a sync submission from here, since we can't wait for
@@ -920,7 +997,8 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	kfree(sqe);
 }
 
-static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
+static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
+			 struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 	ssize_t ret;
@@ -935,7 +1013,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
 	req->rw.ki_filp = NULL;
 
-	ret = __io_submit_sqe(ctx, req, s, true);
+	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
 		struct io_uring_sqe *sqe_copy;
 
@@ -956,6 +1034,26 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	return ret;
 }
 
+/*
+ * Batched submission is done, ensure local IO is flushed out.
+ */
+static void io_submit_state_end(struct io_submit_state *state)
+{
+	blk_finish_plug(&state->plug);
+	io_file_put(state, NULL);
+}
+
+/*
+ * Start submission side cache.
+ */
+static void io_submit_state_start(struct io_submit_state *state,
+				  struct io_ring_ctx *ctx, unsigned max_ios)
+{
+	blk_start_plug(&state->plug);
+	state->file = NULL;
+	state->ios_left = max_ios;
+}
+
 static void io_commit_sqring(struct io_ring_ctx *ctx)
 {
 	struct io_sq_ring *ring = ctx->sq_ring;
@@ -1023,11 +1121,13 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
 static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
+	struct io_submit_state state, *statep = NULL;
 	int i, ret = 0, submit = 0;
-	struct blk_plug plug;
 
-	if (to_submit > IO_PLUG_THRESHOLD)
-		blk_start_plug(&plug);
+	if (to_submit > IO_PLUG_THRESHOLD) {
+		io_submit_state_start(&state, ctx, to_submit);
+		statep = &state;
+	}
 
 	for (i = 0; i < to_submit; i++) {
 		struct sqe_submit s;
@@ -1038,7 +1138,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		s.has_user = true;
 		s.needs_lock = false;
 
-		ret = io_submit_sqe(ctx, &s);
+		ret = io_submit_sqe(ctx, &s, statep);
 		if (ret) {
 			io_drop_sqring(ctx);
 			break;
@@ -1048,8 +1148,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	}
 	io_commit_sqring(ctx);
 
-	if (to_submit > IO_PLUG_THRESHOLD)
-		blk_finish_plug(&plug);
+	if (statep)
+		io_submit_state_end(statep);
 
 	return submit ? submit : ret;
 }
-- 
2.17.1

