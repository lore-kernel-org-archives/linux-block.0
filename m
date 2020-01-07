Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DEDC33C9B
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C74D208C4
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Vzb4SfLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgAGQap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:30:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41818 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGQao (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 11:30:44 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so49674286ioo.8
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 08:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02WrhvT9MKXQhtl97p5XQGxAO2MSQtzBgMftZca/EuU=;
        b=Vzb4SfLmtU9ydglHlUg6Zvup5x8KKL6YDpM8lDj5NZ/2ukxjRjthzofc0egDfd0C8l
         NQpSTYEEGeLso2YNd9rA6Kw/5QL6e0O1Du8q/LprxXPEAyEzV6HLieYhLb35SLbnKRB1
         hGVQjk4jiAbY4dKAItrvTqrPf4CdfduZofT6nNMQhQMqsO0kx6lEr+12xiYnTM1VQ/ju
         vdGRfEF4p6kg7e+gVXHIsTI7COmTIeXzfoJnv6Uz1mRy/t5/G+kIHaJXISHO5FOw0DpA
         U1rtpA4KsmK2+a6hHc8y9eISzxyHshjGajoNHZ6+BI4qkF/5gTS/5XGDfOUTl/eNwqV+
         hEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02WrhvT9MKXQhtl97p5XQGxAO2MSQtzBgMftZca/EuU=;
        b=dE8AHZu76Mek6haopXwe8q+7/c1l91wra6VpFDKwpIBpEal5ceas0SZIHQ4+/zV5H0
         w64TwC1bra2mFHZlZFuaOU+MhBT2/jkjpnvdQbJ/YMv76yvgTCTI9KxMhnpMB+5T55Xy
         ifDD1aMiSVc/V3mq+elw4ZByxtgqjNRLctm7FEzKRn2I2pm9yLNUZVpBlEU+sildK+Jn
         gIpHYHIqFLWe2zVeDmW3MRkT9Q1aCoeUf5AmqA9iz2fp29lRBsuErsf2rr6TPK8N7QtA
         JC3HT2LbbYJ/n2crhUeLaplHg5z90LSFWMazMvA3kuuPUtQba04m7PSp2+ER8LMyfZWu
         BFnA==
X-Gm-Message-State: APjAAAWsylw2JGfXtV+iZRkzW0G6JvuYj19CU5wTpzcrc/sVDC2kZsJ8
        GkWtylBPLG5b2zOj4gCafaDHY9vFePI=
X-Google-Smtp-Source: APXvYqxs1shqYGXMydjb8G1l7MR1UrtYHQbMSGbx8oI9O7vGaXuxgG0y+RZCrtZV51iu2zhNkCxUcQ==
X-Received: by 2002:a5d:9d03:: with SMTP id j3mr74245831ioj.266.1578414643410;
        Tue, 07 Jan 2020 08:30:43 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm20639ilh.55.2020.01.07.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:30:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] blk-mq: remove ctx->queue
Date:   Tue,  7 Jan 2020 09:30:35 -0700
Message-Id: <20200107163037.31745-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107163037.31745-1-axboe@kernel.dk>
References: <20200107163037.31745-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We only use this for a lookup in the sysfs code, replace with getting
the queue off the default set of hardware queues.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sysfs.c | 4 ++--
 block/blk-mq.c       | 2 --
 block/blk-mq.h       | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 062229395a50..1f3cb13f932e 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -69,7 +69,7 @@ static ssize_t blk_mq_sysfs_show(struct kobject *kobj, struct attribute *attr,
 
 	entry = container_of(attr, struct blk_mq_ctx_sysfs_entry, attr);
 	ctx = container_of(kobj, struct blk_mq_ctx, kobj);
-	q = ctx->queue;
+	q = ctx->hctxs[0]->queue;
 
 	if (!entry->show)
 		return -EIO;
@@ -90,7 +90,7 @@ static ssize_t blk_mq_sysfs_store(struct kobject *kobj, struct attribute *attr,
 
 	entry = container_of(attr, struct blk_mq_ctx_sysfs_entry, attr);
 	ctx = container_of(kobj, struct blk_mq_ctx, kobj);
-	q = ctx->queue;
+	q = ctx->hctxs[0]->queue;
 
 	if (!entry->store)
 		return -EIO;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6a68e8a246dc..a36764c38bfb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2439,8 +2439,6 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		for (k = HCTX_TYPE_DEFAULT; k < HCTX_MAX_TYPES; k++)
 			INIT_LIST_HEAD(&__ctx->rq_lists[k]);
 
-		__ctx->queue = q;
-
 		/*
 		 * Set local node, IFF we have more than one hw queue. If
 		 * not, we remain on the home node of the device
diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaaca8fc1c28..d15ef0bafe29 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -32,7 +32,6 @@ struct blk_mq_ctx {
 	/* incremented at completion time */
 	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
 
-	struct request_queue	*queue;
 	struct blk_mq_ctxs      *ctxs;
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
-- 
2.24.1

