Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B1C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 06:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiCGGpj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 01:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiCGGpi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 01:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C9284504F
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 22:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646635484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rmhl1dpNVVAV1rPyGRwYjcfhdZtbcSjlyE3aMUa6w8=;
        b=MHES211oE7XKO+j2tT3IYWY00rUVhzFzl9qwKxW9stPCKWbGXkGPDl6+n8mww0VbI7JxAR
        8ix50S2mWn1R7hm0M+3jJu3FECkKfoX61URS8NjsuSGKvQJFy+45K90xaHn5lOIyzzf5sW
        x1wl45K8vaDVhs+HMq9UGFQo0Xh2CzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-cNszV3eVOK6i3fFEr8z38g-1; Mon, 07 Mar 2022 01:44:40 -0500
X-MC-Unique: cNszV3eVOK6i3fFEr8z38g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78DE51091DA0;
        Mon,  7 Mar 2022 06:44:39 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B5D3827AF;
        Mon,  7 Mar 2022 06:44:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/6] blk-mq: simplify reallocation of hw ctxs a bit
Date:   Mon,  7 Mar 2022 14:43:57 +0800
Message-Id: <20220307064401.30056-3-ming.lei@redhat.com>
In-Reply-To: <20220307064401.30056-1-ming.lei@redhat.com>
References: <20220307064401.30056-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_alloc_and_init_hctx() has already taken reuse into account, so
no need to do it outside, then we can simplify blk_mq_realloc_hw_ctxs().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5d25abf9e551..64fddb36c93c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3966,29 +3966,24 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
+		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
-		struct blk_mq_hw_ctx *hctx;
+		struct blk_mq_hw_ctx *old_hctx = hctxs[i];
 
-		/*
-		 * If the hw queue has been mapped to another numa node,
-		 * we need to realloc the hctx. If allocation fails, fallback
-		 * to use the previous one.
-		 */
-		if (hctxs[i] && (hctxs[i]->numa_node == node))
-			continue;
+		if (old_hctx) {
+			old_node = old_hctx->numa_node;
+			blk_mq_exit_hctx(q, set, old_hctx, i);
+		}
 
-		hctx = blk_mq_alloc_and_init_hctx(set, q, i, node);
-		if (hctx) {
-			if (hctxs[i])
-				blk_mq_exit_hctx(q, set, hctxs[i], i);
-			hctxs[i] = hctx;
-		} else {
-			if (hctxs[i])
-				pr_warn("Allocate new hctx on node %d fails,\
-						fallback to previous one on node %d\n",
-						node, hctxs[i]->numa_node);
-			else
+		hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i, node);
+		if (!hctxs[i]) {
+			if (!old_hctx)
 				break;
+			pr_warn("Allocate new hctx on node %d fails, fallback to previous one on node %d\n",
+					node, old_node);
+			hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i,
+					old_node);
+			WARN_ON_ONCE(!hctxs[i]);
 		}
 	}
 	/*
-- 
2.31.1

