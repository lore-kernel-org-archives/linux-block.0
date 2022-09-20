Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAAFC6FA90
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 02:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiITCRx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 22:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiITCRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 22:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F94DB16
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663640254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h9ZmCI0LCaoZR7HfXTt/Db+qT+knp1RrpFNmpWwfzuI=;
        b=Ycl2lvyulGN9OivHUXMuK5l8Bo9JD8Vd8xUhNVm8K59lHYX8aJEUDSZayHvN62ufoJY2sk
        pgrJRN2lwR6YewtYFpb5sCrOUUvh/bmCaHK6io9P4JrTil8LdielClnveSXSI/nMFHZcDB
        U3ssrgKE5hNYoQG6bpTwiROrNM8s2nE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-_jpJ3zoUOja4-7BEnVWeKA-1; Mon, 19 Sep 2022 22:17:32 -0400
X-MC-Unique: _jpJ3zoUOja4-7BEnVWeKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D6B01C05152;
        Tue, 20 Sep 2022 02:17:32 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E61DAC159CD;
        Tue, 20 Sep 2022 02:17:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
Date:   Tue, 20 Sep 2022 10:17:24 +0800
Message-Id: <20220920021724.1841850-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For avoiding to trigger io timeout when one hctx becomes inactive, we
drain IOs when all CPUs of one hctx are offline. However, driver's
timeout handler may require cpus_read_lock, such as nvme-pci,
pci_alloc_irq_vectors_affinity() is called in nvme-pci reset context,
and irq_build_affinity_masks() needs cpus_read_lock().

Meantime when blk-mq's cpuhp offline handler is called, cpus_write_lock
is held, so deadlock is caused.

Fixes the issue by breaking the wait loop if enough long time elapses,
and these in-flight not drained IO still can be handled by timeout
handler.

Cc: linux-nvme@lists.infradead.org
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c96c8c4f751b..4585985b8537 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3301,6 +3301,7 @@ static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
 	return true;
 }
 
+#define BLK_MQ_MAX_OFFLINE_WAIT_MSECS 3000
 static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 {
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
@@ -3326,8 +3327,13 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	 * frozen and there are no requests.
 	 */
 	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
-		while (blk_mq_hctx_has_requests(hctx))
+		unsigned int wait_ms = 0;
+
+		while (blk_mq_hctx_has_requests(hctx) && wait_ms <
+				BLK_MQ_MAX_OFFLINE_WAIT_MSECS) {
 			msleep(5);
+			wait_ms += 5;
+		}
 		percpu_ref_put(&hctx->queue->q_usage_counter);
 	}
 
-- 
2.31.1

