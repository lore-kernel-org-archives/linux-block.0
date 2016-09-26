Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:35098
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932234AbcIZDbG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Sep 2016 23:31:06 -0400
To: Jens Axboe <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH] genhd: Handle part_tbl and part pointers correctly
Message-ID: <d9d01f81-40c6-8824-9c84-b042fb6428ae@sandisk.com>
Date: Sun, 25 Sep 2016 19:56:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch ensures that sparse does not complain about disk->part_tbl
manipulations nor about part_tbl->part accesses.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 block/genhd.c             | 7 ++++---
 block/partition-generic.c | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index fcd6d4f..a54c8ce 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1072,7 +1072,7 @@ static const struct attribute_group *disk_attr_groups[] = {
 static void disk_replace_part_tbl(struct gendisk *disk,
 				  struct disk_part_tbl *new_ptbl)
 {
-	struct disk_part_tbl *old_ptbl = disk->part_tbl;
+	struct disk_part_tbl *old_ptbl = rcu_dereference(disk->part_tbl);
 
 	rcu_assign_pointer(disk->part_tbl, new_ptbl);
 
@@ -1098,7 +1098,7 @@ static void disk_replace_part_tbl(struct gendisk *disk,
  */
 int disk_expand_part_tbl(struct gendisk *disk, int partno)
 {
-	struct disk_part_tbl *old_ptbl = disk->part_tbl;
+	struct disk_part_tbl *old_ptbl = rcu_dereference(disk->part_tbl);
 	struct disk_part_tbl *new_ptbl;
 	int len = old_ptbl ? old_ptbl->len : 0;
 	int i, target;
@@ -1303,7 +1303,8 @@ struct gendisk *alloc_disk_node(int minors, int node_id)
 			kfree(disk);
 			return NULL;
 		}
-		disk->part_tbl->part[0] = &disk->part0;
+		rcu_assign_pointer(rcu_dereference(disk->part_tbl)->part[0],
+				   &disk->part0);
 
 		/*
 		 * set_capacity() and get_capacity() currently don't use
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 71d9ed9..df38027 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -252,13 +252,13 @@ void __delete_partition(struct percpu_ref *ref)
 
 void delete_partition(struct gendisk *disk, int partno)
 {
-	struct disk_part_tbl *ptbl = disk->part_tbl;
+	struct disk_part_tbl *ptbl = rcu_dereference(disk->part_tbl);
 	struct hd_struct *part;
 
 	if (partno >= ptbl->len)
 		return;
 
-	part = ptbl->part[partno];
+	part = rcu_dereference(ptbl->part[partno]);
 	if (!part)
 		return;
 
@@ -293,7 +293,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	err = disk_expand_part_tbl(disk, partno);
 	if (err)
 		return ERR_PTR(err);
-	ptbl = disk->part_tbl;
+	ptbl = rcu_dereference(disk->part_tbl);
 
 	if (ptbl->part[partno])
 		return ERR_PTR(-EBUSY);
-- 
2.10.0

