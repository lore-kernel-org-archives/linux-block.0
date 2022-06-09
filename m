Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A53C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Jun 2022 15:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiFIPbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jun 2022 11:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiFIPbp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 11:31:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86D1AD8A
        for <linux-block@vger.kernel.org>; Thu,  9 Jun 2022 08:31:44 -0700 (PDT)
Date:   Thu, 9 Jun 2022 17:31:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654788702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=x1IU5yCEHf/MM/Hmbd8q5mhxUvy2J2NC0IGOUDixj9s=;
        b=nskkSfjQYr6GAaefiBP9bJ6VIQoKu2wts5avFcvueBUQR3HR5HK3tGmYJ9eaRfwqlQhYCA
        WoUDGNxAn0oe6h7mh3qF/aeEpxTnQAjaYPzY1sW3HxsRaTqHa2rP7CenG5oDdBx1LXPlmI
        2IPyYh0MElKikzeIrVhPeCnPstXwHG1u+AknbnyWf/WLfbl9mqxzu770OSHM4M7wCHb0ZD
        zxGA9Gg6edvgqyWwBG69EuGh/y7p61KoA+7v34rjOvUF0f5iuq4PbwInfaFaSix8wbcbDP
        o5NGZDgytQyc2nzkKEPMj2mNEP0fRuQzB4OvwBByvcxPTCFBLnFzMwIT6qmiNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654788702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=x1IU5yCEHf/MM/Hmbd8q5mhxUvy2J2NC0IGOUDixj9s=;
        b=hL4xEFcqPY3ZYfeCoo+9O5WuN8dZreVgnZQb60qbavueM76Bvf47lKF3rO7ruQtZYm8pI1
        ZlN2eQnF+fzluBDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] blk-mq: Don't disable preemption around
 __blk_mq_run_hw_queue().
Message-ID: <YqISXf6GAQeWqcR+@linutronix.de>
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
Link: https://lore.kernel.org/r/YnQHqx/5+54jd+U+@linutronix.de
---
 block/blk-mq.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2083,14 +2083,14 @@ static void __blk_mq_delay_run_hw_queue(
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
