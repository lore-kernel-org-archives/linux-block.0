Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF10CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 09:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiBOJMO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:12:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiBOJMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 04:12:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187C1EC49
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 01:12:03 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:11:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644916320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TWQ23lvqeBkKd5wSu3giNfT/P3ry1m1T6RMLic/EYlM=;
        b=A+FHEEiugr7DEM4aI2DUt6Pp7Pboc+o84zd0muxGaRYApyg9zuU+9x2YqpBSlpIA95xTNa
        QdntdccJaxMLIDZWOEjoWqUAs1SS2De870GFmba0VWcvvbZtQH+8fhMsTaLCnEVYbrA+N8
        ChjNfs7EIW4mVC9Gj7KEWOISxvGxlivf98K76gIb56B4g1uvECso3R8WyNOtk9/wzI6vv0
        tk1G84lcvafxC9Mbl1fQrc/1Ps4QeFaC3J0h5Hgq1jyBE3n+VXeRx7fqwra4XwOFZ+ox7C
        r3YYjshzeImH+x2zIGJB+6GBWfrNUvjZ3C/0tMyyTXXERzMGc3kdbldNHko57Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644916320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TWQ23lvqeBkKd5wSu3giNfT/P3ry1m1T6RMLic/EYlM=;
        b=VljMnoQXYAhU2nBUKLLVWNpqVkmCYyg/gPVLF7jc81mZj/caZD5TaGE5dCtStbMizR6KzY
        0qGwNkHiC9TQ/lAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: Remove get_cpu() in __blk_mq_delay_run_hw_queue().
Message-ID: <YgtuX9dDpXe8Xbs+@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The callchain:
  __blk_mq_delay_run_hw_queue(x, false, x)
    cpu = get_cpu();
    cpumask_test_cpu(cpu, hctx->cpumask);
      __blk_mq_run_hw_queue(hctx);
        blk_mq_run_dispatch_ops();
	  __blk_mq_run_dispatch_ops(x, true, x);
	    might_sleep_if(true);

will trigger the might_sleep warning since get_cpu() disables
preemption. Based on my understanding, __blk_mq_run_hw_queue() should
run on the requested CPU for the benefit of cache locality. The system
won't crash if it runs on another CPU but the performance will be
probably less than optimal.

If the current CPU matches the requested cpumask then it may remain and
fulfill the requirement. If the scheduler moves the task to another CPU
then it will run on the wrong CPU but no harm is done in terms of
correctness.

Remove get_cpu() from __blk_mq_delay_run_hw_queue().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I have nothing to trigger that path, this is based on review. I see the
callchain but with blk_queue_has_srcu == 0.
The calls I see are from per-CPU threads and from unbound CPU threads.

If the correct CPU is important then migrate_disable() could be used
(slightly higher overhead than preempt_disable() but preemptible) or
unconditionally pass to kblockd_mod_delayed_work_on() (higher overhead
than migrate_disable() but will be done anyway if the current CPU is
wrong).

 block/blk-mq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1adfe4824ef5e..90217f1b09add 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2040,14 +2040,10 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		int cpu = get_cpu();
-		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
-			put_cpu();
 			return;
 		}
-
-		put_cpu();
 	}
 
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
-- 
2.34.1

