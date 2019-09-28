Return-Path: <SRS0=y3Aw=XX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477DEC4360C
	for <linux-block@archiver.kernel.org>; Sat, 28 Sep 2019 23:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF382086A
	for <linux-block@archiver.kernel.org>; Sat, 28 Sep 2019 23:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pH4jFtJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfI1XYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Sep 2019 19:24:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41734 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfI1XX7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Sep 2019 19:23:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so2433652plr.8
        for <linux-block@vger.kernel.org>; Sat, 28 Sep 2019 16:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pXDQRqlnXsSlKZ11MGFx4GPXn5dQc00eAC9cS8hEsr0=;
        b=pH4jFtJfrrEiHY3XfsbmiWRlW19xKgPhau8wVdZvhR8Ov/VZ+yVRTAxtQatsRlGXGb
         oYqgZ6UXnUbxuacyofcY/1Kf2wSkLDkYd0zrxn9+0Pgy/waMgVxlh+uMIklSteyvL82f
         YxR6gl/9DaSIdlUxI85O/SCoC+DrKkGNqm4fyqboP/YLzPbe3P5feZIUyW4/mgp7rvxm
         JrUCwp6L+Zghk6nCXYKTAcSXrjoUIn46ODvlDYAfGecqUdWDDUJ/rO6WV/MStgCnXptW
         U4pQ/TUp/52rTAhz2X3m2DlXt4egF8qxL6Z+NQL+Ehsz0ZCLyQhwO311ujQkaI7imWrV
         bw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pXDQRqlnXsSlKZ11MGFx4GPXn5dQc00eAC9cS8hEsr0=;
        b=FrT1TNEJeBJSJE91TPi+22RAETLDW0RlUQcvQUuiGuP0SUCKtTfTNkXd7cpVrZrHwH
         J9qiLDP3OpWeEE/EItQy0xsCUdp1oHxLB6fFxmxIAoZduehdzBDoZfHqAQkZ4DJB0ulx
         fdLz46gbbpbudIooJgT5XjQXMzFyx5hHy1+bEdCnmHyEg++JW+w2YJfXXY7hMR9lIK/v
         Ux02FjPb0H+m+y3qnTQb4tkxMtaB7chaI/FeUKA4E1JerXj/jVAl8OJFfK289flVZU2Z
         OxbwyKfrGH7poDxFDKDFvocmLDMIImCXgAfkpjt8CCbN5X0tweswgZFVREJ+eg/QnqXt
         n51A==
X-Gm-Message-State: APjAAAWdkY8/57PQZBMPCn2PW3MOOiIqsnR0LCLCtwrcUliWSpCVgZTD
        nL2Ye1ZnrEm5BfnHuFImBGBjDsS5XmpyVP/S
X-Google-Smtp-Source: APXvYqx9g7+Se3MqjAp12CYrVFaR4VYUkIWR5bKb0Vb/8Wx6GqdbfKKbTtFn+lhMlO+YdAodXNSu2w==
X-Received: by 2002:a17:902:a986:: with SMTP id bh6mr7919788plb.197.1569713037519;
        Sat, 28 Sep 2019 16:23:57 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f74sm8536081pfa.34.2019.09.28.16.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2019 16:23:56 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: run dependent links inline if possible
Cc:     Jackie Liu <liuyun01@kylinos.cn>
Message-ID: <e736649e-8360-ad69-8151-3cf3cf78b50f@kernel.dk>
Date:   Sat, 28 Sep 2019 17:23:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently any dependent link is executed from a new workqueue context,
which means that we'll be doing a context switch per link in the chain.
If we are running the completion of the current request from our async
workqueue and find that the next request is a link, then run it directly
from the workqueue context instead of forcing another switch.

This improves the performance of linked SQEs, and reduces the CPU
overhead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

2-3x speedup doing read-write links, where the read often ends up
blocking. Tested with examples/link-cp.c

diff --git a/fs/io_uring.c b/fs/io_uring.c
index aa8ac557493c..742d95563a54 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -667,7 +667,7 @@ static void __io_free_req(struct io_kiocb *req)
 	kmem_cache_free(req_cachep, req);
 }
 
-static void io_req_link_next(struct io_kiocb *req)
+struct io_kiocb *io_req_link_next(struct io_kiocb *req)
 {
 	struct io_kiocb *nxt;
 
@@ -686,9 +686,19 @@ static void io_req_link_next(struct io_kiocb *req)
 		}
 
 		nxt->flags |= REQ_F_LINK_DONE;
+		/*
+		 * If we're in async work, we can continue processing this,
+		 * we can continue processing the chain in this context instead
+		 * of having to queue up new async work.
+		 */
+		if (current_work())
+			return nxt;
 		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
 		io_queue_async_work(req->ctx, nxt);
+		nxt = NULL;
 	}
