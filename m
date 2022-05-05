Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F85EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  5 May 2022 17:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351971AbiEERZc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 May 2022 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbiEERZb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 May 2022 13:25:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A15C351
        for <linux-block@vger.kernel.org>; Thu,  5 May 2022 10:21:51 -0700 (PDT)
Date:   Thu, 5 May 2022 19:21:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651771309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=R7qpjgbn1b6RR9QRF66vEq+Hu1c1iiO3RvPzNgXS5lk=;
        b=bJ8xDazD5/S98EN/yZJS8MjD+Eb9NhUnwmLj+8i/3L4+K5qSNUpI808O7OFV9iRkyMKrbi
        rkmedMyGHNcKyR2hRO/Joys8ioN3rrYFT8FGHenrg5pL7RUUhf3uIzMNI8dopSsy8KADPC
        hsXr/H/KjurHDQ0BSJz9zamMx1NhgGW/xbxHbBHUPI468mrRv0N6/afN/tjplV4ibmCRd5
        SPdjXOodSG/y9t2nAHyqPr0IxNmUALlNEijusZhlkkhOlHChBorn/lUq+ue161LkV8x8B6
        eaqgBDL8U13vACg+f0oeyGHDbLfR/HzuqHpiMsPUMl+dyalvG7zTLxmaOlxYDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651771309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=R7qpjgbn1b6RR9QRF66vEq+Hu1c1iiO3RvPzNgXS5lk=;
        b=pYw+eE8JEITca8IwfL/ylnjw8OBJN7fl62uTvFvASXwxe6bm3jAH3psFGpqgsKR3a3C3Og
        cDm+grPB1lIcxyAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] blk-mq: Don't disable preemption around
 __blk_mq_run_hw_queue().
Message-ID: <YnQHqx/5+54jd+U+@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blk_mq_delay_run_hw_queue() disables preemption to get a stable
current CPU number and then invokes __blk_mq_run_hw_queue() if the CPU
number is part the mask.

__blk_mq_run_hw_queue() acquires a spin_lock_t which is a sleeping lock
on PREEMPT_RT and can't be acquired with disabled preemption.

If it is important that the current CPU matches the requested CPU mask
and that the context does not migrate to another CPU while
__blk_mq_run_hw_queue() is invoked then it possible to achieve this by
disabling migration and keeping the context preemptible.

Disable only migration while testing the CPU mask and invoking
__blk_mq_run_hw_queue().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 84d749511f551..a28406ea043a8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2046,14 +2046,14 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		int cpu = get_cpu();
-		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+		migrate_disable();
+		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
-			put_cpu();
+			migrate_enable();
 			return;
 		}
 
-		put_cpu();
+		migrate_enable();
 	}
 
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
-- 
2.36.0

