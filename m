Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D109ECA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F1F2070B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DgVFp0vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503722AbfJYQDZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:03:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45427 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfJYQDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:03:24 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so2968916iot.12
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=epIZn6+Wd30ec+WMFBH2/DUm6JPwiv9ffXe7aBYJZg0=;
        b=DgVFp0vMHDg+9Ok10nyLdQenddZHB7FXCw6Phi4otowCPa3Wt/J0x7vj92lnjgshQH
         GQsNXJxAxMQ2gLi6vad0xrN6GHWz9qPZUUUJn6pmjNsbnKMUz75mJ1wO6dnLGgh2D4p4
         bT9kR2zBcigfYI4VlCwjwoe6JSLPEAUPcmoFnhx1NL9Sz75GCAzfKdOqLxS9TYWkzjR1
         1AeLarLvedliotQLMmGygVKiKMEv8MPeVOvaN9dkU2huCAt7YyHOncKEA/79byV4eo2+
         10MUPTtCbka69ZfsSnPmZhwh+ui0x3clFEQsbMHa6kPYjNXCm3tHYVHgtej+kfVsrKWr
         Qq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epIZn6+Wd30ec+WMFBH2/DUm6JPwiv9ffXe7aBYJZg0=;
        b=n/zYXSTEt48rPqsVYtRd05v3q/KX8DTu0j6QSZxbsHJZQh57fXvGQDiKABJh975jxh
         afjlybJcFZ9BuYPnEeMR6Jq6MzVWpQJ+vwEOrvC5V5jiWnZYBGYNKnVv1q5SFqfgzc8/
         k3F73fQ4LlzdzJIC7yaD6lle4LGy/zK1+UZiQ643pgN0LwbpR93vzd3fdzC76mLIV49p
         uUv9/OmclwQfOKdicXKhK5A2mi3g2nMicFx77fqU37tC2zx8wuC7uGPFi6sAX7FQEcT9
         jrxgSczgdZg7a9ENiGCblFLnOcTvjbmgpcWiQd4rU+Hvnu6pqp30StdKSoDNULjSoYQg
         e1tQ==
X-Gm-Message-State: APjAAAWs7bt1A3hvKr0it9NavB9Q1rwCmffifsf711UR8W6/HBISgZZe
        yuxPEzpaoNqx5N4zaCIqw2S79A==
X-Google-Smtp-Source: APXvYqxKJHkOiI3fJ45XVvMviuR26Mn6895VoLiH0yZZkjV00mrF7bGDN89Qw7vCI/eXdFtBnbdgGw==
X-Received: by 2002:a6b:b54a:: with SMTP id e71mr4579239iof.132.1572019403834;
        Fri, 25 Oct 2019 09:03:23 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o25sm379302ili.51.2019.10.25.09.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:03:22 -0700 (PDT)
Subject: Re: [BUG] io_uring: defer logic based on shared data
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
Date:   Fri, 25 Oct 2019 10:03:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 3:55 AM, Pavel Begunkov wrote:
> I found 2 problems with __io_sequence_defer().
> 
> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
> it can be maliciously changed.
> 
> see sent liburing test (test/defer *_hung()), which left an unkillable
> process for me

OK, how about the below. I'll split this in two, as it's really two
separate fixes.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5d10984381cf..5d9d960c1c17 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -191,6 +191,7 @@ struct io_ring_ctx {
 		unsigned		sq_entries;
 		unsigned		sq_mask;
 		unsigned		sq_thread_idle;
+		unsigned		cached_sq_dropped;
 		struct io_uring_sqe	*sq_sqes;
 
 		struct list_head	defer_list;
@@ -208,6 +209,7 @@ struct io_ring_ctx {
 
 	struct {
 		unsigned		cached_cq_tail;
+		unsigned		cached_cq_overflow;
 		unsigned		cq_entries;
 		unsigned		cq_mask;
 		struct wait_queue_head	cq_wait;
@@ -419,7 +421,8 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
 				       struct io_kiocb *req)
 {
-	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
+	return req->sequence != ctx->cached_cq_tail + ctx->cached_sq_dropped
+					+ ctx->cached_cq_overflow;
 }
 
 static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
@@ -590,9 +593,8 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
 	} else {
-		unsigned overflow = READ_ONCE(ctx->rings->cq_overflow);
-
-		WRITE_ONCE(ctx->rings->cq_overflow, overflow + 1);
+		ctx->cached_cq_overflow++;
+		WRITE_ONCE(ctx->rings->cq_overflow, ctx->cached_cq_overflow);
 	}
 }
 
@@ -2601,7 +2603,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
 	/* drop invalid entries */
 	ctx->cached_sq_head++;
-	rings->sq_dropped++;
+	ctx->cached_sq_dropped++;
+	WRITE_ONCE(rings->sq_dropped, ctx->cached_sq_dropped);
 	return false;
 }
 
@@ -2685,6 +2688,7 @@ static int io_sq_thread(void *data)
 
 	timeout = inflight = 0;
 	while (!kthread_should_park()) {
+		unsigned prev_cq, cur_cq;
 		bool mm_fault = false;
 		unsigned int to_submit;
 
@@ -2767,8 +2771,12 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = min(to_submit, ctx->sq_entries);
+		prev_cq = ctx->cached_cq_tail + ctx->cached_cq_overflow;
 		inflight += io_submit_sqes(ctx, to_submit, cur_mm != NULL,
 					   mm_fault);
+		cur_cq = ctx->cached_cq_tail + ctx->cached_cq_overflow;
+		if ((ctx->flags & IORING_SETUP_IOPOLL) && (prev_cq != cur_cq))
+			inflight -= cur_cq - prev_cq;
 
 		/* Commit SQ ring head once we've consumed all SQEs */
 		io_commit_sqring(ctx);

-- 
Jens Axboe

