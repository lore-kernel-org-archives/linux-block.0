Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA7C10F14
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 02:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47702171F
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 02:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDSCmR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:42:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbfDSCmR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 22:42:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 47CC5B07EA66E39F44C1;
        Fri, 19 Apr 2019 10:27:04 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Apr 2019
 10:27:00 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>
Subject: [PATCH] block: kill all_q_node in request_queue
Date:   Fri, 19 Apr 2019 10:31:27 +0800
Message-ID: <20190419023127.71085-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

all_q_node has not been used since commit 4b855ad37194 ("blk-mq: Create
hctx for each present CPU"), so remove it.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/blkdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5c58a3b2bf00..317ab30d2904 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -548,7 +548,6 @@ struct request_queue {
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
 	struct percpu_ref	q_usage_counter;
-	struct list_head	all_q_node;
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
-- 
2.16.2.dirty

