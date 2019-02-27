Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D9AC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 13:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8143D2133D
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 13:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S8/7BKvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfB0NcC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:32:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38720 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfB0NcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 08:32:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1RDSq6H067801;
        Wed, 27 Feb 2019 13:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=jP1rCEWZttWuConnvNH2Dav4eb+rzhuEldM4Iax3isI=;
 b=S8/7BKvs00MG07uTa/yfH2A9KxWDULdUQVEVztWF1pGUJA6/qKyvavLzsXgHHK3HdXtZ
 M/6a/UdeRxEIwhuUnEGHawFbp+Rmh7EZeqUoz8+f4HXgIgn0JOZanD6ZhF2pJoqZk8Tf
 +bHeDZYZ1LUx0qU/uG9zI63QxUqX3CIQZKooJQvDuVtP3YodErNrWDNmzlSv1+c27+gn
 mfvaD3NAKd3LuZvvDVIap/m7bBMsJXO9xvwFxIaNeQoroNJ/JggpNhiFC5TGVxVgS6ol
 CtQV1ra9y/3u1vkZFZHUgQAmh29XMLUss3if7qdhQl4Igf1WMraR8C+tLHi1BeJjazWY ow== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qtupeb18x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 13:31:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1RDVwJw005468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 13:31:59 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1RDVwoR024619;
        Wed, 27 Feb 2019 13:31:58 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Feb 2019 05:31:58 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH for-next 1/1] blk-mq: use HCTX_TYPE_DEFAULT but not 0 to index blk_mq_tag_set->map
Date:   Wed, 27 Feb 2019 21:35:01 +0800
Message-Id: <1551274501-8297-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=917 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902270091
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace set->map[0] with set->map[HCTX_TYPE_DEFAULT] to avoid hardcoding.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 block/blk-mq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 54535f4..4e502db 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2069,7 +2069,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	struct blk_mq_tags *tags;
 	int node;
 
-	node = blk_mq_hw_queue_to_node(&set->map[0], hctx_idx);
+	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
@@ -2125,7 +2125,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	size_t rq_size, left;
 	int node;
 
-	node = blk_mq_hw_queue_to_node(&set->map[0], hctx_idx);
+	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
@@ -2424,7 +2424,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	 * If the cpu isn't present, the cpu is mapped to first hctx.
 	 */
 	for_each_possible_cpu(i) {
-		hctx_idx = set->map[0].mq_map[i];
+		hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
 		/* unmapped hw queue can be remapped after CPU topo changed */
 		if (!set->tags[hctx_idx] &&
 		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
@@ -2434,7 +2434,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 			 * case, remap the current ctx to hctx[0] which
 			 * is guaranteed to always have tags allocated
 			 */
-			set->map[0].mq_map[i] = 0;
+			set->map[HCTX_TYPE_DEFAULT].mq_map[i] = 0;
 		}
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
@@ -2741,7 +2741,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		int node;
 		struct blk_mq_hw_ctx *hctx;
 
-		node = blk_mq_hw_queue_to_node(&set->map[0], i);
+		node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], i);
 		/*
 		 * If the hw queue has been mapped to another numa node,
 		 * we need to realloc the hctx. If allocation fails, fallback
@@ -2972,7 +2972,7 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		return set->ops->map_queues(set);
 	} else {
 		BUG_ON(set->nr_maps > 1);
-		return blk_mq_map_queues(&set->map[0]);
+		return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 	}
 }
 
@@ -3242,7 +3242,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			pr_warn("Increasing nr_hw_queues to %d fails, fallback to %d\n",
 					nr_hw_queues, prev_nr_hw_queues);
 			set->nr_hw_queues = prev_nr_hw_queues;
-			blk_mq_map_queues(&set->map[0]);
+			blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 			goto fallback;
 		}
 		blk_mq_map_swqueue(q);
-- 
2.7.4

