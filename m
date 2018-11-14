Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D309C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C5722419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 08:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="We5DQDDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C5722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeKNSsd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:48:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38874 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732150AbeKNSsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 13:48:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE8hxOk089052;
        Wed, 14 Nov 2018 08:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=2kpgH3uGPuhpX7ndqfQ+P4DE4uncydkuu2AhXgfQn8w=;
 b=We5DQDDrwKOliVQUrhBJLi01EZy1ipENaEBcby7EB5lRphWT6Z9jxOOjnkliIbeEu3Ln
 cCEXI7+UJoZ3+MxWTakVBDv0ludGLp2qZ1RwH4RfuVsZdHWfLA+06Y9jMqN88bY4+Y+D
 ERI6mNH1CtEYY8lNMFRk1Vdq2FESmuwVEihCqvcMK18KOGgRVWAXq/eM3rgMz7/jflc5
 9orefFxFGYW/SVdIhfy49kTa8MnE9badOJSO+KM5+6vazUTgrYm2TcuXTyrXwc64h1T0
 +h+Gx9voOU8fl+JNZ+afaYva75Y3tHgyzqxwNYoqltEJqSJblhIdr4CfBaHVzn7CpHNB ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nr7cs1vt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 08:46:12 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAE8k6sJ010967
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 08:46:07 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAE8k6Ye011600;
        Wed, 14 Nov 2018 08:46:06 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 00:46:05 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 2/4] blk-mq: fix issue directly case when q is stopped or quiesced
Date:   Wed, 14 Nov 2018 16:45:29 +0800
Message-Id: <1542185131-15029-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140080
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When try to issue request directly, if the queue is stopped or
quiesced, 'bypass' will be ignored and return BLK_STS_OK to caller
to avoid it dispatch request again. Then the request will be
inserted with blk_mq_sched_insert_request. This is not correct
for dm-rq case where we should avoid to pass through the underlying
path's io scheduler.

To fix it, use blk_mq_request_bypass_insert to insert the request
to hctx->dispatch when we cannot pass through io scheduler but have
to insert.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 14b4d06..11c52bb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1772,7 +1772,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						bool bypass)
 {
 	struct request_queue *q = rq->q;
-	bool run_queue = true;
+	bool run_queue = true, force = false;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int srcu_idx;
 
@@ -1786,7 +1786,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q))) {
 		run_queue = false;
-		bypass = false;
+		force = true;
 		goto out_unlock;
 	}
 
@@ -1817,6 +1817,9 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		if (!bypass) {
 			blk_mq_sched_insert_request(rq, false, run_queue, false);
 			ret = BLK_STS_OK;
+		} else if (force) {
+			blk_mq_request_bypass_insert(rq, run_queue);
+			ret = BLK_STS_OK;
 		}
 		break;
 	default:
-- 
2.7.4

