Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D7CC04EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 03:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D512146D
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 03:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rm2oZDyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D512146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeLFDd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:33:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54742 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeLFDd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 22:33:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB63SwF7083500;
        Thu, 6 Dec 2018 03:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=3eRURsMXPdx6Rg6huxnDh77FOWwRG0SaaiF99f37WTA=;
 b=Rm2oZDyQyDrig2b+8qMRw+muED6povOsYRthzzTqTknHg84SI1QQT19jcMUx0YPEjzUn
 xFvGbKzlWQBfjk2Nwb2p7ooBBjz3atcOMB+7/eMTVl60Zd+Cy1zlCC6C/LE51ZJbysSJ
 tmE6uKY+F3uPdFM1CAPObFgEMHpdLQJxQ1z5lNDpXMXWRZTGZ4ILcSC7sSIIu9ULXf7N
 9tygzfSVlLmmD6l7NOeSUtYngQG4BwJ/Mb50YebD930tgOJtqEOjTYlrEYqyeSN95Wh5
 62M9jj5BpFvQ9+ttTFM37hpGal3P+LDMAixvBX4DjaYn8Eh9tvPBqL1OB3MRiplz+SHd cQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p3jxrnuwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 03:33:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB63XOEX011913
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 03:33:25 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB63XOpo025471;
        Thu, 6 Dec 2018 03:33:24 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 19:33:24 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 2/4] blk-mq: refactor the code of issue request directly
Date:   Thu,  6 Dec 2018 11:32:38 +0800
Message-Id: <1544067160-20564-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544067160-20564-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1544067160-20564-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060030
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
into one interface to unify the interfaces to issue requests
directly. The merged interface takes over the requests totally,
it could insert, end or do nothing based on the return value of
.queue_rq and 'bypass' parameter. Then caller needn't any other
handling any more and then code could be cleaned up.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 112 ++++++++++++++++++++++++++-------------------------------
 1 file changed, 51 insertions(+), 61 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 01802bf..a1cccdd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1815,92 +1815,82 @@ static bool blk_rq_can_direct_dispatch(struct request *rq)
 	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
 }
 
-static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
-						bool bypass_insert, bool last)
+						bool bypass, bool last)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	blk_status_t ret = BLK_STS_RESOURCE;
+	int srcu_idx;
 	bool force = false;
 
+	if (!blk_rq_can_direct_dispatch(rq)) {
+		/*
+		 * Insert request to hctx dispatch list and return
+		 * BLK_STS_OK for 'bypass == true' case, otherwise,
+		 * the caller will fail forever.
+		 */
+		force = bypass;
+		goto out;
+	}
+
+	hctx_lock(hctx, &srcu_idx);
 	/*
-	 * RCU or SRCU read lock is needed before checking quiesced flag.
+	 * hctx_lock is needed before checking quiesced flag.
 	 *
-	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
-	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
-	 * and avoid driver to try to dispatch again.
+	 * When queue is stopped or quiesced, ignore 'bypass', insert
+	 * and return BLK_STS_OK to caller, and avoid driver to try to
+	 * dispatch again.
 	 */
-	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
+	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q))) {
 		run_queue = false;
-		bypass_insert = false;
-		goto insert;
+		bypass = false;
+		goto out_unlock;
 	}
 
-	if (q->elevator && !bypass_insert)
-		goto insert;
-
-	if (!blk_rq_can_direct_dispatch(rq)) {
-		/*
-		 * For 'bypass_insert == true' case, insert request into hctx
-		 * dispatch list.
-		 */
-		force = bypass_insert;
-		goto insert;
-	}
+	if (unlikely(q->elevator && !bypass))
+		goto out_unlock;
 
 	if (!blk_mq_get_dispatch_budget(hctx))
-		goto insert;
+		goto out_unlock;
 
 	if (!blk_mq_get_driver_tag(rq)) {
 		blk_mq_put_dispatch_budget(hctx);
-		goto insert;
+		goto out_unlock;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie, last);
-insert:
-	if (force) {
-		blk_mq_request_bypass_insert(rq, run_queue);
-		return BLK_STS_OK;
-	} else if (bypass_insert) {
-		return BLK_STS_RESOURCE;
+	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
+out_unlock:
+	hctx_unlock(hctx, srcu_idx);
+out:
+	switch (ret) {
+	case BLK_STS_OK:
+		break;
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_RESOURCE:
+		if (force) {
+			blk_mq_request_bypass_insert(rq, run_queue);
+			ret = BLK_STS_OK;
+		} else if (!bypass) {
+			blk_mq_sched_insert_request(rq, false, run_queue, false);
+		}
+		break;
+	default:
+		if (!bypass)
+			blk_mq_end_request(rq, ret);
+		break;
 	}
 
-	blk_mq_sched_insert_request(rq, false, run_queue, false);
-	return BLK_STS_OK;
-}
-
-static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, blk_qc_t *cookie)
-{
-	blk_status_t ret;
-	int srcu_idx;
-
-	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
-
-	hctx_lock(hctx, &srcu_idx);
-
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		blk_mq_sched_insert_request(rq, false, true, false);
-	else if (ret != BLK_STS_OK)
-		blk_mq_end_request(rq, ret);
-
-	hctx_unlock(hctx, srcu_idx);
+	return ret;
 }
 
 blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
-	blk_status_t ret;
-	int srcu_idx;
-	blk_qc_t unused_cookie;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+	blk_qc_t unused;
 
-	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
-	hctx_unlock(hctx, srcu_idx);
-
-	return ret;
+	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused, true, last);
 }
 
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
@@ -2043,13 +2033,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
-					&cookie);
+					&cookie, false, true);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+		blk_mq_try_issue_directly(data.hctx, rq, &cookie, false, true);
 	} else {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-- 
2.7.4

