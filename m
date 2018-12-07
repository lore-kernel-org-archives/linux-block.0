Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B6C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C3520838
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2CavLLGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C3520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeLGDKl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:10:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51182 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeLGDKk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:10:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB72x7Xc018748;
        Fri, 7 Dec 2018 03:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=OeMPcaxDTjTZYrQXzZRWlHK02ZDBV0lCZIhqry/BzG0=;
 b=2CavLLGlQ/w1kn0veZGRzZcIT1tqld+PAPkf0uV5UmjA3PJKnUxt9ZRmhGvIhpY1unSM
 SmXjFADt9lKEz34aW9hI914JHfobzWk7l1eA8kI4RJU++Lm3lGT1VviUhojxWVXMxyOS
 s5DP1AumrHhSOGr6ByU1kC0Nq2V+CU9weKMMpp99poqWCoVMADXlIHTSLaCLXSzzb1YI
 /6Wre9T+jNAA64XdVBnQCq2Xdb+KVkcEcTLywduXw1gq/RVEzh/Zhfic4bguNa6Znwmd
 ZAeJPgWBzLAwExsngOFJViyXTVxEAVNCVTDRjKVXlB02Im5FiI85dcqKyRyz5JOnyBIy 7g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqubkc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 03:10:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB73AVdo014748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 03:10:31 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB73AV29028318;
        Fri, 7 Dec 2018 03:10:31 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 19:10:30 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V11 4/4] blk-mq: replace and kill blk_mq_request_issue_directly
Date:   Fri,  7 Dec 2018 11:09:45 +0800
Message-Id: <1544152185-32667-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070024
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
index 3265e30..32102d0 100644
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
@@ -1894,13 +1894,6 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
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

