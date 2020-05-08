Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6439C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 04:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B30208CA
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 04:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOK6OqHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgEHEod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 00:44:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37687 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbgEHEoc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 00:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588913070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8gNEy7m2O7/4KGfkJAlFm0quuKItdj5MuWr8hU03s8=;
        b=hOK6OqHRJwhmdDsg7wXuwUodGNxVyyaoapm1qskEbFyzMx+fHLUcAoNZSfRatlS/NbJ0QU
        dd3LbOl1E+kE0bQZ2lkVu52fS02y7EhrtSJI5+nlupCawppvaOU7F8SCkWOuAutIla8bM1
        YL5WU55JO8emOWbhUFcmIBlKLcfTVnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-rKDaZwK1Of2fGdge4Ti-0A-1; Fri, 08 May 2020 00:44:28 -0400
X-MC-Unique: rKDaZwK1Of2fGdge4Ti-0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B86F473;
        Fri,  8 May 2020 04:44:27 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A663C5D9CA;
        Fri,  8 May 2020 04:44:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH V2 1/4] block: fix use-after-free on cached last_lookup partition
Date:   Fri,  8 May 2020 12:44:04 +0800
Message-Id: <20200508044407.1371907-2-ming.lei@redhat.com>
In-Reply-To: <20200508044407.1371907-1-ming.lei@redhat.com>
References: <20200508044407.1371907-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

delete_partition() clears the cached last_lookup partition. However the
.last_lookup cache may be overwritten by one IO path after it is cleared
from delete_partition(). Then another IO path may use the cached deleting
partition after hd_struct_free() is called, then use-after-free is triggered
on the cached partition.

Fixes the issue by the following approach:

1) always get the partition's refcount via hd_struct_try_get() before
setting .last_lookup

2) move clearing .last_lookup from delete_partition() to hd_struct_free()
which is the release handle of the partition's percpu-refcount, so that no
IO path can cache deleteing partition via .last_lookup.

It is one candidate approach of Yufen's patch[1] which adds overhead
in fast path by indirect lookup which may introduce one extra cacheline
in IO path. Also this patch relies on percpu-refcount's protection, and
it is easier to understand and verify.

[1] https://lore.kernel.org/linux-block/20200109013551.GB9655@ming.t460p/T/#t

Reported-by: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c        | 12 ------------
 block/genhd.c           | 15 ++++++++++++---
 block/partitions/core.c | 12 +++++++++++-
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ec50d7e6be21..826a8980997d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1363,18 +1363,6 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		part_stat_inc(part, merges[rw]);
 	} else {
 		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
-		if (!hd_struct_try_get(part)) {
-			/*
-			 * The partition is already being removed,
-			 * the request will be accounted on the disk only
-			 *
-			 * We take a reference on disk->part0 although that
-			 * partition will never be deleted, so we can treat
-			 * it as any other partition.
-			 */
-			part = &rq->rq_disk->part0;
-			hd_struct_get(part);
-		}
 		part_inc_in_flight(rq->q, part, rw);
 		rq->part = part;
 	}
diff --git a/block/genhd.c b/block/genhd.c
index c05d509877fa..ec57d5d7a64d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -344,11 +344,12 @@ static inline int sector_in_part(struct hd_struct *part, sector_t sector)
  * primarily used for stats accounting.
  *
  * CONTEXT:
- * RCU read locked.  The returned partition pointer is valid only
- * while preemption is disabled.
+ * RCU read locked.  The returned partition pointer is always valid
+ * because its refcount is grabbed.
  *
  * RETURNS:
  * Found partition on success, part0 is returned if no partition matches
+ * or the matched partition is being deleted.
  */
 struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 {
@@ -359,17 +360,25 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 	ptbl = rcu_dereference(disk->part_tbl);
 
 	part = rcu_dereference(ptbl->last_lookup);
-	if (part && sector_in_part(part, sector))
+	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
 		return part;
 
 	for (i = 1; i < ptbl->len; i++) {
 		part = rcu_dereference(ptbl->part[i]);
 
 		if (part && sector_in_part(part, sector)) {
+			/*
+			 * only live partition can be cached for lookup,
+			 * so use-after-free on cached & deleting partition
+			 * can be avoided
+			 */
+			if (!hd_struct_try_get(part))
+				break;
 			rcu_assign_pointer(ptbl->last_lookup, part);
 			return part;
 		}
 	}
+	hd_struct_get(&disk->part0);
 	return &disk->part0;
 }
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index c085bf85509b..f4000dac23ef 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -288,6 +288,12 @@ static void hd_struct_free_work(struct work_struct *work)
 static void hd_struct_free(struct percpu_ref *ref)
 {
 	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
+	struct gendisk *disk = part_to_disk(part);
+	struct disk_part_tbl *ptbl =
+		rcu_dereference_protected(disk->part_tbl, 1);
+
+	rcu_assign_pointer(ptbl->last_lookup, NULL);
+	put_device(disk_to_dev(disk));
 
 	INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
 	queue_rcu_work(system_wq, &part->rcu_work);
@@ -309,8 +315,12 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
 	struct disk_part_tbl *ptbl =
 		rcu_dereference_protected(disk->part_tbl, 1);
 
+	/*
+	 * ->part_tbl is referenced in this part's release handler, so
+	 *  we have to hold the disk device
+	 */
+	get_device(disk_to_dev(part_to_disk(part)));
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
 
-- 
2.25.2

