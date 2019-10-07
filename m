Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E8C47404
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 23:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4490E206C0
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuwgjtsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfJGXTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:19:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46411 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfJGXTD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 19:19:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so17124857wrv.13;
        Mon, 07 Oct 2019 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8fSnDMFwoBetrWXVXSxxN7Vi5ILs+0deb5nNDy4m2k=;
        b=HuwgjtsXEQcJQJK/M1dtqh/cfARhkbuDtfb8l8GTWlkl2Bgoxb8DKBZjpNr0illqsZ
         ClNN4wwRSCloHBei1oXhMb8O0WleRJPoycRHPojyWOiX6nJhY1TACAqIYvKuYpvkDIg3
         WGj3gq+nklG4iqxaxClYz8/0dTYPItqw72wAeKNMBZ1GmzQmTAWe/8XOtXzfELL1MNNO
         Qwj05jjtvLriAr2b8huaxJUcij/AzfKdIFa76K4MjpoFp1aPELIP1EwZva8gTKJPYLH3
         o6Nw2BZ6Nw37Yh+mbM0OM1BvgSOD1qxDxFN5+qSdu2oTZBu+tbrH1JkRHksU+ddlfDc6
         kzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8fSnDMFwoBetrWXVXSxxN7Vi5ILs+0deb5nNDy4m2k=;
        b=EAOUR4A3BWS9VjYK1QNJqzUdTioWOWTH1YDjyII+KgMnEpRmgjAGp+je1cWEIB4okg
         royT6sL36/ZJzg2CN7f53CXBhCgT199eUFdb3CF7ddGQC9nr31z/uVs2AFfLxlrFak8X
         uE5O3zMK7PbMLSxuhD4ZJS/tpC6aFpKzNJrMaKDxp5jjH9OAONm1YJEdKZtBw8sF5dsy
         +BPC1z/L7fKC6zspiXp64W44d+vHBDXxcesDEK6TRPRnQDMgOHcXDA0uIzcKBlsWmYwW
         xLKr6SR/9h8AnN7poBst3iURDyHUNAFHgnHsciVRPjsyyR9jnASYknlcOeKlxjHxv1Rd
         KKpA==
X-Gm-Message-State: APjAAAUKCgAh+dFzy3iPBuZoOcAtJQYyfIXX9a4gqCJzmad5KkZWF1Pr
        C1HbLakXy6y3zde2BXBDjnelKqtO
X-Google-Smtp-Source: APXvYqxnjQoAgteLUfyU63Eq8Mg2gEPWwfQtgKqWhbBGs1rzVcEmMc2ppDnUjNR/3iTrxjDs6MnSIw==
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr19987220wrr.23.1570490340688;
        Mon, 07 Oct 2019 16:19:00 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.195])
        by smtp.gmail.com with ESMTPSA id d4sm20726435wrq.22.2019.10.07.16.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 16:18:59 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH] io_uring: remove wait loop spurious wakeups
Date:   Tue,  8 Oct 2019 02:18:42 +0300
Message-Id: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Any changes interesting to tasks waiting in io_cqring_wait() are
commited with io_cqring_ev_posted(). However, io_ring_drop_ctx_refs()
also tries to do that but with no reason, that means spurious wakeups
every io_free_req() and io_uring_enter().

Just use percpu_ref_put() instead.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c934f91c51e9..89d77a626063 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -591,14 +591,6 @@ static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 user_data,
 	io_cqring_ev_posted(ctx);
 }
 
-static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
-{
-	percpu_ref_put_many(&ctx->refs, refs);
-
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
-}
-
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 				   struct io_submit_state *state)
 {
@@ -646,7 +638,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	req->result = 0;
 	return req;
 out:
-	io_ring_drop_ctx_refs(ctx, 1);
+	percpu_ref_put(&ctx->refs);
 	return NULL;
 }
 
@@ -654,7 +646,7 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 {
 	if (*nr) {
 		kmem_cache_free_bulk(req_cachep, *nr, reqs);
-		io_ring_drop_ctx_refs(ctx, *nr);
+		percpu_ref_put_many(&ctx->refs, *nr);
 		*nr = 0;
 	}
 }
@@ -663,7 +655,7 @@ static void __io_free_req(struct io_kiocb *req)
 {
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
-	io_ring_drop_ctx_refs(req->ctx, 1);
+	percpu_ref_put(&req->ctx->refs);
 	kmem_cache_free(req_cachep, req);
 }
 
@@ -3630,7 +3622,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		}
 	}
 
-	io_ring_drop_ctx_refs(ctx, 1);
+	percpu_ref_put(&ctx->refs);
 out_fput:
 	fdput(f);
 	return submitted ? submitted : ret;
-- 
2.23.0

