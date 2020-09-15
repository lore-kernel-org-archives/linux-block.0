Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE275C43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17542078D
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 09:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIOJL0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 05:11:26 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:23368 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOJLV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 05:11:21 -0400
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 15 Sep 2020 02:11:20 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 15 Sep 2020 02:11:18 -0700
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg01-blr.qualcomm.com with ESMTP; 15 Sep 2020 14:41:05 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id 6F19620EBA; Tue, 15 Sep 2020 14:41:04 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V2] block: Fix use-after-free issue while accessing ioscheduler lock
Date:   Tue, 15 Sep 2020 14:41:02 +0530
Message-Id: <1600161062-43793-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Observes below crash while accessing (use-after-free) lock member
of bfq data.

context#1			context#2
				process_one_work()
kthread()			blk_mq_run_work_fn()
worker_thread()			 ->__blk_mq_run_hw_queue()
process_one_work()		  ->blk_mq_sched_dispatch_requests()
__blk_release_queue()		    ->blk_mq_do_dispatch_sched()
->__elevator_exit()
  ->blk_mq_exit_sched()
    ->exit_sched()
      ->kfree()
      					->bfq_dispatch_request()
					  ->spin_unlock_irq(&bfqd->lock)

This is because of the kblockd delayed work that might got scheduled
around blk_release_queue() and accessed use-after-free member of
bfq_data.

240.212359:   <2> Unable to handle kernel paging request at
virtual address ffffffee2e33ad70
...
240.212637:   <2> Workqueue: kblockd blk_mq_run_work_fn
240.212649:   <2> pstate: 00c00085 (nzcv daIf +PAN +UAO)
240.212666:   <2> pc : queued_spin_lock_slowpath+0x10c/0x2e0
240.212677:   <2> lr : queued_spin_lock_slowpath+0x84/0x2e0
...
Call trace:
240.212865:   <2>  queued_spin_lock_slowpath+0x10c/0x2e0
240.212876:   <2>  do_raw_spin_lock+0xf0/0xf4
240.212890:   <2>  _raw_spin_lock_irq+0x74/0x94
240.212906:   <2>  bfq_dispatch_request+0x4c/0xd60
240.212918:   <2>  blk_mq_do_dispatch_sched+0xe0/0x1f0
240.212927:   <2>  blk_mq_sched_dispatch_requests+0x130/0x194
240.212940:   <2>  __blk_mq_run_hw_queue+0x100/0x158
240.212950:   <2>  blk_mq_run_work_fn+0x1c/0x28
240.212963:   <2>  process_one_work+0x280/0x460
240.212973:   <2>  worker_thread+0x27c/0x4dc
240.212986:   <2>  kthread+0x160/0x170

Fix this by cancelling the delayed work if any before elevator exits.

Changes since V1:
- Moved the logic into blk_cleanup_queue() as per Ming comments.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4abb714..890fded 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2598,6 +2598,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 			break;
 		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
+		cancel_delayed_work_sync(&hctx->run_work);
 	}
 }
 
-- 
2.7.4

