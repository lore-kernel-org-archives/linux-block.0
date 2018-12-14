Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF5AC67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 01:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71A42075B
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 01:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ILgE9p+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71A42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeLNB3l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:29:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42978 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeLNB3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 20:29:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBE1OPWC158563;
        Fri, 14 Dec 2018 01:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=9TBTfJALae16hdD8OBiuBFcGlbqT897B63K0LtZfH2w=;
 b=ILgE9p+RvdUGtweBOVpqN0z7tOjJy9sqeYhS79NcPjw+NKX2iiaVh4TTChbjaqPeiEbC
 PcOVrRDb8cLBDul4iTlbXK+oGFsSYsuJmAmC014jUFPzzSKck+zs7RKh0Z+Tc28Yltil
 XHRhkfbAeZpROGaLrLg6jReHsTcQKFOz+ruyt+WqnSjMXb8MDDNzCw1oXvVcSmYy7VS9
 DxrMYFHtU1IBW4u7c1KiYWeIl2H5QahDMJqdmlM5LyLoUaiaL3+laKmFc6wcyskCFRpy
 hjZfz145GBfGtWzofbXNgHB1O6CtdtAkhhfpR9nalzydPy7lqk96CbEI+DRyobC5usAl /w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pb7tf77ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 01:29:19 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBE1TItL015296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 01:29:19 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBE1TIBW012393;
        Fri, 14 Dec 2018 01:29:18 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 17:29:18 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V14 2/3] blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
Date:   Fri, 14 Dec 2018 09:28:19 +0800
Message-Id: <1544750900-1549-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544750900-1549-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1544750900-1549-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9106 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812140011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is not necessary to issue request directly with bypass 'true'
in blk_mq_sched_insert_requests and handle the non-issued requests
itself. Just set bypass to 'false' and let blk_mq_try_issue_directly
handle them totally. Remove the blk_rq_can_direct_dispatch check,
because blk_mq_try_issue_directly can handle it well.If request is
direct-issued unsuccessfully, insert the reset.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c |  8 +++-----
 block/blk-mq.c       | 20 +++++++++-----------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index f096d898..5b4d52d 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -417,12 +417,10 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 		 * busy in case of 'none' scheduler, and this way may save
 		 * us one extra enqueue & dequeue to sw queue.
 		 */
-		if (!hctx->dispatch_busy && !e && !run_queue_async) {
+		if (!hctx->dispatch_busy && !e && !run_queue_async)
 			blk_mq_try_issue_list_directly(hctx, list);
-			if (list_empty(list))
-				return;
-		}
-		blk_mq_insert_requests(hctx, ctx, list);
+		else
+			blk_mq_insert_requests(hctx, ctx, list);
 	}
 
 	blk_mq_run_hw_queue(hctx, run_queue_async);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index af4dc82..90361fe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1874,22 +1874,20 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
+	blk_qc_t unused;
+	blk_status_t ret = BLK_STS_OK;
+
 	while (!list_empty(list)) {
-		blk_status_t ret;
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq, list_empty(list));
-		if (ret != BLK_STS_OK) {
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				blk_mq_request_bypass_insert(rq,
+		if (ret == BLK_STS_OK)
+			ret = blk_mq_try_issue_directly(hctx, rq, &unused,
+							false,
 							list_empty(list));
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		}
+		else
+			blk_mq_sched_insert_request(rq, false, true, false);
 	}
 
 	/*
@@ -1897,7 +1895,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 	 * the driver there was more coming, but that turned out to
 	 * be a lie.
 	 */
-	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
+	if (ret != BLK_STS_OK && hctx->queue->mq_ops->commit_rqs)
 		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
-- 
2.7.4

