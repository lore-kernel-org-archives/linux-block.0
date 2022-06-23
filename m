Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA00EC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiFWH2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiFWH2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:28:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9D3DE9E;
        Thu, 23 Jun 2022 00:28:08 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LTBfX27Q1zDqqY;
        Thu, 23 Jun 2022 15:27:32 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 15:28:06 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 15:28:06 +0800
From:   Li Nan <linan122@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linan122@huawei.com>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v4] block: remove WARN_ON() from bd_link_disk_holder
Date:   Thu, 23 Jun 2022 15:41:00 +0800
Message-ID: <20220623074100.2251301-1-linan122@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 83cbce957446("block: add error handling for device_add_disk /
add_disk"), bdev->bd_holder_dir can not be empty now, so remove WARN_ON()
from bd_link_disk_holder.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/holder.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index 8d750281a1cd..5283bc804cc1 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -79,10 +79,6 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 
 	WARN_ON_ONCE(!bdev->bd_holder);
 
-	/* FIXME: remove the following once add_disk() handles errors */
-	if (WARN_ON(!bdev->bd_holder_dir))
-		goto out_unlock;
-
 	holder = bd_find_holder_disk(bdev, disk);
 	if (holder) {
 		holder->refcnt++;
-- 
2.31.1

