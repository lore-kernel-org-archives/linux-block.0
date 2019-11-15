Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45793C43215
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9B8206D9
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 19:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OLogLQtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOTfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:35:02 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34566 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfKOTfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 14:35:02 -0500
Received: by mail-il1-f194.google.com with SMTP id p6so10153720ilp.1
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 11:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IB6tMy2YEgGP5YDDY/pCy3ihFVCR8d4rdE82qCrvJqc=;
        b=OLogLQtGvH91Dp3UaPztxn9UqwzM13fqv5kuoWUu/CsNOXFJEbX+CZ7VGT+nd8QkjC
         vPTHzkqpqa1UQpIaaVeiJr0P0aDzdGobz9Wo/K57zl19yKpul2HxIrDj/nA5SViubraN
         bSRXy18XpBAAmoQDJit15i2QgAdZIhCJT6aIMuQ2/Y8qRCQ72RAtdLertDv8OJejmwGZ
         dAy5clFat03nMo9U7xykrrdlJNsBCGGseJMC8X1wsK+fcnN/mUasQCpeu4iZyfRtI56H
         9KRceqBYOz78+Sxg/a6gF06aWVRPRmECT/vAyo/yiTdqfAwEdRH+PUftVlmAuDBaqAQj
         izXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IB6tMy2YEgGP5YDDY/pCy3ihFVCR8d4rdE82qCrvJqc=;
        b=nstvOkfYHXWK1Lb4zr/tH7lsIcy42x+3kaYkuGtw3NJZw8dyddg0+KbmqWiqFSpQzG
         mFbwF0FJEvEbyiZBynQDMoYgT/QOpygIIMDZo9b+vrwDwM1vIfuD/3Ht2fG+oL0xHmQT
         +8dmyIDCVMnM+t7Koq9n4ZfLJeJxmI3LA7LfTcKERSzzOvCePR3YRV8wD4mni4Ag0Ass
         OhATMQz1NRFl9H2MsVsG5PEuA18fGze8yOkLD105KpCh8Jk779nuv6ZL+Zxgu/Vb+y2t
         w8YSKF+uhaBZ5wQ86Yx7kQI2IU5MZk1hRDBfXVT01FSJJEKTSuwy2+x48uIOTJ/y4xF/
         7CEQ==
X-Gm-Message-State: APjAAAV9ZIEwnBdfXqgrcQvu8cZo+QfNrNuzWapQsV6DXr/7QqM9OHMj
        UMc36hHeztnVP+tObfjFrRHGyA==
X-Google-Smtp-Source: APXvYqzuYxep69YVKnZVRWujKJXNZFFsXXXj8GtA7IYSGHfDljcP5/2PqFSfp10cAP7owXgTQ+5gnA==
X-Received: by 2002:a92:c981:: with SMTP id y1mr2525476iln.53.1573846500472;
        Fri, 15 Nov 2019 11:35:00 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s11sm1801213ilh.54.2019.11.15.11.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 11:34:59 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
Date:   Fri, 15 Nov 2019 12:34:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

How about something like this? Should work (and be valid) to have any
sequence of timeout links, as long as there's something in front of it.
Commit message has more details.


commit 437fd0500d08f32444747b861c72cd58a4b833d5
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Nov 14 19:39:52 2019 -0700

    io_uring: fix sequencing issues with linked timeouts
    
    We have an issue with timeout links that are deeper in the submit chain,
    because we only handle it upfront, not from later submissions. Move the
    prep + issue of the timeout link to the async work prep handler, and do
    it normally for non-async queue. If we validate and prepare the timeout
    links upfront when we first see them, there's nothing stopping us from
    supporting any sort of nesting.
    
    Ensure that we handle the sequencing of linked timeouts correctly as
    well. The loop in io_req_link_next() isn't necessary, and it will never
    do anything, because we can't have both REQ_F_LINK_TIMEOUT set and have
    dependent links.
    
    Reported-by: Pavel Begunkov <asml.silence@gmail.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a0204b48866f..47d61899b8ba 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -352,6 +352,7 @@ struct io_kiocb {
 #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
 #define REQ_F_INFLIGHT		8192	/* on inflight list */
 #define REQ_F_COMP_LOCKED	16384	/* completion under lock */
+#define REQ_F_FREE_SQE		32768
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -390,6 +391,8 @@ static void __io_free_req(struct io_kiocb *req);
 static void io_put_req(struct io_kiocb *req);
 static void io_double_put_req(struct io_kiocb *req);
 static void __io_double_put_req(struct io_kiocb *req);
+static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req);
+static void io_queue_linked_timeout(struct io_kiocb *req);
 
 static struct kmem_cache *req_cachep;
 
@@ -524,7 +527,8 @@ static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
 		 opcode == IORING_OP_WRITE_FIXED);
 }
 
-static inline bool io_prep_async_work(struct io_kiocb *req)
+static inline bool io_prep_async_work(struct io_kiocb *req,
+				      struct io_kiocb **link)
 {
 	bool do_hashed = false;
 
@@ -553,13 +557,17 @@ static inline bool io_prep_async_work(struct io_kiocb *req)
 			req->work.flags |= IO_WQ_WORK_NEEDS_USER;
 	}
 
