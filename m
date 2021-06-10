Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402DC48BCF
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 02:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1210360FE4
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 02:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhFJC2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 22:28:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3818 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJC2p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 22:28:45 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0nmM3WKczWtlC;
        Thu, 10 Jun 2021 10:21:55 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 10:26:43 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 10:26:43 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Yufen Yu <yuyufen@huawei.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] block: check disk exist before trying to add partition
Date:   Thu, 10 Jun 2021 10:32:41 +0800
Message-ID: <20210610023241.3646241-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/partitions/core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 186d4fbd9f09..b123ccb2cf64 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -454,17 +454,26 @@ int bdev_add_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length)
 {
 	struct block_device *part;
+	struct gendisk *disk = bdev->bd_disk;
+	int ret;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	if (partition_overlaps(bdev->bd_disk, start, length, -1)) {
-		mutex_unlock(&bdev->bd_disk->open_mutex);
-		return -EBUSY;
+	mutex_lock(&disk->open_mutex);
+	if (!(disk->flags & GENHD_FL_UP)) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+	if (partition_overlaps(disk, start, length, -1)) {
+		ret = -EBUSY;
+		goto out;
 	}
 
-	part = add_partition(bdev->bd_disk, partno, start, length,
+	part = add_partition(disk, partno, start, length,
 			ADDPART_FLAG_NONE, NULL);
-	mutex_unlock(&bdev->bd_disk->open_mutex);
-	return PTR_ERR_OR_ZERO(part);
+	ret = PTR_ERR_OR_ZERO(part);
+out:
+	mutex_unlock(&disk->open_mutex);
+	return ret;
 }
 
 int bdev_del_partition(struct block_device *bdev, int partno)
-- 
2.25.4

