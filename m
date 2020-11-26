Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52CBC64E75
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 15:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F1320B80
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 15:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbgKZPCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 10:02:23 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:56776 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390811AbgKZPCW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 10:02:22 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 Nov 2020 07:02:22 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Nov 2020 07:02:20 -0800
X-QCInternal: smtphost
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 Nov 2020 20:32:09 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id EE1C021110; Thu, 26 Nov 2020 20:32:07 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V1] block: Fix use-after-free while iterating over requests
Date:   Thu, 26 Nov 2020 20:32:05 +0530
Message-Id: <1606402925-24420-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Observes below crash while accessing (use-after-free) request queue
member of struct request.

191.784789:   <2> Unable to handle kernel paging request at virtual
address ffffff81429a4440
...
191.786174:   <2> CPU: 3 PID: 213 Comm: kworker/3:1H Tainted: G S
O      5.4.61-qgki-debug-ge45de39 #1
...
191.786226:   <2> Workqueue: kblockd blk_mq_timeout_work
191.786242:   <2> pstate: 20c00005 (nzCv daif +PAN +UAO)
191.786261:   <2> pc : bt_for_each+0x114/0x1a4
191.786274:   <2> lr : bt_for_each+0xe0/0x1a4
...
191.786494:   <2> Call trace:
191.786507:   <2>  bt_for_each+0x114/0x1a4
191.786519:   <2>  blk_mq_queue_tag_busy_iter+0x60/0xd4
191.786532:   <2>  blk_mq_timeout_work+0x54/0xe8
191.786549:   <2>  process_one_work+0x2cc/0x568
191.786562:   <2>  worker_thread+0x28c/0x518
191.786577:   <2>  kthread+0x160/0x170
191.786594:   <2>  ret_from_fork+0x10/0x18
191.786615:   <2> Code: 0b080148 f9404929 f8685921 b4fffe01 (f9400028)
191.786630:   <2> ---[ end trace 0f1f51d79ab3f955 ]---
191.786643:   <2> Kernel panic - not syncing: Fatal exception

Fix this by updating the freed request with NULL.
This could avoid accessing the already free request from other
contexts while iterating over the requests.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 block/blk-mq.c | 1 +
 block/blk-mq.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5..9996cb1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -492,6 +492,7 @@ static void __blk_mq_free_request(struct request *rq)
 
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
+	hctx->tags->rqs[rq->tag] = NULL;
 	rq->mq_hctx = NULL;
 	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a52703c..8747bf1 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -224,6 +224,7 @@ static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
+	hctx->tags->rqs[rq->tag] = NULL;
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rq->tag = BLK_MQ_NO_TAG;
 
-- 
2.7.4

