Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF1C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 10:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D3A218AD
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 10:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fKRnUCkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfAXK2M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:28:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44758 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfAXK2L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 05:28:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0OANaBM002859;
        Thu, 24 Jan 2019 10:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=+Usxm2UTsfK6KOpeBzWDfDQFkXfGRshAHGkmo6ZDD4A=;
 b=fKRnUCkPPsB0s0ImUNbTQE5K7bDgQnZQoxtG8SaD8Sd9had9pgI7FlBihuJpKKaKYfFV
 No5cs3ofWwRPoP3hipBLlENy4P8Y1L+nGrv0wiDb4RW2qM5RrRIwMD+/JzTTmvhvbOEu
 y7XcC3uUd+ExL4RHhkpwAmKlWF8VgowioTXQVenpnRwkB0QDuC29OThtBgICPZmoiTu1
 3USrcKmkf7SWuHDmhzSPnHVN0aX+PLoKWQ8kbatYHCs5cegizIkjnqUDzig8qtGoFddW
 DG5pvx2ClDnuFl9C4lFWDOaG8++Z6cjM+CHUcEDJVpdU/Kmj/+QbbnE3VQJraQ4m0THk RQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q3sdeq785-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 10:28:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0OAS7WZ017878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 10:28:08 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0OAS7Lo010241;
        Thu, 24 Jan 2019 10:28:07 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jan 2019 02:28:06 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: save queue mapping result into ctx directly
Date:   Thu, 24 Jan 2019 18:25:32 +0800
Message-Id: <1548325533-1695-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=986
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901240076
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currelty, the queue mapping result is saved in a two-dimensional
array. In hot path, to get a hctx, we need do following,

  q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]]

This looks not efficient. Actually, we could save the queue mapping
result into ctx directly with different hctx type, like,

  ctx->hctxs[type]

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c | 2 +-
 block/blk-mq-tag.c   | 2 +-
 block/blk-mq.c       | 4 ++--
 block/blk-mq.h       | 7 ++++---
 block/blk.h          | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 140933e..4090553 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -321,7 +321,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
 	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx->cpu);
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
 	bool ret = false;
 	enum hctx_type type;
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2089c6c..a4931fc 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -170,7 +170,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
-						data->ctx->cpu);
+						data->ctx);
 		tags = blk_mq_tags_from_data(data);
 		if (data->flags & BLK_MQ_REQ_RESERVED)
 			bt = &tags->breserved_tags;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8f5b533..445d0a2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -364,7 +364,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	}
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
-						data->ctx->cpu);
+						data->ctx);
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
@@ -2435,7 +2435,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 				continue;
 
 			hctx = blk_mq_map_queue_type(q, j, i);
-
+			ctx->hctxs[j] = hctx;
 			/*
 			 * If the CPU is already set in the mask, then we've
 			 * mapped this one already. This can happen if
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d943d46..9fb0626 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -23,6 +23,7 @@ struct blk_mq_ctx {
 
 	unsigned int		cpu;
 	unsigned short		index_hw[HCTX_MAX_TYPES];
+	struct blk_mq_hw_ctx 	*hctxs[HCTX_MAX_TYPES];
 
 	/* incremented at dispatch time */
 	unsigned long		rq_dispatched[2];
@@ -97,11 +98,11 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
  * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
  * @q: request queue
  * @flags: request command flags
- * @cpu: CPU
+ * @cpu: cpu ctx
  */
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 						     unsigned int flags,
-						     unsigned int cpu)
+						     struct blk_mq_ctx *ctx)
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
@@ -116,7 +117,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 		 q->tag_set->map[HCTX_TYPE_READ].nr_queues)
 		type = HCTX_TYPE_READ;
 	
-	return blk_mq_map_queue_type(q, type, cpu);
+	return ctx->hctxs[type];
 }
 
 /*
diff --git a/block/blk.h b/block/blk.h
index 848278c..5d636ee 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -38,7 +38,7 @@ extern struct ida blk_queue_ida;
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 {
-	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx->cpu)->fq;
+	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx)->fq;
 }
 
 static inline void __blk_get_queue(struct request_queue *q)
-- 
2.7.4

