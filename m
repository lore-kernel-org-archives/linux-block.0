Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF2C282E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D162320643
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="O1cIkxV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDSStU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:49:20 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:51612 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfDSStT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:49:19 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id D12E5C030C5;
        Fri, 19 Apr 2019 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1555667868;
        bh=wb/i8BcN5fqgSFtX3SfggrE1MGsKCMGq/XvRrOHXams=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O1cIkxV4R1bYjDmqx2QOq2FUcethemPxBsHsTN4nG323xtTUytLoGFkpFkWg+MJC3
         hQoNW/dTHuNtvbG2VPUagGtqVo6FEq9DSDUIDoBxlNDg+rr2uK6wT10KgRBiu15MYy
         MD1LChw5x1m7uaVj4c3RvnCaHSi++IfAfYITiaJo=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 3/3] io_uring: fix poll full SQ detection
Date:   Fri, 19 Apr 2019 11:57:46 +0200
Message-Id: <20190419095746.22894-3-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419095746.22894-1-source@stbuehler.de>
References: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
 <20190419095746.22894-1-source@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

io_uring_poll shouldn't signal EPOLLOUT | EPOLLWRNORM if the queue is
full; the old check would always signal EPOLLOUT | EPOLLWRNORM (unless
there were U32_MAX - 1 entries in the SQ queue).

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 912b0b304d90..047a0aa7a58c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2576,7 +2576,8 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &ctx->cq_wait, wait);
 	/* See comment at the top of this file */
 	smp_rmb();
-	if (READ_ONCE(ctx->sq_ring->r.tail) + 1 != ctx->cached_sq_head)
+	if (READ_ONCE(ctx->sq_ring->r.tail) - ctx->cached_sq_head !=
+	    ctx->sq_ring->ring_entries)
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	if (READ_ONCE(ctx->cq_ring->r.head) != ctx->cached_cq_tail)
 		mask |= EPOLLIN | EPOLLRDNORM;
-- 
2.20.1

