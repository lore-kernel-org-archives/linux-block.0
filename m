Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E490C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 17:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhKWROK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbhKWROJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 12:14:09 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658CC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:11:01 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 14so28709371ioe.2
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlIXO1+Df28dRCWMrnsPEvj1eS6L9MP2lhaGQ2y3v+g=;
        b=5BcNaLUG5id7+Cklik7xvrZYfFbEDQ1zS34ZdTtnD7EUeoh9U3Ths5/tQjK0vQglAe
         zZRWwVqtNajw4+jS3yxGiieK45IeKtF6jbsbNw6SYGNm3y1tTegyWmeytXGW292TnNeI
         SKqSytb9wyVcqsWDEH4NXUSa1oyuMcUU53ZwI4pwwPiDsdAc7J9nf1m2nGXZCo0F/3He
         YBY/9PwW21rJJkSaVPqkbIH2I9jvMkQ7YhghHAGkzhGomSR0sXqCfYncha5epQYTTsNn
         X26pp3WdZkpszfAhPPL2DJpsFRvxQJlaaFVx3e2n/PYZqILhjz2vIKGXwVKvKkrrcgrr
         RA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlIXO1+Df28dRCWMrnsPEvj1eS6L9MP2lhaGQ2y3v+g=;
        b=8Ikkb0GWqRYXE5vISSBArUbsZGeRl42ObLmFLbgUJgl4d8SGQB4t23lVmcCBJ+BE90
         4oNhQ712ohBsBZ2lA6Ai67hIANvUD3jJbxMSFilCtK8nW2tJznutwaHWV7PYAVohJWiG
         jdlew03LHGKGJ0xBqelpGNUiGWJmW8u8xyBhhSi8/5EWGDof+klNvg+XYY0x2TDwpUhd
         XqcJtHMUHzhw03UhxWVx4G4KacojPE5R8RSf923hBgnHicpIhff/2bapqwsUmYoQuqo7
         g8HWn/o6RCraG/J2dGtOaSLUv5BPpeQbh6PjgwW2O88SDugN/ohURjXhXkO+0Qe3VcaJ
         bw2w==
X-Gm-Message-State: AOAM531efCbckN6UrRoHkUEmsU0tGD5+xqmV3aWXozSgIyNrkgW0JJJI
        OoCn9tD9cGhvE6n8C+f4jUtknEeTbDxbDnma
X-Google-Smtp-Source: ABdhPJyqN0pyUqocEWYrJK+CohDl3f6E0vV+7B5+MaDcON1+VKmEcBVFJXNVMr7bBqdzSBYXr1BxYQ==
X-Received: by 2002:a05:6638:1395:: with SMTP id w21mr8086533jad.125.1637687460892;
        Tue, 23 Nov 2021 09:11:00 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm8251283iow.9.2021.11.23.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:11:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block: move io_context creation into where it's needed
Date:   Tue, 23 Nov 2021 10:10:56 -0700
Message-Id: <20211123171058.346084-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123171058.346084-1-axboe@kernel.dk>
References: <20211123171058.346084-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only user of the io_context for IO is BFQ, yet we put the checking
and logic of it into the normal IO path.

Put the creation into blk_mq_sched_assign_ioc(), and have BFQ use that
helper.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c  | 2 ++
 block/blk-core.c     | 9 ---------
 block/blk-ioc.c      | 1 +
 block/blk-mq-sched.c | 5 +++++
 block/blk-mq.c       | 3 ---
 5 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fec18118dc30..1ce1a99a7160 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6573,6 +6573,8 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
  */
 static void bfq_prepare_request(struct request *rq)
 {
+	blk_mq_sched_assign_ioc(rq);
+
 	/*
 	 * Regardless of whether we have an icq attached, we have to
 	 * clear the scheduler pointers, as they might point to
diff --git a/block/blk-core.c b/block/blk-core.c
index 6443f2dfe43e..6ae8297b033f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -750,15 +750,6 @@ noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		break;
 	}
 
-	/*
-	 * Various block parts want %current->io_context, so allocate it up
-	 * front rather than dealing with lots of pain to allocate it only
-	 * where needed. This may fail and the block layer knows how to live
-	 * with it.
-	 */
-	if (unlikely(!current->io_context))
-		create_task_io_context(current, GFP_ATOMIC, q->node);
-
 	if (blk_throtl_bio(bio))
 		return false;
 
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 57299f860d41..736e0280d76f 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -286,6 +286,7 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(create_task_io_context);
 
 /**
  * get_task_io_context - get io_context of a task
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ba21449439cc..b942b38000e5 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -24,6 +24,10 @@ void blk_mq_sched_assign_ioc(struct request *rq)
 	struct io_context *ioc;
 	struct io_cq *icq;
 
+	/* create task io_context, if we don't have one already */
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, q->node);
+
 	/*
 	 * May not have an IO context if it's a passthrough request
 	 */
@@ -43,6 +47,7 @@ void blk_mq_sched_assign_ioc(struct request *rq)
 	get_io_context(icq->ioc);
 	rq->elv.icq = icq;
 }
+EXPORT_SYMBOL_GPL(blk_mq_sched_assign_ioc);
 
 /*
  * Mark a hardware queue as needing a restart. For shared queues, maintain
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c00b22590cc..20a6445f6a01 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -406,9 +406,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 		if (!op_is_flush(data->cmd_flags) &&
 		    e->type->ops.prepare_request) {
-			if (e->type->icq_cache)
-				blk_mq_sched_assign_ioc(rq);
-
 			e->type->ops.prepare_request(rq);
 			rq->rq_flags |= RQF_ELVPRIV;
 		}
-- 
2.34.0

