Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0732CC04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C128220868
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t5HQJMfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C128220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLGDKd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:10:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeLGDKd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:10:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB72x5TN177303;
        Fri, 7 Dec 2018 03:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=1HrGOB7n42joPy8UiZcuIER2fmv6qujifgn9jg+k/0w=;
 b=t5HQJMfMEfE8jKO91qHin+Shf5zRBmRLsvCJhcUZBm8H3W4b/7VHoSLvKDRALlYThr5u
 YqY7HjiIF2W51M7Atdg6tV3oQMnukVVXhv5F2wTx3PMo98vL/7ka/zHgSs/WdG03QQXx
 S/VFH5hhymfocIrDxT7kiLrwl90o0QFLGvpMU6pjcK6Idb7dE9KIyZniG5H/YxCI++5M
 3gF6qaLdAQd0uVKLoQvTZVsdVL/0tviaEtte1IcbzxVv0EurMBe6DvMvoItFZqNQkjjX
 dMeIlshLVsTByWJ7zJYj0KJ1IJeQz+fNKqLkHy8wWsQvCcjQG0jbN5HdyyPzNBVz9/UA ZA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p3jxrufqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 03:10:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB73ATf8019723
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 03:10:29 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB73ATlR028311;
        Fri, 7 Dec 2018 03:10:29 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 19:10:28 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V11 3/4] blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
Date:   Fri,  7 Dec 2018 11:09:44 +0800
Message-Id: <1544152185-32667-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070024
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
 block/blk-mq.c       | 29 ++++++++++-------------------
 2 files changed, 13 insertions(+), 24 deletions(-)

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
index 88ee447..3265e30 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1904,32 +1904,23 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
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
 
-		if (!blk_rq_can_direct_dispatch(rq))
-			break;
-
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq, list_empty(list));
-		if (ret != BLK_STS_OK) {
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				list_add(&rq->queuelist, list);
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		}
+		if (ret == BLK_STS_OK)
+			ret = blk_mq_try_issue_directly(hctx, rq, &unused,
+							false,
+							list_empty(list));
+		else
+			blk_mq_sched_insert_request(rq, false, true, false);
 	}
 
-	/*
-	 * If we didn't flush the entire list, we could have told
-	 * the driver there was more coming, but that turned out to
-	 * be a lie.
-	 */
-	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
+	if (ret != BLK_STS_OK && hctx->queue->mq_ops->commit_rqs)
 		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
-- 
2.7.4