+	*link = io_prep_linked_timeout(req);
 	return do_hashed;
 }
 
 static inline void io_queue_async_work(struct io_kiocb *req)
 {
-	bool do_hashed = io_prep_async_work(req);
 	struct io_ring_ctx *ctx = req->ctx;
+	struct io_kiocb *link;
+	bool do_hashed;
+
+	do_hashed = io_prep_async_work(req, &link);
 
 	trace_io_uring_queue_async_work(ctx, do_hashed, req, &req->work,
 					req->flags);
@@ -569,6 +577,9 @@ static inline void io_queue_async_work(struct io_kiocb *req)
 		io_wq_enqueue_hashed(ctx->io_wq, &req->work,
 					file_inode(req->file));
 	}
+
+	if (link)
+		io_queue_linked_timeout(link);
 }
 
 static void io_kill_timeout(struct io_kiocb *req)
@@ -868,30 +879,26 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	 * safe side.
 	 */
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	while (nxt) {
+	if (nxt) {
 		list_del_init(&nxt->list);
 		if (!list_empty(&req->link_list)) {
 			INIT_LIST_HEAD(&nxt->link_list);
 			list_splice(&req->link_list, &nxt->link_list);
 			nxt->flags |= REQ_F_LINK;
+		} else if (req->flags & REQ_F_LINK_TIMEOUT) {
+			wake_ev = io_link_cancel_timeout(nxt);
+			nxt = NULL;
 		}
 
 		/*
 		 * If we're in async work, we can continue processing the chain
 		 * in this context instead of having to queue up new async work.
 		 */
-		if (req->flags & REQ_F_LINK_TIMEOUT) {
-			wake_ev = io_link_cancel_timeout(nxt);
-
-			/* we dropped this link, get next */
-			nxt = list_first_entry_or_null(&req->link_list,
-							struct io_kiocb, list);
-		} else if (nxtptr && io_wq_current_is_worker()) {
-			*nxtptr = nxt;
-			break;
-		} else {
-			io_queue_async_work(nxt);
-			break;
+		if (nxt) {
+			if (nxtptr && io_wq_current_is_worker())
+				*nxtptr = nxt;
+			else
+				io_queue_async_work(nxt);
 		}
 	}
 
@@ -916,6 +923,9 @@ static void io_fail_links(struct io_kiocb *req)
 
 		trace_io_uring_fail_link(req, link);
 
+		if (req->flags & REQ_F_FREE_SQE)
+			kfree(link->submit.sqe);
+
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
@@ -2651,8 +2661,12 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 
 	/* if a dependent link is ready, pass it back */
 	if (!ret && nxt) {
-		io_prep_async_work(nxt);
+		struct io_kiocb *link;
+
+		io_prep_async_work(nxt, &link);
 		*workptr = &nxt->work;
+		if (link)
+			io_queue_linked_timeout(link);
 	}
 }
 
@@ -2832,7 +2846,6 @@ static int io_validate_link_timeout(struct io_kiocb *req)
 static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 {
 	struct io_kiocb *nxt;
-	int ret;
 
 	if (!(req->flags & REQ_F_LINK))
 		return NULL;
@@ -2841,14 +2854,6 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 	if (!nxt || nxt->submit.sqe->opcode != IORING_OP_LINK_TIMEOUT)
 		return NULL;
 
-	ret = io_validate_link_timeout(nxt);
-	if (ret) {
-		list_del_init(&nxt->list);
-		io_cqring_add_event(nxt, ret);
-		io_double_put_req(nxt);
-		return ERR_PTR(-ECANCELED);
-	}
-
 	if (nxt->submit.sqe->timeout_flags & IORING_TIMEOUT_ABS)
 		nxt->timeout.data->mode = HRTIMER_MODE_ABS;
 	else
@@ -2862,16 +2867,9 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 
 static void __io_queue_sqe(struct io_kiocb *req)
 {
-	struct io_kiocb *nxt;
+	struct io_kiocb *nxt = io_prep_linked_timeout(req);
 	int ret;
 
-	nxt = io_prep_linked_timeout(req);
-	if (IS_ERR(nxt)) {
-		ret = PTR_ERR(nxt);
-		nxt = NULL;
-		goto err;
-	}
-
 	ret = __io_submit_sqe(req, NULL, true);
 
 	/*
@@ -2899,10 +2897,6 @@ static void __io_queue_sqe(struct io_kiocb *req)
 			 * submit reference when the iocb is actually submitted.
 			 */
 			io_queue_async_work(req);
-
-			if (nxt)
-				io_queue_linked_timeout(nxt);
-
 			return;
 		}
 	}
@@ -2947,6 +2941,10 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	int need_submit = false;
 	struct io_ring_ctx *ctx = req->ctx;
 
+	if (unlikely(req->flags & REQ_F_FAIL_LINK)) {
+		ret = -ECANCELED;
+		goto err;
+	}
 	if (!shadow) {
 		io_queue_sqe(req);
 		return;
@@ -2961,9 +2959,11 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	ret = io_req_defer(req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
+err:
 			io_cqring_add_event(req, ret);
 			io_double_put_req(req);
-			__io_free_req(shadow);
+			if (shadow)
+				__io_free_req(shadow);
 			return;
 		}
 	} else {
@@ -3020,6 +3020,14 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	if (*link) {
 		struct io_kiocb *prev = *link;
 
+		if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
+			ret = io_validate_link_timeout(req);
+			if (ret) {
+				prev->flags |= REQ_F_FAIL_LINK;
+				goto err_req;
+			}
+		}
+
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (!sqe_copy) {
 			ret = -EAGAIN;

-- 
Jens Axboe

