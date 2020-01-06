Return-Path: <SRS0=PDkS=23=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169AC32771
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 07:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5C42072C
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 07:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgAFHgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:36:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50990 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbgAFHgM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Jan 2020 02:36:12 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 49B5DC237A51AB415BD6;
        Mon,  6 Jan 2020 15:36:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 Jan 2020
 15:35:58 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>,
        <houtao1@huawei.com>, <hch@lst.de>, <yi.zhang@huawei.com>,
        <zhengchuan@huawei.com>
Subject: [PATCH] block: cache index instead of part self to avoid use-after-free
Date:   Mon, 6 Jan 2020 15:35:10 +0800
Message-ID: <20200106073510.10825-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When delete partition executes concurrently with IOs issue,
it may cause use-after-free on part in disk_map_sector_rcu()
as following:

blk_account_io_start(req1)  delete_partition  blk_account_io_start(req2)

rcu_read_lock()
disk_map_sector_rcu
part = rcu_dereference(ptbl->part[4])
                           rcu_assign_pointer(ptbl->part[4], NULL);
                           rcu_assign_pointer(ptbl->last_lookup, NULL);
rcu_assign_pointer(ptbl->last_lookup, part);

                           hd_struct_kill(part)
!hd_struct_try_get
  part = &rq->rq_disk->part0;
rcu_read_unlock()
                           __delete_partition
                           call_rcu
                                            rcu_read_lock
                                            disk_map_sector_rcu
                                            part = rcu_dereference(ptbl->last_lookup);

                           delete_partition_work_fn
                           free(part)
                                            hd_struct_try_get(part)
                                            BUG_ON use-after-free

req1 try to get 'ptbl->part[4]', while the part is beening
deleted. Although the delete_partition() will set last_lookup
as NULL, req1 can overwrite it as 'part[4]' again.

After calling call_rcu() and free() for the part, req2 can
access the part by last_lookup, resulting in use after free.

In fact, this bug has been reported by syzbot:
    https://lkml.org/lkml/2019/1/4/357

To fix the bug, we try to cache index of part[] instead of
part[i] itself in last_lookup. Even if the index may been
re-assign, others can either get part[i] as value of NULL,
or get the new allocated part[i] after call_rcu. Both of
them is okay.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/genhd.c             | 15 +++++++++------
 block/partition-generic.c |  2 +-
 include/linux/genhd.h     |  3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..97447281a4f5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -282,18 +282,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 	struct disk_part_tbl *ptbl;
 	struct hd_struct *part;
 	int i;
+	int last_lookup;
 
 	ptbl = rcu_dereference(disk->part_tbl);
-
-	part = rcu_dereference(ptbl->last_lookup);
-	if (part && sector_in_part(part, sector))
-		return part;
+	last_lookup = READ_ONCE(ptbl->last_lookup);
+	if (last_lookup > 0 && last_lookup < ptbl->len) {
+		part = rcu_dereference(ptbl->part[last_lookup]);
+		if (part && sector_in_part(part, sector))
+			return part;
+	}
 
 	for (i = 1; i < ptbl->len; i++) {
 		part = rcu_dereference(ptbl->part[i]);
 
 		if (part && sector_in_part(part, sector)) {
-			rcu_assign_pointer(ptbl->last_lookup, part);
+			WRITE_ONCE(ptbl->last_lookup, i);
 			return part;
 		}
 	}
@@ -1263,7 +1266,7 @@ static void disk_replace_part_tbl(struct gendisk *disk,
 	rcu_assign_pointer(disk->part_tbl, new_ptbl);
 
 	if (old_ptbl) {
-		rcu_assign_pointer(old_ptbl->last_lookup, NULL);
+		WRITE_ONCE(old_ptbl->last_lookup, 0);
 		kfree_rcu(old_ptbl, rcu_head);
 	}
 }
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 1d20c9cf213f..a9fd24ae3acb 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -284,7 +284,7 @@ void delete_partition(struct gendisk *disk, int partno)
 		return;
 
 	rcu_assign_pointer(ptbl->part[partno], NULL);
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
+	WRITE_ONCE(ptbl->last_lookup, 0);
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8bb63027e4d6..9be4fb8f8b8b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -160,7 +160,8 @@ enum {
 struct disk_part_tbl {
 	struct rcu_head rcu_head;
 	int len;
-	struct hd_struct __rcu *last_lookup;
+	/* Cache last lookup part[] index */
+	int last_lookup;
 	struct hd_struct __rcu *part[];
 };
 
-- 
2.17.2

