Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3657C282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE3D21852
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jLiyKz5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfA2T1Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:24 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35732 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfA2T1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:23 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so6437487itp.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EVEpWstn5vxrAQFzCU3pYR02OVZlOOvK1pF+9JTcdtI=;
        b=jLiyKz5dhZTu74Kr7RUphUjdZ8AHlh6U3S5ka3jZzk4xjCQRBudUfMhrIpSaU965Bw
         VqaFgDBLazlvNuRuEAo6b7T8VpYtO+UGOKF4lewj9O0+vo0/VdUxUAdM4QXSIUx6Zb/H
         zLz/loOhUNaX35h36wmTjh95l+eBHZGXdCpGrWEe3U3tXyhbalxSI7eXvPwuCrc2wTbI
         h5qNV2vI4zr121T/ycpKvtj2v5XXgfhmOiihyOpH0QXD5RQNmxbvZ5syzlFAu7BIjESy
         lsN70IExFgdMiEuTc0jbBRbkge+bSljJ4khUdHvmIIRSslya21hCzpw2cGrgi+lMKflU
         pEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EVEpWstn5vxrAQFzCU3pYR02OVZlOOvK1pF+9JTcdtI=;
        b=D/4PEpGR8s34lICL9OWMoSFy2HM/M9aXQ0rHPMyhU4lx8BVrhoRU5rPKH44ChD7OMz
         PHWZmVhaXOyDf3VAzN/9N6lV72ungLHWrqqKUnai8xPvG5vpHv2FaUJ7dr0KZNACMX0C
         YuUOlmO1WABbvLKYXyPHpmPfqQKdQnYPSiNhewaJTHDdtjJuDD2DP5sKXpDvoeSwprLN
         Bfb0XfR5DnvUy/+08qNv2ommVQl8DfaecQ6M+kmed59+faxvL+Ec8sZE6DkTAkWZNzZg
         Hm+oaOxfeJ9NRprHkpthyUXuSvGmCoSWZkcLgG3ZGyKAS7+tyeRSB5lO3QL3wHdeGHtF
         AJAQ==
X-Gm-Message-State: AJcUukc6RUig6eDmYuMyFdiEvnRmLSNxiZqZHFkDcE5gMdf44CYxwuk6
        TBINS4ztWE06oPpkEhXamFB/9w==
X-Google-Smtp-Source: ALg8bN4pGN+Shf9qLEqVLxq8Xo1jy3EOxwMyb9mgkw9BPCtFwS0fylLgUafyc0HOFLmonyX++FEfjg==
X-Received: by 2002:a02:94eb:: with SMTP id x98mr16670743jah.88.1548790042612;
        Tue, 29 Jan 2019 11:27:22 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/18] io_uring: use fget/fput_many() for file references
Date:   Tue, 29 Jan 2019 12:26:53 -0700
Message-Id: <20190129192702.3605-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129192702.3605-1-axboe@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
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
 fs/io_uring.c | 139 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 118 insertions(+), 21 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a4f4d75609d5..a4c3c91abc76 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -132,6 +132,19 @@ struct io_kiocb {
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
@@ -279,9 +292,11 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
@@ -291,12 +306,28 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
 	if (to_free)
 		io_free_req_many(ctx, reqs, &to_free);
 }
@@ -478,8 +509,50 @@ static void io_iopoll_req_issued(struct io_kiocb *req)
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
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
+		      bool force_nonblock, struct io_submit_state *state)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
@@ -487,7 +560,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	int fd, ret;
 
 	fd = READ_ONCE(sqe->fd);
-	kiocb->ki_filp = fget(fd);
+	kiocb->ki_filp = io_file_get(state, fd);
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
 	kiocb->ki_pos = READ_ONCE(sqe->off);
@@ -528,7 +601,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	fput(kiocb->ki_filp);
+	io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
 
@@ -570,7 +643,7 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 }
 
 static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		       bool force_nonblock)
+		       bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -578,7 +651,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, sqe, force_nonblock);
+	ret = io_prep_rw(req, sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -613,7 +686,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 }
 
 static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-			bool force_nonblock)
+			bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -621,7 +694,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, sqe, force_nonblock);
+	ret = io_prep_rw(req, sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -721,7 +794,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   const struct sqe_submit *s, bool force_nonblock)
+			   const struct sqe_submit *s, bool force_nonblock,
+			   struct io_submit_state *state)
 {
 	ssize_t ret;
 	int opcode;
@@ -737,10 +811,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = io_nop(req, req->user_data);
 		break;
 	case IORING_OP_READV:
-		ret = io_read(req, s->sqe, force_nonblock);
+		ret = io_read(req, s->sqe, force_nonblock, state);
 		break;
 	case IORING_OP_WRITEV:
-		ret = io_write(req, s->sqe, force_nonblock);
+		ret = io_write(req, s->sqe, force_nonblock, state);
 		break;
 	case IORING_OP_FSYNC:
 		ret = io_fsync(req, s->sqe, force_nonblock);
@@ -788,7 +862,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	use_mm(ctx->sqo_mm);
 	set_fs(USER_DS);
 
-	ret = __io_submit_sqe(ctx, req, s, false);
+	ret = __io_submit_sqe(ctx, req, s, false, NULL);
 
 	set_fs(old_fs);
 	unuse_mm(ctx->sqo_mm);
@@ -804,7 +878,8 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	task_unlock(current);
 }
 
-static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
+static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
+			 struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 	ssize_t ret;
@@ -817,7 +892,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
 	if (unlikely(!req))
 		return -EAGAIN;
 
-	ret = __io_submit_sqe(ctx, req, s, true);
+	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
 		memcpy(&req->submit, s, sizeof(*s));
 		INIT_WORK(&req->work, io_sq_wq_submit_work);
@@ -830,6 +905,26 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
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
@@ -892,11 +987,13 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
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
@@ -904,7 +1001,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!io_get_sqring(ctx, &s))
 			break;
 
-		ret = io_submit_sqe(ctx, &s);
+		ret = io_submit_sqe(ctx, &s, statep);
 		if (ret) {
 			io_drop_sqring(ctx);
 			break;
@@ -914,8 +1011,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
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

