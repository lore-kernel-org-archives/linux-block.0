Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED63C43332
	for <linux-block@archiver.kernel.org>; Sat, 26 Dec 2020 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93912221E9
	for <linux-block@archiver.kernel.org>; Sat, 26 Dec 2020 10:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLZK0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Dec 2020 05:26:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10368 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgLZK0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Dec 2020 05:26:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D30LC6RtZz7K5X;
        Sat, 26 Dec 2020 18:24:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Sat, 26 Dec 2020
 18:25:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH 2/3] blk-mq: clear 'active_queues' immediately when 'nr_active' is decreased to 0
Date:   Sat, 26 Dec 2020 18:28:07 +0800
Message-ID: <20201226102808.2534966-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201226102808.2534966-1-yukuai3@huawei.com>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently 'active_queues' is cleared when there is no more IO in 5
secondes. Thus if multiple hardware queues share a tag set, and
some queues occasionally issue small amount of IO, some queues might
can't get enough tags while the utilization rate of total tags is
less than 100% because 'active_queues' is never decreased.

Thus clear 'active_queues' immediately when 'nr_active' is
decreased to 0.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index f7212bacfa56..228c5c442be4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -212,8 +212,10 @@ static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
 {
 	if (blk_mq_is_sbitmap_shared(hctx->flags))
 		atomic_dec(&hctx->queue->nr_active_requests_shared_sbitmap);
-	else if (!atomic_dec_return(&hctx->nr_active))
+	else if (!atomic_dec_return(&hctx->nr_active)) {
+		blk_mq_tag_idle(hctx);
 		blk_mq_dtag_idle(hctx);
+	}
 }
 
 static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
-- 
2.25.4

