Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7938CA9EBC
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CF821D7B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhiyo7wP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406341AbfJYJbv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:31:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438652AbfJYJbu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 05:31:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so1475900wrs.9;
        Fri, 25 Oct 2019 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmRjCgPUzKkYP2MIaB/azsfLQhHwn5qPJdajE425Fu0=;
        b=vhiyo7wPudEr0Gu9924BQzkHVXmfKXKsh/khTCJDNwrJ5yXAg0DspSYohuQKnpUSiQ
         MGXeLBCGAXaAZHfEa4achL9hFzwmUC8OILeHVB7ocw72eTrmLGybuWd7ZaUmFZYJGmB7
         B9aJY9ASAEDSejh/I6+p/q58w5i/vOaYmy16zRwlcjAkLgGafzd5PY3q/R6X8aTzPOdm
         fqK624csERn5RSU60LPENQBd2Q7URvauPFJVFYuTBqakM5/F5AKvdkedillCnl7q9ib5
         IDaIFsMAnA8HCs65LhFkY+hdK1DbDAip0D5GwJCkhr7/OqW6SqH7hdkj5qvWADpjAjO2
         T7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmRjCgPUzKkYP2MIaB/azsfLQhHwn5qPJdajE425Fu0=;
        b=adLvcB46N+TGslMC2L+DEzVsKLKXloDdrFYKiZRIHR/KDzUF7YJLFyxR+eiHih0Vsm
         FwMthpip7J20+nfq5riFSGJx8LfFRR/zU+skOgO/ro9+qzdCGTz/O/uKJU0LbrH7OVxz
         L5yGXVWEb+Bg14BZ9itg3Y1SLKhjYu+zdI3CUDJqZGkO4/dqVxPjPB6wf3wAN9pBDCcw
         cFtWv5VaOwUuAvPYN2y1JsuwESVlFp+sHME7G+PMEcfOgRLoNs2rc0ozxvWtZNpUlQ1U
         aVA1XuLzXzCO5zg/EE3xNn2Q1y2g1toFBhRjXE7m8X66YRRpvKolVJHl4bWpl8yvLXOi
         1sEQ==
X-Gm-Message-State: APjAAAU6YNeCPx52II4wTWldYN70Elwh716M2XDkQbFk7gel0ykG3D7p
        OqBqauDlaibYY8ryKdZ51tjosoZP
X-Google-Smtp-Source: APXvYqy8SWNGaNVLczSgaGmiXvj46hbOdxX3pT2leyUhfQJAVmGMu6Lb3bSDi2YqHzXIam/JMo3Xtg==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr1911075wrn.97.1571995907880;
        Fri, 25 Oct 2019 02:31:47 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id l7sm2054551wro.17.2019.10.25.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 02:31:47 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 2/3] io_uring: Fix broken links with offloading
Date:   Fri, 25 Oct 2019 12:31:30 +0300
Message-Id: <bd0eaa7729e3b8b599a25167df0a4ee583da69cc.1571991701.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571991701.git.asml.silence@gmail.com>
References: <cover.1571991701.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

io_sq_thread() processes sqes by 8 without considering links. As a
result, links will be randomely subdivided.

The easiest way to fix it is to call io_get_sqring() inside
io_submit_sqes() as do io_ring_submit().

Downsides:
1. This removes optimisation of not grabbing mm_struct for fixed files
2. It submitting all sqes in one go, without finer-grained sheduling
with cq processing.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 62 +++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0e141d905a5b..949c82a40d16 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -735,6 +735,14 @@ static unsigned io_cqring_events(struct io_rings *rings)
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
 }
 
+static inline unsigned int io_sqring_entries(struct io_ring_ctx *ctx)
+{
+	struct io_rings *rings = ctx->rings;
+
+	/* make sure SQ entry isn't read before tail */
+	return smp_load_acquire(&rings->sq.tail) - ctx->cached_sq_head;
+}
+
 /*
  * Find and free completed poll iocbs
  */
@@ -2560,8 +2568,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	return false;
 }
 
