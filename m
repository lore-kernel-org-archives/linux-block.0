Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE04C282DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9392064A
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="UkxfDmma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfDSStU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:49:20 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:51614 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbfDSStT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:49:19 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 475A8C02FFB;
        Fri, 19 Apr 2019 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1555667867;
        bh=E+pBak04zce3NEXwB6UZ70CJv2w7yxoGBE8YB3hIvbc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UkxfDmmaBlMsD+SvMH6htxk7T+F5toeN5ZN0zoSXu/FBpS60woRYbiFmw6eWlJ/Ar
         U/bZhzmg/6B3mPkEfERFnar9ySsFeLHT0L6fpHFtajil5Vzg49H98Qa3lSGvmQUM+l
         tEybbw5yzCjxMpjeQvFwmcU/Sf2TCY4IFDJ4tkQQ=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/3] io_uring: fix race condition reading SQ entries
Date:   Fri, 19 Apr 2019 11:57:44 +0200
Message-Id: <20190419095746.22894-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
References: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A read memory barrier is required between reading SQ tail and reading
the actual data belonging to the SQ entry.

Userspace needs a matching write barrier between writing SQ entries and
updating SQ tail (using smp_store_release to update tail will do).

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f65f85d89217..96863e4780b7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1739,7 +1739,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	head = ctx->cached_sq_head;
 	/* See comment at the top of this file */
 	smp_rmb();
-	if (head == READ_ONCE(ring->r.tail))
+	/* make sure SQ entry isn't read before tail */
+	if (head == smp_load_acquire(&ring->r.tail))
 		return false;
 
 	head = READ_ONCE(ring->array[head & ctx->sq_mask]);
-- 
2.20.1

