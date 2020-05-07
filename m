Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B952BC38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955FA2073A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/G1sPjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgEGIxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 04:53:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20241 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGIxB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 04:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588841579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpA0pdi0rYGUd0QecsXouuj41dAKhFaGvzGLf3JXxQ0=;
        b=V/G1sPjSn/dzKmTht28IxDcI5tl88Ywu6uKpPsqHQb/Rbdv8IqfL25HUg1YePde7M0+6He
        eEhpIUIghEiIxD3UBjaTktCd55soKseN1k1BKuwO7+0fDeD6mq5WMqqfkVMvYaWBZp5SR+
        U/48wW62qJLMOcNCdvU8b4S1GNMVLpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-IupDrj-dPP2WbFctXVsxOw-1; Thu, 07 May 2020 04:52:56 -0400
X-MC-Unique: IupDrj-dPP2WbFctXVsxOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD6841895A29;
        Thu,  7 May 2020 08:52:54 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 075C21FBCD;
        Thu,  7 May 2020 08:52:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 1/4] block: fix use-after-free on cached last_lookup partition
Date:   Thu,  7 May 2020 16:52:36 +0800
Message-Id: <20200507085239.1354854-2-ming.lei@redhat.com>
In-Reply-To: <20200507085239.1354854-1-ming.lei@redhat.com>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

delete_partition() clears the cached last_lookup partition. However the
.last_lookup cache may be overwritten by one IO path after it is cleared
from delete_partition(). Then another IO path may use the cached deleting
partition after hd_struct_free() is called, then use-after-free is trigge=
red
on the cached partition.

Fixes the issue by the following approach:

1) always get the partition's refcount via hd_struct_try_get() before
setting .last_lookup

2) move clearing .last_lookup from delete_partition() to hd_struct_free()
which is the release handle of the partition's percpu-refcount, so that n=
o
IO path can overwrite .last_lookup after it is cleared in hd_struct_free(=
).

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
 block/blk-core.c        | 12 ------------
 block/genhd.c           |  6 +++++-
 block/partitions/core.c | 12 +++++++++++-
 include/linux/genhd.h   |  1 +
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ec50d7e6be21..826a8980997d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1363,18 +1363,6 @@ void blk_account_io_start(struct request *rq, bool=
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
index c05d509877fa..8b33f0e54356 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -359,17 +359,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendis=
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
=20
diff --git a/block/partitions/core.c b/block/partitions/core.c
index c085bf85509b..b6cbc9b98426 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -288,6 +288,11 @@ static void hd_struct_free_work(struct work_struct *=
work)
 static void hd_struct_free(struct percpu_ref *ref)
 {
 	struct hd_struct *part =3D container_of(ref, struct hd_struct, ref);
+	struct disk_part_tbl *ptbl =3D
+		rcu_dereference_protected(part->disk->part_tbl, 1);
+
+	rcu_assign_pointer(ptbl->last_lookup, NULL);
+	put_device(disk_to_dev(part->disk));
=20
 	INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
 	queue_rcu_work(system_wq, &part->rcu_work);
@@ -309,8 +314,12 @@ void delete_partition(struct gendisk *disk, struct h=
d_struct *part)
 	struct disk_part_tbl *ptbl =3D
 		rcu_dereference_protected(disk->part_tbl, 1);
=20
+	/*
+	 * make sure disk won't be gone because ->part_tbl is referenced in
+	 * this part's release handler
+	 */
+	get_device(disk_to_dev(disk));
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
=20
@@ -393,6 +402,7 @@ static struct hd_struct *add_partition(struct gendisk=
 *disk, int partno,
 	p->nr_sects =3D len;
 	p->partno =3D partno;
 	p->policy =3D get_disk_ro(disk);
+	p->disk =3D disk;
=20
 	if (info) {
 		struct partition_meta_info *pinfo;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f9c226f9546a..c28d1d9bfa72 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -85,6 +85,7 @@ struct hd_struct {
 	struct disk_stats dkstats;
 #endif
 	struct percpu_ref ref;
+	struct gendisk *disk;
 	struct rcu_work rcu_work;
 };
=20
--=20
2.25.2

