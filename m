Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7899CC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 03:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7D122360
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 03:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LqjIa1t+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7D122360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeKONTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:19:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47962 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKONTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 08:19:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAF33OHe182234;
        Thu, 15 Nov 2018 03:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ABo4P82kL2uWLscpPI3EimEyXdJFt0UOuAC6MlPy9HU=;
 b=LqjIa1t+4pWSqytJ6ikkJGCAWvpfbeQHq5goHlQlVLNNYnUmqgVddaFL1AX+Hy43sAO0
 bzFT/Rf4vzs9VrH+FqaaGHycSxVtjCbIn+35aHUfoeZCfVKNr5nnGpGzQBhS36IhfGdx
 bsdEdbBBkrzN5VeCNvtjgGIh9hfusViuzKBFHA/wGloBGsulciYyfRU1QcMx+J3QCxiZ
 wPkbkkfFUz0bYS66jKthjxyIl9QNLJe88WThzlXDFBLWnwLfzZlmZKmeXrG92Nl4K9Ma
 MjowWOTsi3XqI20mzdxKSX0qqN10ZZzALKfBfnGf4xiqid1UA5E00nOqoISc0JRBaHQM +g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nr7cs730f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 03:13:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAF3D3eS002518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 03:13:04 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAF3D3x3005684;
        Thu, 15 Nov 2018 03:13:03 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 19:13:03 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 1/3] blk-mq: refactor the code of issue request directly
Date:   Thu, 15 Nov 2018 11:12:36 +0800
Message-Id: <1542251558-10517-2-git-send-email-jianchao.w.wang@oracle.com>
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

Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
into one interface to unify the interfaces to issue requests
directly. The merged interface takes over the requests totally,
it could insert, end or do nothing based on the return value of
.queue_rq and 'bypass' parameter. Then caller needn't any other
handling any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 89 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 411be60..1b57449 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1766,78 +1766,75 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
-						bool bypass_insert)
+						bool bypass)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	blk_status_t ret = BLK_STS_RESOURCE;
+	int srcu_idx;
 
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
+	/*
+	 * Bypass the potential scheduler on the bottom device.
+	 */
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
 
-	return __blk_mq_issue_directly(hctx, rq, cookie);
-insert:
-	if (bypass_insert)
-		return BLK_STS_RESOURCE;
-
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
+	ret = __blk_mq_issue_directly(hctx, rq, cookie);
 
-	hctx_lock(hctx, &srcu_idx);
+out_unlock:
+	hctx_unlock(hctx, srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		blk_mq_sched_insert_request(rq, false, true, false);
-	else if (ret != BLK_STS_OK)
-		blk_mq_end_request(rq, ret);
+	switch (ret) {
+	case BLK_STS_OK:
+		break;
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_RESOURCE:
+		if (!bypass) {
+			blk_mq_sched_insert_request(rq, false, run_queue, false);
+			ret = BLK_STS_OK;
+		}
+		break;
+	default:
+		if (!bypass) {
+			blk_mq_end_request(rq, ret);
+			ret = BLK_STS_OK;
+		}
+		break;
+	}
 
-	hctx_unlock(hctx, srcu_idx);
+	return ret;
 }
 
 blk_status_t blk_mq_request_issue_directly(struct request *rq)
 {
-	blk_status_t ret;
-	int srcu_idx;
 	blk_qc_t unused_cookie;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
-	hctx_unlock(hctx, srcu_idx);
-
-	return ret;
+	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused_cookie, true);
 }
 
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
@@ -1958,13 +1955,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
-					&cookie);
+					&cookie, false);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+		blk_mq_try_issue_directly(data.hctx, rq, &cookie, false);
 	} else {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-- 
2.7.4

