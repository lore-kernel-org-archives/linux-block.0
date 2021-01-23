Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15CDC433E0
	for <linux-block@archiver.kernel.org>; Sat, 23 Jan 2021 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E9E22CF6
	for <linux-block@archiver.kernel.org>; Sat, 23 Jan 2021 20:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbhAWULU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:11:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbhAWULS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jan 2021 15:11:18 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611432636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXtKHqimthZytcdJDbVm1RJiJEFrCp7q87+tAWESN50=;
        b=Xpr0UAX3SBHng2S2PsZcHE9cil5C2zfy62SMwHQ9oana5hWH2FqnXJFUjplVYbrPnc5c9V
        alABo9w6jnrrt+P3AWNKa5EUbb8GgzHTGZMd0gpalXhQhQlRWoB/E/pgTs4ok7T0aimbrV
        AUwJrDBw0V11RrTn4DXgGAolTAB4TKLYsDwawcrTKAjWHfzpqYA8FY7ULRH96pXTym5Gh4
        CE2Fp6s0EK8dYMkCl7gzYwHpNaJDTBDms3rmhJJFpGfVjKzvbsjigGFlQeaX/7hFD3ys8Q
        Ocj00S7+6RK3ierIm8ChUAtTRB3QrvaekQU6Izlz3l0ztPLRZST68YwVsTbVOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611432636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXtKHqimthZytcdJDbVm1RJiJEFrCp7q87+tAWESN50=;
        b=ouIsL2O14nSxYq0yflXVMdGLkZdVAg5NqvPVmOBSlT66bALlbVhPk8ezeM98DO7ePm+t3q
        oBljjHyZQ/S5G0DQ==
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] blk-mq: Always complete remote completions requests in softirq
Date:   Sat, 23 Jan 2021 21:10:26 +0100
Message-Id: <20210123201027.3262800-3-bigeasy@linutronix.de>
In-Reply-To: <20210123201027.3262800-1-bigeasy@linutronix.de>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
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
index f285a9123a8b0..90348ae518461 100644
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
2.30.0

