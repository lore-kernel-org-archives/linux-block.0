Return-Path: <SRS0=Yh1G=6Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C8EC3A5A9
	for <linux-block@archiver.kernel.org>; Sat,  2 May 2020 23:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4690820721
	for <linux-block@archiver.kernel.org>; Sat,  2 May 2020 23:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uu/7IO1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgEBX4V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 19:56:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21723 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbgEBX4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 May 2020 19:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588463780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0E6FjJfym2wxaJpRjfmaRhSzHJS6rkCL0z9quTLXr8=;
        b=Uu/7IO1w1/iREB3kH7EOb9g4ifwdQ/d857XFqBxGnE7qUf3gMazpGctYIklODsubazfbga
        727WYYCn9dzcAp2b0oXd4oqQIQR1wNwD7i0nOVYTPCXs/eyy7Lhu8xLvXzv+YhL5KKJUQC
        GTnU0xfEGq9ZsjCchJKu84tah+5TgHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-PtN0QPOxPUaHQGX8xSkxSw-1; Sat, 02 May 2020 19:56:18 -0400
X-MC-Unique: PtN0QPOxPUaHQGX8xSkxSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8462B1005510;
        Sat,  2 May 2020 23:56:16 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB6A260612;
        Sat,  2 May 2020 23:56:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V9 11/11] block: deactivate hctx when the hctx is actually inactive
Date:   Sun,  3 May 2020 07:54:54 +0800
Message-Id: <20200502235454.1118520-12-ming.lei@redhat.com>
In-Reply-To: <20200502235454.1118520-1-ming.lei@redhat.com>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Run queue on dead CPU still may be triggered in some corner case,
such as one request is requeued after CPU hotplug is handled.

So handle this corner case during run queue.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b777d9fd4ee..12dee4ecd5cc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,8 @@
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
=20
+static void blk_mq_hctx_deactivate(struct blk_mq_hw_ctx *hctx);
+
 static int blk_mq_poll_stats_bkt(const struct request *rq)
 {
 	int ddir, sectors, bucket;
@@ -1373,28 +1375,16 @@ static void __blk_mq_run_hw_queue(struct blk_mq_h=
w_ctx *hctx)
 	int srcu_idx;
=20
 	/*
-	 * We should be running this queue from one of the CPUs that
-	 * are mapped to it.
-	 *
-	 * There are at least two related races now between setting
-	 * hctx->next_cpu from blk_mq_hctx_next_cpu() and running
-	 * __blk_mq_run_hw_queue():
-	 *
-	 * - hctx->next_cpu is found offline in blk_mq_hctx_next_cpu(),
-	 *   but later it becomes online, then this warning is harmless
-	 *   at all
-	 *
-	 * - hctx->next_cpu is found online in blk_mq_hctx_next_cpu(),
-	 *   but later it becomes offline, then the warning can't be
-	 *   triggered, and we depend on blk-mq timeout handler to
-	 *   handle dispatched requests to this hctx
+	 * BLK_MQ_S_INACTIVE may not deal with some requeue corner case:
+	 * one request is requeued after cpu unplug is handled, so check
+	 * if the hctx is actually inactive. If yes, deactive it and
+	 * re-submit all requests in the queue.
 	 */
 	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
-		cpu_online(hctx->next_cpu)) {
-		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
-			raw_smp_processor_id(),
-			cpumask_empty(hctx->cpumask) ? "inactive": "active");
-		dump_stack();
+	    cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) >=3D
+	    nr_cpu_ids) {
+		blk_mq_hctx_deactivate(hctx);
+		return;
 	}
=20
 	/*
--=20
2.25.2

