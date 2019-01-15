Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED83C43612
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4068A206BA
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vKe7kf48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfAOC4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:56:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41757 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfAOCz6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:55:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so573757pfi.8
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ksruPEKzFOhRCy5jbp8Upn5+r3/UISBFDpyMnvsP50Q=;
        b=vKe7kf48ft5jjdB0BZO4Ybotpxuwme5QAbAtes+P5Y+EtgserVX31yNcjAMMkHpOJ/
         Of0JC340yd7NuoL+mRoCcJfY5cF22vsn//09ZvLt5TcDC84K5jBEb2cwM/01lC+t4e7m
         uDqqTApuim/T9X5NrHXOmU5Jxenz7LfdnsxYNgPa4zLoJU0rZiiXBpynQDoPBakUoG7A
         5v6MMcS94va0zGey7FhOh4ta2UQhgkqf0buXrpHRbgoPcr0uduXgx9DD/mC3QZv2JdKx
         25Qcdz8OHU6L1UwShFZeBkH+rgO2VynAbtFodHJL4mtzLF5SqZ1UsGXciCx5ICvHGB6s
         VDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ksruPEKzFOhRCy5jbp8Upn5+r3/UISBFDpyMnvsP50Q=;
        b=bzSxisQdDO6W7MnkUis+ZAvfL/oM2ev+Mu+J9esCj+US8ibfRd37XWqrELcSmm/Ddl
         VJgPrzDbngz9KLPGDUV76cC1kXbiny5vTMO/MPbq1e0D4VLCTDsHdQLch1b0mUM6vhgz
         m3FX360q+gh39L9+Cz8nMsqCChP9QJRrDy+yzjbH9b21+vhH8qzZqwvUi6k1aJJP2V5+
         oagddYgm8ZgG3TGQ5cpyei2E1Fi19IIjKzX/Dl4JfK5UZLMSeuiv+1rrBy4nCTkqKQ5E
         wb11WkagsCKj6xhGBI22XUyLqBCFkPDBfLlrQd9zIxApF8ecKoFc8VQvz0annKcCu/tB
         IYAg==
X-Gm-Message-State: AJcUukfIYG/BR6SMcraFnZja3/jjzMgltHAo2XEvbht3qwUIV5HhF1DU
        d2k2ZG8DZmIbzVtlZ0vc662APA==
X-Google-Smtp-Source: ALg8bN6M1oM5PW4EVE8bIHEAiKYh2R7LtaMfUeTVn7O+a8Fmyn6Nj4SmIZE1lXqOKcYNMY8UCiTGnw==
X-Received: by 2002:a62:6799:: with SMTP id t25mr1660272pfj.139.1547520957446;
        Mon, 14 Jan 2019 18:55:57 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:55:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] io_uring: use fget/fput_many() for file references
Date:   Mon, 14 Jan 2019 19:55:25 -0700
Message-Id: <20190115025531.13985-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On the submission side, add file reference batching to the
io_submit_state. We get as many references as the number of iocbs we
are submitting, and drop unused ones if we end up switching files. The
assumption here is that we're usually only dealing with one fd, and if
there are multiple, hopefuly they are at least somewhat ordered. Could
trivially be extended to cover multiple fds, if needed.

On the completion side we do the same thing, except this is trivially
done just locally in io_iopoll_reap().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 98 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 62f31f20f3d5..0d7c44a2d424 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -139,6 +139,15 @@ struct io_submit_state {
 	 */
 	struct list_multi req_list;
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
 
 static struct kmem_cache *req_cachep;
@@ -316,9 +325,11 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
@@ -328,11 +339,27 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
 
+	if (file)
+		fput_many(file, file_count);
 	if (to_free)
 		io_free_req_many(ctx, reqs, &to_free);
 }
@@ -522,14 +549,56 @@ static void io_iopoll_req_issued(struct io_submit_state *state,
 		io_iopoll_req_add_state(state, req);
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
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
+		      bool force_nonblock, struct io_submit_state *state)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
 	int ret;
 
-	kiocb->ki_filp = fget(sqe->fd);
+	kiocb->ki_filp = io_file_get(state, sqe->fd);
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
 	kiocb->ki_pos = sqe->off;
@@ -568,7 +637,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	fput(kiocb->ki_filp);
+	io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
 
@@ -607,7 +676,7 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 }
 
 static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		       bool force_nonblock)
+		       bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -615,7 +684,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, sqe, force_nonblock);
+	ret = io_prep_rw(req, sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -650,7 +719,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 }
 
 static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-			bool force_nonblock)
+			bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -658,7 +727,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, sqe, force_nonblock);
+	ret = io_prep_rw(req, sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -771,10 +840,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = io_nop(req, sqe);
 		break;
 	case IORING_OP_READV:
-		ret = io_read(req, sqe, force_nonblock);
+		ret = io_read(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_WRITEV:
-		ret = io_write(req, sqe, force_nonblock);
+		ret = io_write(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_FSYNC:
 		ret = io_fsync(req, sqe, force_nonblock);
@@ -877,17 +946,20 @@ static void io_submit_state_end(struct io_submit_state *state)
 	blk_finish_plug(&state->plug);
 	if (!list_empty(&state->req_list.list))
 		io_flush_state_reqs(state->ctx, state);
+	io_file_put(state, NULL);
 }
 
 /*
  * Start submission side cache.
  */
 static void io_submit_state_start(struct io_submit_state *state,
-				  struct io_ring_ctx *ctx)
+				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list.list);
 	state->req_count = 0;
+	state->file = NULL;
+	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
 	state->plug_cb.callback = io_state_unplug;
 	blk_start_plug(&state->plug);
@@ -933,7 +1005,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	int i, ret = 0, submit = 0;
 
 	if (to_submit > IO_PLUG_THRESHOLD) {
-		io_submit_state_start(&state, ctx);
+		io_submit_state_start(&state, ctx, to_submit);
 		statep = &state;
 	}
 
-- 
2.17.1

