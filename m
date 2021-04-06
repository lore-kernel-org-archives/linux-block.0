Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A92C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 12:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D77E613C4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 12:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbhDFMKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 08:10:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15557 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343731AbhDFMKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 08:10:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF5qm1W9BzPnmF;
        Tue,  6 Apr 2021 20:07:16 +0800 (CST)
Received: from mdc.localdomain (10.175.104.57) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 20:09:54 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <huangguobin4@huawei.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <drbd-dev@lists.linbit.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drbd: use DEFINE_SPINLOCK() for spinlock
Date:   Tue, 6 Apr 2021 20:09:48 +0800
Message-ID: <1617710988-49205-1-git-send-email-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guobin Huang <huangguobin4@huawei.com>

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guobin Huang <huangguobin4@huawei.com>
---
 drivers/block/drbd/drbd_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 25cd8a2f729d..d8605159240b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -125,7 +125,7 @@ struct bio_set drbd_io_bio_set;
 	 member of struct page.
  */
 struct page *drbd_pp_pool;
-spinlock_t   drbd_pp_lock;
+DEFINE_SPINLOCK(drbd_pp_lock);
 int          drbd_pp_vacant;
 wait_queue_head_t drbd_pp_wait;
 
@@ -2161,9 +2161,6 @@ static int drbd_create_mempools(void)
 	if (ret)
 		goto Enomem;
 
-	/* drbd's page pool */
-	spin_lock_init(&drbd_pp_lock);
-
 	for (i = 0; i < number; i++) {
 		page = alloc_page(GFP_HIGHUSER);
 		if (!page)

