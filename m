Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E80C433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 11:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DFC6186A
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 11:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhEKLd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 07:33:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2631 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhEKLd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 07:33:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfbLl3s1DzldBn;
        Tue, 11 May 2021 19:30:07 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Tue, 11 May 2021
 19:32:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <justin@coraid.com>, <axboe@kernel.dk>
Subject: [PATCH -next] aoe: remove unnecessary mutex_init()
Date:   Tue, 11 May 2021 19:34:40 +0800
Message-ID: <20210511113440.3772053-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The mutex ktio_spawn_lock is initialized statically.
It is unnecessary to initialize by mutex_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/block/aoe/aoecmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index ecd77897a761..588889bea7c3 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1701,8 +1701,6 @@ aoecmd_init(void)
 		goto ktiowq_fail;
 	}
 
-	mutex_init(&ktio_spawn_lock);
-
 	for (i = 0; i < ncpus; i++) {
 		INIT_LIST_HEAD(&iocq[i].head);
 		spin_lock_init(&iocq[i].lock);
-- 
2.25.1