+
+	return nxt;
 }
 
 /*
@@ -707,8 +717,10 @@ static void io_fail_links(struct io_kiocb *req)
 	}
 }
 
-static void io_free_req(struct io_kiocb *req)
+static struct io_kiocb *io_free_req(struct io_kiocb *req)
 {
+	struct io_kiocb *nxt = NULL;
+
 	/*
 	 * If LINK is set, we have dependent requests in this chain. If we
 	 * didn't fail this request, queue the first one up, moving any other
@@ -719,16 +731,30 @@ static void io_free_req(struct io_kiocb *req)
 		if (req->flags & REQ_F_FAIL_LINK)
 			io_fail_links(req);
 		else
-			io_req_link_next(req);
+			nxt = io_req_link_next(req);
 	}
 
 	__io_free_req(req);
+	return nxt;
 }
 
-static void io_put_req(struct io_kiocb *req)
+static struct io_kiocb *__io_put_req(struct io_kiocb *req)
 {
 	if (refcount_dec_and_test(&req->refs))
-		io_free_req(req);
+		return io_free_req(req);
+
+	return NULL;
+}
+
+static void io_put_req(struct io_kiocb *req)
+{
+	struct io_kiocb *nxt;
+
+	nxt = __io_put_req(req);
+	if (nxt) {
+		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
+		io_queue_async_work(nxt->ctx, nxt);
+	}
 }
 
 static unsigned io_cqring_events(struct io_rings *rings)
@@ -934,7 +960,7 @@ static void kiocb_end_write(struct kiocb *kiocb)
 	}
 }
 
-static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw_common(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
@@ -943,9 +969,24 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	if ((req->flags & REQ_F_LINK) && res != req->result)
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, req->user_data, res);
+}
+
+static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+{
+	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+
+	io_complete_rw_common(kiocb, res);
 	io_put_req(req);
 }
 
+static struct io_kiocb *__io_complete_rw(struct kiocb *kiocb, long res)
+{
+	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+
+	io_complete_rw_common(kiocb, res);
+	return __io_put_req(req);
+}
+
 static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
@@ -1128,6 +1169,15 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 	}
 }
 
+static void call_io_rw_done(struct kiocb *kiocb, ssize_t ret,
+			    struct io_kiocb **nxt, bool in_async)
+{
+	if (in_async && ret >= 0 && nxt && kiocb->ki_complete == io_complete_rw)
+		*nxt = __io_complete_rw(kiocb, ret);
+	else
+		io_rw_done(kiocb, ret);
+}
+
 static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 			   const struct io_uring_sqe *sqe,
 			   struct iov_iter *iter)
@@ -1344,7 +1394,7 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 }
 
 static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
-		   bool force_nonblock)
+		   bool force_nonblock, struct io_kiocb **nxt)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -1391,7 +1441,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN) {
-			io_rw_done(kiocb, ret2);
+			call_io_rw_done(kiocb, ret2, nxt, s->needs_lock);
 		} else {
 			/*
 			 * If ->needs_lock is true, we're already in async
@@ -1407,7 +1457,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 }
 
 static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
-		    bool force_nonblock)
+		    bool force_nonblock, struct io_kiocb **nxt)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -1465,7 +1515,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		else
 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
 		if (!force_nonblock || ret2 != -EAGAIN) {
-			io_rw_done(kiocb, ret2);
+			call_io_rw_done(kiocb, ret2, nxt, s->needs_lock);
 		} else {
 			/*
 			 * If ->needs_lock is true, we're already in async
@@ -1968,7 +2018,8 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   const struct sqe_submit *s, bool force_nonblock)
+			   const struct sqe_submit *s, bool force_nonblock,
+			   struct io_kiocb **nxt)
 {
 	int ret, opcode;
 
@@ -1985,18 +2036,18 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_READV:
 		if (unlikely(s->sqe->buf_index))
 			return -EINVAL;
-		ret = io_read(req, s, force_nonblock);
+		ret = io_read(req, s, force_nonblock, nxt);
 		break;
 	case IORING_OP_WRITEV:
 		if (unlikely(s->sqe->buf_index))
 			return -EINVAL;
-		ret = io_write(req, s, force_nonblock);
+		ret = io_write(req, s, force_nonblock, nxt);
 		break;
 	case IORING_OP_READ_FIXED:
-		ret = io_read(req, s, force_nonblock);
+		ret = io_read(req, s, force_nonblock, nxt);
 		break;
 	case IORING_OP_WRITE_FIXED:
-		ret = io_write(req, s, force_nonblock);
+		ret = io_write(req, s, force_nonblock, nxt);
 		break;
 	case IORING_OP_FSYNC:
 		ret = io_fsync(req, s->sqe, force_nonblock);
@@ -2081,6 +2132,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		struct sqe_submit *s = &req->submit;
 		const struct io_uring_sqe *sqe = s->sqe;
 		unsigned int flags = req->flags;
+		struct io_kiocb *nxt = NULL;
 
 		/* Ensure we clear previously set non-block flag */
 		req->rw.ki_flags &= ~IOCB_NOWAIT;
@@ -2101,7 +2153,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 			s->has_user = cur_mm != NULL;
 			s->needs_lock = true;
 			do {
-				ret = __io_submit_sqe(ctx, req, s, false);
+				ret = __io_submit_sqe(ctx, req, s, false, &nxt);
 				/*
 				 * We can get EAGAIN for polled IO even though
 				 * we're forcing a sync submission from here,
@@ -2125,6 +2177,12 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		/* async context always use a copy of the sqe */
 		kfree(sqe);
 
+		/* if a dependent link is ready, do that as the next one */
+		if (!ret && nxt) {
+			req = nxt;
+			continue;
+		}
+
 		/* req from defer and link list needn't decrease async cnt */
 		if (flags & (REQ_F_IO_DRAINED | REQ_F_LINK_DONE))
 			goto out;
@@ -2271,7 +2329,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 {
 	int ret;
 
-	ret = __io_submit_sqe(ctx, req, s, force_nonblock);
+	ret = __io_submit_sqe(ctx, req, s, force_nonblock, NULL);
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
 
-- 
Jens Axboe

