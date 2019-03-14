Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AFEC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928F021872
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NoBNxZ84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfCNUop (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34533 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfCNUoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:44 -0400
Received: by mail-io1-f65.google.com with SMTP id n11so6519960ioh.1
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GkQgnR8Dxlw6eMCFxktvvmbSrLQd+vccM/+thHvNV8Q=;
        b=NoBNxZ84SlJzEyoWKoldOCW2KzUpVWnPoqMUxJ6JseiYkAmYhVl8JW8sMEB1Wner0i
         ZIBCvli9UGcTFzeFq3apVGHaJjnB3yzfPsqexr6Fx5L5kXbCLA/6t+PiUUjgVYAXuut9
         TJXnDYjDJdApU2pKonijFJRFKff4CRz2hVNZ5lf2oS8cTT1SorZJL/ERkPdNzCjiy+9a
         CabYAq26cHo/OjShnoa3YOI9fWzmb7l0AQXCt5nyRh3/n7nJSpzzaWTwWU5Zg0CeH2yT
         LaSndNFnpm/KIG7fegjMs0K3lMlaZQE8/yF+OTD21ps5m2WSNetKwOzBWm2wSX8NDJyA
         odMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GkQgnR8Dxlw6eMCFxktvvmbSrLQd+vccM/+thHvNV8Q=;
        b=ABkF6QLa1Wk1ydKHpBRM5kN7ITwHoiiJZoR6K8LnT7VTO/R1JWPyvD1x8wUvZ3DIy1
         tgQNv+LymOYRh22lkU5PNEh8sRt8arkBRCYTDeT1Uv+Jc3lpIbY6L9MFw8MH3bb42nho
         gTnyWRXm8b/VtXVTaVZZttcG+64r9Q3kSuox77kJ6f0yy3PnsjKwoD0aOCxq+eDcdNQg
         Z6Atz7BYLQlP8pOnjBXIbthnPNcre60JNCmlbS84mjgFRDuC2ek17rb98JLXV0SvBnfs
         iAOOB5f1ABo2FNDhUS8BKf38eA5LLDHKkr7EVPqEHtGwxv0RBNAB8sURSTytVEiONGbE
         BPXw==
X-Gm-Message-State: APjAAAWjVwQDsWbhdP/YH4CIcdnKPuN0/Rpom10OzsGelLd66LzZ6Y6I
        IgHfKm51iGl6DdafD15fST/QvaYlrdW7lQ==
X-Google-Smtp-Source: APXvYqyWtlUZXThcHFyDK1NqpEfJMam9MaweeDgGJ6IgJ6dFXNoIHA5XgNbnkNwb9b0T93I/uq0UBQ==
X-Received: by 2002:a5e:8212:: with SMTP id l18mr14345iom.67.1552596283757;
        Thu, 14 Mar 2019 13:44:43 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] io_uring: make io_read/write return an integer
Date:   Thu, 14 Mar 2019 14:44:29 -0600
Message-Id: <20190314204435.7692-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314204435.7692-1-axboe@kernel.dk>
References: <20190314204435.7692-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The callers all convert to an integer, and we only return 0/-ERROR
anyway.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c54af70c72fd..ecb93bb9d84e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -893,7 +893,7 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 	opcode = READ_ONCE(sqe->opcode);
 	if (opcode == IORING_OP_READ_FIXED ||
 	    opcode == IORING_OP_WRITE_FIXED) {
-		ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
+		int ret = io_import_fixed(ctx, rw, sqe, iter);
 		*iovec = NULL;
 		return ret;
 	}
@@ -951,15 +951,15 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
 	async_list->io_end = io_end;
 }
 
-static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
-		       bool force_nonblock, struct io_submit_state *state)
+static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
+		   bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	ssize_t ret;
+	int ret;
 
 	ret = io_prep_rw(req, s, force_nonblock, state);
 	if (ret)
@@ -1004,15 +1004,15 @@ static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	return ret;
 }
 
-static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
-			bool force_nonblock, struct io_submit_state *state)
+static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
+		    bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	ssize_t ret;
+	int ret;
 
 	ret = io_prep_rw(req, s, force_nonblock, state);
 	if (ret)
@@ -1396,8 +1396,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   const struct sqe_submit *s, bool force_nonblock,
 			   struct io_submit_state *state)
 {
-	ssize_t ret;
-	int opcode;
+	int ret, opcode;
 
 	if (unlikely(s->index >= ctx->sq_entries))
 		return -EINVAL;
@@ -1624,7 +1623,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 {
 	bool did_submit = true;
 	struct io_kiocb *req;
-	ssize_t ret;
+	int ret;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(s->sqe->flags & ~IOSQE_FIXED_FILE))
-- 
2.17.1

