Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50623 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751185AbdBAEZ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 23:25:56 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v114MNZo028129
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 20:25:56 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 28auv429tf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 20:25:56 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.100.97) with ESMTP id
 849856e4e83611e6882b24be0593f280-298d8a50 for <linux-block@vger.kernel.org>;
        Tue, 31 Jan 2017 20:25:53 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <axboe@fb.com>
Subject: [PATCH 1/2] blk-mq: allocate blk_mq_tags and requests in correct node
Date: Tue, 31 Jan 2017 20:25:51 -0800
Message-ID: <1c91ab2c0073598592f66f007ff72cfa58a17a54.1485922654.git.shli@fb.com>
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
 block/blk-mq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3400b5..90a37ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1594,9 +1594,13 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 	struct blk_mq_tags *tags;
 	unsigned int i, j, entries_per_page, max_order = 4;
 	size_t rq_size, left;
+	int node;
+
+	node = blk_mq_hw_queue_to_node(set->mq_map, hctx_idx);
+	if (node == NUMA_NO_NODE)
+		node = set->numa_node;
 
-	tags = blk_mq_init_tags(set->queue_depth, set->reserved_tags,
-				set->numa_node,
+	tags = blk_mq_init_tags(set->queue_depth, set->reserved_tags, node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
 	if (!tags)
 		return NULL;
@@ -1605,7 +1609,7 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 
 	tags->rqs = kzalloc_node(set->queue_depth * sizeof(struct request *),
 				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				 set->numa_node);
+				 node);
 	if (!tags->rqs) {
 		blk_mq_free_tags(tags);
 		return NULL;
@@ -1629,7 +1633,7 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 			this_order--;
 
 		do {
-			page = alloc_pages_node(set->numa_node,
+			page = alloc_pages_node(node,
 				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO,
 				this_order);
 			if (page)
@@ -1660,7 +1664,7 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 			if (set->ops->init_request) {
 				if (set->ops->init_request(set->driver_data,
 						tags->rqs[i], hctx_idx, i,
-						set->numa_node)) {
+						node)) {
 					tags->rqs[i] = NULL;
 					goto fail;
 				}
-- 
2.9.3

