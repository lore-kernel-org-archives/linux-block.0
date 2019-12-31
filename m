Return-Path: <SRS0=i4wP=2V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94971C2D0C2
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 11:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626CC206DA
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 11:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLaLKl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Dec 2019 06:10:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbfLaLKl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Dec 2019 06:10:41 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 300A23335ECE8D610C89;
        Tue, 31 Dec 2019 19:10:38 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 31 Dec 2019
 19:10:29 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <zhengchuan@huawei.com>, <houtao1@huawei.com>,
        <yi.zhang@huawei.com>, <yuyufen@huawei.com>
Subject: [PATCH] block: make sure last_lookup set as NULL after part deleted
Date:   Tue, 31 Dec 2019 19:09:45 +0800
Message-ID: <20191231110945.10857-1-yuyufen@huawei.com>
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
deleted. Although the delete_partition() try to set last_lookup
as NULL, req1 can overwrite it as 'part[4]' again.

After calling call_rcu() and free() for the part, req2 can
get the part by last_lookup, resulting in use after free.

In fact, this bug has been reported by syzbot:
    https://lkml.org/lkml/2019/1/4/357

We fix the bug by rereading ptbl->part[i] after setting
last_lookup. If part[i] is NULL, that means the part will
be freed, we need to clear last_lookup.

Then we can make sure last_lookup have been set as NULL
before call_rcu(). Thus, others can not get the freed part.

Fixes: a6f23657d307 ("block: add one-hit cache for disk partition lookup")
Reported-by: Zheng Chuan <zhengchuan@huawei.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/genhd.c             | 16 ++++++++++++++++
 block/partition-generic.c |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..39fa8999905f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -293,7 +293,23 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 		part = rcu_dereference(ptbl->part[i]);
 
 		if (part && sector_in_part(part, sector)) {
+			/*
+			 * After delete_partition() trying to delete this
+			 * part and setting last_lookup as 'NULL', we can
+			 * overwrite it here. Then, others may use the freed
+			 * part by reading last_lookup.
+			 *
+			 * To avoiding the use-after-free, we reread the
+			 * value of ptbl->part[i] here. If it has been set
+			 * as 'NULL', that means the part will be freed.
+			 * And we need to clear last_lookup also.
+			 */
 			rcu_assign_pointer(ptbl->last_lookup, part);
+			part = rcu_dereference(ptbl->part[i]);
+			if (part == NULL) {
+				rcu_assign_pointer(ptbl->last_lookup, NULL);
+				break;
+			}
 			return part;
 		}
 	}
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 1d20c9cf213f..1e0065ed6f02 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -284,6 +284,13 @@ void delete_partition(struct gendisk *disk, int partno)
 		return;
 
 	rcu_assign_pointer(ptbl->part[partno], NULL);
+	/*
+	 * Without the memory barrier, disk_map_sector_rcu()
+	 * may read the old value after overwriting the
+	 * last_lookup. Then it can not clear last_lookup,
+	 * which may cause use-after-free.
+	 */
+	smp_mb();
 	rcu_assign_pointer(ptbl->last_lookup, NULL);
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
-- 
2.17.2

