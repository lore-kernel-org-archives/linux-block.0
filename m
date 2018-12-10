Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35825C65BAF
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F2420831
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ObHHtwSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F2420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeLJCox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:44:53 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41832 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeLJCox (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 21:44:53 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBA2iX7B117171;
        Mon, 10 Dec 2018 02:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=1I4WU5pAJIPO2B5WsvKbH7U8W/PZ6adMl6UTg+hWGIE=;
 b=ObHHtwSAJqY62nThH3dX/e6HtvD1zybQzZWEBzydy1vX2z7PZ0YwhSQrKz9AcYgFLtb8
 0aNa0FhibEYZw6bGpkjECicw/ns6xqV3fru4Z2YGsqrBLc0cyUv1SY0RpwoUUqKRXCO8
 SVKtSFe6K2gmLpHVWZUqTv/h902m08F7XEaCp2TwlK1R79+/NvVssjSSmek/qrmnblVD
 L5+66YwzdY8OxsaF2i/BZBPyTd0T07uDNxJ57nnHxmQAZpaRp1N2uemAvm1lRbjZ56So
 GXfj9sVStMCt8zhRYF9+iWEbdIn59LYbCnaPJgXmV3EJCNk13O7dl9qhf49BjVp/dgNV yQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p83fdukg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 02:44:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBA2im4E021939
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 02:44:48 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBA2imml007566;
        Mon, 10 Dec 2018 02:44:48 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Dec 2018 18:44:47 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V12 1/3] blk-mq: refactor the code of issue request directly
Date:   Mon, 10 Dec 2018 10:44:07 +0800
Message-Id: <1544409849-20119-2-git-send-email-jianchao.w.wang@oracle.com>
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

Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
into one interface to unify the interfaces to issue requests
directly. The merged interface takes over the requests totally,
it could insert, end or do nothing based on the return value of
.queue_rq and 'bypass' parameter. Then caller needn't any other
handling any more and then code could be cleaned up.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 104 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 49 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b645275..261ff6d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1794,78 +1794,84 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
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
+	bool force = false;
 
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
-	if (bypass_insert)
-		return BLK_STS_RESOURCE;
-
-	blk_mq_request_bypass_insert(rq, run_queue);
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
-		blk_mq_request_bypass_insert(rq, true);
-	else if (ret != BLK_STS_OK)
-		blk_mq_end_request(rq, ret);
-
+	/*
+	 * Always add a request that has been through
+	 *.queue_rq() to the hardware dispatch list.
+	 */
+	force = true;
+	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
+out_unlock:
 	hctx_unlock(hctx, srcu_idx);
+out:
+	switch (ret) {
+	case BLK_STS_OK:
+		break;
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_RESOURCE:
+		if (force) {
+			blk_mq_request_bypass_insert(rq, run_queue);
+			/*
+			 * We have to return BLK_STS_OK for the DM
+			 * to avoid livelock. Otherwise, we return
+			 * the real result to indicate whether the
+			 * request is direct-issued successfully.
+			 */
+			ret = bypass ? BLK_STS_OK : ret;
+		} else if (!bypass) {
+			blk_mq_sched_insert_request(rq, false,
+						    run_queue, false);
+		}
+		break;
+	default:
+		if (!bypass)
+			blk_mq_end_request(rq, ret);
+		break;
+	}
+
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
@@ -2006,13 +2012,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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

