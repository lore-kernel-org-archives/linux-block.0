Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BFFC43612
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 02:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76BD218E2
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 02:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cggyCT0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeL0CBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:01:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36288 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeL0CBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Dec 2018 21:01:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBR1t59X122394;
        Thu, 27 Dec 2018 02:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=gjMmfSLbMrrJ66QLIzqcokPklNUU9lUf5hHh9XoRT9M=;
 b=cggyCT0vEfi+TeOnvGaufy2TzkDitxYzTov9wW22qgdHTNs6s1HcFVa3X6Jo18g5Eraz
 ymIU4PHOCgsNIj/BOSesBDRwbgbhyCw6bGt7vtRFMDurXX3Cn2qhTFTifHN0eeg0UQzn
 655ch6F6FnsqKfK8mfee7OswV0gA6TwNqVx1RVyU8LGwH1PDP58J6l+9EBJnaXo6xxW/
 zNsybp+Hob+9PlQDxXAmJmpFemQBnGAs6f6zLTm0oF6xon6UhuLBcokvg19WaTLdVtxE
 dEPAdDb4q9NzqZ3QJJYbN2GfKzUea+JvzBT4TAvDpbDE3sJBYTaRrgf+bfBWLgt373YI mg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2phasdu93q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Dec 2018 02:01:35 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBR21YMM002194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Dec 2018 02:01:35 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBR21Y0G023067;
        Thu, 27 Dec 2018 02:01:34 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Dec 2018 18:01:33 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: save default hctx into ctx->hctxs for not-supported type
Date:   Thu, 27 Dec 2018 10:00:41 +0800
Message-Id: <1545876041-16076-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545876041-16076-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1545876041-16076-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9118 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=989
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812270015
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, we check whether the hctx type is supported every time
in hot path. Actually, this is not necessary, we could save the
default hctx into ctx->hctxs if the type is not supported when
map swqueues and use it directly with ctx->hctxs[type].

We also needn't check whether the poll is enabled or not, because
the caller would clear the REQ_HIPRI in that case.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c |  9 ++++++++-
 block/blk-mq.h | 15 ++++++---------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6898d24..1dab467 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2430,8 +2430,11 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
 		for (j = 0; j < set->nr_maps; j++) {
-			if (!set->map[j].nr_queues)
+			if (!set->map[j].nr_queues) {
+				ctx->hctxs[j] = blk_mq_map_queue_type(q,
+						HCTX_TYPE_DEFAULT, i);
 				continue;
+			}
 
 			hctx = blk_mq_map_queue_type(q, j, i);
 			ctx->hctxs[j] = hctx;
@@ -2454,6 +2457,10 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 			 */
 			BUG_ON(!hctx->nr_ctx);
 		}
+
+		for (; j < HCTX_MAX_TYPES; j++)
+			ctx->hctxs[j] = blk_mq_map_queue_type(q,
+					HCTX_TYPE_DEFAULT, i);
 	}
 
 	mutex_unlock(&q->sysfs_lock);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 998f5cf..ed1ed45 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -98,7 +98,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
  * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
  * @q: request queue
  * @flags: request command flags
- * @cpu: CPU
+ * @ctx: mq cpu ctx
  */
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 						     unsigned int flags,
@@ -106,15 +106,12 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
-	if ((flags & REQ_HIPRI) &&
-	    q->tag_set->nr_maps > HCTX_TYPE_POLL && 
-	    q->tag_set->map[HCTX_TYPE_POLL].nr_queues &&
-	    test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	/*
+	 * The caller ensure that if REQ_HIPRI, poll must be enabled.
+	 */
+	if (flags & REQ_HIPRI)
 		type = HCTX_TYPE_POLL;
-
-	else if (((flags & REQ_OP_MASK) == REQ_OP_READ) &&
-	         q->tag_set->nr_maps > HCTX_TYPE_READ &&
-		 q->tag_set->map[HCTX_TYPE_READ].nr_queues)
+	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
 	
 	return ctx->hctxs[type];
-- 
2.7.4

