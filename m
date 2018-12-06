Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D9C65BB0
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 03:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B42146D
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 03:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FQItv/ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4B42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeLFDde (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:33:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbeLFDdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 22:33:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB63TU1g122110;
        Thu, 6 Dec 2018 03:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=SlOJgCvNv5RqgSs7l0Idob7JgiMnH+xdhY46sVdUhwo=;
 b=FQItv/ko8Ev09diWIqXXEJIBq79i2DFPyx5du2RmL/+02SCpkDv324z9VHa6R2N2494W
 hllgyqkTIXell9kekznZaJ/w/nb1JJmIIchHAI97MTFqj4dREidNNH/kBiHZXWt4RL6x
 dT4/I3a7Mwx3/bql6zgfsJZMMWxLeV7crIjDHU5/x+dWNamVz3fBTX3FcJWteZwwgsJx
 wseeLqt7fj4feQCxen68emNxRzmr5FEPV6nlm85HDT1f09DOIdpGsSAkHDIow8yyshkd
 RlNkHDSVlvlDhgqv6qI2lRK6fpAuPUWttFVd/uxajB7zy7KqqA62xVwVg3yyd7P8ePBU WA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p3hqu5yyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 03:33:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB63XStm028728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 03:33:28 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB63XSYQ017269;
        Thu, 6 Dec 2018 03:33:28 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 19:33:28 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 4/4] blk-mq: replace and kill blk_mq_request_issue_directly
Date:   Thu,  6 Dec 2018 11:32:40 +0800
Message-Id: <1544067160-20564-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544067160-20564-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1544067160-20564-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060030
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
index dd07fe1..3ae5095 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1815,7 +1815,7 @@ static bool blk_rq_can_direct_dispatch(struct request *rq)
 	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
 }
 
-static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
 						bool bypass, bool last)
@@ -1886,13 +1886,6 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
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

