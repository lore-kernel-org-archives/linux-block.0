Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EAAC43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 09:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4F8214F1
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 09:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NOlvZ3P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4F8214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbeKMTy7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:54:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46264 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731853AbeKMTy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 14:54:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAD9sBUH017578;
        Tue, 13 Nov 2018 09:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=cH1NUSTPaeNFjjdGymczsoRVZoo+NNx1HDR8ByXFEBQ=;
 b=NOlvZ3P+k7qbnHJiRXrv7jB1gYZf+/dHgsumRDDtn3R+RF6gNpfyMkBDpgBtB3hNZGsW
 rJk6qNN/t1TtU7hkgYca37m6Yc4WYjLtsFBVrGomlLvdrqf0a9wzZakhFYTSqZdzhYEB
 oQKXLnMtbWiyTdqpJ32/LsFLacT17NI0D3Sg4hXfYLX/dTSLP7To704YAxLPD+K2/H9r
 J4+I6bZAcg/goC3PTtpH6iIGerUYWYnK/ZYgUU2fLa+5ukTH0OvxWVl2p4U9XyyXkJE2
 klVXXPGZHOd+l1OKVezH8DcN/IwwZgTOygEgIAaIqZSntiK02CNKaQE7yxvn/bxu2X96 vQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nnwg19fxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 09:57:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAD9vZ8h013900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 09:57:35 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAD9vZBG025573;
        Tue, 13 Nov 2018 09:57:35 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Nov 2018 01:57:34 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 3/5] blk-mq: ensure hctx to be ran on mapped cpu when issue directly
Date:   Tue, 13 Nov 2018 17:56:54 +0800
Message-Id: <1542103016-21037-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542103016-21037-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542103016-21037-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9075 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=971
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When issue request directly and the task is migrated out of the
original cpu where it allocates request, hctx could be ran on
the cpu where it is not mapped.
To fix this,
 - insert the request forcibly if BLK_MQ_F_BLOCKING is set.
 - check whether the current is mapped to the hctx, if not, insert
   forcibly.
 - invoke __blk_mq_issue_directly under preemption disabled.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 11c52bb..58f15cc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1776,6 +1776,17 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int srcu_idx;
 
+	if (hctx->flags & BLK_MQ_F_BLOCKING) {
+		force = true;
+		goto out;
+	}
+
+	if (unlikely(!cpumask_test_cpu(get_cpu(), hctx->cpumask))) {
+		put_cpu();
+		force = true;
+		goto out;
+	}
+
 	hctx_lock(hctx, &srcu_idx);
 	/*
 	 * hctx_lock is needed before checking quiesced flag.
@@ -1808,7 +1819,8 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
-
+	put_cpu();
+out:
 	switch (ret) {
 	case BLK_STS_OK:
 		break;
-- 
2.7.4

