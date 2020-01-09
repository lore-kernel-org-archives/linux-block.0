Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6CEC32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7541B206ED
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYB6CtW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgAIGVc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:21:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbgAIGVc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jan 2020 01:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578550892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGjxHmFlju7WrnsYJiIRBK64P2R32jVIc38DBQZoWpA=;
        b=eYB6CtW96tEDI0Z6hceYGq7L4Qp2nHjghCncJkpYWeqWUHu355ePkG+E3LqoTKZidzJBGl
        BTRAjwcpS6AwDHnISv+HKSw6KuvLvk1vHYXq8iR4QL/Jw1oPgZUXYsl8BT3b9mzqVj4jx/
        aG6nmAAvOqkufQSiJkcgDWg2S0aBejE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-5mF-0zymPxG-SB3Ndzofvg-1; Thu, 09 Jan 2020 01:21:28 -0500
X-MC-Unique: 5mF-0zymPxG-SB3Ndzofvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67BAF800EBF;
        Thu,  9 Jan 2020 06:21:27 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38CDB5DA60;
        Thu,  9 Jan 2020 06:21:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 1/4] block: fix use-after-free on cached last_lookup partition
Date:   Thu,  9 Jan 2020 14:21:06 +0800
Message-Id: <20200109062109.2313-2-ming.lei@redhat.com>
In-Reply-To: <20200109062109.2313-1-ming.lei@redhat.com>
References: <20200109062109.2313-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

delete_partition() clears the cached last_lookup partition. However
the .last_lookup cache may be overwritten by one IO path after
it is cleared from delete_partition(). Then another IO path may
use the cached deleting partition after __delete_partition() is
called, then use-after-free is triggered on the cached partition.

Fixes the issue by the following approach:

1) always get the partition's refcount via hd_struct_try_get() before
setting .last_lookup

2) move clearing .last_lookup from delete_partition() to
__delete_partition() which is release handle of the partition's
percpu-refcount, so that no IO path can overwrite .last_lookup after it
is cleared in __delete_partition().

It is one candidate approach of Yufen's patch[1] which adds overhead
in fast path by indirect lookup which may introduce one extra cacheline
in IO path. Also this patch relies on percpu-refcount's protection, and
it is easier to understand and verify.

[1] https://lore.kernel.org/linux-block/20200109013551.GB9655@ming.t460p/=
T/#t

Reported-by: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          | 12 ------------
 block/genhd.c             |  6 +++++-
 block/partition-generic.c | 10 +++++++++-
 include/linux/genhd.h     |  1 +
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..79599f5fd5b7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1365,18 +1365,6 @@ void blk_account_io_start(struct request *rq, bool=
 new_io)
 		part_stat_inc(part, merges[rw]);
 	} else {
 		part =3D disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
-		if (!hd_struct_try_get(part)) {
-			/*
-			 * The partition is already being removed,
-			 * the request will be accounted on the disk only
-			 *
-			 * We take a reference on disk->part0 although that
-			 * partition will never be deleted, so we can treat
-			 * it as any other partition.
-			 */
-			part =3D &rq->rq_disk->part0;
-			hd_struct_get(part);
-		}
 		part_inc_in_flight(rq->q, part, rw);
 		rq->part =3D part;
 	}
diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..6029c94510f0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -286,17 +286,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendis=
k *disk, sector_t sector)
 	ptbl =3D rcu_dereference(disk->part_tbl);
=20
 	part =3D rcu_dereference(ptbl->last_lookup);
-	if (part && sector_in_part(part, sector))
+	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
 		return part;
=20
 	for (i =3D 1; i < ptbl->len; i++) {
 		part =3D rcu_dereference(ptbl->part[i]);
=20
 		if (part && sector_in_part(part, sector)) {
+			if (!hd_struct_try_get(part))
+				goto exit;
 			rcu_assign_pointer(ptbl->last_lookup, part);
 			return part;
 		}
 	}
+ exit:
+	hd_struct_get(&disk->part0);
 	return &disk->part0;
 }
 EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 1d20c9cf213f..1739f750dbf2 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -262,6 +262,12 @@ static void delete_partition_work_fn(struct work_str=
uct *work)
 void __delete_partition(struct percpu_ref *ref)
 {
 	struct hd_struct *part =3D container_of(ref, struct hd_struct, ref);
+	struct disk_part_tbl *ptbl =3D
+		rcu_dereference_protected(part->disk->part_tbl, 1);
+
+	rcu_assign_pointer(ptbl->last_lookup, NULL);
+	put_device(disk_to_dev(part->disk));
+
 	INIT_RCU_WORK(&part->rcu_work, delete_partition_work_fn);
 	queue_rcu_work(system_wq, &part->rcu_work);
 }
@@ -283,8 +289,9 @@ void delete_partition(struct gendisk *disk, int partn=
o)
 	if (!part)
 		return;
=20
+	get_device(disk_to_dev(disk));
 	rcu_assign_pointer(ptbl->part[partno], NULL);
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
+
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
=20
@@ -349,6 +356,7 @@ struct hd_struct *add_partition(struct gendisk *disk,=
 int partno,
 	p->nr_sects =3D len;
 	p->partno =3D partno;
 	p->policy =3D get_disk_ro(disk);
+	p->disk =3D disk;
=20
 	if (info) {
 		struct partition_meta_info *pinfo =3D alloc_part_info(disk);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8bb63027e4d6..1b09cfe00aa3 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -130,6 +130,7 @@ struct hd_struct {
 	struct disk_stats dkstats;
 #endif
 	struct percpu_ref ref;
+	struct gendisk *disk;
 	struct rcu_work rcu_work;
 };
=20
--=20
2.20.1

