Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1260AC43219
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F284F60C4B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhJLST5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhJLSTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897FC061753
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b10so9789907iof.12
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjfdwdOP2h7oZEEBaaGTV7Ar0fpekZ11g0+z4RlOBFc=;
        b=bRoG2yUgCYnYvg7NKkf++dKLMYEkxzLOz0jSARY33vIzlpxU1IgRGTM3UDqk7RyeLM
         J6su0UnY7wxg75qfgtW4CErQHMobfuiipG1EBn6s2WNyQB9la9TurxcemyFXCzD4Q9bQ
         c2z5OCbCRJL2Ks1OPNQVv2reTG4kLpasVe55/R5azpcoS3FtbIdO0NUY3uxEJFLULwe2
         cPN7mNqDB0cSDHb0XEUsqakHBGfBqjB2FsVf4OrnlGSNmkTFKrMiHo+4/Pyt5CgbVMdN
         DQCdribv0ZJIFK+4YuAsSDFnUPj3QSFQ1XEDVrQEkbOp4JBVjeVYni/6LFydo4VYbz6L
         of+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjfdwdOP2h7oZEEBaaGTV7Ar0fpekZ11g0+z4RlOBFc=;
        b=tvAtWgP5b8j2QUBauguXTA8czMA+qzpF2HoykKG2s7AYcP9gzR6PcMg537PmJOO2ba
         yiABqJqnH78Vv7iQGC1pYS6pj3OPMDqg6SppgAxQnevNYb/Rsr6smfRF1eRaapZStKG8
         hkRxXKjaz3OPWiRMLwo1mLxRY1Lv+w8yWD6trGyr4R1jskCSTzlm+tXebEkq464fZPxM
         jCnIIaOu37zXq1WAOuJKpLkuX705qYpV4nBhUx0meep8JGOnBr00txHwXbiv7Lh5c5+X
         7PrPvfvMDNsp6Vm/kcKs9p1fDtaknn0fbHLAAWKFam6746/SY4g7VXQ5KaZK3FNO6ehD
         XDyg==
X-Gm-Message-State: AOAM5331cg2iUBulm4UYpWpZAgJanaUdB/dAa4Y+T8S9RfcEtYQrLAyk
        JSJ3Y1/I4xewvp8/MmkK1yZw7nCMjtzgWQ==
X-Google-Smtp-Source: ABdhPJziSe/gtjT2FZNxJ2RLiMM1v05nbamjdJp+BydRrv5XNMyXoHvJawcqB13St6uhac91Fx2U9A==
X-Received: by 2002:a6b:f816:: with SMTP id o22mr26398442ioh.106.1634062670348;
        Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/9] io_uring: utilize the io_batch infrastructure for more efficient polled IO
Date:   Tue, 12 Oct 2021 12:17:41 -0600
Message-Id: <20211012181742.672391-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Wire up using an io_batch for f_op->iopoll(). If the lower stack supports
it, we can handle high rates of polled IO more efficiently.

This raises the single core efficiency on my system from ~6.1M IOPS to
~6.6M IOPS running a random read workload at depth 128 on two gen2
Optane drives.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 082ff64c1bcb..cbf00ad3ac3f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2390,6 +2390,8 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 {
 	struct io_wq_work_node *pos, *start, *prev;
 	unsigned int poll_flags = BLK_POLL_NOSLEEP;
+	struct file *file = NULL;
+	struct io_batch ib;
 	int nr_events = 0;
 
 	/*
@@ -2399,11 +2401,17 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 	if (ctx->poll_multi_queue && force_nonspin)
 		poll_flags |= BLK_POLL_ONESHOT;
 
+	ib.req_list = NULL;
 	wq_list_for_each(pos, start, &ctx->iopoll_list) {
 		struct io_kiocb *req = container_of(pos, struct io_kiocb, comp_list);
 		struct kiocb *kiocb = &req->rw.kiocb;
 		int ret;
 
+		if (!file)
+			file = kiocb->ki_filp;
+		else if (file != kiocb->ki_filp)
+			break;
+
 		/*
 		 * Move completed and retryable entries to our local lists.
 		 * If we find a request that requires polling, break out
@@ -2412,19 +2420,21 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 		if (READ_ONCE(req->iopoll_completed))
 			break;
 
-		ret = kiocb->ki_filp->f_op->iopoll(kiocb, NULL, poll_flags);
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, &ib, poll_flags);
 		if (unlikely(ret < 0))
 			return ret;
 		else if (ret)
 			poll_flags |= BLK_POLL_ONESHOT;
 
 		/* iopoll may have completed current req */
-		if (READ_ONCE(req->iopoll_completed))
+		if (ib.req_list || READ_ONCE(req->iopoll_completed))
 			break;
 	}
 
-	if (!pos)
+	if (!pos && !ib.req_list)
 		return 0;
+	if (ib.req_list)
+		ib.complete(&ib);
 
 	prev = start;
 	wq_list_for_each_resume(pos, prev) {
-- 
2.33.0

