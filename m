Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C9C6FA86
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 11:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiIVLZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiIVLZQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 07:25:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B81A8322;
        Thu, 22 Sep 2022 04:25:15 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYCYW5MzYzpVL9;
        Thu, 22 Sep 2022 19:22:23 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:25:13 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:25:12 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 3/5] block, bfq: don't disable wbt if CONFIG_BFQ_GROUP_IOSCHED is disabled
Date:   Thu, 22 Sep 2022 19:35:56 +0800
Message-ID: <20220922113558.1085314-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922113558.1085314-1-yukuai3@huawei.com>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

wbt and bfq should work just fine if CONFIG_BFQ_GROUP_IOSCHED is disabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..fec52968fe07 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7037,6 +7037,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
+	wbt_enable_default(bfqd->queue);
 #else
 	spin_lock_irq(&bfqd->lock);
 	bfq_put_async_queues(bfqd, bfqd->root_group);
@@ -7045,7 +7046,6 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
-	wbt_enable_default(bfqd->queue);
 
 	kfree(bfqd);
 }
@@ -7190,7 +7190,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	wbt_disable_default(q);
+#endif
 	blk_stat_enable_accounting(q);
 
 	return 0;
-- 
2.31.1

