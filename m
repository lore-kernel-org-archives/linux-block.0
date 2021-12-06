Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC5DC433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 11:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbhLFLQX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 06:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236157AbhLFLQU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Dec 2021 06:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638789171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9ryFPPWiRsFSsrjykSWsCrHONpTXKQcjfhU8bkis7c=;
        b=X0piEsNIF2jK28FwuBuHL3LSIhmAaFCeIW1t9L2oZzOd8YpTLJgy2teFO7sILacdu3tDOK
        3vfXLdmoXW9q2FS2i+Sx1HZ2eqKC04vajrp1lVBtbZMQhxaEGjPHRnwoQzbBfuouIpN46D
        JsAGVdAI08L1GKLkGWsHDhsnUk5KHMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-q_4wBqa0N3in1rI3F-RbGA-1; Mon, 06 Dec 2021 06:12:48 -0500
X-MC-Unique: q_4wBqa0N3in1rI3F-RbGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61DDC190D340;
        Mon,  6 Dec 2021 11:12:47 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92DC610013D6;
        Mon,  6 Dec 2021 11:12:18 +0000 (UTC)
Date:   Mon, 6 Dec 2021 19:12:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] blk-mq: remove hctx_lock and hctx_unlock
Message-ID: <Ya3wDS/UNzQXoYpQ@T590>
References: <20211203131534.3668411-1-ming.lei@redhat.com>
 <20211203131534.3668411-2-ming.lei@redhat.com>
 <CGME20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447@eucas1p2.samsung.com>
 <8b6e48b0-c55d-1583-1146-b18bf4eaf94a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b6e48b0-c55d-1583-1146-b18bf4eaf94a@samsung.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 06, 2021 at 11:31:21AM +0100, Marek Szyprowski wrote:
> Hi,
> 
> On 03.12.2021 14:15, Ming Lei wrote:
> > Remove hctx_lock and hctx_unlock, and add one helper of
> > blk_mq_run_dispatch_ops() to run code block defined in dispatch_ops
> > with rcu/srcu read held.
> >
> > Compared with hctx_lock()/hctx_unlock():
> >
> > 1) remove 2 branch to 1, so we just need to check
> > (hctx->flags & BLK_MQ_F_BLOCKING) once when running one dispatch_ops
> >
> > 2) srcu_idx needn't to be touched in case of non-blocking
> >
> > 3) might_sleep_if() can be moved to the blocking branch
> >
> > Also put the added blk_mq_run_dispatch_ops() in private header, so that
> > the following patch can use it out of blk-mq.c.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> This patch landed in linux next-20211206 as commit 2a904d00855f 
> ("blk-mq: remove hctx_lock and hctx_unlock"). It introduces a following 
> 'BUG' warning on my test systems (ARM/ARM64-based boards with rootfs on 
> SD card or eMMC):
> 
> BUG: sleeping function called from invalid context at block/blk-mq.c:2060
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 249, name: 
> kworker/0:3H
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 4 locks held by kworker/0:3H/249:
>   #0: c1d782a8 ((wq_completion)mmc_complete){+.+.}-{0:0}, at: 
> process_one_work+0x21c/0x7ec
>   #1: c3b59f18 ((work_completion)(&mq->complete_work)){+.+.}-{0:0}, at: 
> process_one_work+0x21c/0x7ec
>   #2: c1d7858c (&mq->complete_lock){+.+.}-{3:3}, at: 
> mmc_blk_mq_complete_prev_req.part.3+0x2c/0x234
>   #3: c1f7a1b4 (&fq->mq_flush_lock){....}-{2:2}, at: 
> mq_flush_data_end_io+0x68/0x124

It should be fixed by the attached patch.

From bce4d1bf7ab4ac4c04a65eca67705567e9d5f0c0 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 6 Dec 2021 15:54:11 +0800
Subject: [PATCH] blk-mq: don't run might_sleep() if the operation needn't
 blocking

The operation protected via blk_mq_run_dispatch_ops() in blk_mq_run_hw_queue
won't sleep, so don't run might_sleep() for it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 block/blk-mq.h | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 537295f6e0e9..0bf3523dd1f5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2048,7 +2048,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
 	 * quiesced.
 	 */
-	blk_mq_run_dispatch_ops(hctx->queue,
+	__blk_mq_run_dispatch_ops(hctx->queue, false,
 		need_run = !blk_queue_quiesced(hctx->queue) &&
 		blk_mq_hctx_has_pending(hctx));
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d62004e2d531..948791ea2a3e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -375,7 +375,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 }
 
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
-#define blk_mq_run_dispatch_ops(q, dispatch_ops)		\
+#define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
 do {								\
 	if (!blk_queue_has_srcu(q)) {				\
 		rcu_read_lock();				\
@@ -384,11 +384,14 @@ do {								\
 	} else {						\
 		int srcu_idx;					\
 								\
-		might_sleep();					\
+		might_sleep_if(check_sleep);			\
 		srcu_idx = srcu_read_lock((q)->srcu);		\
 		(dispatch_ops);					\
 		srcu_read_unlock((q)->srcu, srcu_idx);		\
 	}							\
 } while (0)
 
+#define blk_mq_run_dispatch_ops(q, dispatch_ops)		\
+	__blk_mq_run_dispatch_ops(q, true, dispatch_ops)	\
+
 #endif
-- 
2.31.1


Thanks,
Ming

