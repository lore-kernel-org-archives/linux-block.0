Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB449C2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 01:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79EF3613B9
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 01:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFRCBm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 22:01:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9372 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFRCBl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 22:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623981571; x=1655517571;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s6vn8nw1JpBVm5D3VpDVeUItY85tDB6eBbHrafTINEA=;
  b=E0wzgfakFB3YC75hia+3DiqmhqH2MPjYs9pwe1CsofH975mGaxygFA0+
   AYCP2zPH/yGoF0ipjazaICMHDIx+DgO7yT6b4Qj6hcZg0vdl/bt/iOA9F
   bhkzAhFUV5/nBe3xeUVbAyIK9M/i5QB2wlp3Iiwc6yferxByEKh/7qs//
   CJJL18uoIc1BjobBbRkGPgn+Ky55PuKDu768DYdLVu+PpxitbiRb03cYF
   4ocUCBTGP+4ZjnJZCd5zzInzEPUT92pIT0R48zRnRBe3XCpyhEGKv3/+L
   97tOXxZyVoBqkSujcjh8l48LmMSCkuSjDmBwrYuKsH4+y7SIfMDlQwjEQ
   w==;
IronPort-SDR: mlTyu2Rr0QXMvcKFpClgITsebyTDq0fCiriTcTfLkgg3ErzSG3vZjwjrbo6LTC7NGigsZIi372
 1APGfZlM2RuV5Qd9wa+b/UdDN12jDebew4BZit2QdiRDuusS86ivJWsAJaAaAvUzxAyfVAigs2
 EFY39I6A1QjDlOp70WebSjc7+zMbs1JHVzu7mN12GQWbacaTjkW/xJMxC6U9QXTiVtuX3ThIQt
 VjMPpi4Jb8Ipcv0marSocru3e4FNYmSUbazXRxUsJnAPzhDPUgfJXxRgcSt8A0kj/PUzTscuZm
 Us8=
X-IronPort-AV: E=Sophos;i="5.83,281,1616428800"; 
   d="scan'208";a="177049992"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 09:59:30 +0800
IronPort-SDR: Gqb3AeHPhS7JiqZFgHGTVrfJdv/2ROboehwrI9UIizdy8Z+2lRGRFCkm6/bTjyT0vH5nB+MX66
 gySKFkD9xmcI1xpUnZcRpbxF0QuQo1LZyDYojzSZYkYlEb0XgLHuwqiG2iXChgzBOeJY7JOH+l
 FXVB30M3Il/oxG6Susgsyn30X4KHv4ME+/SNlhOkJ0q8Sv7bZI/qy0rKmlkdJMrsf+qps6/HfQ
 vWD5GyIUJ1MF8YsfOSD3ROJiv6e8fYhX1FQGYC7I7MVuT79SIRG1C85WQ2pcHWH3uM79VQ2ynA
 rqNhvOFo/GkN+F+sx3SzY61t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 18:36:58 -0700
IronPort-SDR: wGdsMqFftqFOhxxEc5cO3Vgd3J0loorJd+zYdOVxOB5OsXMoYot2JHOyekzj2OxGq8NBxbRPf8
 dWSgkJeLTye23uLnwcgfL55P4fW7J2pIIHigmS5ftpLkLnb35qEsLqofPqSt8Em65ADJsKEs00
 Jbli+Qi8yOdXFBHJFiOmsaZNge+9uyCMD2+5WiVTzmiTMR4ec/LR4hgAhNMnrjmoSeYCCL+QZl
 0L4VNK4RC3eGUO/5NfD/GdjXzpskRM11/hyWWHiIGvV1U+a5zyZsjLZWCXXVb/bSF7s00RRlbp
 eSo=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2021 18:59:31 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Remove unnecessary elevator operation checks
Date:   Fri, 18 Jun 2021 10:59:22 +0900
Message-Id: <20210618015922.713999-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The insert_requests and dispatch_request elevator operations are
mandatory for the correct execution of an elevator, and all implemented
elevators (bfq, kyber and mq-deadline) implement them. As a result,
there is no need to check for these operations before calling them when
a queue has an elevator set. This simplifies the code in
__blk_mq_sched_dispatch_requests() and blk_mq_sched_insert_request().

To avoid out-of-tree elevators to crash the kernel in case of bad
implementation, add a check in elv_register() to verify that these
operations are implemented.

A small, probably not significant, IOPS improvement of 0.1% is observed
with this patch applied (4.117 MIOPS to 4.123 MIOPS, average of 20 fio
runs doing 4K random direct reads with psync and 32 jobs).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-mq-sched.c | 13 ++++++-------
 block/elevator.c     |  4 ++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a9182d2f8ad3..bf2c105e81a2 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -294,8 +294,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
-	struct elevator_queue *e = q->elevator;
-	const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
+	const bool has_sched = q->elevator;
 	int ret = 0;
 	LIST_HEAD(rq_list);
 
@@ -326,12 +325,12 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
 		if (blk_mq_dispatch_rq_list(hctx, &rq_list, 0)) {
-			if (has_sched_dispatch)
+			if (has_sched)
 				ret = blk_mq_do_dispatch_sched(hctx);
 			else
 				ret = blk_mq_do_dispatch_ctx(hctx);
 		}
-	} else if (has_sched_dispatch) {
+	} else if (has_sched) {
 		ret = blk_mq_do_dispatch_sched(hctx);
 	} else if (hctx->dispatch_busy) {
 		/* dequeue request one by one from sw queue if queue is busy */
@@ -463,7 +462,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		goto run;
 	}
 
-	if (e && e->type->ops.insert_requests) {
+	if (e) {
 		LIST_HEAD(list);
 
 		list_add(&rq->queuelist, &list);
@@ -494,9 +493,9 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 	percpu_ref_get(&q->q_usage_counter);
 
 	e = hctx->queue->elevator;
-	if (e && e->type->ops.insert_requests)
+	if (e) {
 		e->type->ops.insert_requests(hctx, list, false);
-	else {
+	} else {
 		/*
 		 * try to issue requests directly if the hw queue isn't
 		 * busy in case of 'none' scheduler, and this way may save
diff --git a/block/elevator.c b/block/elevator.c
index 06e203426410..85d0d4adbb64 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -522,6 +522,10 @@ void elv_unregister_queue(struct request_queue *q)
 
 int elv_register(struct elevator_type *e)
 {
+	/* insert_requests and dispatch_request are mandatory */
+	if (WARN_ON_ONCE(!e->ops.insert_requests || !e->ops.dispatch_request))
+		return -EINVAL;
+
 	/* create icq_cache if requested */
 	if (e->icq_size) {
 		if (WARN_ON(e->icq_size < sizeof(struct io_cq)) ||
-- 
2.31.1

