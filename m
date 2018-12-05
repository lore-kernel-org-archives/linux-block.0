Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43121C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 07:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21A22082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 07:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JG4JBfwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21A22082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeLEHoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:44:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 02:44:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB57i48q129835;
        Wed, 5 Dec 2018 07:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=B2zNxyNngGK6JzHyyb7FVpzffaYVgPFHJVpgTzXKJBc=;
 b=JG4JBfwN7u0lw5RuFiI8zYp6y1xK7j59W6eGoq4nSdoQv7N1M1xCBPbduBmSuTtoiroY
 /MutwyjE+hof4KvkXlHhNmsfjmOWbz76ds7whKltF2dEqb3EP8ls5xlVjmKuatfr1ErN
 WZ83t0JwbDlJd3LGBlGgsMvtSt9JewreEl1/O74PBt6lUxmCfQ+EyuhEp19cbqI7k5e6
 1Tz1Mj8Vy5x6AVYfO4Iri7MMQa08m5jD1d08Cvn//m7IbYpvX45axKYr+6vNyUCMZrW9
 gLJeRDJ3QxQF/OXyVzJN7c/QbDeFy+HZsRLMdhF/UsEmlZwFEUM3N5Rm4xMWpjGGLEzQ YQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxrgpvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 07:44:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB57ifUb002756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 07:44:41 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB57ifi4025491;
        Wed, 5 Dec 2018 07:44:41 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 23:44:40 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 1/4] blk-mq: insert to hctx dispatch list when bypass_insert is true
Date:   Wed,  5 Dec 2018 15:43:59 +0800
Message-Id: <1543995842-20704-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050072
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
 block/blk-mq.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9005505..153af90 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1822,6 +1822,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	bool force = false;
 
 	/*
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
@@ -1836,9 +1837,19 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
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
+		if (bypass_insert)
+			force = true;
+		goto insert;
+	}
+
 	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
 
@@ -1849,8 +1860,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
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

