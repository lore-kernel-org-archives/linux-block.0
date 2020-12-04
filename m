Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D17C4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 19:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62D222C9F
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 19:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgLDTOr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:14:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgLDTOr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 14:14:47 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607109244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcuZUB5nFMpQRoWQVOhcAERBptrSeWMm+81ZrjusF/E=;
        b=Ix8PWWjzu/kGiLUn7Z9GiXFsohekv5JA3QpvEW4QGaL4UjPKoroTztHHgYAfyAo6+a7lxc
        5aiRhSAcvCrN1ezE/JBvXAY15rILQlQp5QDg83PeZJhSRkxrSmdA5NPsmZs9rO90qoqpGa
        GPOAn8rf6SJkxYMxKECUVgGvqKGdgJBmJxAQHTZMI0n3d4x51Om07KmD43MrWaQwx3HoQ7
        zAH914iD/kh+yL8ptsD6qv7Ulso77bnfpB5ZCdwp+yMF+lmPrGEcOOCqqxvXM6Wqp6yQhU
        FvfB2Ytl2cfcQO2RmL2rHkELeVn77lMQj5xRiv7E1Kegi3/yrLvyQ9EAX/bfzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607109244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcuZUB5nFMpQRoWQVOhcAERBptrSeWMm+81ZrjusF/E=;
        b=zQl3ZB/WCJPKhJ8qQqUf9rDGHaV5GzEHVsZ9d63umJ4hTcKzoJRieBQjo+qq/tt85V5/eX
        WdaSm8URbHmPvcCg==
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] blk-mq: Don't complete on a remote CPU in force threaded mode
Date:   Fri,  4 Dec 2020 20:13:54 +0100
Message-Id: <20201204191356.2516405-2-bigeasy@linutronix.de>
In-Reply-To: <20201204191356.2516405-1-bigeasy@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With force threaded interrupts enabled, raising softirq from an SMP
function call will always result in waking the ksoftirqd thread. This is
not optimal given that the thread runs at SCHED_OTHER priority.

Completing the request in hard IRQ-context on PREEMPT_RT (which enforces
the force threaded mode) is bad because the completion handler may
acquire sleeping locks which violate the locking context.

Disable request completing on a remote CPU in force threaded mode.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b9c2efab5db78..7091bb097c63f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -650,6 +650,14 @@ static inline bool blk_mq_complete_need_ipi(struct req=
uest *rq)
 	if (!IS_ENABLED(CONFIG_SMP) ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
 		return false;
+	/*
+	 * With force threaded interrupts enabled, raising softirq from an SMP
+	 * function call will always result in waking the ksoftirqd thread.
+	 * This is probably worse than completing the request on a different
+	 * cache domain.
+	 */
+	if (force_irqthreads)
+		return false;
=20
 	/* same CPU or cache domain?  Complete locally */
 	if (cpu =3D=3D rq->mq_ctx->cpu ||
--=20
2.29.2

