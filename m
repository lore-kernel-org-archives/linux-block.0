Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E05ECE59D
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8004620659
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bKc7hmx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbfJOWvI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:51:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44059 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbfJOWvH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 18:51:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so10270789pll.11
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5kjF+ne95iAr4ENV6P+Tj0MjCzIz5JCsXBNbeLx/hHs=;
        b=bKc7hmx2lU53q7tGs4mQJ29shFQsfKqFq08eZlsdD5bZquGk5N1xxgKJYen2kK7+qd
         cf0yLfzHtOnhmeupyfmlgFjb44R1i15HmTCaoqbpmc4uAU6wzrHrQH50awjez5JBlp+k
         5whBuX3NHjylYQN18t7x5Ckzd6zBuHBHW53tC2djfDWu+kkFPzNBelRiKZX6cRn0VhfW
         65b2LK7wWgnlmaqwPcaI8YpjyHcTTWqfAhRqO1zDE3/aW2WogH2ZU2D06Ox0oxAZbtDA
         2LvbZY73owWwHhkpQyfHvXLrSw85fuXe+jZ5ABC2CkpQuO5pTVI1HEvveBtYfCKrE2+j
         YhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5kjF+ne95iAr4ENV6P+Tj0MjCzIz5JCsXBNbeLx/hHs=;
        b=fVQjSxiKNCc/DQtvORL5daqdjrdsCjS52rtKCHbIhLydIwNfNLSAikbHAJGYkWdzSg
         zf28YsY+/iSXB34TwyI5TGvc8fmXxIy5GKiT+IQyQP3JvU9hfKtDnyP/4rP5WDhR8FX3
         LLEnMsqcUMbVJEfJsMsOghP7g/AM4leOV+7/CXONs3fi9o46hDxFkKQKv6OXNujfT8aG
         cU8ePXGcFDPU4w8ECIVaOUrK+t18g4x4cvhPVoqSwXfW8Os/6h6PLH19f4ynpBH6/Qpx
         fZ7QCEZj5zHPG8fS+VJ3gEfS7lVzo6qTGtf894AyzPcYCxtvNqa+LHGZZ0WhmQgcdtyZ
         E+hA==
X-Gm-Message-State: APjAAAX48sVCIuiSX9h6wFCe9xOmBth/kkpc72btWTRonb51hgRthjLv
        pdmxVwP3ujJrsuQlT7rzInEAmhQGMMneCg==
X-Google-Smtp-Source: APXvYqzHWE11Cse/cpfAvU2K75W0PKpFSYRpICRq21PBEhYtdzHR4Am3a3AKlAaeljCre9FvmWYTBQ==
X-Received: by 2002:a17:902:7c8a:: with SMTP id y10mr21364316pll.115.1571179865253;
        Tue, 15 Oct 2019 15:51:05 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id k93sm358172pjh.3.2019.10.15.15.51.03
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:51:04 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: add support for absolute timeouts
Message-ID: <49ac4938-8868-2751-7857-366fadf0c104@kernel.dk>
Date:   Tue, 15 Oct 2019 16:51:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a pretty trivial addition on top of the relative timeouts
we have now, but it's handy for ensuring tighter timing for those
that are building scheduling primitives on top of io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 17 ++++++++++++-----
 include/uapi/linux/io_uring.h |  5 +++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d92a34707afb..e48e0854bc1e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1937,12 +1937,16 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	unsigned count, req_dist, tail_index;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct list_head *entry;
+	enum hrtimer_mode mode;
 	struct timespec64 ts;
+	unsigned flags;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
-	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->timeout_flags ||
-	    sqe->len != 1)
+	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->len != 1)
+		return -EINVAL;
+	flags = READ_ONCE(sqe->timeout_flags);
+	if (flags & ~IORING_TIMEOUT_ABS)
 		return -EINVAL;
 
 	if (get_timespec64(&ts, u64_to_user_ptr(sqe->addr)))
@@ -1977,10 +1981,13 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	list_add(&req->list, entry);
 	spin_unlock_irq(&ctx->completion_lock);
 
-	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	if (flags & IORING_TIMEOUT_ABS)
+		mode = HRTIMER_MODE_ABS;
+	else
+		mode = HRTIMER_MODE_REL;
+	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, mode);
 	req->timeout.timer.function = io_timeout_fn;
-	hrtimer_start(&req->timeout.timer, timespec64_to_ktime(ts),
-			HRTIMER_MODE_REL);
+	hrtimer_start(&req->timeout.timer, timespec64_to_ktime(ts), mode);
 	return 0;
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index e0137ea6ad79..b402dfee5e15 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -70,6 +70,11 @@ struct io_uring_sqe {
  */
 #define IORING_FSYNC_DATASYNC	(1U << 0)
 
+/*
+ * sqe->timeout_flags
+ */
+#define IORING_TIMEOUT_ABS	(1U << 0)
+
 /*
  * IO completion data structure (Completion Queue Entry)
  */
-- 
2.17.1

-- 
Jens Axboe

