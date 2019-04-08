Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63226C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 11:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBA820863
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 11:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xekls8G3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDHLJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:09:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45974 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHLJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 07:09:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38B8TGP106534;
        Mon, 8 Apr 2019 11:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=M7Wxt78UTN+oTd8w+SBxTUtGiYywnP/iYxEtMz+6d20=;
 b=xekls8G3i/gWvFru3g2m//gVHbIKsL6kEH5hmfQwJZpfNLYfAuiRZHEWYJD41g2uc4Cp
 y9ACKwwCoUWt9qNpm2k2DJH85PyEXyGRnJqfAQNSjq8xzysmsz1RZOFbRd264H8ro59y
 MQvA21Qmf7J3PHBuNoGGYE6Pwb+3lgt277xpx3z6JY2bIlmJX9/o69MuFSXpaa2pcPzv
 JkHkB9mnHCXV38IE4XqawHH5sS9Gzfz2Me9toxO2KuYrtEsYaDkF0ZLmyQO4WN8TOnnE
 DPdIn6orBIXK1uyLnjn+ICjs1lppA/KbZioXqkA+2H9Snrhe4gQ3VcRng/DxG3JVg0yt dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rphme5rhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 11:09:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38B8Oih067557;
        Mon, 8 Apr 2019 11:09:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2rph7rxhbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 11:09:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x38B8xaG008731;
        Mon, 8 Apr 2019 11:09:00 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 04:08:59 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] blk-mq: do not splice ctx->rq_lists[type] to hctx->dispatch if ctx is not mapped to hctx
Date:   Mon,  8 Apr 2019 19:12:53 +0800
Message-Id: <1554721973-32456-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=914
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080098
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=934 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080098
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a cpu is offline, blk_mq_hctx_notify_dead() is called once for each
hctx for the offline cpu.

While blk_mq_hctx_notify_dead() is used to splice all ctx->rq_lists[type]
to hctx->dispatch, it never checks whether the ctx is already mapped to the
hctx.

For example, on a VM (with nvme) of 4 cpu, to offline cpu 2 out of the
4 cpu (0-3), blk_mq_hctx_notify_dead() is called once for each io queue
hctx:

1st: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 3
2nd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 2
3rd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 1
4th: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 0

Although blk_mq_ctx->cpu = 2 is only mapped to blk_mq_hw_ctx->queue_num = 2
in this case, its ctx->rq_lists[type] will however be moved to
blk_mq_hw_ctx->queue_num = 3 during the 1st call of
blk_mq_hctx_notify_dead().

This patch would return and go ahead to next call of
blk_mq_hctx_notify_dead() if ctx is not mapped to hctx.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a935483..9612746 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2219,6 +2219,10 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	enum hctx_type type;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
+
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 	type = hctx->type;
 
-- 
2.7.4

