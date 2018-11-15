Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5D2C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 03:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6624D214F1
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 03:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UxdrWhL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6624D214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeKONTM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:19:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57012 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKONTM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 08:19:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAF33UPI029147;
        Thu, 15 Nov 2018 03:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Dyl0j++O9hIaxHaZ5CG/bsiuBU1YPsBsz3hJmwajJhM=;
 b=UxdrWhL3tWpoXO/DCrzmMzM8P+vVLP/yIOo45wehuQzhtD660yWo/A5Vlx7ErwCYOA3w
 ggXgLiiEOY+rodfpifhzOOsS7+8XrzvqqqduV1H5on+Q1z6FhGag5HOJG9oaTxvTbjPI
 QpqedXCCfJh5N9krBRITCouyPzJiMJw03QFzjUoxmnVgZJ1W04etYBpLiuaRxE7nM55E
 QxK+1VuakfRhbnW7by1KbQoF5/hjJ97uDxRg7gIjx3+Nm3+aoYb9R7p+Z/Bfg9czzSoi
 V9hCo7Ne97K/Wocsm0fG11Ymc2YrRsVqaQm4JH349uf0D7lz44HIM8DDzjKfDE7shgSH 1Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nr7cs73u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 03:13:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAF3D5Gt030623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 03:13:06 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAF3D51r010373;
        Thu, 15 Nov 2018 03:13:05 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 19:13:05 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 2/3] blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
Date:   Thu, 15 Nov 2018 11:12:37 +0800
Message-Id: <1542251558-10517-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542251558-10517-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542251558-10517-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9077 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811150026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is not necessary to issue request directly with bypass 'true'
in blk_mq_sched_insert_requests and handle the non-issued requests
itself. Just set bypass to 'false' and let blk_mq_try_issue_directly
handle them totally.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c |  8 +++-----
 block/blk-mq.c       | 13 +++----------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 66fda19..9af57c8 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -410,12 +410,10 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
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
index 1b57449..c8566f9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1840,21 +1840,14 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
+	blk_qc_t unused_cookie;
+
 	while (!list_empty(list)) {
-		blk_status_t ret;
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq);
-		if (ret != BLK_STS_OK) {
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				list_add(&rq->queuelist, list);
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		}
+		blk_mq_try_issue_directly(hctx, rq, &unused_cookie, false);
 	}
 }
 
-- 
2.7.4

