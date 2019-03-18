Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263CDC10F00
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA45C20863
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCROCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:02:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbfCROCt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:02:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CB0D035276FDAB61C688;
        Mon, 18 Mar 2019 22:02:47 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Mar 2019
 22:02:45 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <tj@kernel.org>, <hch@lst.de>
Subject: [PATCH 1/2] block: remove devt from ext_devt_idr when delete partition
Date:   Mon, 18 Mar 2019 22:07:02 +0800
Message-ID: <20190318140703.28963-2-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20190318140703.28963-1-yuyufen@huawei.com>
References: <20190318140703.28963-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In part_release(), it will remove devt from ext_devt_idr and
get_gendisk cannot find it. But, if disk_release() works before
part_release, open device partition may cause use-after-free of
disk in get_gendisk(). We use md device as example, the race sence:

Process1	Worker			Process2
md_free
					blkdev_open
del_gendisk
  add delete_partition_work_fn() to wq
  					__blkdev_get
					get_gendisk
put_disk
  disk_release
    kfree(disk)
    					find part from ext_devt_idr
					get_disk_and_module(disk)
    					  cause use after free

    		delete_partition_work_fn
		put_device(part)
    		  part_release
		    remove part from ext_devt_idr

Before Woker thread removes part from ext_devt_idr, Process2 can find
the part and access the disk, resulting use-after-free.

We fix this by removing the devt from ext_devt_idr when delete partition.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/partition-generic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 1ee3e1d1bc2a..30d1039d5e8d 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -288,6 +288,11 @@ void delete_partition(struct gendisk *disk, int partno)
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
 
+	/*
+	 * We should ensuere to delete part from idr before kfree(disk),
+	 * avoiding use-after-free of disk.
+	 */
+	blk_free_devt(part_devt(part));
 	hd_struct_kill(part);
 }
 
-- 
2.16.2.dirty

