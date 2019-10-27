Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046CCA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C65208C0
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 20:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmGv37gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfJ0UQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 16:16:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39260 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfJ0UQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 16:16:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so7727906wra.6;
        Sun, 27 Oct 2019 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGfY3UlSVbXSdzMRM54Cq1hRzB3Ln2tYQCuK0v8mGTY=;
        b=VmGv37gYhPLOYRsaIabOXNfdsG1DTqDRczBT7/O21QAugGsHKJXwe7CvlMY5DQDANU
         1YvEALEtkl0VrQ9T2sOOwV6dt4+RypOA3SAyrJwgSYEraGjMTmX+5fLrViR9syGQhjrI
         BV/NYqhTCEWA/mrp/b5XYsF5QtSwGDjb1ejE74YOAW5IGxqNGKnguBoZX43HXuAIL1KN
         navBXAmrj+j9Yu66Iwf4EyUtXSAbS14A6iOTPto9TzT0SkvE9LuROdU/xMc6R6oSQ2sc
         BfYKzo2eAG9frw/q8M9eK4KpN1MW6aloUGTIY5navwKA6E2o1rolVDp4PVBdYmAF/Zxm
         7ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGfY3UlSVbXSdzMRM54Cq1hRzB3Ln2tYQCuK0v8mGTY=;
        b=F+opHEFO1RrTHybFBX0KtkpBav8uoNno6N91h6k4jD+11q4VZwN7mxecuMWgMUw1Ir
         LIQecPMd5gUFp976ZKoAigLPhC44OQpdLCynbaEFktAS6pf5T5qhXQ3dZYkcL1mLRAuD
         Y9M0XMllavRoWeT57ob0sEb8nom86mI+Nwd+nR/nI8kmnSDj8Okx7b0+G3B6lXHvySX4
         r7aefEUNUFpknPe+p/Px1bna62bKZe3tdONB3+C9z4wsy2LRgHPRmrlz9OmGz1dkf5Pr
         CfV/2qUg6uRNRytOa4UUWgJzC8N7BBkj5jk2KE44/BF12RFv/BINHzDnsoH/jAPPKHIJ
         bvug==
X-Gm-Message-State: APjAAAVr7Bm0iBiZnogd55eIszp7vDV+6q0XKJolFBNr4xx+LVwNwu3x
        /ZnhMZYuLEn0oVzPkEHS0+I=
X-Google-Smtp-Source: APXvYqyKMEQTndFZNgQNmnVHsgggw7GAmRQNmpYqOGd1Pi4mLW3nxhUz4Y5kAEjAxa9qFlxjQ32Yhw==
X-Received: by 2002:a5d:4aca:: with SMTP id y10mr11760612wrs.292.1572207365077;
        Sun, 27 Oct 2019 13:16:05 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id g5sm11527550wmg.12.2019.10.27.13.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 13:16:04 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][for-linus] io_uring: Fix mm_fault with READ/WRITE_FIXED
Date:   Sun, 27 Oct 2019 23:15:41 +0300
Message-Id: <a30b1e934506227b4740b6030dd77e7e233a58c2.1572207237.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit fb5ccc98782f ("io_uring: Fix broken links with offloading")
itroduced a regression with unconditionally taking mm even for
READ/WRITE_FIXED operations.

Return the logic handling it back. mm-faulted requests will go through
the generic submission path, so honoring links and drains, but will
fail further on req->has_user check.

Fixes: fb5ccc98782f ("io_uring: Fix broken links with offloading").
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a30c4f622cb3..860a7c0df128 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2579,13 +2579,14 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 }
 
 static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
-			  bool has_user, bool mm_fault)
+			  struct mm_struct **mm)
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
 	struct io_kiocb *shadow_req = NULL;
 	bool prev_was_link = false;
 	int i, submitted = 0;
+	bool mm_fault = false;
 
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
@@ -2598,6 +2599,14 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		if (!io_get_sqring(ctx, &s))
 			break;
 
+		if (io_sqe_needs_user(s.sqe) && !*mm) {
+			mm_fault = mm_fault || !mmget_not_zero(ctx->sqo_mm);
+			if (!mm_fault) {
+				use_mm(ctx->sqo_mm);
+				*mm = ctx->sqo_mm;
+			}
+		}
+
 		/*
 		 * If previous wasn't linked and we have a linked command,
 		 * that's the end of the chain. Submit the previous link.
@@ -2621,16 +2630,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		}
 
 out:
-		if (unlikely(mm_fault)) {
-			io_cqring_add_event(ctx, s.sqe->user_data,
-						-EFAULT);
-		} else {
-			s.has_user = has_user;
-			s.needs_lock = true;
-			s.needs_fixed_file = true;
-			io_submit_sqe(ctx, &s, statep, &link);
-			submitted++;
-		}
+		s.has_user = *mm != NULL;
+		s.needs_lock = true;
+		s.needs_fixed_file = true;
+		io_submit_sqe(ctx, &s, statep, &link);
+		submitted++;
 	}
 
 	if (link)
@@ -2657,7 +2661,6 @@ static int io_sq_thread(void *data)
 
 	timeout = inflight = 0;
 	while (!kthread_should_park()) {
-		bool mm_fault = false;
 		unsigned int to_submit;
 
 		if (inflight) {
@@ -2742,18 +2745,8 @@ static int io_sq_thread(void *data)
 			ctx->rings->sq_flags &= ~IORING_SQ_NEED_WAKEUP;
 		}
 
-		/* Unless all new commands are FIXED regions, grab mm */
-		if (!cur_mm) {
-			mm_fault = !mmget_not_zero(ctx->sqo_mm);
-			if (!mm_fault) {
-				use_mm(ctx->sqo_mm);
-				cur_mm = ctx->sqo_mm;
-			}
-		}
-
 		to_submit = min(to_submit, ctx->sq_entries);
-		inflight += io_submit_sqes(ctx, to_submit, cur_mm != NULL,
-					   mm_fault);
+		inflight += io_submit_sqes(ctx, to_submit, &cur_mm);
 
 		/* Commit SQ ring head once we've consumed all SQEs */
 		io_commit_sqring(ctx);
-- 
2.23.0

