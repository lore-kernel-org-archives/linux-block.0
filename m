Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8475C282C4
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F8A21872
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d3US/kJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBGT4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36026 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfBGT4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:16 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so2969660itj.1
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZnyEzVIX6pQDgSUenqYBdx8lBpdlDoO+QEnLqKLjuOs=;
        b=d3US/kJlHVaPTn0ZGmbvOkutjHDTgzSVoR2hOtcU+TV5Ifad6zOMvgPE+5abZ5nzFb
         hE+O0GTW/9uUghhUu9dFUlRCzY0COsb2Ui3qyfTqv4rPPO86Og56uR9jaTyqRFqE6Wvr
         Vw3QrG7rpfaRKx22fvZPum/ZR32Qp/0fO9Gog3YMbJK+qCvuUsQAIULCQzxm7i25a35g
         4Z0KDYrYX3y2ljnIsDvHJWf3iSXjxpBGXvJxFNxcUcrmtHefjYHOeuNPF+GeIeSesakq
         wajiRMFjyTph7iF3kKPHpVf8lSEzUBdyGu2NZ1DR1vl9TPj1z/yQ/06n2MPOyAJCm1Yi
         vO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZnyEzVIX6pQDgSUenqYBdx8lBpdlDoO+QEnLqKLjuOs=;
        b=qL0I5v2NBQvtHNwgOEu9Y+hsM4ePNqWVEsPC1UxxdSluV/cJXEntT0iVZYFKZDeV9M
         DANqR4jkXd+63oihQB6HexQD1Nj3pRhWgxDXJqd9P/AcY33VXJLOilWXc24Y6kEej69L
         F+F9IpRzbVNJva9BDEfgYA+uHEI6z/KXRBjXeFAaMTpyP6a81+b7TnelEyMdWJbrYW0i
         /xSq/Qj2GP1caxNOFn+S3LHquosHJ3wVhHGTzK2miUEppyneps85jmp9jUmTMY4Hwz+U
         zF0VY5wqFheKPRCU4tHTF5V8iFL2hus/lifclYQVczoKvOgqbMG3fSsQirdxYOugtqDX
         Kq4A==
X-Gm-Message-State: AHQUAuZUcAa/PtUJmCgkG8mul/r2/X/LZRKszr/uQ222BdHNAYsFhYZE
        mdzj4CwCstR3v+B4s7Jg+WrPDQ==
X-Google-Smtp-Source: AHgI3IbY3OGHFOhEaJNOBnJ3iDhJPreTccBdsL6rOyF9TI14Ks5512aKQXMcVLF8bxK2ytRVsETEnw==
X-Received: by 2002:a6b:5b01:: with SMTP id v1mr7630586ioh.12.1549569375406;
        Thu, 07 Feb 2019 11:56:15 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/18] io_uring: use fget/fput_many() for file references
Date:   Thu,  7 Feb 2019 12:55:43 -0700
Message-Id: <20190207195552.22770-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
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

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 142 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 121 insertions(+), 21 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5e83391dc538..e23e639a4ff0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -144,6 +144,19 @@ struct io_kiocb {
 #define IO_PLUG_THRESHOLD		2
 #define IO_IOPOLL_BATCH			8
 
+struct io_submit_state {
+	struct blk_plug plug;
+
+	/*
+	 * File reference cache
+	 */
+	struct file *file;
+	unsigned int fd;
+	unsigned int has_refs;
+	unsigned int used_refs;
+	unsigned int ios_left;
+};
+
 static struct kmem_cache *req_cachep;
 
 static const struct file_operations io_uring_fops;
@@ -303,9 +316,11 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
@@ -315,12 +330,28 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
 
@@ -501,6 +532,48 @@ static void io_iopoll_req_issued(struct io_kiocb *req)
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
@@ -519,7 +592,7 @@ static bool io_file_supports_async(struct file *file)
 }
 
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
+		      bool force_nonblock, struct io_submit_state *state)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
@@ -531,7 +604,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		return 0;
 
 	fd = READ_ONCE(sqe->fd);
-	kiocb->ki_filp = fget(fd);
+	kiocb->ki_filp = io_file_get(state, fd);
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
 	if (force_nonblock && !io_file_supports_async(kiocb->ki_filp))
@@ -575,7 +648,10 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
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
 
@@ -621,7 +697,7 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 }
 
 static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
-		       bool force_nonblock)
+		       bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -629,7 +705,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s->sqe, force_nonblock);
+	ret = io_prep_rw(req, s->sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -665,7 +741,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 }
 
 static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
-			bool force_nonblock)
+			bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -673,7 +749,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s->sqe, force_nonblock);
+	ret = io_prep_rw(req, s->sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	/* Hold on to the file for -EAGAIN */
@@ -772,7 +848,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   const struct sqe_submit *s, bool force_nonblock)
+			   const struct sqe_submit *s, bool force_nonblock,
+			   struct io_submit_state *state)
 {
 	ssize_t ret;
 	int opcode;
@@ -787,10 +864,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
@@ -842,7 +919,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	s->needs_lock = true;
 
 	do {
-		ret = __io_submit_sqe(ctx, req, s, false);
+		ret = __io_submit_sqe(ctx, req, s, false, NULL);
 		/*
 		 * We can get EAGAIN for polled IO even though we're forcing
 		 * a sync submission from here, since we can't wait for
@@ -863,7 +940,8 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	}
 }
 
-static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
+static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
+			 struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 	ssize_t ret;
@@ -878,7 +956,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
 
 	req->rw.ki_filp = NULL;
 
-	ret = __io_submit_sqe(ctx, req, s, true);
+	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
 		memcpy(&req->submit, s, sizeof(*s));
 		INIT_WORK(&req->work, io_sq_wq_submit_work);
@@ -891,6 +969,26 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
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
@@ -953,11 +1051,13 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
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
@@ -968,7 +1068,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		s.has_user = true;
 		s.needs_lock = false;
 
-		ret = io_submit_sqe(ctx, &s);
+		ret = io_submit_sqe(ctx, &s, statep);
 		if (ret) {
 			io_drop_sqring(ctx);
 			break;
@@ -978,8 +1078,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
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

