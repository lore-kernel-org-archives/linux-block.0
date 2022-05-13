Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF93DC433FE
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 02:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376491AbiEMCVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 22:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376487AbiEMCVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 22:21:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6033D71DB4;
        Thu, 12 May 2022 19:21:18 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KzsnW00C5zgYdj;
        Fri, 13 May 2022 10:20:46 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:21:16 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 10:21:16 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v2 1/2] block, bfq: protect 'bfqd->queued' by 'bfqd->lock'
Date:   Fri, 13 May 2022 10:35:06 +0800
Message-ID: <20220513023507.2625717-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220513023507.2625717-1-yukuai3@huawei.com>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If bfq_schedule_dispatch() is called from bfq_idle_slice_timer_body(),
then 'bfqd->queued' is read without holding 'bfqd->lock'. This is
wrong since it can be wrote concurrently.

Fix the problem by holding 'bfqd->lock' in such case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 272d48d8f326..61750696e87f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -456,6 +456,8 @@ static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
  */
 void bfq_schedule_dispatch(struct bfq_data *bfqd)
 {
+	lockdep_assert_held(&bfqd->lock);
+
 	if (bfqd->queued != 0) {
 		bfq_log(bfqd, "schedule dispatch");
 		blk_mq_run_hw_queues(bfqd->queue, true);
@@ -6898,8 +6900,8 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_bfqq_expire(bfqd, bfqq, true, reason);
 
 schedule_dispatch:
-	spin_unlock_irqrestore(&bfqd->lock, flags);
 	bfq_schedule_dispatch(bfqd);
+	spin_unlock_irqrestore(&bfqd->lock, flags);
 }
 
 /*
-- 
2.31.1

