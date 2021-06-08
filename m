Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA3C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 09:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9009961208
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 09:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFHJWv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:22:51 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5291 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHJWu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 05:22:50 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fzl392Zmnz1BJwj;
        Tue,  8 Jun 2021 17:16:05 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 17:20:55 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 17:20:55 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <jack@suse.cz>, <hare@suse.de>,
        <ming.lei@redhat.com>, <damien.lemoal@wdc.com>
Subject: [PATCH] block: check disk exist before trying to add partition
Date:   Tue, 8 Jun 2021 17:27:07 +0800
Message-ID: <20210608092707.1062259-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If disk have been deleted, we should return fail for ioctl
BLKPG_DEL_PARTITION. Otherwise, the directory /sys/class/block
may remain invalid symlinks file. The race as following:

blkdev_open
				del_gendisk
				    disk->flags &= ~GENHD_FL_UP;
				    blk_drop_partitions
blkpg_ioctl
    bdev_add_partition
    add_partition
        device_add
	    device_add_class_symlinks

ioctl may add_partition after del_gendisk() have tried to delete
partitions. Then, symlinks file will be created.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/partitions/core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index dc60ecf46fe6..58662a0f48e4 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -449,17 +449,26 @@ int bdev_add_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length)
 {
 	struct block_device *part;
+	struct gendisk *disk = bdev->bd_disk;
+	int ret;
 
 	mutex_lock(&bdev->bd_mutex);
-	if (partition_overlaps(bdev->bd_disk, start, length, -1)) {
-		mutex_unlock(&bdev->bd_mutex);
-		return -EBUSY;
+	if (!(disk->flags & GENHD_FL_UP)) {
+		ret = -ENXIO;
+		goto out;
 	}
 
-	part = add_partition(bdev->bd_disk, partno, start, length,
+	if (partition_overlaps(disk, start, length, -1)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	part = add_partition(disk, partno, start, length,
 			ADDPART_FLAG_NONE, NULL);
+	ret = PTR_ERR_OR_ZERO(part);
+out:
 	mutex_unlock(&bdev->bd_mutex);
-	return PTR_ERR_OR_ZERO(part);
+	return ret;
 }
 
 int bdev_del_partition(struct block_device *bdev, int partno)
-- 
2.25.4

