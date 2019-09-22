Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC8C3A5A2
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 08:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5E220830
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 08:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8AgvgEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfIVIJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 04:09:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35126 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIVIJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 04:09:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so6055824wmi.0;
        Sun, 22 Sep 2019 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CD5dbN6dWmUlIx4cKSdgxz+b1tGDJ8hFL6z+Q546CZk=;
        b=E8AgvgExUI3gKjb+333Cd12keB8bc0WQFm2GpsOIlfUr7WYthQc8alEPksUTgL+n49
         keuqFaF5/5HPCsxXo+UtFlIijmQ4dK9LJ4RdtGKf4JG7JN/z95IvlHNOq+npitQx+wvr
         YKq+oPNLD+tMkML8nh/tNDZQhq1tVD5YCaRz/LLbqdGxvG/20yagbTWn/3CxPzx1dzYX
         KgvCUw0vn5Ia0QTkpHtz2tyuBz3Z0VQ0L3N0L9O95gbwGFYnQYYhCiQAvs2kW4reVqMQ
         gez8w4veI56zulgySmi4zvpu7dvFmeU3wsr2kL5UzBDjacTuXGtPmh89xH9npx+NqyFB
         8q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CD5dbN6dWmUlIx4cKSdgxz+b1tGDJ8hFL6z+Q546CZk=;
        b=Jc5e+5/3QwM5pWiWF4kI8e1yAynXiAZxEohvGJEKKe+Ocm4QiqDRJo6Y6kzJCEyt5Y
         lXp41tw9QrE/9kLGlrknGSQ0KTLyToWR/P3N8yY4E+EgKBj7XE10sohcGpS1gTvy8zzE
         eqU5uozMY9lFt6ahJZdZrVXHz+6jqabJFTNLGXwrRyMvQAnXGY9n+uO2/EphSZyPvkZO
         Jq9SDj6OgQ46whsUWQWLpugKqUF1Z54eUq+tofvQkG9dG6yEq8jdtk9/97fWT6fgdYes
         4P/dvEOhBjxdnZ17J6nApO4XOartqBUhKkoK7vDWSJNShYXS4YZwpkMX/C4o14EQ5LLl
         RmtA==
X-Gm-Message-State: APjAAAUD3mGUBEfMa2X+bXJzTWne3JwwLcGQ/52k9on7tp5gT6WRKm7b
        nZVnPTWrmR2/Ikv2vPZbczk=
X-Google-Smtp-Source: APXvYqxRF3hjhST0yeu+KSpaHSaKnYdpDROzfGN1inYoTYsKyq521h9oabCKDJNmF7s3rDCOWG6JmQ==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr9564923wmk.30.1569139757683;
        Sun, 22 Sep 2019 01:09:17 -0700 (PDT)
Received: from localhost.localdomain ([109.126.147.119])
        by smtp.gmail.com with ESMTPSA id x5sm7726983wrt.75.2019.09.22.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 01:09:17 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 2/2] io_uring: Optimise cq waiting with wait_threshold
Date:   Sun, 22 Sep 2019 11:08:51 +0300
Message-Id: <321aa8db2bbefb8f4b41d7b2608f629fbd5d3d55.1569139018.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569139018.git.asml.silence@gmail.com>
References: <cover.1569139018.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

While waiting for completion events in io_cqring_wait(), the process
will be waken up inside wait_threshold_interruptible() on any request
completion, check num of events in completion queue and potentially go
to sleep again.

Apparently, there could be a lot of such spurious wakeups with lots of
overhead. It especially manifests itself, when min_events is large, and
completions are arriving one by one or in small batches (that usually
is true).

E.g. if device completes requests one by one and io_uring_enter is
waiting for 100 events, then there will be ~99 spurious wakeups.

Use new wait_threshold_*() instead, which won't wake it up until
necessary number of events is collected.

Performance test:
The first thread generates requests (QD=512) one by one, so they will
be completed in the similar pattern. The second thread waiting for
128 events to complete.

Tested with null_blk with 5us delay
and 3.8GHz Intel CPU.

throughput before: 270 KIOPS
throughput after:  370 KIOPS
~40% throughput boost, exaggerated, but makes a point.

v2: wake always in io_timeout_fn() with WQ_THRESHOLD_WAKE_ALWAYS

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5c3f2bb81637..05f4391c7bbe 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -70,6 +70,7 @@
 #include <linux/nospec.h>
 #include <linux/sizes.h>
 #include <linux/hugetlb.h>
+#include <linux/wait_threshold.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -414,6 +415,13 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	return ctx;
 }
 
+static unsigned int io_cqring_events(struct io_rings *rings)
+{
+	/* See comment at the top of this file */
+	smp_rmb();
+	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
+}
+
 static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
 				     struct io_kiocb *req)
 {
@@ -559,16 +567,27 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 	}
 }
 
-static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
+static void __io_cqring_ev_posted(struct io_ring_ctx *ctx,
+				unsigned int nr_events)
 {
 	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+		wake_up_threshold(&ctx->wait, nr_events);
 	if (waitqueue_active(&ctx->sqo_wait))
 		wake_up(&ctx->sqo_wait);
 	if (ctx->cq_ev_fd)
 		eventfd_signal(ctx->cq_ev_fd, 1);
 }
 
+static inline void io_cqring_ev_posted(struct io_ring_ctx *ctx)
+{
+	__io_cqring_ev_posted(ctx, io_cqring_events(ctx->rings));
+}
+
+static inline void io_cqring_timeout_posted(struct io_ring_ctx *ctx)
+{
+	__io_cqring_ev_posted(ctx, WQ_THRESHOLD_WAKE_ALWAYS);
+}
+
 static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 user_data,
 				long res)
 {
@@ -587,7 +606,7 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 	percpu_ref_put_many(&ctx->refs, refs);
 
 	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+		wake_up_threshold(&ctx->wait, io_cqring_events(ctx->rings));
 }
 
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
@@ -722,12 +741,6 @@ static void io_put_req(struct io_kiocb *req)
 		io_free_req(req);
 }
 
-static unsigned io_cqring_events(struct io_rings *rings)
-{
-	/* See comment at the top of this file */
-	smp_rmb();
-	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
-}
 
 /*
  * Find and free completed poll iocbs
@@ -1824,7 +1837,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
-	io_cqring_ev_posted(ctx);
+	io_cqring_timeout_posted(ctx);
 
 	io_put_req(req);
 	return HRTIMER_NORESTART;
@@ -2723,7 +2736,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	 * we started waiting. For timeouts, we always want to return to
 	 * userspace.
 	 */
-	ret = wait_event_interruptible(ctx->wait,
+	ret = wait_threshold_interruptible(ctx->wait, min_events,
 				io_cqring_events(rings) >= min_events ||
 				atomic_read(&ctx->cq_timeouts) != nr_timeouts);
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
-- 
2.23.0

