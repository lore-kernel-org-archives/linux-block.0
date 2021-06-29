Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B65C11F66
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB35261DC2
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhF2Hwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232284AbhF2Hwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 03:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624953020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sK6AunQ5QlMOQJ8G9+eFl+B0+tOEEvgGaeTW3pvcl4=;
        b=IyzRWhllEWCKnayQfFM9rtcI5YDM2dgpxBEWdHaE/23oD1aBoAhyOGAcdciY4Dos/ZJSon
        SG0IN66JeHHRxcp1Dt31Ie2paFCDw4QVQZzKig5GLt5NzsUsR1NcCnCyey1ORwAcB9SblW
        Rgl118rHy/EiSGNHrQDVnCsybhHRiVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-sVw30hPJP-C_OQdRxEiNeQ-1; Tue, 29 Jun 2021 03:50:18 -0400
X-MC-Unique: sVw30hPJP-C_OQdRxEiNeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7796610B7464;
        Tue, 29 Jun 2021 07:50:17 +0000 (UTC)
Received: from localhost (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 215B260877;
        Tue, 29 Jun 2021 07:50:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use managed irq
Date:   Tue, 29 Jun 2021 15:49:50 +0800
Message-Id: <20210629074951.1981284-2-ming.lei@redhat.com>
In-Reply-To: <20210629074951.1981284-1-ming.lei@redhat.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hctx is deactivated when all CPU in hctx->cpumask become offline by
draining all requests originated from this hctx and moving new
allocation to active hctx. This way is for avoiding inflight IO when
the managed irq is shutdown.

Some drivers(nvme fc, rdma, tcp, loop) doesn't use managed irq, so
they needn't to deactivate hctx. Also, they are the only user of
blk_mq_alloc_request_hctx() which is used for connecting io queue.
And their requirement is that the connect request can be submitted
via one specified hctx on which all CPU in its hctx->cpumask may have
become offline.

Address the requirement for nvme fc/rdma/loop, so the reported kernel
panic on the following line in blk_mq_alloc_request_hctx() can be fixed.

	data.ctx = __blk_mq_get_ctx(q, cpu)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 6 +++++-
 include/linux/blk-mq.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df5dc3b756f5..74632f50d969 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -494,7 +494,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	cpu = cpumask_first(data.hctx->cpumask);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
@@ -2570,6 +2570,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
 		return 0;
 
+	/* Controller doesn't use managed IRQ, no need to deactivate hctx */
+	if (hctx->flags & BLK_MQ_F_NOT_USE_MANAGED_IRQ)
+		return 0;
+
 	/*
 	 * Prevent new request from being allocated on the current hctx.
 	 *
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 21140132a30d..600c5dd1a069 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -403,6 +403,7 @@ enum {
 	 */
 	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
+	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.31.1

