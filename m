Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5EFC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 03:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D898D2146D
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 03:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XC/LmE6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D898D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeLFDde (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:33:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54800 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeLFDdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 22:33:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB63SZZI083183;
        Thu, 6 Dec 2018 03:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=S3+/7CXRFbPTfIbccA8dMMcAQ3GGP2dz6DsxuSvojyM=;
 b=XC/LmE6hGgtbitlP4xXVTwm9f0KBRlEJnQ1XYNa3vuPtg+bM0BGUSyYFzMl3O3rlia8f
 7GYC7rNrk2kwI8tFT7IXUsyLOb3/vO2UBA2Msu7zFgmc8lsuiu/UG3iOPAmtVCP8fSZg
 lgY36jjXKCoonImA6rjg05t56wukQ7wNvx5i1KO4Ay3dqFMIT+mzaI7yAfjCtI2jknAS
 HPRZJMXCr1IP90GdwPMCT2Iv7PFBp4UjoZdlqpsbPmpAjjJfFkh345hcnc2N4QL5X+Db
 MIvCJAbjhl7H8EuttfBP5CWXQJkNt0lisaUcF/OpxFJcXrxeH2sRfN2Rg0cT84cIoFVG bg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxrnuxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 03:33:29 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB63XNi2028522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 03:33:23 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB63XNYE014438;
        Thu, 6 Dec 2018 03:33:23 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 19:33:22 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 1/4] blk-mq: insert to hctx dispatch list when bypass_insert is true
Date:   Thu,  6 Dec 2018 11:32:37 +0800
Message-Id: <1544067160-20564-2-git-send-email-jianchao.w.wang@oracle.com>
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

We don't allow direct dispatch of anything but regular reads/writes
and insert all of non-read-write requests. However, this is not
correct for 'bypass_insert == true' case where inserting is ignored
and BLK_STS_RESOURCE is returned. The caller will fail forever.

Fix it with inserting the non-read-write request to hctx dispatch
list to avoid to involve merge and io scheduler when bypass_insert
is true.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9005505..01802bf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1822,6 +1822,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	bool force = false;
 
 	/*
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
@@ -1836,9 +1837,18 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	if (!blk_rq_can_direct_dispatch(rq) || (q->elevator && !bypass_insert))
+	if (q->elevator && !bypass_insert)
 		goto insert;
 
+	if (!blk_rq_can_direct_dispatch(rq)) {
+		/*
+		 * For 'bypass_insert == true' case, insert request into hctx
+		 * dispatch list.
+		 */
+		force = bypass_insert;
+		goto insert;
+	}
+
 	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
 
@@ -1849,8 +1859,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	return __blk_mq_issue_directly(hctx, rq, cookie, last);
 insert:
-	if (bypass_insert)
+	if (force) {
+		blk_mq_request_bypass_insert(rq, run_queue);
+		return BLK_STS_OK;
+	} else if (bypass_insert) {
 		return BLK_STS_RESOURCE;
+	}
 
 	blk_mq_sched_insert_request(rq, false, run_queue, false);
 	return BLK_STS_OK;
-- 
2.7.4

