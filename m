Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEBEC43466
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F134220872
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIRBre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:47:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbgIRBrd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 21:47:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60180F3F6DBA07D70061;
        Fri, 18 Sep 2020 09:47:31 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 09:47:23 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <yuyufen@huawei.com>
Subject: [PATCH 2/4] block: use common interface blk_queue_registered()
Date:   Thu, 17 Sep 2020 21:47:04 -0400
Message-ID: <20200918014706.1962485-3-yuyufen@huawei.com>
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

We have defined common interface blk_queue_registered() to
test QUEUE_FLAG_REGISTERED. Just use it.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-iocost.c | 2 +-
 block/elevator.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d37b55db2409..073624f54bc9 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -618,7 +618,7 @@ static struct ioc *q_to_ioc(struct request_queue *q)
 
 static const char *q_name(struct request_queue *q)
 {
-	if (test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+	if (test_bit(blk_queue_registered(q)))
 		return kobject_name(q->kobj.parent);
 	else
 		return "<unknown>";
diff --git a/block/elevator.c b/block/elevator.c
index b506895b34c7..431a2a1c896e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -672,7 +672,7 @@ void elevator_init_mq(struct request_queue *q)
 	if (!elv_support_iosched(q))
 		return;
 
-	WARN_ON_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags));
+	WARN_ON_ONCE(blk_queue_registered(q));
 
 	if (unlikely(q->elevator))
 		return;
-- 
2.25.4

