Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8454CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhKWQVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhKWQVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:21:24 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABE3C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:18:16 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id m5so13836833ilh.11
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vVFO+/R5NkLbL7rYZ4JlMVhNlcOZaatMH92z117Iuw=;
        b=S0iV+LeR0mLu8k8I2zrXEGnUWCxdyBRzz0dDzrlvGyGHSUuWV/6RGAiZrhT+xDLc92
         csYcGWbcYOdKfJ6b3gmKiUgxGUbmijA+xRscFHPGBPZe9D3ukhDkhEf+JbzbicA4OrXO
         1skB2WxoPVa/tJPAq49dz3XTBnd9WAIHEWZzLARMzleauZXEuCJkkGNbzMnqotQSsYAY
         DdypoJeN10NDmzS9rh7WhWlbkwpIeRuKB/96V8Snc+FGiu4OgR8VNoyRNc8wO6Z9PIOt
         r8LMccR50OM9EPtNrQL9WcYdajb409LjD5tWJodBc4YtfWghvWQwyP8J633PeQsmaDxE
         Vq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vVFO+/R5NkLbL7rYZ4JlMVhNlcOZaatMH92z117Iuw=;
        b=MEmGtQzQx3wCRcXhIw2vbQ7Ra1BZKDNKzzYNjPKkbsDoxp/eUofnqtE3GNnOp6HTfQ
         omLlxKcgfHBYasmkUXvvnwxm7AJT8oNu/WPk0CqlIexZ7YozMeLq8gTHFghBO5BZFjIz
         Gc7SnS5/kIbcwyeqD07SAVYvk+ugvhDkR7s6AlDxz7Zu2hVI6JHXMFeaBJLHWrOMDUDt
         N0rR8gY3hxiwOhT7B4VKkZCTshPveC0OOvt0257L/9V/4N8oPgd9Y6O6VVsd9nI1If5/
         7TlzyQvbT29EW4rYGULP5BcGftKLgu3TEXGJXhgGceKOeoEOqnvyMDWEZRRrmk5TsmEa
         CTMQ==
X-Gm-Message-State: AOAM5321uIFaBnqmqc17y1reE1hibEQYbcLF6TufZB2lT24EAsl9RtDI
        0XsMICdjUrIJ55mYPGp8D+yhI0fw0d9km3Rq
X-Google-Smtp-Source: ABdhPJxKK+zsrcw44Z7sLdyWRQW024Kp1xseFIllqLTjgJGkzaS4YbF41EvPuOsfhjnwE04VQzw6jg==
X-Received: by 2002:a92:c241:: with SMTP id k1mr6699994ilo.207.1637684295476;
        Tue, 23 Nov 2021 08:18:15 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t188sm7858034iof.5.2021.11.23.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:18:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block: move io_context creation into where it's needed
Date:   Tue, 23 Nov 2021 09:18:11 -0700
Message-Id: <20211123161813.326307-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123161813.326307-1-axboe@kernel.dk>
References: <20211123161813.326307-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only user of the io_context for IO is BFQ, yet we put the checking
and logic of it into the normal IO path.

Move the assignment and creation into BFQ.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c  | 6 ++++++
 block/blk-core.c     | 9 ---------
 block/blk-ioc.c      | 1 +
 block/blk-mq-sched.c | 1 +
 block/blk-mq.c       | 3 ---
 5 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fec18118dc30..a82475361a7e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6573,6 +6573,12 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
  */
 static void bfq_prepare_request(struct request *rq)
 {
+	/* create task io_context, if we don't have one already */
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, rq->q->node);
+
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
index ba21449439cc..550e27189be2 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -43,6 +43,7 @@ void blk_mq_sched_assign_ioc(struct request *rq)
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

