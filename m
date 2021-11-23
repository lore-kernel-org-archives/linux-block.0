Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A2C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhKWTSg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhKWTSg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:18:36 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC97C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:15:27 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e8so112628ilu.9
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWTXILHKioDlUR9/1yuOnR+USM47KfgVXLKUXMs+E3s=;
        b=wVb7+GhP2miEMTopuETbl/ulJI3XJcu4AeQvren2pycP93THXZZj6ETWe4QgdV17Ya
         /r2VdScP0aSZn9KlBK1LRn2bUMn8R0ro1rDdeb1ZbEpFuxwJQRxRzrcXwN5lIIbLT3Ab
         Ri93k39otACVlnj9Sj7tfLkBFGuVLd8GxdjZmfXfaWYkGDYkeYK/C320Iu/C0AZLuBwd
         MNVim6VfopkMCkGxx3JOqY1HPcNIhdZKaUcDFzu+/WOKTeFeyA3teqhiqMpy4I16pl8P
         GcwGtpScs2pitK647QaC7Q32QYClQSHcnxGW5Wa7KvhfJY3+azfMpsVPhWfewU18D7w6
         1YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWTXILHKioDlUR9/1yuOnR+USM47KfgVXLKUXMs+E3s=;
        b=aDO/gDuNZkuY5GNUuMNWiXYZrrR8ld+NmaRWTBhLU7hTsindag4PmKCq7UmcerhZxh
         4dK8ydJ6z3dEHC9Xw6qZBQVgFSv15HLLIYXYRgTBufwKtnMGjzdrD9JSxCd5iCCK2vR5
         HBtzxCYjcYY/mW6Sd/nLeylIvHJ4RZBNgY28FIctFKTSOKZB6V23WX3i0CuRlXjSL800
         rS9WwEBi6JBhupzWQtj3PKdOF/1PHSG9gEZCN0rV3my1ZyziM/pA4foStAfs88HcWcFt
         1M0m/yvoEn7GYVsoWq8d3rhrpwBQm0T4trk5wlrHKGrpsQXx7utH1MHSik1VE63l8P02
         P9DA==
X-Gm-Message-State: AOAM5312ICEWz3sOeZsptQrp0xwg1qnsp9RUA3wOjh1UOpHI846jL9xq
        mr7rpFvnUZa1yyIydtHCDnWOQuATlBZmi8Hk
X-Google-Smtp-Source: ABdhPJxULsRR6ZL3ZQdLqQUSlUM62jEomnWVyyXz4d9Tef899aa/iHfIYl14ZkSwmG8OqftarCZNBQ==
X-Received: by 2002:a05:6e02:4a9:: with SMTP id e9mr4755094ils.199.1637694926776;
        Tue, 23 Nov 2021 11:15:26 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v62sm8050399iof.31.2021.11.23.11.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:15:26 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: move io_context creation into where it's needed
Date:   Tue, 23 Nov 2021 12:15:19 -0700
Message-Id: <20211123191518.413917-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123191518.413917-1-axboe@kernel.dk>
References: <20211123191518.413917-1-axboe@kernel.dk>
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
 block/blk-mq-sched.c | 5 +++++
 block/blk-mq.c       | 3 ---
 4 files changed, 7 insertions(+), 12 deletions(-)

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
index 9d29245511ec..b9ca76fb1a03 100644
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

