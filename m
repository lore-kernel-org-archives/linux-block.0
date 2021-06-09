Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649DFC48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B706136D
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhFIM3q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:29:46 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5356 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhFIM3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 08:29:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0R9N2DQBz6tlt;
        Wed,  9 Jun 2021 20:23:52 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:27:44 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:27:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] z2ram: remove unnecessary oom message
Date:   Wed, 9 Jun 2021 20:27:39 +0800
Message-ID: <20210609122739.14151-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/z2ram.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index c1d20818e649..dce119f697a7 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -236,11 +236,8 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
 
 			case Z2MINOR_Z2ONLY:
 				z2ram_map = kmalloc(max_z2_map, GFP_KERNEL);
-				if (z2ram_map == NULL) {
-					printk(KERN_ERR DEVICE_NAME
-					       ": cannot get mem for z2ram_map\n");
+				if (!z2ram_map)
 					goto err_out;
-				}
 
 				get_z2ram();
 
@@ -253,11 +250,8 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
 
 			case Z2MINOR_CHIPONLY:
 				z2ram_map = kmalloc(max_chip_map, GFP_KERNEL);
-				if (z2ram_map == NULL) {
-					printk(KERN_ERR DEVICE_NAME
-					       ": cannot get mem for z2ram_map\n");
+				if (!z2ram_map)
 					goto err_out;
-				}
 
 				get_chipram();
 
-- 
2.25.1


