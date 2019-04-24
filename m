Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D474EC282E3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A607720685
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="bYVZHD+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfDXVy0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:54:26 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:41022 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731786AbfDXVyZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 17:54:25 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id CE742C030C5;
        Wed, 24 Apr 2019 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556142864;
        bh=66skNcbVaC2Y2x/luaOKJisPsjdX43vHw1Fl19FcSLs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bYVZHD+Nw1AlYM056L8d2JmLZLQSQMMqAKxmEO5jAhmWGVAkvUxYUl2nofwhs+luC
         kTj+aMeoeZjswI8p6NFLHPG1+w1D655yVTVfMdllAhNUHQO02VD9YKI/9oW5e1XBYA
         cd1BbGJW4zBHreM+wqon4UftPCrZ+yw48BnL+9ak=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH barrier cleanup v1 5/7] io_uring: remove unnecessary barrier before reading SQ tail
Date:   Wed, 24 Apr 2019 23:54:20 +0200
Message-Id: <20190424215422.7404-5-source@stbuehler.de>
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

There is no operation before to order with.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 31357cc0e8e6..f93a9fca8311 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1828,8 +1828,6 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	 *    though the application is the one updating it.
 	 */
 	head = ctx->cached_sq_head;
-	/* See comment at the top of this file */
-	smp_rmb();
 	/* make sure SQ entry isn't read before tail */
 	if (head == smp_load_acquire(&ring->r.tail))
 		return false;
-- 
2.20.1

