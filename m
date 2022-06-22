Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164FDC43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 08:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347666AbiFVI0D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 04:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiFVI0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 04:26:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB983879B
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 01:26:00 -0700 (PDT)
Date:   Wed, 22 Jun 2022 10:25:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655886356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTgSn5jqE2RC5acTgnD8bWoPtj4J51j6OItz1sAx6Ys=;
        b=IvQgfij2A/nnJCcjzHCRRrykFVbH/keMsXTs7JT7QrVYqBValtO4JEIQNDL4rC9YG8mMKu
        ir39a+6yltqlpJr1mtmeyKXk8uzeZV9OcIwysJIaKyUyBCrjStJ0JUPYpOos+5St+2GFtR
        n0KCu/udqUXd66QZ18+kbZEiz68eyVWXSDIyx/YyqZQoiIJSGdV8Yv8uyMz1EyVKKoBhL1
        gnhzcGM93ZcnmFZY1L8VIdM7oTkeIqceRiQQwXx3cZtuZhsG/75sGi4eVqSOVDxVbAQczE
        PzIng34lvOxzuIkaM6LeoL7lHz6Eg/plhF2y/S8rho0VJ0FbI6hTykTvIgWHNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655886356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTgSn5jqE2RC5acTgnD8bWoPtj4J51j6OItz1sAx6Ys=;
        b=FzjepoF5GmPXF5iHGdjxR1nSNIx7lg5Gh8Uhj2MaBty5RTE78OwI8I1Rj2x34cY7kXTPw4
        EW6NM7cK2DkSlyCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] blk-mq: Don't disable preemption around
 __blk_mq_run_hw_queue().
Message-ID: <YrLSEiNvagKJaDs5@linutronix.de>
References: <YrF1p2n0MxHQ3fcJ@linutronix.de>
 <YrF5uf4ZL7Oh7LVJ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YrF5uf4ZL7Oh7LVJ@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blk_mq_delay_run_hw_queue() disables preemption to get a stable
current CPU number and then invokes __blk_mq_run_hw_queue() if the CPU
number is part the mask.

__blk_mq_run_hw_queue() acquires a spin_lock_t which is a sleeping lock
on PREEMPT_RT and can't be acquired with disabled preemption.

It is not required for correctness to invoke __blk_mq_run_hw_queue() on
a CPU matching hctx->cpumask. Both (async and direct requests) can run
on a CPU not matching hctx->cpumask.

The CPU mask without disabling preemption and invoking
__blk_mq_run_hw_queue().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Drop migrate_disable() as per Ming Lei.

 block/blk-mq.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2085,14 +2085,10 @@ static void __blk_mq_delay_run_hw_queue(
 		return;
=20
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		int cpu =3D get_cpu();
-		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
-			put_cpu();
 			return;
 		}
-
-		put_cpu();
 	}
=20
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
