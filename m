Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D26C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 06:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiCGGpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 01:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiCGGpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 01:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 769A0443FE
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 22:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646635463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJazbow8R5+85aFgFMDLilK+8+rVXHpj3q2OjN7TS2E=;
        b=MUVvYDu5DbZmhwIjf2QlSQK6JaAzi7EbD7ctOPsYphIECv0UEf/f5CgweXHNwsqu1UyUbU
        t+fwL0q/O5IK4kBCDPXoTACou44sZ/AGueE43+TnbI6gDZjNx/gB5xtMVOcjlOrCXzXJ0Y
        +QJdE+Vmbp3alYwDLH+LyEfur2ys2IM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-KIo8hrdlN3-ht9KXzw44vA-1; Mon, 07 Mar 2022 01:44:19 -0500
X-MC-Unique: KIo8hrdlN3-ht9KXzw44vA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CACAC80202C;
        Mon,  7 Mar 2022 06:44:17 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1678362D4A;
        Mon,  7 Mar 2022 06:44:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/6] blk-mq: figure out correct numa node for hw queue
Date:   Mon,  7 Mar 2022 14:43:56 +0800
Message-Id: <20220307064401.30056-2-ming.lei@redhat.com>
In-Reply-To: <20220307064401.30056-1-ming.lei@redhat.com>
References: <20220307064401.30056-1-ming.lei@redhat.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a05ce7725031..5d25abf9e551 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3107,15 +3107,41 @@ void blk_mq_free_rq_map(struct blk_mq_tags *tags)
 	blk_mq_free_tags(tags);
 }
 
+static enum hctx_type hctx_idx_to_type(struct blk_mq_tag_set *set,
+		unsigned int hctx_idx)
+{
+	int i;
+
+	for (i = 0; i < set->nr_maps; i++) {
+		unsigned int start = set->map[i].queue_offset;
+		unsigned int end = start + set->map[i].nr_queues;
+
+		if (hctx_idx >= start && hctx_idx < end)
+			break;
+	}
+
+	if (i >= set->nr_maps)
+		i = HCTX_TYPE_DEFAULT;
+
+	return i;
+}
+
+static int blk_mq_get_hctx_node(struct blk_mq_tag_set *set,
+		unsigned int hctx_idx)
+{
+	enum hctx_type type = hctx_idx_to_type(set, hctx_idx);
+
+	return blk_mq_hw_queue_to_node(&set->map[type], hctx_idx);
+}
+
 static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					       unsigned int hctx_idx,
 					       unsigned int nr_tags,
 					       unsigned int reserved_tags)
 {
+	int node = blk_mq_get_hctx_node(set, hctx_idx);
 	struct blk_mq_tags *tags;
-	int node;
 
-	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
@@ -3164,10 +3190,9 @@ static int blk_mq_alloc_rqs(struct blk_mq_tag_set *set,
 			    unsigned int hctx_idx, unsigned int depth)
 {
 	unsigned int i, j, entries_per_page, max_order = 4;
+	int node = blk_mq_get_hctx_node(set, hctx_idx);
 	size_t rq_size, left;
-	int node;
 
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

