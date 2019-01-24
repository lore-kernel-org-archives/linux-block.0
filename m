Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE7DC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 10:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB5421872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 10:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o7JcR5x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfAXK2N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:28:13 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44796 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfAXK2M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 05:28:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0OANCh6002504;
        Thu, 24 Jan 2019 10:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=qgk8gTpduc4z1WFJNcxqo8VLFCxykyxb3RrGxZsR5hM=;
 b=o7JcR5x68ITLfXgSioS/4BgaQ/7LgcRBwekaQwmgHMlaLK6ZFCoJT/IDgSdycmmeALcs
 Vp0wceLcuUdHMoYFtU5V/Ttj+Zantmsa8ug5+OSjtQSdmgrdy61TggNfjMb7TzFvlrwR
 BHQ5uOBjME/1AmhVUqxz0kCwjjjThI26MPr0zwPG4xPMow3A8U9pNyC3IAlp8AB2SjrM
 3jGqDt7uxOF9X+7MIwfbwYs+tCCfLksL66wWaIwPVDT2L7ymJRVq3IGj3ucHfuttE+Mz
 EhP+bTVNwvq+5+yMETjjpj6hThTcI5C6UUBfNEFb9Ic5x+45D08lJrJcVLewZVEBNu3L hA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q3sdeq789-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 10:28:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0OAS98U002728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 10:28:09 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0OAS9ke020019;
        Thu, 24 Jan 2019 10:28:09 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jan 2019 02:28:08 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: save default hctx into ctx->hctxs for not-supported type
Date:   Thu, 24 Jan 2019 18:25:33 +0800
Message-Id: <1548325533-1695-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=911
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901240076
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
 block/blk-mq.h | 13 +++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 445d0a2..8a825ae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2431,8 +2431,11 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
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
@@ -2455,6 +2458,10 @@ static void blk_mq_map_swqueue(struct request_queue *q)
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
index 9fb0626..14b7efb9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
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

