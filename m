Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FAAC63777
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 09:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9D5208CA
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 09:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgKZJv7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 04:51:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:46630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387418AbgKZJv6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 04:51:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDFF1ACA3;
        Thu, 26 Nov 2020 09:51:56 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] blk-mq: Make running from the wrong CPU less scary
Date:   Thu, 26 Nov 2020 10:51:52 +0100
Message-Id: <20201126095152.19151-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current warning looks aweful like a proper crash. This is
confusing. There is not much information to gained from the stack
trace anyway, let's drop it.

While at it print the cpumask as there might be additial helpful
information when debugging the sitation.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

We got a report from a customer because he was concerned about the log
entries. As it turns out, it fooled me too to be honest. What do you
think about making it a bit less look-a-like a kernel oops?


 smpboot: Booting Node 0 Processor 12 APIC 0x26                                                
WARNING, didn't collect load info for all cpus, balancing is broken                            
 run queue from wrong CPU 0, hctx active                                                       
 CPU: 0 PID: 42300 Comm: kworker/13:2H Kdump: loaded Tainted: G           OE  X    5.3.18-109.$
 Hardware name: IBM System x3650 M5 -[5462AC1]-/00KG915, BIOS -[TCE144J-3.11]- 12/03/2019      
 Workqueue: kblockd blk_mq_run_work_fn                                                         
 Call Trace:                                                                                   
  dump_stack+0x66/0x8b                                                                         
  __blk_mq_run_hw_queue+0xee/0x100                                                             
  process_one_work+0x1f4/0x3e0                                                                 
  worker_thread+0x2d/0x3e0                                                                     
  ? process_one_work+0x3e0/0x3e0                                                               
  kthread+0x10d/0x130                                                                          
  ? kthread_park+0xa0/0xa0                                                                     
  ret_from_fork+0x35/0x40                                                                      
 run queue from wrong CPU 0, hctx active                                                       
 CPU: 0 PID: 42300 Comm: kworker/13:2H Kdump: loaded Tainted: G           OE  X    5.3.18-109.$
 Hardware name: IBM System x3650 M5 -[5462AC1]-/00KG915, BIOS -[TCE144J-3.11]- 12/03/2019      
 Workqueue: kblockd blk_mq_run_work_fn    


Thanks,
Daniel

 block/blk-mq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..0427b719d9c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1514,10 +1514,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
 		cpu_online(hctx->next_cpu)) {
-		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
-			raw_smp_processor_id(),
-			cpumask_empty(hctx->cpumask) ? "inactive": "active");
-		dump_stack();
+		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %*pbl\n",
+			raw_smp_processor_id(), cpumask_pr_args(hctx->cpumask));
 	}
 
 	/*
-- 
2.16.4

