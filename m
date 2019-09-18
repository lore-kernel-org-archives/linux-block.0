Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07040C4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 17:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A18207FC
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 17:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YF2sz3N6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfIRRS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:18:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34773 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfIRRS0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 13:18:26 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so1088519ion.1
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2019 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5s3r/aNw0R3KjbWBbRFywkBC6DrJ+q2Z3JO4FXfEQJw=;
        b=YF2sz3N6aKWOU0mbVoqddlzljFOsc3SNUJdhhnO1Z/3EDG+8e/kav5WNhRbQk9DVfm
         nr9TAGkzLQo9tjkhHWHKafyOwt/M30MLouJIsk9P8nrwnHEjhPLcaGBNG/tjFktNx6l8
         MpeK94Uejgj6CQ85JUZh2y8noH6wn6lOj5j2OV+HwhYwusZVbTQANzvavyoSI1z6JDaW
         qo+ypftVDy9TmhKHY2DRt041uroJ98Dwt9LZ0hY781JybsIudbpm+TvgTMwe9xZhXDQD
         aeF2KBxaxMJKUX65TZy4xWM2+8OuO5hpchwXN61i65PR6FdviZljVhPxsIa+aUDFTdXF
         NkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5s3r/aNw0R3KjbWBbRFywkBC6DrJ+q2Z3JO4FXfEQJw=;
        b=CwxdtroGb5PF43MsooW3KusSufS/3WkrUlBDZ+pzXRZjfxWzu2HTtXKxs+uFD82j4R
         XRn4JXS/feSU87sSYNvZDTBK//cwWE6aWgrrhx+1R0bXBVW5kDJxi/Q2r2lgQt1gHHTT
         cKs0B8SYymJX3B0jMpWtviTQjaixc7DNpVhGaBilYXuviw92BhB8+vo3+fnMjUh0pf/L
         E/e2poSVbka2Xx1AllfYL/ZamdPeGwJy7hYH0nt7urx/Lb8mbEF4kww+nyp5N5Da08mF
         350JJyc4nRdVzYRM//L4JvVZlHXy6jH3X0onBf4t25lsLxNa5JOp3Iz3kZsgwbqCrNHE
         tD9Q==
X-Gm-Message-State: APjAAAWfSqAIe8X6tr4jp6/u1egE7nwqKXK/OxSoLTVch8O/nCRBb1qH
        LlCJDhR9e4Fp+Zz2N/wu6Om4i3oZYRw+bQ==
X-Google-Smtp-Source: APXvYqyUrdQ7IkD7yhjfSlRN74o4gsG41EUSaU2jz6j4+U4jiZp8NvnZGela0PjZJUK/jkPqNkjPdQ==
X-Received: by 2002:a02:16c5:: with SMTP id a188mr6209713jaa.106.1568827105398;
        Wed, 18 Sep 2019 10:18:25 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l186sm9756076ioa.54.2019.09.18.10.18.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:18:24 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: ensure poll commands clear ->sqe
Message-ID: <b5561328-5574-bcba-8a2f-ba2343713922@kernel.dk>
Date:   Wed, 18 Sep 2019 11:18:23 -0600
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

If we end up getting woken in poll (due to a signal), then we may need
to punt the poll request to an async worker. When we do that, we look up
the list to queue at, deferefencing req->submit.sqe, however that is
only set for requests we initially decided to queue async.

This fixes a crash with poll command usage and wakeups that need to punt
to async context.

Fixes: 54a91f3bb9b9 ("io_uring: limit parallelism of buffered writes")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b550f685eadd..8c28bd7792b6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -453,16 +453,15 @@ static void __io_commit_cqring(struct io_ring_ctx *ctx)
 static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 				       struct io_kiocb *req)
 {
-	int rw;
+	int rw = 0;
 
-	switch (req->submit.sqe->opcode) {
-	case IORING_OP_WRITEV:
-	case IORING_OP_WRITE_FIXED:
-		rw = !(req->rw.ki_flags & IOCB_DIRECT);
-		break;
-	default:
-		rw = 0;
-		break;
+	if (req->submit.sqe) {
+		switch (req->submit.sqe->opcode) {
+		case IORING_OP_WRITEV:
+		case IORING_OP_WRITE_FIXED:
+			rw = !(req->rw.ki_flags & IOCB_DIRECT);
+			break;
+		}
 	}
 
 	queue_work(ctx->sqo_wq[rw], &req->work);
@@ -1721,6 +1720,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (!poll->file)
 		return -EBADF;
 
+	req->submit.sqe = NULL;
 	INIT_WORK(&req->work, io_poll_complete_work);
 	events = READ_ONCE(sqe->poll_events);
 	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;

-- 
Jens Axboe

