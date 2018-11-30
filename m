Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE81C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02202146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n+cGsW4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02202146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeLAEHT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:19 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38887 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLAEHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:18 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so10227557ith.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87XpvuDDlcLhO+RTk32hugbhh+JSJwc5rY+aocDNyxM=;
        b=n+cGsW4u1yCdB2HLqeIT/PbtOXG7gX6P5jfFcGsss3mXjvtmPcGMl/Y6ezEZqX17hy
         kXwqAJenkDRNGFmwT+mmGOHGFCDN2byioJm379u2WRMmu1FuiSMpyEGIxk0hlZ3fh5XF
         ghdzm6WdvjLo1oFedW4SmV/jQe50wuGKi9aXtLv38jj76XZdewFQ5mn7MOPiSJ4vxfJ1
         OkIrLPRVDudqdvA7QkbnrRxgYcKVDLVPpp+Olg3KDLY7Gg7M3qxGCuCi/2n41a70ldKp
         +V8NK3pkUCVAdJ+mdnWZJAYtEpmM48tGGdPeBGSlnANrsrJmgEpf8L+a8YJq/VMws109
         3E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87XpvuDDlcLhO+RTk32hugbhh+JSJwc5rY+aocDNyxM=;
        b=H663lvmHIFw7JbWB3bZnALuh1PIw/ECwdQQGBs+9wlU9gMO9dSB49WTgmzxli6hIxv
         p5dd6ll5N7dtKNaru+Q4IrpNt2Ur9YvHPxazUNMAtx5eG8mtH0054sW5Mg5u46vzQk7C
         iy4bqexDjXZdRZLiCX1Zj5nyHDSCR04tvKhpOfPPSNbUjvHaRXqf7X9NwTMcDzezyYfn
         iWuByQQbULLjcYu9IaYi8Ej51dd+2jSDdke5pZTTN2WBmNpDaIrNCW2YhIqmKAwDG27O
         GOvqmE41w7X5T0mDzHvn3k//BFOJaQVf85ii3azUMsxkIkbj4rOas73LXj2v/2hbT7QT
         ItCA==
X-Gm-Message-State: AA+aEWYx867oCWMSdHmTic4p0EqCqNVKNbXnCivcfZBJBshMT6Ap1LSL
        5mFkixRx9vWersHSNKbGHOmcluIX5LA=
X-Google-Smtp-Source: AFSGD/X2ivh+dObCO+W2p8nGQmOA1hJhuYwxkylBqK5n/y6HogmCoMql4C2STfH5jZ79+NBP2UitLA==
X-Received: by 2002:a24:f2c1:: with SMTP id j184mr5719431ith.35.1543597041885;
        Fri, 30 Nov 2018 08:57:21 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 20/27] aio: use fget/fput_many() for file references
Date:   Fri, 30 Nov 2018 09:56:39 -0700
Message-Id: <20181130165646.27341-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
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
index 182e2fc6ec82..291bbc62b2a8 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -243,6 +243,15 @@ struct aio_submit_state {
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
@@ -1344,7 +1353,8 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 {
 	void *iocbs[AIO_IOPOLL_BATCH];
 	struct aio_kiocb *iocb, *n;
-	int to_free = 0, ret = 0;
+	int file_count, to_free = 0, ret = 0;
+	struct file *file = NULL;
 
 	/* Shouldn't happen... */
 	if (*nr_events >= max)
@@ -1361,7 +1371,20 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
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
@@ -1371,6 +1394,9 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 		(*nr_events)++;
 	}
 
+	if (file)
+		fput_many(file, file_count);
+
 	if (to_free)
 		iocb_put_many(ctx, iocbs, &to_free);
 
@@ -1768,13 +1794,58 @@ static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
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
@@ -1924,7 +1995,8 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 }
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			bool vectored, bool compat)
+			struct aio_submit_state *state, bool vectored,
+			bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -1932,7 +2004,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1958,7 +2030,8 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 }
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			 bool vectored, bool compat)
+			 struct aio_submit_state *state, bool vectored,
+			 bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -1966,7 +2039,7 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -2277,16 +2350,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -2374,17 +2447,20 @@ static void aio_submit_state_end(struct aio_submit_state *state)
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
@@ -2431,7 +2507,7 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
@@ -2475,7 +2551,7 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
-- 
2.17.1

