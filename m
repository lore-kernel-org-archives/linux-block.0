Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC0C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFD220850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B3r3zdMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFD220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeLDXiW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44885 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeLDXiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so9065680pls.11
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=judl9Bd+gAX598NMF94uBUUR80aUoPJYBIu45By8XSI=;
        b=B3r3zdMGPoORa2HjO1m0dRG8Bk6Go31u2iz8zQOAfA2eTpmuRaPDS0Sdt50gfdEAGz
         UCTmBmvYaDqyCNJBTpADPA1gZyKD31G+NHfaXQ+xXiKU6S01FCfciY/8Tx83NgO67gjp
         YYZGRLIgr0mlQjXiofVjaZjuNPp8TFGrlcmULjgvYwdYz6d/hheZJPAiAAGrWOSdWKCT
         /ktFSIgLT5GOlcZctoAWUnolgH5gU7cQHt2jmwAE8B+IRQQvEpzkhlUwlZXC05Xg1TtC
         YL9rGmQ+8FZrn9qIAqLe1VtWW3BBtvS1MIf6+HX7+QO0Wi40EDGSXx1rXftXtyIXyVwy
         y0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=judl9Bd+gAX598NMF94uBUUR80aUoPJYBIu45By8XSI=;
        b=fWB2+mJ5fOtD736XpNShe3nU/wmxax1Q5Wy+lRLCGepbXuKB1iUansk/OxLEWMckZP
         lGPikWDFJ3bo94LI7nWOn5F0Zyzx7d4fU2VeY2HHyyq1fj/R7PjmDfMzYwPI/b+pwGlU
         s1ZgLITw2zyWRSOO8JMQj9+TXvkGX5ks2521rL5dKwJQ0WEWM3YcExDtHj1T8flsNBOZ
         SXXO4NsVVoC0vxS++g9YNn8v0rs/2oMXcInmCrgCHaLqbCJ/tBzG6LIp7p029n2sAO8U
         vKPF9704oBWUXZvQBe6tvzDafgBFVyOWHYWhzHF37Ied18FlUjwjVAkGrEcuImiyEJS3
         4z8w==
X-Gm-Message-State: AA+aEWaIYxIOFZXIaVCyily/6qKlKdDOTBe1OseGImUZ1s10SaZmQKOR
        qyriiO0sRsOS1e9kFbgFMgDGnKEUNDY=
X-Google-Smtp-Source: AFSGD/UTPeclHujyxdJK+xJZjRIiYzWNfOvHbvklg1dN8CWJPUNK4pJMQjRrAXXs6yA2MmBOU6FUwA==
X-Received: by 2002:a17:902:7c0c:: with SMTP id x12mr22532702pll.265.1543966700587;
        Tue, 04 Dec 2018 15:38:20 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/26] aio: use fget/fput_many() for file references
Date:   Tue,  4 Dec 2018 16:37:21 -0700
Message-Id: <20181204233729.26776-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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
index ae0805dc814c..634b540b0c92 100644
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
 
@@ -1804,13 +1830,58 @@ static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
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
@@ -1960,7 +2031,8 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 }
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			bool vectored, bool compat)
+			struct aio_submit_state *state, bool vectored,
+			bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -1968,7 +2040,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1994,7 +2066,8 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 }
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			 bool vectored, bool compat)
+			 struct aio_submit_state *state, bool vectored,
+			 bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2002,7 +2075,7 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -2313,16 +2386,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -2410,17 +2483,20 @@ static void aio_submit_state_end(struct aio_submit_state *state)
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
@@ -2461,7 +2537,7 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
@@ -2505,7 +2581,7 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
-- 
2.17.1

