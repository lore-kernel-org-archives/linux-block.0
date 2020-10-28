Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DF0C4363A
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 00:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA41207DE
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 00:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGFQCcb4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVtEV4q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbgJ1Waa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732937AbgJ1W30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A5FC0613CF;
        Wed, 28 Oct 2020 15:29:26 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603894383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oenc0cjwon5MKl60ej1HgOeBLKZJX10OgXE32L/q/r0=;
        b=eGFQCcb4z4k36cszZuqTNmUJikgNEzbyFVRCjge6IXwC3ZAH0e5nl4KmHm8/ftNUSub5Dw
        K7pqoLSKoeQ39+j9rTSzbH5bp9P17T+/nnsSy+6Gm4wiuYHdvzbc4FFdipEuCECsU0o7SJ
        O0X0I3dkY8Fm3YXyW5nlEPTyANDPrVcngBHWnOVbrXbuafY4xlzYcUbrwdZQ2Qi0MteyPp
        1Jf4yGov3w2zlUk3GoGMAhKxiPa6xc4vDRexD1xrJGFiqjIyevLbmvniPa86ifwo+A1ZkM
        ecUw+WDtU7fbi1T0P2t4eglia2AUnWmw0eygOWZTZpBIv22ndERDIa5OhCiqxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603894383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oenc0cjwon5MKl60ej1HgOeBLKZJX10OgXE32L/q/r0=;
        b=iVtEV4q992c+tNfqD1NVjkVxYTneooEp1OPB/tjKSRYmmg/wdwSQS5s3PxTmAsOms+52Mg
        +HVKmzHGKKtDm4CA==
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] blk-mq: Always complete remote completions requests in softirq
Date:   Wed, 28 Oct 2020 15:12:50 +0100
Message-Id: <20201028141251.3608598-2-bigeasy@linutronix.de>
In-Reply-To: <20201028141251.3608598-1-bigeasy@linutronix.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
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
index 421a40968c9ff..769d2d532a825 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -626,19 +626,7 @@ static void __blk_mq_complete_request_remote(void *dat=
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
2.28.0

