Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E8EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 09:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiB1JFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiB1JFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 04:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53DA0286E1
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646039107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7vgXRHNqvrfBbXDnm1SX3pfQl9OfbcM9TmVvoNixHY=;
        b=HLg/jyfMycQ9amuGRey/htv5plbZdu6HlvOtxJfbd0j7H6Q6Ge6raZgXwucUy/FjgiJG+d
        7JWWaTY4YA9SLjY1vcC56q9C7/neInkQR4IDMFgR1coy1w1mHbuweMIcptyhD63bjSZp8W
        FvdLqPC52ix/JwFgdvnPtSEkxOYQS10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-VHU_HpoqMb6vmIpSgR5OFg-1; Mon, 28 Feb 2022 04:05:04 -0500
X-MC-Unique: VHU_HpoqMb6vmIpSgR5OFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA35835DE1;
        Mon, 28 Feb 2022 09:05:03 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3B3A6F94F;
        Mon, 28 Feb 2022 09:05:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/6] blk-mq: figure out correct numa node for hw queue
Date:   Mon, 28 Feb 2022 17:04:25 +0800
Message-Id: <20220228090430.1064267-2-ming.lei@redhat.com>
In-Reply-To: <20220228090430.1064267-1-ming.lei@redhat.com>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current code always uses default queue map and hw queue index
for figuring out the numa node for hw queue, this way isn't correct
because blk-mq supports three queue maps, and the correct queue map
should be used for the specified hw queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a05ce7725031..931add81813b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3107,15 +3107,41 @@ void blk_mq_free_rq_map(struct blk_mq_tags *tags)
 	blk_mq_free_tags(tags);
 }
 
+static int hctx_idx_to_type(struct blk_mq_tag_set *set,
+		unsigned int hctx_idx)
+{
+	int j;
+
+	for (j = 0; j < set->nr_maps; j++) {
+		unsigned int start =  set->map[j].queue_offset;
+		unsigned int end = start + set->map[j].nr_queues;
+
+		if (hctx_idx >= start && hctx_idx < end)
+			break;
+	}
+
+	if (j >= set->nr_maps)
+		j = HCTX_TYPE_DEFAULT;
+
+	return j;
+}
+
+static int blk_mq_get_hctx_node(struct blk_mq_tag_set *set,
+		unsigned int hctx_idx)
+{
+	int type = hctx_idx_to_type(set, hctx_idx);
+
+	return blk_mq_hw_queue_to_node(&set->map[type], hctx_idx);
+}
+
 static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					       unsigned int hctx_idx,
 					       unsigned int nr_tags,
 					       unsigned int reserved_tags)
 {
 	struct blk_mq_tags *tags;
-	int node;
+	int node = blk_mq_get_hctx_node(set, hctx_idx);
 
-	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
@@ -3165,9 +3191,8 @@ static int blk_mq_alloc_rqs(struct blk_mq_tag_set *set,
 {
 	unsigned int i, j, entries_per_page, max_order = 4;
 	size_t rq_size, left;
-	int node;
+	int node = blk_mq_get_hctx_node(set, hctx_idx);
 
-	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
@@ -3941,10 +3966,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
-		int node;
+		int node = blk_mq_get_hctx_node(set, i);
 		struct blk_mq_hw_ctx *hctx;
 
-		node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], i);
 		/*
 		 * If the hw queue has been mapped to another numa node,
 		 * we need to realloc the hctx. If allocation fails, fallback
-- 
2.31.1

