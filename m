Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41113C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 21:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383257AbhLCVtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhLCVtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 16:49:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A516C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 13:45:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id iq11so3304552pjb.3
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKuHL/KZVSVISLRG3bffZqV5xT2zA+0nRRE7V8Ac64s=;
        b=f2pSf5NdbjG+w/joZ1zBUGX9AvZuLkRcIX6k9Z1K5WUfF55j+mNKn8BO3w26nyqVAh
         OiT/XrQOw4blpksIu5ZdNwXqsGJyen3+UV8FpWsGMQF2/Ub0Y4oibFeedh9lpSyaq9b2
         CdPwBRqR7jyyfhQ6t6vYMm2xcKEt/WoVocCNv0c58jNU2kAiRPirlIYj9bLkWsnN4JUc
         yeVtBrCltmVRWQTntZSojr7QsgwPr2OwdFh7aq3v9lR5O4uEQfYU8ze6IEVz8KonMgz7
         RQcVILOU4QnYQAacLRbmNcdyaBDXmi3a/v6ctis/TSKi9N+UtZJ82xAfuPIzhLCLaakX
         2w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKuHL/KZVSVISLRG3bffZqV5xT2zA+0nRRE7V8Ac64s=;
        b=YWQ9WLxxnF84oz4yWj94oSnfZq8sDEnWc3qB7KbM4MNiCp5ZDma8Sgn73X+ZnWZOi+
         vshz2UYND2Gjlfk4LhyeR/ODxnbylhBaD0U9Ywp+u9OuZ71b5TcbE4oOn58AEDVeXDND
         WcouiW3zc0RQHLxvZGPzZLkT15kCsM6T2TUagPNDOcu3zIw3ucIkuYdYPIX6i+wRUIzd
         iP6aPqn6ETH8e6OlHi/n3bGVT4jrCUl8yRsg7++6aJLfD8t3+R0nXfY+UdtTnpPEv/Vi
         sMQs/zn3lTKUIiHrWC1Zx9PcyulfocHpJ9/JTdZVftu+GW6cbhP6KScVYvIhl3pKNUsH
         +lDA==
X-Gm-Message-State: AOAM530uN8ZFFE1AQGyoejOfGe2E0dVIW9cve8dIftDuJAagJtMh4qvb
        gZxtPwrjTomgvfJSzsMPHC+gOWh1BKVRV2so
X-Google-Smtp-Source: ABdhPJxFFSbx8kIz6tEOf+g5FlRKymbAnBz6UtS9KiqXcbYifv9l8XECHjDyvGiAuD0R9PiLyfRRaA==
X-Received: by 2002:a17:90b:4d90:: with SMTP id oj16mr17092107pjb.2.1638567954222;
        Fri, 03 Dec 2021 13:45:54 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:45:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Date:   Fri,  3 Dec 2021 14:45:41 -0700
Message-Id: <20211203214544.343460-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203214544.343460-1-axboe@kernel.dk>
References: <20211203214544.343460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have a list of requests in our plug list, send it to the driver in
one go, if possible. The driver must set mq_ops->queue_rqs() to support
this, if not the usual one-by-one path is used.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 24 +++++++++++++++++++++---
 include/linux/blk-mq.h |  8 ++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22ec21aa0c22..9ac9174a2ba4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2513,6 +2513,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
+	struct request *rq;
 	unsigned int depth;
 	LIST_HEAD(list);
 
@@ -2521,7 +2522,26 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		blk_mq_run_dispatch_ops(plug->mq_list->q,
+		struct request_queue *q;
+
+		rq = plug->mq_list;
+		q = rq->q;
+
+		/*
+		 * Peek first request and see if we have a ->queue_rqs() hook.
+		 * If we do, we can dispatch the whole plug list in one go. We
+		 * already know at this point that all requests belong to the
+		 * same queue, caller must ensure that's the case.
+		 */
+		if (q->mq_ops->queue_rqs &&
+		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+			blk_mq_run_dispatch_ops(q,
+				q->mq_ops->queue_rqs(&plug->mq_list));
+			if (rq_list_empty(plug->mq_list))
+				return;
+		}
+
+		blk_mq_run_dispatch_ops(q,
 				blk_mq_plug_issue_direct(plug, false));
 		if (rq_list_empty(plug->mq_list))
 			return;
@@ -2531,8 +2551,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	this_ctx = NULL;
 	depth = 0;
 	do {
-		struct request *rq;
-
 		rq = rq_list_pop(&plug->mq_list);
 
 		if (!this_hctx) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ecdc049b52fa..cdd183757ea0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -494,6 +494,14 @@ struct blk_mq_ops {
 	 */
 	void (*commit_rqs)(struct blk_mq_hw_ctx *);
 
+	/**
+	 * @queue_rqs: Queue a list of new requests. Driver is guaranteed
+	 * that each request belongs to the same queue. If the driver doesn't
+	 * empty the @rqlist completely, then the rest will be queued
+	 * individually by the block layer upon return.
+	 */
+	void (*queue_rqs)(struct request **rqlist);
+
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
-- 
2.34.1

