Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44705C282C0
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B61B21872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAXARC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:17:02 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42822 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfAXARC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 19:17:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TIsrxct_1548289019;
Received: from localhost(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TIsrxct_1548289019)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jan 2019 08:16:59 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 3/3] blk-mq: remove duplicated definition of blk_mq_freeze_queue
Date:   Thu, 24 Jan 2019 08:16:55 +0800
Message-Id: <20190124001655.92508-4-bo.liu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
In-Reply-To: <20190124001655.92508-1-bo.liu@linux.alibaba.com>
References: <20190124001655.92508-1-bo.liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As the prototype has been defined in "include/linux/blk-mq.h", the one
in "block/blk-mq.h" can be removed then.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-mq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index d943d46b0785..d0b3dd54ef8d 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -36,7 +36,6 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
-void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_free_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
-- 
2.20.1.2.gb21ebb6

