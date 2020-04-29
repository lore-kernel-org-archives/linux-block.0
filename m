Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C5C83007
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 02:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27BA2073E
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 02:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgD2CEj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:04:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgD2CEi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 22:04:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A0CCEB55BE340ACF03EF;
        Wed, 29 Apr 2020 10:04:36 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 10:04:28 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] blk-mq: Use BUG_ON() instead of BUG()
Date:   Wed, 29 Apr 2020 10:10:24 +0800
Message-ID: <1588126224-47877-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes coccicheck warning:

 block/blk-mq.c:546:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.

Fixes: 63151a449eba ("blk-mq: allow drivers to hook into I/O completion")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bcc3a23..49a227e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -542,8 +542,7 @@ EXPORT_SYMBOL(__blk_mq_end_request);
 
 void blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	if (blk_update_request(rq, error, blk_rq_bytes(rq)))
-		BUG();
+	BUG_ON(blk_update_request(rq, error, blk_rq_bytes(rq)));
 	__blk_mq_end_request(rq, error);
 }
 EXPORT_SYMBOL(blk_mq_end_request);
-- 
2.6.2

