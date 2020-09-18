Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813DCC43464
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B6D20872
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgIRBrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:47:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13279 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgIRBrd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 21:47:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B53B7317F8675FB75D7;
        Fri, 18 Sep 2020 09:47:31 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 09:47:22 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <yuyufen@huawei.com>
Subject: [PATCH 1/4] block: invoke blk_mq_exit_sched no matter whether have .exit_sched
Date:   Thu, 17 Sep 2020 21:47:03 -0400
Message-ID: <20200918014706.1962485-2-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918014706.1962485-1-yuyufen@huawei.com>
References: <20200918014706.1962485-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We will register debugfs for scheduler no matter whether it have
defined callback funciton .exit_sched. So, blk_mq_exit_sched()
is always needed to unregister debugfs. Also, q->elevator should
be set as NULL after exiting scheduler.

For now, since all register scheduler have defined .exit_sched,
it will not cause any actual problem. But It will be more reasonable
to do this change.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-sysfs.c | 1 -
 block/elevator.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7dda709f3ccb..ee2cd4d1054c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -883,7 +883,6 @@ static void blk_exit_queue(struct request_queue *q)
 	if (q->elevator) {
 		ioc_clear_queue(q);
 		__elevator_exit(q, q->elevator);
-		q->elevator = NULL;
 	}
 
 	/*
diff --git a/block/elevator.c b/block/elevator.c
index 6e775bd4af66..b506895b34c7 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -191,8 +191,7 @@ static void elevator_release(struct kobject *kobj)
 void __elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	mutex_lock(&e->sysfs_lock);
-	if (e->type->ops.exit_sched)
-		blk_mq_exit_sched(q, e);
+	blk_mq_exit_sched(q, e);
 	mutex_unlock(&e->sysfs_lock);
 
 	kobject_put(&e->kobj);
-- 
2.25.4

