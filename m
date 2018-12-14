Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB92C65BAE
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 01:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6284120892
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 01:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hF4TgULc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6284120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeLNB30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:29:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58718 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbeLNB3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 20:29:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBE1P5HR154970;
        Fri, 14 Dec 2018 01:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ZkAALPKmIUWDkl5FMt5OcSZlTrPsZgwQBTR37DpndsU=;
 b=hF4TgULcGl58YMVDC0lt+euN6JP0pA+n2TELT2lz7Sl6GMujclVZoIOTKa1lv7VAQ3fu
 8g/k62cKnTaheootMJTi7Bc4eWiO6Knd0X8CEOM783egGk8ob457XPvUJ+atpOUaOFA9
 KVKVL5up0khcoEnmY3Dqyt/wJC1DcgTM2bvbcIkFBAjGjpWt8RcVJbSt8noXgx1UpxJ1
 l1A+7lKULLJzaoP/rBCRKjr6m0SE24kh2eUXonY8q0PFRTLMXS6ZbQeOcx6j7LyNypxi
 qhHYCSuFOzzEmqY+5rctDQfrMtfPjEkTw/LHa9Vc6OnrxKigLLrJT+v8yte4tmHYF+Pu ow== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pawwpas6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 01:29:21 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBE1TKcN013020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 01:29:21 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBE1TKas013056;
        Fri, 14 Dec 2018 01:29:20 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 17:29:19 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V14 3/3] blk-mq: replace and kill blk_mq_request_issue_directly
Date:   Fri, 14 Dec 2018 09:28:20 +0800
Message-Id: <1544750900-1549-4-git-send-email-jianchao.w.wang@oracle.com>
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

Replace blk_mq_request_issue_directly with blk_mq_try_issue_directly
in blk_insert_cloned_request and kill it as nobody uses it any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c | 4 +++-
 block/blk-mq.c   | 9 +--------
 block/blk-mq.h   | 6 ++++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 268d2b8..fa661ba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1240,6 +1240,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
+	blk_qc_t unused;
+
 	if (blk_cloned_rq_check_limits(q, rq))
 		return BLK_STS_IOERR;
 
@@ -1255,7 +1257,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_request_issue_directly(rq, true);
+	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused, true, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 90361fe..2d3a29e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1792,7 +1792,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
 						bool bypass, bool last)
@@ -1864,13 +1864,6 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
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
index 0c9c9ea..b63a0de 100644
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

