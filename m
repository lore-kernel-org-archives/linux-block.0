Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E6EC433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 07:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25DE610CF
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 07:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhDBHdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 03:33:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15529 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhDBHdT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 03:33:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBWtN37pHzNsDn;
        Fri,  2 Apr 2021 15:30:36 +0800 (CST)
Received: from huawei.com (10.67.174.166) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 15:33:10 +0800
From:   Zucheng Zheng <zhengzucheng@huawei.com>
To:     <justin@coraid.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hucool.lihua@huawei.com>
Subject: [PATCH -next] driver: aoe: use DEFINE_SPINLOCK() for spinlock
Date:   Fri, 2 Apr 2021 15:33:11 +0800
Message-ID: <20210402073311.74558-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.166]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
---
 drivers/block/aoe/aoenet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..46cce83c155d 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -47,7 +47,7 @@ static int __init aoe_iflist_setup(char *str)
 __setup("aoe_iflist=", aoe_iflist_setup);
 #endif
 
-static spinlock_t txlock;
+static DEFINE_SPINLOCK(txlock);
 static struct sk_buff_head skbtxq;
 
 /* enters with txlock held */
@@ -201,7 +201,6 @@ aoenet_init(void)
 {
 	skb_queue_head_init(&skbtxq);
 	init_waitqueue_head(&txwq);
-	spin_lock_init(&txlock);
 	kts.lock = &txlock;
 	kts.fn = tx;
 	kts.waitq = &txwq;
-- 
2.17.1

