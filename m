Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C3C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 05:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE99207D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 05:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGBF0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:26:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgGBF0o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 01:26:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 32875F289A79CC233160;
        Thu,  2 Jul 2020 13:26:30 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 13:26:21 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        "Ming Lei" <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH -next v2] block: remove unused but set variable 'hctx'
Date:   Thu, 2 Jul 2020 13:36:35 +0800
Message-ID: <20200702053635.29386-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After commit 37f4a24c2469 ("blk-mq: centralise related handling
into blk_mq_get_driver_tag"), 'hctx' is never be used. Gcc report
build warning:

block/blk-flush.c:222:24: warning:
 variable hctx set but not used [-Wunused-but-set-variable]
  222 |  struct blk_mq_hw_ctx *hctx;
      |                        ^~~~

Just removing it to avoid build warning.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
v1 -> v2: fix signed-off-by
---
 block/blk-flush.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e756db088d84..a20fe125e9fa 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -219,7 +219,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	struct request *rq, *n;
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
-	struct blk_mq_hw_ctx *hctx;
 
 	blk_account_io_flush(flush_rq);
 
@@ -235,7 +234,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	if (fq->rq_status != BLK_STS_OK)
 		error = fq->rq_status;
 
-	hctx = flush_rq->mq_hctx;
 	if (!q->elevator)
 		flush_rq->tag = BLK_MQ_NO_TAG;
 	else

