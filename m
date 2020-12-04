Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E501C19425
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 19:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA8922C9F
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgLDTOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbgLDTOr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 14:14:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02657C061A4F
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 11:14:07 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607109245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAlQ2JBtbq6g5nCibdn4i+qWOJybyEQ2RwkSZYQMVn8=;
        b=MfJlRSf7K6D1LAI0UrTRHI88q5wWkChUSCvijMdhyP2wUnGRWu5LDwKEj2pcg7DcwPniYX
        gh7bcMbHXKYKDXYE5CeqROmzICiMh5MtOGcOKeKY/CZAO7PiYIsiPKL514+3RKt2YA37Pt
        CqLnQ2d1h0/IzmlF68TjWZDrDmo8isik+swbSMgOEzEoKEVOc98cW0erNikTzSXBw54pX8
        mFDjwbeabx/RT3NKbEGWrh4IHub2e879xoVmpqZ9ORA7TGQO5LAOZrSvciVYZr8//yq8f+
        U8Sa3dQjfkqagPdfgZzTekdlDRWUbGLS3B6KFsitiH8+sRhykYQKPYsbXQU4dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607109245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAlQ2JBtbq6g5nCibdn4i+qWOJybyEQ2RwkSZYQMVn8=;
        b=d4fWv6+PYGuXMvLlhtRCKvjNKxwnCe4AZgTZZVSwECTm7dY6VbUKQB0i+YvbK2Ap0d4dOf
        w2JviSYhwSL5fqCw==
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] blk-mq: Always complete remote completions requests in softirq
Date:   Fri,  4 Dec 2020 20:13:55 +0100
Message-Id: <20201204191356.2516405-3-bigeasy@linutronix.de>
In-Reply-To: <20201204191356.2516405-1-bigeasy@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Controllers with multiple queues have their IRQ-handelers pinned to a
CPU. The core shouldn't need to complete the request on a remote CPU.

Remove this case and always raise the softirq to complete the request.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7091bb097c63f..3c0e94913d874 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -628,19 +628,7 @@ static void __blk_mq_complete_request_remote(void *dat=
a)
 {
 	struct request *rq =3D data;
=20
-	/*
-	 * For most of single queue controllers, there is only one irq vector
-	 * for handling I/O completion, and the only irq's affinity is set
-	 * to all possible CPUs.  On most of ARCHs, this affinity means the irq
-	 * is handled on one specific CPU.
-	 *
-	 * So complete I/O requests in softirq context in case of single queue
-	 * devices to avoid degrading I/O performance due to irqsoff latency.
-	 */
-	if (rq->q->nr_hw_queues =3D=3D 1)
-		blk_mq_trigger_softirq(rq);
-	else
-		rq->q->mq_ops->complete(rq);
+	blk_mq_trigger_softirq(rq);
 }
=20
 static inline bool blk_mq_complete_need_ipi(struct request *rq)
--=20
2.29.2

