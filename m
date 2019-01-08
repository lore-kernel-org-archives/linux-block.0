Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7CEC43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54287214C6
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FVWoicZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfAHQ5M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46163 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfAHQ5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:10 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so3640646ios.13
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IVD1aACbOf9E3T2cMeMXe0vYKp9FPjypBFliz/GxAEQ=;
        b=FVWoicZFSmyI3NpZH8o7XG3pwewvO05qPKnQyE4SSkEgPKTVgS6REhszGXnS1zU1vY
         1RgcgkjiIODHuZ1ARgjxXCmeEtNzM6vNFRkJHNgAPPSpG4mXMVZZyLmCuATa/DR0QkVU
         zySx9H3csuKKFqKCTTSrs8EBKiV3iLB/omnglR09IaKc7OBLr16I4fjG5V0LPFtLCc58
         +9jgD1f2UpYt3SFagG5LS/wcKwlr89eA0IkrbaFQ8qAgHiHqhI23660KBjI4HrWfl0l4
         M/M+fZFkfmsIzaHn1SAACSw2wk+cCYldxU84aN5ESgUtQdwtgcnQ8ZhF94wKxODSPYYi
         ehTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IVD1aACbOf9E3T2cMeMXe0vYKp9FPjypBFliz/GxAEQ=;
        b=k4Gn45W3LWV4byqCBsV2S7TOMn+mPKtgf7BFwGI8THS11S7LLodOn6bY5/yb7MaKuC
         453RNk06h9CjjxrajrwbNcZa5T500gLled/S+QDFnQLvhDFfQoaaP6l3AMaJQxWUglog
         LvMhjpfXfOktbPsyzOMUGhp9r9akslm79sslmdKJ7WGCOfUDVcU28/0VMlt3fImqVmGw
         dzSJK6pl3xUKBcqJxgFppjoNgDOl85RUss5ZJyO/Hg+UvZLCz2Yeq70v5XJSph9pRnBv
         RFAdqYDxkNV0uq2X8lpe2sUgTn3Bks/PqnuHKWzWcEHOx1duUkRvcAXLJZ4dYJBslQw4
         yIYQ==
X-Gm-Message-State: AJcUukdkODxUwcul/vU1z33ZDZS0J96AhaONJL/9Vi7vS+yTvUH59AlL
        dvMoUN7B4ebCI54gPgnAjFDogg==
X-Google-Smtp-Source: ALg8bN7pqQLuBunNQFEh9uG7z7iOvCRuESJ1wBwEchD7J87Wa/ZaQt/zkkZFpbMm1J15n1qFFXnx9Q==
X-Received: by 2002:a6b:c402:: with SMTP id y2mr1690122ioa.77.1546966629440;
        Tue, 08 Jan 2019 08:57:09 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/16] io_uring: use fget/fput_many() for file references
Date:   Tue,  8 Jan 2019 09:56:38 -0700
Message-Id: <20190108165645.19311-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
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
 fs/io_uring.c | 105 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9f36eb728208..afbaebb63012 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -134,6 +134,15 @@ struct io_submit_state {
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
 
 static struct kmem_cache *kiocb_cachep, *ioctx_cachep;
@@ -237,7 +246,8 @@ static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
 {
 	void *iocbs[IO_IOPOLL_BATCH];
 	struct io_kiocb *iocb, *n;
-	int to_free = 0;
+	int file_count, to_free = 0;
+	struct file *file = NULL;
 
 	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
 		if (!test_bit(KIOCB_F_IOPOLL_COMPLETED, &iocb->ki_flags))
@@ -248,10 +258,27 @@ static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
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
+
 		(*nr_events)++;
 	}
 
+	if (file)
+		fput_many(file, file_count);
+
 	if (to_free)
 		iocb_put_many(ctx, iocbs, &to_free);
 }
@@ -433,13 +460,60 @@ static void io_complete_scqring_iopoll(struct kiocb *kiocb, long res, long res2)
 	}
 }
 
-static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
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
+	io_file_put(state, NULL);
+	goto get_file;
+}
+
+static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
+		      struct io_submit_state *state)
 {
 	struct io_ring_ctx *ctx = kiocb->ki_ctx;
 	struct kiocb *req = &kiocb->rw;
 	int ret;
 
-	req->ki_filp = fget(iocb->fd);
+	req->ki_filp = io_file_get(state, iocb->fd);
 	if (unlikely(!req->ki_filp))
 		return -EBADF;
 	req->ki_pos = iocb->off;
@@ -473,7 +547,7 @@ static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
 	}
 	return 0;
 out_fput:
-	fput(req->ki_filp);
+	io_file_put(state, req->ki_filp);
 	return ret;
 }
 
@@ -567,7 +641,8 @@ static void io_iopoll_iocb_issued(struct io_submit_state *state,
 		io_iopoll_iocb_add_state(state, kiocb);
 }
 
-static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
+static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
+		       struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -575,7 +650,7 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(kiocb, iocb);
+	ret = io_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -602,7 +677,8 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
 }
 
 static ssize_t io_write(struct io_kiocb *kiocb,
-			const struct io_uring_iocb *iocb)
+			const struct io_uring_iocb *iocb,
+			struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -610,7 +686,7 @@ static ssize_t io_write(struct io_kiocb *kiocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(kiocb, iocb);
+	ret = io_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -704,10 +780,10 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
 	ret = -EINVAL;
 	switch (iocb->opcode) {
 	case IORING_OP_READ:
-		ret = io_read(req, iocb);
+		ret = io_read(req, iocb, state);
 		break;
 	case IORING_OP_WRITE:
-		ret = io_write(req, iocb);
+		ret = io_write(req, iocb, state);
 		break;
 	case IORING_OP_FSYNC:
 		if (ctx->flags & IORING_SETUP_IOPOLL)
@@ -762,17 +838,20 @@ static void io_submit_state_end(struct io_submit_state *state)
 	blk_finish_plug(&state->plug);
 	if (!list_empty(&state->req_list))
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
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->file = NULL;
+	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
 	state->plug_cb.callback = io_state_unplug;
 	blk_start_plug(&state->plug);
@@ -818,7 +897,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	int i, ret = 0, submit = 0;
 
 	if (to_submit > IO_PLUG_THRESHOLD) {
-		io_submit_state_start(&state, ctx);
+		io_submit_state_start(&state, ctx, to_submit);
 		statep = &state;
 	}
 
-- 
2.17.1

