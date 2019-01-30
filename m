Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE610C282D5
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 09:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1DF20870
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 09:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SlvlyFid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfA3JDO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:03:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52248 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfA3JDN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 04:03:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0U8wf66153750;
        Wed, 30 Jan 2019 09:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=qyn410wvLlaCQXa4w+QoXzv2LmM8/MQC4WXbMeQGAow=;
 b=SlvlyFid0eAmvM9Yj9WzMrhOw3qSlZn6MGf3uBnmo9/X0TbDtugZNYGqBpoEpVNR8R/K
 B13LavqI/XWA3+nKcMjPl8Q4nEq/+qQM4VP/mDBUEYtBqnYwOLTZe63KuMi0eB1ylmZU
 nFL9tcja13DI5UzwMsVpnuvK0Qh8a5DCp/o98gtbmt5nPBW0A87LB/uOMICShiGkg8wk
 rZxmXbh5MvkSyfIvJNhjKDTBlHVKudYZka76HBVkl3cp6vVxbn4KdxK7XnnH2D+QmJON
 88tuV4mAJ0bYwmCnjxLCTjul4Df7u495KO+RMAaXD4BY16Zs7d5NjGyaWGqTnX2B7qTB yQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q8d2e9eb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 09:03:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0U937rJ002034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 09:03:07 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0U936PM000575;
        Wed, 30 Jan 2019 09:03:07 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jan 2019 01:03:06 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     m19@florianstecker.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: fix a hung issue when fsync
Date:   Wed, 30 Jan 2019 17:01:56 +0800
Message-Id: <1548838916-25051-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9151 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901300072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Florian reported a io hung issue when fsync(). It should be
triggered by following race condition.

data + post flush         a flush

blk_flush_complete_seq
  case REQ_FSEQ_DATA
    blk_flush_queue_rq
    issued to driver      blk_mq_dispatch_rq_list
                            try to issue a flush req
                            failed due to NON-NCQ command
                            .queue_rq return BLK_STS_DEV_RESOURCE

request completion
  req->end_io // doesn't check RESTART
  mq_flush_data_end_io
    case REQ_FSEQ_POSTFLUSH
      blk_kick_flush
        do nothing because previous flush
        has not been completed
     blk_mq_run_hw_queue
                              insert rq to hctx->dispatch
                              due to RESTART is still set, do nothing

To fix this, replace the blk_mq_run_hw_queue in mq_flush_data_end_io
with blk_mq_sched_restart to check and clear the RESTART flag.

Fixes: bd166ef1 (blk-mq-sched: add framework for MQ capable IO schedulers)
Reported-by: Florian Stecker <m19@florianstecker.de>
Tested-by: Florian Stecker <m19@florianstecker.de>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index a3fc7191..6e0f2d9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -335,7 +335,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
-	blk_mq_run_hw_queue(hctx, true);
+	blk_mq_sched_restart(hctx);
 }
 
 /**
-- 
2.7.4

