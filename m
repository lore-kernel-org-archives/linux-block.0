Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7508C04FDF
	for <linux-block@archiver.kernel.org>; Wed, 16 Aug 2023 13:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbjHPNHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Aug 2023 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245417AbjHPNHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2023 09:07:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C30426BA
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 06:07:30 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQpJy0g4czVjN2;
        Wed, 16 Aug 2023 21:05:22 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 21:07:27 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <axboe@kernel.dk>, <yuehaibing@huawei.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH -next] blk-stat: Remove unused declaration blk_stats_alloc_enable()
Date:   Wed, 16 Aug 2023 21:07:15 +0800
Message-ID: <20230816130715.38484-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 54bdd67d0f88 ("blk-mq: remove hybrid polling")
removed blk_stats_alloc_enable() but not its declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 block/blk-stat.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17e1eb4ec7e2..5d7f18ba436d 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -64,7 +64,6 @@ struct blk_stat_callback {
 
 struct blk_queue_stats *blk_alloc_queue_stats(void);
 void blk_free_queue_stats(struct blk_queue_stats *);
-bool blk_stats_alloc_enable(struct request_queue *q);
 
 void blk_stat_add(struct request *rq, u64 now);
 
-- 
2.34.1

