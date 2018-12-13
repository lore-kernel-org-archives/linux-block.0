Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803AC67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D35720851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iyTSaVH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D35720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeLMR5Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55342 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeLMR5Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:24 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so4960486itg.5
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GW+HicuEIZ9l2w5wF/GUDcrivS+/EOai0WgC5+IJMkE=;
        b=iyTSaVH0FMMIGeVswb/agzjLYIeUw6dVN/Ylui8UgwHyqLvgLYrPkILFHUcF8Bi4Xf
         uElnX1N4PGDy+fhWa6pSqigpSdz1+FNvDrPRsaTegJSOnlECepUSuijCnxs1DcTo32g/
         38GWCk2c5EBZweRI3n/FelCJbzjJ1eXX/vmYjwlu4SW4XAL1+2+SXtz9uyR3sxyVenq/
         ZrgkjesBT7pZ9IxnFAaBzxCeD3MIKeE0OTK3ODhpKezQ7GgennosadvVnw6xM2Zlu8PE
         mE0CHzSE8RkpODaeRqVYNwTKSI+/7GcfRxYLrevSbEDH/rUVc3U0XsmZ1KAEYlR2FxTj
         RajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GW+HicuEIZ9l2w5wF/GUDcrivS+/EOai0WgC5+IJMkE=;
        b=FF+zpCj1Ro2QGdcgmVofwMH8I1nK0lTpAgzeFiMXSQHC7jaWABVmElKwhWOe5dbkUi
         l7ZAyUR34jX4RPOeeQWmIdQ1Jy+Pgl5MSoGdHlwemAtE5h9YCuk10I8KN/CCHwVbFD5a
         4df98hBq1K1SGexwP3yr0ExttHIxjFaBWiQoQWkAZB/Ss1Fz3PeKPzNEns/3s8X/7EWq
         MI5i6T3TOVyzHUYPcBYwYySOGD6FwfuQOsYgb0xNrolHKq1rZD+LuMBRSqWKhzxPCwtu
         BR3z8ltFGklCGr0ugVOLX5ttAWWWL3mHkLSoLSyzFM4SAZs6AWEMG4rFhaKu6LCpEaxC
         mElQ==
X-Gm-Message-State: AA+aEWaT64Ux0CJcDj7/J7Y2ue3mMwR4HGWDHEhPiBVMhRJfIQocFV7F
        cAVE5s9VzeC84jpxQp9dhJeTvCo4VmSq2g==
X-Google-Smtp-Source: AFSGD/WG1nX78HWIVstfsogsFCBcVd5XtOI74YShCr9tr0v0gmpGBCKNDOzNeY86/P0pUiB8AdJPBw==
X-Received: by 2002:a02:41c7:: with SMTP id n68mr24355169jad.61.1544723842780;
        Thu, 13 Dec 2018 09:57:22 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/26] aio: use fget/fput_many() for file references
Date:   Thu, 13 Dec 2018 10:56:36 -0700
Message-Id: <20181213175645.22181-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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
index abc0e4dc2aed..29336c6e8b40 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -246,6 +246,15 @@ struct aio_submit_state {
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
@@ -1353,7 +1362,8 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 {
 	void *iocbs[AIO_IOPOLL_BATCH];
 	struct aio_kiocb *iocb, *n;
-	int to_free = 0, ret = 0;
+	int file_count, to_free = 0, ret = 0;
+	struct file *file = NULL;
 
 	/* Shouldn't happen... */
 	if (*nr_events >= max)
@@ -1370,7 +1380,20 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
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
@@ -1380,6 +1403,9 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 		(*nr_events)++;
 	}
 
+	if (file)
+		fput_many(file, file_count);
+
 	if (to_free)
 		iocb_put_many(ctx, iocbs, &to_free);
 
@@ -1740,13 +1766,60 @@ static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
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
@@ -1804,7 +1877,7 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb)
 
 	return 0;
 out_fput:
-	fput(req->ki_filp);
+	aio_file_put(state, req->ki_filp);
 	return ret;
 }
 
@@ -1896,7 +1969,8 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 }
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			bool vectored, bool compat)
+			struct aio_submit_state *state, bool vectored,
+			bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -1904,7 +1978,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1930,7 +2004,8 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 }
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
-			 bool vectored, bool compat)
+			 struct aio_submit_state *state, bool vectored,
+			 bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -1938,7 +2013,7 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb);
+	ret = aio_prep_rw(kiocb, iocb, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -2248,16 +2323,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -2335,17 +2410,20 @@ static void aio_submit_state_end(struct aio_submit_state *state)
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
@@ -2386,7 +2464,7 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
@@ -2430,7 +2508,7 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		nr = ctx->nr_events;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
-		aio_submit_state_start(&state, ctx);
+		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 	for (i = 0; i < nr; i++) {
-- 
2.17.1

