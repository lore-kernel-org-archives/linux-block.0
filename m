Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942FBC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFB320685
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="xPwO9BM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfDXVyZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:54:25 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:41006 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfDXVyZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 17:54:25 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id F28ACC0305A;
        Wed, 24 Apr 2019 21:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556142863;
        bh=0RSvUxsIo8Ibx3xQwGcriYo415sDbopj8zmEKzbZIuI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=xPwO9BM7hjfYr14fD+FwgCVfHuoR9lt1JaprgMYcW/YIZsjJysOBh/L/D/2LpfN0q
         OuV21fIXd2eiO0ewdL41d27HmLswhB+Sf1zQFSeXpCRz2zHNELhsg9+TZc10X7T1Yt
         3NMyvqtqrYRUpRa5P/Pigs059hIkrdGBOfyofU7Y=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH barrier cleanup v1 2/7] io_uring: remove unnecessary barrier before wq_has_sleeper
Date:   Wed, 24 Apr 2019 23:54:17 +0200
Message-Id: <20190424215422.7404-2-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424215422.7404-1-source@stbuehler.de>
References: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
 <20190424215422.7404-1-source@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

wq_has_sleeper has a full barrier internally. The smp_rmb barrier in
io_uring_poll synchronizes with it.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7025e9830abe..1f4419f38ef1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -418,12 +418,6 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 		/* order cqe stores with ring update */
 		smp_store_release(&ring->r.tail, ctx->cached_cq_tail);
 
-		/*
-		 * Write sider barrier of tail update, app has read side. See
-		 * comment at the top of this file.
-		 */
-		smp_wmb();
-
 		if (wq_has_sleeper(&ctx->cq_wait)) {
 			wake_up_interruptible(&ctx->cq_wait);
 			kill_fasync(&ctx->cq_fasync, SIGIO, POLL_IN);
@@ -2674,7 +2668,9 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	__poll_t mask = 0;
 
 	poll_wait(file, &ctx->cq_wait, wait);
-	/* See comment at the top of this file */
+	/* synchronizes with barrier from wq_has_sleeper call in
+	 * io_commit_cqring
+	 */
 	smp_rmb();
 	if (READ_ONCE(ctx->sq_ring->r.tail) - ctx->cached_sq_head !=
 	    ctx->sq_ring->ring_entries)
-- 
2.20.1