-static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
-			  unsigned int nr, bool has_user, bool mm_fault)
+static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
+			  bool has_user, bool mm_fault)
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
@@ -2575,6 +2583,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 	}
 
 	for (i = 0; i < nr; i++) {
+		struct sqe_submit s;
+
+		if (!io_get_sqring(ctx, &s))
+			break;
+
 		/*
 		 * If previous wasn't linked and we have a linked command,
 		 * that's the end of the chain. Submit the previous link.
@@ -2584,9 +2597,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			link = NULL;
 			shadow_req = NULL;
 		}
-		prev_was_link = (sqes[i].sqe->flags & IOSQE_IO_LINK) != 0;
+		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
 
-		if (link && (sqes[i].sqe->flags & IOSQE_IO_DRAIN)) {
+		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
 			if (!shadow_req) {
 				shadow_req = io_get_req(ctx, NULL);
 				if (unlikely(!shadow_req))
@@ -2594,18 +2607,18 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
 				refcount_dec(&shadow_req->refs);
 			}
-			shadow_req->sequence = sqes[i].sequence;
+			shadow_req->sequence = s.sequence;
 		}
 
 out:
 		if (unlikely(mm_fault)) {
-			io_cqring_add_event(ctx, sqes[i].sqe->user_data,
+			io_cqring_add_event(ctx, s.sqe->user_data,
 						-EFAULT);
 		} else {
-			sqes[i].has_user = has_user;
-			sqes[i].needs_lock = true;
-			sqes[i].needs_fixed_file = true;
-			io_submit_sqe(ctx, &sqes[i], statep, &link);
+			s.has_user = has_user;
+			s.needs_lock = true;
+			s.needs_fixed_file = true;
+			io_submit_sqe(ctx, &s, statep, &link);
 			submitted++;
 		}
 	}
@@ -2620,7 +2633,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 
 static int io_sq_thread(void *data)
 {
-	struct sqe_submit sqes[IO_IOPOLL_BATCH];
 	struct io_ring_ctx *ctx = data;
 	struct mm_struct *cur_mm = NULL;
 	mm_segment_t old_fs;
@@ -2635,8 +2647,8 @@ static int io_sq_thread(void *data)
 
 	timeout = inflight = 0;
 	while (!kthread_should_park()) {
-		bool all_fixed, mm_fault = false;
-		int i;
+		bool mm_fault = false;
+		unsigned int to_submit;
 
 		if (inflight) {
 			unsigned nr_events = 0;
@@ -2656,7 +2668,8 @@ static int io_sq_thread(void *data)
 				timeout = jiffies + ctx->sq_thread_idle;
 		}
 
-		if (!io_get_sqring(ctx, &sqes[0])) {
+		to_submit = io_sqring_entries(ctx);
+		if (!to_submit) {
 			/*
 			 * We're polling. If we're within the defined idle
 			 * period, then let us spin without work before going
@@ -2687,7 +2700,8 @@ static int io_sq_thread(void *data)
 			/* make sure to read SQ tail after writing flags */
 			smp_mb();
 
-			if (!io_get_sqring(ctx, &sqes[0])) {
+			to_submit = io_sqring_entries(ctx);
+			if (!to_submit) {
 				if (kthread_should_park()) {
 					finish_wait(&ctx->sqo_wait, &wait);
 					break;
@@ -2705,19 +2719,8 @@ static int io_sq_thread(void *data)
 			ctx->rings->sq_flags &= ~IORING_SQ_NEED_WAKEUP;
 		}
 
-		i = 0;
-		all_fixed = true;
-		do {
-			if (all_fixed && io_sqe_needs_user(sqes[i].sqe))
-				all_fixed = false;
-
-			i++;
-			if (i == ARRAY_SIZE(sqes))
-				break;
-		} while (io_get_sqring(ctx, &sqes[i]));
-
 		/* Unless all new commands are FIXED regions, grab mm */
-		if (!all_fixed && !cur_mm) {
+		if (!cur_mm) {
 			mm_fault = !mmget_not_zero(ctx->sqo_mm);
 			if (!mm_fault) {
 				use_mm(ctx->sqo_mm);
@@ -2725,8 +2728,9 @@ static int io_sq_thread(void *data)
 			}
 		}
 
-		inflight += io_submit_sqes(ctx, sqes, i, cur_mm != NULL,
-						mm_fault);
+		to_submit = min(to_submit, ctx->sq_entries);
+		inflight += io_submit_sqes(ctx, to_submit, cur_mm != NULL,
+					   mm_fault);
 
 		/* Commit SQ ring head once we've consumed all SQEs */
 		io_commit_sqring(ctx);
-- 
2.23.0

