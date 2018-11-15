Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76479C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 03:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4209E22360
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 03:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l0/jv6Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4209E22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeKONTN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:19:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57044 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbeKONTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 08:19:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAF33bdv029175;
        Thu, 15 Nov 2018 03:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=KPEW6HJUrRwZXKxQp8ySIYcv2IxnTWWm2WMVjBbn/38=;
 b=l0/jv6KwrcYvO8rZAr9SuEiDCPNIm680PQZCd8jAJU4a42Qc6hnBo+DF+LAHhHm+2wig
 xG/J6S67lhLmPpAZhjnrZtW6uNj+nC0poVKmQ3blTU39RCd6m0wQzevqfRIKUlKk775w
 qhnmsBwiGO7No7AiaVTjtH1zdGuaxVyECeD/NvqaXEpdk4LeTE66hcdaQvCUMFpiSwYp
 IMzBC1Vvorz452CAi7RMnFdzO2+w4BqfmUD0ItETyN0VjxW182Bw6QywwRIOkn7+U9ty
 EcStbVEbp9gGXJ3Wx5ClLif3Jp314RGx0i1+YfytiT5oYr2sdmYdLHySLRCILamUIaJ/ uA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nr7cs73u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 03:13:08 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAF3D7Bc000464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 03:13:07 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAF3D7Hl021530;
        Thu, 15 Nov 2018 03:13:07 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 19:13:06 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 3/3] blk-mq: replace and kill blk_mq_request_issue_directly
Date:   Thu, 15 Nov 2018 11:12:38 +0800
Message-Id: <1542251558-10517-4-git-send-email-jianchao.w.wang@oracle.com>
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

Replace blk_mq_request_issue_directly with blk_mq_try_issue_directly
in blk_insert_cloned_request and kill it as nobody uses it any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c | 4 +++-
 block/blk-mq.c   | 9 +--------
 block/blk-mq.h   | 7 ++++---
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdc0ad2..e4eedc7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1421,6 +1421,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
+	blk_qc_t unused_cookie;
+
 	if (blk_cloned_rq_check_limits(q, rq))
 		return BLK_STS_IOERR;
 
@@ -1436,7 +1438,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_request_issue_directly(rq);
+	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused_cookie, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c8566f9..784ca6b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1766,7 +1766,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
 						bool bypass)
@@ -1830,13 +1830,6 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-blk_status_t blk_mq_request_issue_directly(struct request *rq)
-{
-	blk_qc_t unused_cookie;
-
-	return blk_mq_try_issue_directly(rq->mq_hctx, rq, &unused_cookie, true);
-}
-
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index facb6e9..f18c27c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -61,9 +61,10 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 void blk_mq_request_bypass_insert(struct request *rq, bool run_queue);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
-
-/* Used by blk_insert_cloned_request() to issue request directly */
-blk_status_t blk_mq_request_issue_directly(struct request *rq);
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+						struct request *rq,
+						blk_qc_t *cookie,
+						bool bypass);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
 
-- 
2.7.4

