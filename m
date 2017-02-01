Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42035 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753452AbdBARxU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 12:53:20 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v11Hqcrv023532
        for <linux-block@vger.kernel.org>; Wed, 1 Feb 2017 09:53:19 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 28b7p19y12-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2017 09:53:19 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.212.236.89) with ESMTP id
 4fb06176e8a711e6b90e0002c95209d8-e1bf1a50 for <linux-block@vger.kernel.org>;
        Wed, 01 Feb 2017 09:53:17 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <bhelgaas@google.com>, <hch@lst.de>, <axboe@fb.com>
Subject: [PATCH V2 1/3] blk-mq: allocate blk_mq_tags and requests in correct node
Date: Wed, 1 Feb 2017 09:53:14 -0800
Message-ID: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_mq_tags/requests of specific hardware queue are mostly used in
specific cpus, which might not be in the same numa node as disk. For
example, a nvme card is in node 0. half hardware queue will be used by
node 0, the other node 1.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-mq.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 48df5fd..888077c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1666,16 +1666,20 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					unsigned int reserved_tags)
 {
 	struct blk_mq_tags *tags;
+	int node;
+
+	node = blk_mq_hw_queue_to_node(set->mq_map, hctx_idx);
+	if (node == NUMA_NO_NODE)
+		node = set->numa_node;
 
-	tags = blk_mq_init_tags(nr_tags, reserved_tags,
-				set->numa_node,
+	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
 	if (!tags)
 		return NULL;
 
 	tags->rqs = kzalloc_node(nr_tags * sizeof(struct request *),
 				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				 set->numa_node);
+				 node);
 	if (!tags->rqs) {
 		blk_mq_free_tags(tags);
 		return NULL;
@@ -1683,7 +1687,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 
 	tags->static_rqs = kzalloc_node(nr_tags * sizeof(struct request *),
 				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				 set->numa_node);
+				 node);
 	if (!tags->static_rqs) {
 		kfree(tags->rqs);
 		blk_mq_free_tags(tags);
@@ -1703,6 +1707,11 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 {
 	unsigned int i, j, entries_per_page, max_order = 4;
 	size_t rq_size, left;
+	int node;
+
+	node = blk_mq_hw_queue_to_node(set->mq_map, hctx_idx);
+	if (node == NUMA_NO_NODE)
+		node = set->numa_node;
 
 	INIT_LIST_HEAD(&tags->page_list);
 
@@ -1724,7 +1733,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 			this_order--;
 
 		do {
-			page = alloc_pages_node(set->numa_node,
+			page = alloc_pages_node(node,
 				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO,
 				this_order);
 			if (page)
@@ -1757,7 +1766,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 			if (set->ops->init_request) {
 				if (set->ops->init_request(set->driver_data,
 						rq, hctx_idx, i,
-						set->numa_node)) {
+						node)) {
 					tags->static_rqs[i] = NULL;
 					goto fail;
 				}
-- 
2.9.3

