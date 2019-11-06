Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B6FC6198
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 23:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD3221848
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 23:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hNsDsJau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfKFXxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:53:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35551 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFXxP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 18:53:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id d13so523235pfq.2
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 15:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27d3BIBHTrYG/eiGMCku3em4xLvjsIdMZN0YRUlpv2s=;
        b=hNsDsJauwUIyzr3U+rkIGOaW0eLHd7oChYoEY61xcdh2HMMPVclngHcLJNNdXzx37V
         1kknGTaV81qlA4dNsouiN9LRCMYtAiLxcbf/T2Yyy5In9KaSVSuB1JYD3vpssAUaV2T2
         s5V5ppcB2qz1WrEP6GPEI3b6qKuAs/TRnBLsJ7hrkG7rM/NIgo9raOSl6iVVVyG0mruB
         l81XzOjK4pTAvQsYZNcLf07lBuYa1tfw3y3Rw4u+GNMfCH7vCITyiIHOpATnMooy8FSb
         2XtazVDeVxs+2Hw17B9okguC8MQd/bQbe00eCZ0T7vaUj12wcbItf90lJdxE5s35f9Gz
         BH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=27d3BIBHTrYG/eiGMCku3em4xLvjsIdMZN0YRUlpv2s=;
        b=Y6o6yiJuArh9bPXW7lx3Qvyos2yJ/4eYp0uLiqYTgdWr1bMkc4n86FZ0nNycvUperW
         KULHdaVFfdkNrXfyHC6GvA3jnMzvdlhW1+nVVKZdpfJPSity7Kbydq2DzliPEAhiKjOd
         iNlLx2KCfUtrZarvGhfvcyGnBRL/n0L8TCl4vTWB8Ep2s3OjVqaW5/UlEzft9oGuNJOv
         ZKs2HdMO82S2M3qF4pROUjHT0xqoY4y+vdwa4r3ibVPGtSg1Bxz5z2nSCRS0zT+YxSih
         8cy1Ms1LbawHrVUw8qw5i0743AAyJix4WpBsByB4Qdl2aCeGEcArfujJlLdtjtqHOVbi
         QQIg==
X-Gm-Message-State: APjAAAXaxoDjjh+DjbuBjTH/fWt0xOjDukBGG+n9VdyZ6mXtKpgtty09
        HAxTcinsdOdNShdMC7In6YLmHg==
X-Google-Smtp-Source: APXvYqwOMx+n3H/xmfSuinkisAePATiMe41JeeRKaT5agxp/oaQMV38jZ/SY1hpCmj6d3HV4vGbegw==
X-Received: by 2002:a63:6e82:: with SMTP id j124mr654363pgc.115.1573084394429;
        Wed, 06 Nov 2019 15:53:14 -0800 (PST)
Received: from x1.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x125sm109137pfb.93.2019.11.06.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:53:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] io_uring: make io_cqring_events() take 'ctx' as argument
Date:   Wed,  6 Nov 2019 16:53:05 -0700
Message-Id: <20191106235307.32196-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106235307.32196-1-axboe@kernel.dk>
References: <20191106235307.32196-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The rings can be derived from the ctx, and we need the ctx there for
a future change.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b0dd8d322360..36ca7bc38ebf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -859,8 +859,10 @@ static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	}
 }
 
-static unsigned io_cqring_events(struct io_rings *rings)
+static unsigned io_cqring_events(struct io_ring_ctx *ctx)
 {
+	struct io_rings *rings = ctx->rings;
+
 	/* See comment at the top of this file */
 	smp_rmb();
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
@@ -1016,7 +1018,7 @@ static int __io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 		 * If we do, we can potentially be spinning for commands that
 		 * already triggered a CQE (eg in error).
 		 */
-		if (io_cqring_events(ctx->rings))
+		if (io_cqring_events(ctx))
 			break;
 
 		/*
@@ -3064,7 +3066,7 @@ static inline bool io_should_wake(struct io_wait_queue *iowq)
 	 * started waiting. For timeouts, we always want to return to userspace,
 	 * regardless of event count.
 	 */
-	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
+	return io_cqring_events(ctx) >= iowq->to_wait ||
 			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
 }
 
@@ -3099,7 +3101,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	struct io_rings *rings = ctx->rings;
 	int ret = 0;
 
-	if (io_cqring_events(rings) >= min_events)
+	if (io_cqring_events(ctx) >= min_events)
 		return 0;
 
 	if (sig) {
-- 
2.24.0

