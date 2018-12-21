Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C815EC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883AA21928
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cMNK4hQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391674AbeLUTXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55955 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391666AbeLUTXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:00 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so8432840ith.5
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jc0IDV8X+KKOBYo0lYsAf4XRCrbzGXLd0FFRKhIPQtQ=;
        b=cMNK4hQ3O8FBybp18Lk03FkR51+mpXGxdoXHrnSTujrNoxBKFmF3npPwnmeOIKtJcL
         soa7RGZRQ5jPsQGfP6Sk4WvJD+5dyVlzR9SGhhb//FoSCaL1g1RRPlLoFUw2LnHqSzg0
         F8XTBGvKUaDemQxOTJ4/wNr8SR9AZcOx0q2IiTLEMJLMViqIsXu7JLyb8lpTWGq6FIa2
         gSwEMveUxJaVYDod4PakWv4fQoMbBfbNgTmtYMIlcewmCLcLx9/npyQpsDN/jWWsjJiY
         bqmtf0/cPpy8jYh/3oMssMAozb5T+JcH/fxWtzL10fJSVRAzfqcOpO/CdLD6VA5jVHvO
         NaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jc0IDV8X+KKOBYo0lYsAf4XRCrbzGXLd0FFRKhIPQtQ=;
        b=dQvSKtbediXQit+03E/evC4YfZlIFwoviKIVW33F9ygrpJz7SzzuyQClpD5j/2BxdS
         j6uXUgnZ+/mUYXyqP81kJwMtJqn40tMOedE2fpghne/iepm5ldl+2YQAmGT/JV3OEFn3
         FBNTwFplJisd2IspyuCIzh84q3nNwGyQojz7KzgoO9yZU0ZVPt3Tas3Oa5qQQFaW/BLI
         oPU7YfPKPUKYR037Mlu277P1RC279uy6ppteHSw5whAEQK1w1/E6XUHsPstRExsYNHWu
         33KBUSUPRheSsxzEqIgZzjtgd3+uSVn3SLeZYYSe83n/FAH4BnMmr5wuWAubodMQ8Dje
         v9Qw==
X-Gm-Message-State: AA+aEWZmIZzf4s/Ko6jiXyVVdHExbwfFc0d435tLjunUjwmdTza5CsEU
        0ojenzYV+AqCBUa6pDiJI87C0g==
X-Google-Smtp-Source: ALg8bN7/0kMlgHGJ6J7jdzaWgEmFXAgZZNKsUcbjumou+9q/rlYNe6KMlvdnOWiLQ0cdOcOgo5Ij8g==
X-Received: by 2002:a24:414c:: with SMTP id x73mr2690274ita.129.1545420178116;
        Fri, 21 Dec 2018 11:22:58 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/22] aio: use fget/fput_many() for file references
Date:   Fri, 21 Dec 2018 12:22:25 -0700
Message-Id: <20181221192236.12866-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
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
 fs/aio.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ac296139593f..33d1d2c0d6fe 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -249,6 +249,15 @@ struct aio_submit_state {
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
@@ -1346,7 +1355,8 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 {
 	void *iocbs[AIO_IOPOLL_BATCH];
 	struct aio_kiocb *iocb, *n;
-	int to_free = 0, ret = 0;
+	int file_count, to_free = 0, ret = 0;
+	struct file *file = NULL;
 
 	/* Shouldn't happen... */
 	if (*nr_events >= max)
@@ -1363,7 +1373,20 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
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
@@ -1373,6 +1396,9 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 		(*nr_events)++;
 	}
 
+	if (file)
+		fput_many(file, file_count);
+
 	if (to_free)
 		iocb_put_many(ctx, iocbs, &to_free);
 
@@ -1729,13 +1755,60 @@ static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
 	}
 }
 
-static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb)
+static void aio_file_put(struct aio_submit_state *state, struct file *file)
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
+	aio_file_put(state, NULL);
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
@@ -1793,7 +1866,7 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb)
 
 	return 0;
 out_fput:
-	fput(req->ki_filp);
+	aio_file_put(state, req->ki_filp);
 	return ret;
 }
 
@@ -1894,7 +1967,8 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 }
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			bool vectored, bool compat)
+			struct aio_submit_state *state, bool vectored,
+			bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -1902,7 +1976,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1928,7 +2002,8 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 }
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			 bool vectored, bool compat)
+			 struct aio_submit_state *state, bool vectored,
+			 bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -1936,7 +2011,7 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -2246,16 +2321,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -2333,17 +2408,20 @@ static void aio_submit_state_end(struct aio_submit_state *state)
 	blk_finish_plug(&state->plug);
 	if (!list_empty(&state->req_list))
 		aio_flush_state_reqs(state->ctx, state);
+	aio_file_put(state, NULL);
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
@@ -2384,7 +2462,7 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
@@ -2428,7 +2506,7 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
-- 
2.17.1

