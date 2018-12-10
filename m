Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC3C65BAF
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1437A20831
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nXs9uQqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1437A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeLJCpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:45:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43220 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeLJCo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 21:44:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBA2ilVE123052;
        Mon, 10 Dec 2018 02:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Y/wNLVYRK/vWP9oK5Z3z6IPNYMA+z91hLaruyqLYaQY=;
 b=nXs9uQquECRzqfDZLcVlCmdQaxBeKkzew2DjCzTzsU7OLNO4Rc3suFg7gHY7BFbQru/L
 Ac8degj8TZTKmp0q7DnAbjrPrYDXVcEvZp7d8JXJz0LTL1IkvScu4JtrxZoHK05SVzTt
 oDg5P+dj15T3kK/RkC0gn+hYuI9P+nvP6jWOvkfkOmAbdKplVg7xFj1eIOgXfA1WqBg4
 WC4CEl9nfMNcDM0NZbeOBy8f0mZN8pe0R8HPECqOErzOvFadz/hxmu4MElDPBr9LRR7o
 9aAXxGLsnkX/slreImsbpt4EC/ooOim4wxceEEk24XGAv19VnBYv+W37cGzekrSdOix9 Kg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p86kqkcmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 02:44:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBA2iolw021955
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 02:44:50 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBA2io5Y014353;
        Mon, 10 Dec 2018 02:44:50 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Dec 2018 18:44:49 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V12 2/3] blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
Date:   Mon, 10 Dec 2018 10:44:08 +0800
Message-Id: <1544409849-20119-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544409849-20119-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1544409849-20119-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9102 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100024
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
index 261ff6d..c663102 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1877,22 +1877,20 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
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
@@ -1900,7 +1898,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 	 * the driver there was more coming, but that turned out to
 	 * be a lie.
 	 */
-	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
+	if (ret != BLK_STS_OK && hctx->queue->mq_ops->commit_rqs)
 		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
-- 
2.7.4

