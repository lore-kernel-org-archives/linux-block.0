Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A41DC4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E9B218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EBGAojY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfCOOyw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:54:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34276 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfCOOyw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:54:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so6674539pgq.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rpzM7j8edKfPQoYwMy8De353jI/mm9uBUGKHdkCij4k=;
        b=EBGAojY8gQkPlBFoCp+GEVtLSh73fOgI/UkeISjjMmEGI0noFDAhGuibMwE7XIZTvm
         zijPppvT63twHH9bOruK1US+uJoy05WwkrW7xK/2tRC4xB0zKhw08RorNdKOHmXBwQSD
         z1tdt+SpAgpUPM+BIjgzqQLvaxCbE9abP4fKkSmn0ibSHV76gJJwukhZiyTesbKO5xD7
         uoum+PMzMVLWiqKR11VG80xO4iW7gtMUZWNWRMnr9g+Z0RTv3jzmLDygkTUl5lLRdM03
         HwrEnuXPW76qA4CJ4ZAVwZ12cK3gZrxdmkEvHpD6ZmJZBOqk3xDGDQYmlujmLWXaesy5
         eIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rpzM7j8edKfPQoYwMy8De353jI/mm9uBUGKHdkCij4k=;
        b=M3guYvOL39zeXQvMYHbYs0R2XqYUNXB/jXHUXiFlPoQ38glsfC58thdTj8oyrCNsUq
         dFVO9mu++xR23l7mKl7hphjYJ1Sf+bC7MX/5DbYggT1dekEXT+BI0IhisZ4eIhOz9Mxr
         /yP6hMxyWS2V5iV8bP/LyAB0oEYceGaMTlOln10jXnozMin9sdrhhZ4ZiykY7+mAvoGY
         LVOVsuB24FwSZHEWgq0Ua9A0oD4funeEaokr3U3E0r428RXTOWngdnJJY3B6jyj0Gn65
         Y/4zopQUNjijiqaLrAYWotpi9meEkFXIs+bFW6DUQAW75dz33dk2eukJF448WwAp+22P
         Lu+g==
X-Gm-Message-State: APjAAAUW6p0d+eJX01M/+n2kIkIyn6bBHCqX5p6X7QdHOmFbmRZrtdRf
        jh5q2fdaxHBdMNreUoJ7gMaBMA==
X-Google-Smtp-Source: APXvYqzRWKc6cv+iKNZtSVqtXA9NrU0vCGl9GqAAgPtf0G1pUBxydJm0tBOC68DoUM90n1Wur0aOHw==
X-Received: by 2002:a17:902:7242:: with SMTP id c2mr4551994pll.245.1552661691585;
        Fri, 15 Mar 2019 07:54:51 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t10sm3192272pgo.27.2019.03.15.07.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:54:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] io_uring: make io_read/write return an integer
Date:   Fri, 15 Mar 2019 08:54:37 -0600
Message-Id: <20190315145442.21127-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315145442.21127-1-axboe@kernel.dk>
References: <20190315145442.21127-1-axboe@kernel.dk>
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
index 9071fca118a4..caf39663466f 100644
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
@@ -1623,7 +1622,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 			 struct io_submit_state *state)
 {
 	struct io_kiocb *req;
-	ssize_t ret;
+	int ret;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(s->sqe->flags & ~IOSQE_FIXED_FILE))
-- 
2.17.1

