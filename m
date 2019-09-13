Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE12C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6EE20692
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaCyKRbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404103AbfIMW2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:28:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45770 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404102AbfIMW2W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:28:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id l16so33384524wrv.12;
        Fri, 13 Sep 2019 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdU6m/5tnwqD2qEYA/L7MQWWo5R8oi1LocB0y0eYQ5o=;
        b=kaCyKRboocVKY5DzrnmVkwAz3ufQOPecnpbfl0Pc+D4eIMRI5NZ0HGkVHGhPxhNh+v
         L4Ar2MhJFDzzidnTeNm4mmmi9oWJifQFHeRhxj7t8B8VWLubK2DRzAPXH+UYJKgJWUA2
         pt3v8z69izjqbxeQWFiLIKr+ksf6qiS7ygM31lExJ5/1OJ2EPXjRXuoplnaheaMuNXr2
         mSNkvZBvGlB8I9+UQin+KwTFoHPJlKjE2PFcaXt6LgBM0PXMq5Samx0YaHrjvBXhc86W
         npc8AuSEOPbpCRqBv6cBo5mVroPMrENfhBtsVs3ZP+M3KXUtmORZMm6bjR72Wmw0L6TB
         zqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdU6m/5tnwqD2qEYA/L7MQWWo5R8oi1LocB0y0eYQ5o=;
        b=jv1W1qjk7prLQHZfD7Y/buk1AHkdP9unuGNDrMYkPDGxxLTYj5QGZFTDiLCbaCQrRF
         XPHeYPGvXyXfuU79sXNOtkL8efMTTMgDtcWUk2i1uKZ5cyhtnv8ycikvKcggk/dtdfUr
         uz9EhoXodW+6qcXZ/3LIANnyObSf+TdNHa8Fq+52kNIq+ty57tLe6yBVvhuvV3Do+a7E
         b//CMHIJ5aUUbE3/aLqQ0RWKM492UJCH+aPiMWXNczUvvAdiqMhdwF05tdFVNWDH2kf8
         K77b3OmLGxHxmKM/ioo8dT+lMjjhG+OwJKjB8QThcv1B1lAM6D3xSX4HwTeDoqAPntuc
         vTPA==
X-Gm-Message-State: APjAAAUSxf1n+tXojNbApgvMWlCzU1ZqniDBQJ/QojbMwMw9nM5Knyfx
        iA5WWWN3yFUwd83CvHEMTKk=
X-Google-Smtp-Source: APXvYqwXiqK8hNMctc+9E3sU6LIcYAWLGA9V42DhmIKlW9MfqVSe7zqG/u+mPMuejMGFWA7GlMsAXw==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr5982765wrv.30.1568413700857;
        Fri, 13 Sep 2019 15:28:20 -0700 (PDT)
Received: from localhost.localdomain ([109.126.151.137])
        by smtp.gmail.com with ESMTPSA id d12sm3456107wme.33.2019.09.13.15.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 15:28:20 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 2/2] io_uring: Optimise cq waiting with wait_threshold
Date:   Sat, 14 Sep 2019 01:28:02 +0300
Message-Id: <71aa08dfd7fee3093845957cdcf32b21f9194892.1568413210.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1568413210.git.asml.silence@gmail.com>
References: <cover.1568413210.git.asml.silence@gmail.com>
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
So, ~40% throughput boost on this exaggerate test.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 37395208a729..17d2d30b763a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -70,6 +70,7 @@
 #include <linux/nospec.h>
 #include <linux/sizes.h>
 #include <linux/hugetlb.h>
+#include <linux/wait_threshold.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -403,6 +404,13 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
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
@@ -521,7 +529,7 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
 {
 	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+		wake_up_threshold(&ctx->wait, io_cqring_events(ctx->rings));
 	if (waitqueue_active(&ctx->sqo_wait))
 		wake_up(&ctx->sqo_wait);
 	if (ctx->cq_ev_fd)
@@ -546,7 +554,7 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 	percpu_ref_put_many(&ctx->refs, refs);
 
 	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+		wake_up_threshold(&ctx->wait, io_cqring_events(ctx->rings));
 }
 
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
@@ -681,12 +689,6 @@ static void io_put_req(struct io_kiocb *req)
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
@@ -2591,7 +2593,8 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	ret = wait_event_interruptible(ctx->wait, io_cqring_events(rings) >= min_events);
+	ret = wait_threshold_interruptible(ctx->wait, min_events,
+					   io_cqring_events(rings));
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
-- 
2.22.0

