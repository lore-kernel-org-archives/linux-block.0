Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214EDC49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA77C2089F
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HOBD/1hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfIKQPn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:15:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43368 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbfIKQPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 12:15:43 -0400
Received: by mail-io1-f67.google.com with SMTP id r8so22174952iol.10
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2019 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tRWjgrxVMMzik7y+L2a3T9WHSuMT25jL0eU4nBvbOqk=;
        b=HOBD/1hdlsVlQQK0g+Yv1QkO5A9PhOnIiOfCp1wgaJuaPHS/2eFatE8vS8QAHv7oAl
         nnunQ4ux+GhXr5bG/amudS3DQp+IG22H1pf5LxN1oTZmuGBpR00kEczTwuLVRR0muC0/
         yh3k1BNP3MD/9tVkByJhq7CX69pTRiwrxIJN2BcgNIoVn+N2G01SHVhs8/A8acn0nGgG
         /kaXhmSqyrOFXazBlIkrVzT9OBsOqHWUHJtibDCTNCE3bhd6TzAU+UIEbp3I5Bw/7ysj
         CO6GGffpQglIqZgRJeJQOr+OXi2+ziguUBBYQ6B6AjeHrU1YMvvdhTLjtEx94LgR+Oif
         qlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tRWjgrxVMMzik7y+L2a3T9WHSuMT25jL0eU4nBvbOqk=;
        b=AVeP7M5KzTXqJiu++KXI0Ji+ypkjC5kN+LIV41Sp/WzIBC0nTZGqx3PWzfLucxWtHJ
         0zG/HB8n4HB6L6F2Fj/s76/sf0MvqkOO6EBvIoqurxJL1bo9GWXDOO4lnholBf2QMH8+
         zufZYL5UNKzN+ia9X39BYY6iB08PzDCAs1Z8FKTUsHUmlPczny8N6MRz6V6Di9fMDpEI
         hVnwkEH/Qn8RUg4dbvbeFiqHgmqtI8Fgy+CTCLB+cfBstzm7LjsyqwuCS/jmA8hDZIPK
         WaEBa1fwiDVR2bwpAJAzGi7wnInGmGELoo8e9s54VAOFYvnSVbZlX07NXUBFN6j+brdT
         MyJQ==
X-Gm-Message-State: APjAAAUmXRFVsByhGwaHTMaL7ezX5UeaqoniA9zRsm44ni58/dnDqKqR
        mbrBRdDiUK6P/3iRPMKQrefBmppMLM1cXw==
X-Google-Smtp-Source: APXvYqz+4DGEL6ZsVM2BIQ8CDTbJ9O2YPIQltJXWIH+jBIfS7Q7LDAWA2Lm+lA0u4YUd9/OFHk44vw==
X-Received: by 2002:a6b:590b:: with SMTP id n11mr21297901iob.256.1568218540585;
        Wed, 11 Sep 2019 09:15:40 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s201sm51443046ios.83.2019.09.11.09.15.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:15:39 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: extend async work merging
Message-ID: <0b62fee7-d3bd-f60e-ae81-27880f42d508@kernel.dk>
Date:   Wed, 11 Sep 2019 10:15:38 -0600
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

We currently merge async work items if we see a strict sequential hit.
This helps avoid unnecessary workqueue switches when we don't need
them. We can extend this merging to cover cases where it's not a strict
sequential hit, but the IO still fits within the same page. If an
application is doing multiple requests within the same page, we don't
want separate workers waiting on the same page to complete IO. It's much
faster to let the first worker bring in the page, then operate on that
page from the same worker to complete the next request(s).

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 03fcd974fd1d..4bc3ee4ea81f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -167,7 +167,7 @@ struct async_list {
 	struct list_head	list;
 
 	struct file		*file;
-	off_t			io_end;
+	off_t			io_start;
 	size_t			io_len;
 };
 
@@ -1189,6 +1189,28 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
 	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
 }
 
+static inline bool io_should_merge(struct async_list *al, struct kiocb *kiocb)
+{
+	if (al->file == kiocb->ki_filp) {
+		off_t start, end;
+
+		/*
+		 * Allow merging if we're anywhere in the range of the same
+		 * page. Generally this happens for sub-page reads or writes,
+		 * and it's beneficial to allow the first worker to bring the
+		 * page in and the piggy backed work can then work on the
+		 * cached page.
+		 */
+		start = al->io_start & PAGE_MASK;
+		end = (al->io_start + al->io_len + PAGE_SIZE - 1) & PAGE_MASK;
+		if (kiocb->ki_pos >= start && kiocb->ki_pos <= end)
+			return true;
+	}
+
+	al->file = NULL;
+	return false;
+}
+
 /*
  * Make a note of the last file/offset/direction we punted to async
  * context. We'll use this information to see if we can piggy back a
@@ -1200,9 +1222,8 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
 	struct async_list *async_list = &req->ctx->pending_async[rw];
 	struct kiocb *kiocb = &req->rw;
 	struct file *filp = kiocb->ki_filp;
-	off_t io_end = kiocb->ki_pos + len;
 
-	if (filp == async_list->file && kiocb->ki_pos == async_list->io_end) {
+	if (io_should_merge(async_list, kiocb)) {
 		unsigned long max_bytes;
 
 		/* Use 8x RA size as a decent limiter for both reads/writes */
@@ -1215,17 +1236,16 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
 			req->flags |= REQ_F_SEQ_PREV;
 			async_list->io_len += len;
 		} else {
-			io_end = 0;
-			async_list->io_len = 0;
+			async_list->file = NULL;
 		}
 	}
 
 	/* New file? Reset state. */
 	if (async_list->file != filp) {
-		async_list->io_len = 0;
+		async_list->io_start = kiocb->ki_pos;
+		async_list->io_len = len;
 		async_list->file = filp;
 	}
-	async_list->io_end = io_end;
 }
 
 static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
@@ -1994,7 +2014,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
  */
 static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 {
-	bool ret = false;
+	bool ret;
 
 	if (!list)
 		return false;

-- 
Jens Axboe

