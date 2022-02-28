Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FAEC433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 09:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiB1JGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiB1JGT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 04:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37F8566AEC
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646039140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWoRnqRjaPV9Q+9OcGzmTgK4sVMtp4mlIfSrYEcG75Y=;
        b=Xic42cY2fV9PB142AnelxCn/KVf40dZptmknvaLqYr+zaT5cKcBmUQZHf4fe+kXSw6QT7s
        Ql3Rtxg+0sO3WDHXeoecgcxN6ZdopYGWtlW88bLiKjdh6vBEpXdssqvS6Aq1H2m+zVnr+y
        Lm9WTTE5la6WpJWzijXXV85JXTo1/qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-jS4CH8LdN2mEznLrWgiDKQ-1; Mon, 28 Feb 2022 04:05:38 -0500
X-MC-Unique: jS4CH8LdN2mEznLrWgiDKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 819E41091DA2;
        Mon, 28 Feb 2022 09:05:37 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF4707FA3A;
        Mon, 28 Feb 2022 09:05:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/6] blk-mq: simplify reallocation of hw ctxs a bit
Date:   Mon, 28 Feb 2022 17:04:26 +0800
Message-Id: <20220228090430.1064267-3-ming.lei@redhat.com>
In-Reply-To: <20220228090430.1064267-1-ming.lei@redhat.com>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_alloc_and_init_hctx() has already taken reuse into account, so
no need to do it outside, then we can simplify blk_mq_realloc_hw_ctxs().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 931add81813b..361903f07c84 100644
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

