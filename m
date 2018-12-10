Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB83C07E85
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BEB20831
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 02:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xzP+cXoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BEB20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeLJCpA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:45:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43154 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLJCo4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 21:44:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBA2icT1123026;
        Mon, 10 Dec 2018 02:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=co+DNOKrAHoGP78VqdAJrNFZO1YCtSYT/ngCJnBQ+g8=;
 b=xzP+cXoNE4iPW3ALR4uUR6RNrk7cT7VUNXP7UJoPYgqk4cB6fHGZnxOSXYJIUhYych6R
 kQJz9pE2J60h+XCE3BghJd48gEIGzVEsEfOSWmUHRbR9jn1szn/CyyO7f5DqOl1BCvdJ
 OCC3DrdpCqvoR7eCzib1Pyol8G1QS8hP1ZU1zFkwc9EqfN78fxAk+wA3Jay0KSrhZhGE
 2+z14T/f6Lv8aHXUc7Zehq89Zx6FRHWpBsEOiLENtN8AGh2kFhjF/kTL2ZA+rLi8jCgf
 BH807x9qXFHL579lsjqs1RMJvcDRuGWJ8pENHeH25IWtrmX8xa5goHLI0RZGmsePgmOa dQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p86kqkcme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 02:44:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBA2iqxH004229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 02:44:52 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBA2ipJW018187;
        Mon, 10 Dec 2018 02:44:52 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Dec 2018 18:44:51 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V12 3/3] blk-mq: replace and kill blk_mq_request_issue_directly
Date:   Mon, 10 Dec 2018 10:44:09 +0800
Message-Id: <1544409849-20119-4-git-send-email-jianchao.w.wang@oracle.com>
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

Replace blk_mq_request_issue_directly with blk_mq_try_issue_directly
in blk_insert_cloned_request and kill it as nobody uses it any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c | 4 +++-
 block/blk-mq.c   | 9 +--------
 block/blk-mq.h   | 6 ++++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ad59102..c92d866 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1297,6 +1297,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
+	blk_qc_t unused;
+
 	if (blk_cloned_rq_check_limits(q, rq))
 		return BLK_STS_IOERR;
 
@@ -1312,7 +1314,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_request_issue_directly(rq, true);
+	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused, true, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c663102..999e811 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1794,7 +1794,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
 						bool bypass, bool last)
@@ -1867,13 +1867,6 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
-{
-	blk_qc_t unused;
-
-	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused, true, last);
-}
-
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a664ea4..b81e619 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -68,8 +68,10 @@ void blk_mq_request_bypass_insert(struct request *rq, bool run_queue);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 
-/* Used by blk_insert_cloned_request() to issue request directly */
-blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+						struct request *rq,
+						blk_qc_t *cookie,
+						bool bypass, bool last);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
 
-- 
2.7.4

