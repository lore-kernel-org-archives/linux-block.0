Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97035CBB6
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898943; cv=none; b=KSLq1fxa8zUFRdX2rTZIXIziF7F3YDwqCSceaT8Z/lAFg71jC1t57V0vmtA/GZY7GOkzzsvjplRRcSV7KsrxoJHJjqv0uRrNeGu4wRgVRt0DBSgsH8nks+hjggRYSDaIhZbmbGdbQyAcOgCRznZpYEMCsPcnCwvX2xoh4FYhyjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898943; c=relaxed/simple;
	bh=DkKw8ueN+OWjZps/8Vgmc03IAmvEhQt7v+cIGFE9NgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWKUS1IIGIZjR++AIX1DgIIPOFlO7M7i72dxvyrjgQZPTqL/R03NIJ7k4EdtKPeKNKXcancQB5q9TEa2ez2iJmSfGOQ3aL+m4kXYFDtLGdsUMtd4jAVfzoV0X21vP0gyWu7sd1R5rzpq0y7iLzACST60Jz9C7K6WrXvurekvfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SrLH9l9u; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SrLH9l9u"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d5gfh0HDnzlv4V1;
	Tue, 11 Nov 2025 22:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1762898937; x=1765490938; bh=7FupEGXOw+168+N2eZPhc3GLIQYRdM0KHrR
	dyU9ozdY=; b=SrLH9l9uA7eYkytrFxVZoOTPYDqp0yNKmAMdv8Ct7Uar66hfvzn
	dtMi8WfaCgkIVD0JNyUn2P+7XeeoqqpD//5RZnz1WOSL9CVe/F5pY9OzLWK3+t8J
	gzqdp2oXd1fUgXkif8inXslXMzZcX5VlB1hHOLduk5vi6MU6l9dJVTVPoH3m0xS2
	2duMt0Zal7XGpLnaQ/NLr3atDTsu6ZSJw4uxcTzo5A05U4BaNaa6JRvmNBG+1S2D
	E2uWTMPP4j/7cHLMHMgo81F+J8zdQtWKAQII9wRrmrX5xAF70l98g09fo1vrEEQN
	Eq4wMgF96BkepEVuzea6OIP6zpP8eegX4XA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ozq_qKFuXEMY; Tue, 11 Nov 2025 22:08:57 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d5gfV5FsCzlsxDq;
	Tue, 11 Nov 2025 22:08:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	Zheng Qixing <zhengqixing@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] Revert "null_blk: allow byte aligned memory offsets"
Date: Tue, 11 Nov 2025 14:08:33 -0800
Message-ID: <20251111220838.926321-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This reverts commit 3451cf34f51bb70c24413abb20b423e64486161b and fixes
the following KASAN complaint when running test zbd/013:

BUG: KASAN: slab-use-after-free in null_handle_data_transfer+0x88c/0xe50 =
[null_blk]
Write of size 4096 at addr ffff8881ab162000 by task (udev-worker)/78072

CPU: 8 UID: 0 PID: 78072 Comm: (udev-worker) Not tainted 6.18.0-rc5-dbg #=
14 PREEMPT  737e33391e24fa2fcd9958673f6992b5ee131a07
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
Call Trace:
 <TASK>
 show_stack+0x4d/0x60
 dump_stack_lvl+0x61/0x80
 print_address_description.constprop.0+0x8b/0x310
 print_report+0xfd/0x1d7
 kasan_report+0xde/0x1c0
 kasan_check_range+0x10c/0x1f0
 __asan_memcpy+0x3f/0x70
 null_handle_data_transfer+0x88c/0xe50 [null_blk]
 null_process_cmd+0x1a4/0x370 [null_blk]
 null_process_zoned_cmd+0x1ff/0x3c0 [null_blk]
 null_handle_cmd+0x1bd/0x580 [null_blk]
 null_queue_rq+0x568/0x970 [null_blk]
 null_queue_rqs+0xe5/0x2b0 [null_blk]
 __blk_mq_flush_list+0x83/0xb0
 blk_mq_dispatch_queue_requests+0x3d7/0x660
 blk_mq_flush_plug_list+0x1a1/0x730
 __blk_flush_plug+0x290/0x540
 blk_finish_plug+0x53/0xc0
 read_pages+0x456/0xad0
 page_cache_ra_unbounded+0x3cd/0x6e0
 force_page_cache_ra+0x1f0/0x370
 page_cache_sync_ra+0x158/0x870
 filemap_get_pages+0x327/0xcb0
 filemap_read+0x336/0xd30
 blkdev_read_iter+0x15c/0x430
 vfs_read+0x79a/0x1150
 ksys_read+0xfd/0x230
 __x64_sys_read+0x76/0xc0
 x64_sys_call+0x143c/0x17e0
 do_syscall_64+0x96/0x360
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>

Allocated by task 0 on cpu 0 at 3226.274686s:
 kasan_save_stack+0x2a/0x50
 kasan_save_track+0x1c/0x70
 kasan_save_alloc_info+0x3d/0x50
 __kasan_kmalloc+0xa0/0xb0
 __kmalloc_cache_noprof+0x2e9/0x8a0
 kmem_cache_free+0x590/0x870
 mempool_free_slab+0x1b/0x20
 mempool_free+0xd1/0x9b0
 bio_free+0x15e/0x1c0
 bio_put+0x34f/0x790
 bio_endio+0x31d/0x6c0
 blk_update_request+0x425/0xfb0
 blk_mq_end_request+0x5d/0x370
 null_cmd_timer_expired+0x43/0x60 [null_blk]
 __hrtimer_run_queues+0x53e/0xb40
 hrtimer_interrupt+0x32f/0x850
 __sysvec_apic_timer_interrupt+0xdc/0x360
 sysvec_apic_timer_interrupt+0xa4/0xe0
 asm_sysvec_apic_timer_interrupt+0x1f/0x30

Freed by task 14 on cpu 0 at 3226.398721s:
 kasan_save_stack+0x2a/0x50
 kasan_save_track+0x1c/0x70
 __kasan_save_free_info+0x3f/0x60
 __kasan_slab_free+0x67/0x80
 kfree+0x170/0x780
 slab_free_after_rcu_debug+0x6c/0x250
 rcu_do_batch+0x369/0x13f0
 rcu_core+0x385/0x5a0
 rcu_core_si+0x12/0x20
 handle_softirqs+0x1a3/0x930
 run_ksoftirqd+0x3e/0x60
 smpboot_thread_fn+0x311/0xa00
 kthread+0x3cc/0x830
 ret_from_fork+0x39c/0x500
 ret_from_fork_asm+0x11/0x20

Last potentially related work creation:
 kasan_save_stack+0x2a/0x50
 kasan_record_aux_stack+0xad/0xc0
 __call_rcu_common.constprop.0+0xfb/0xbb0
 call_rcu+0x12/0x20
 kmem_cache_free+0x5bc/0x870
 mempool_free_slab+0x1b/0x20
 mempool_free+0xd1/0x9b0
 bio_free+0x15e/0x1c0
 bio_put+0x34f/0x790
 bio_endio+0x31d/0x6c0
 blk_update_request+0x425/0xfb0
 blk_mq_end_request+0x5d/0x370
 null_cmd_timer_expired+0x43/0x60 [null_blk]
 __hrtimer_run_queues+0x53e/0xb40
 hrtimer_interrupt+0x32f/0x850
 __sysvec_apic_timer_interrupt+0xdc/0x360
 sysvec_apic_timer_interrupt+0xa4/0xe0
 asm_sysvec_apic_timer_interrupt+0x1f/0x30

The buggy address belongs to the object at ffff8881ab162000
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff8881ab162000, ffff8881ab162020)

Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c  | 45 ++++++++++++++++------------------
 drivers/block/null_blk/zoned.c |  2 +-
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index f1e67962ecae..ea3fc4241f82 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1130,27 +1130,25 @@ static int null_make_cache_space(struct nullb *nu=
llb, unsigned long n)
 }
=20
 static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
-				  loff_t pos, size_t n, bool is_fua)
+				  sector_t sector, size_t n, bool is_fua)
 {
 	size_t temp, count =3D 0;
+	unsigned int offset;
 	struct nullb_page *t_page;
-	sector_t sector;
=20
 	while (count < n) {
-		temp =3D min3(nullb->dev->blocksize, n - count,
-			    PAGE_SIZE - offset_in_page(pos));
-		sector =3D pos >> SECTOR_SHIFT;
+		temp =3D min_t(size_t, nullb->dev->blocksize, n - count);
=20
 		if (null_cache_active(nullb) && !is_fua)
 			null_make_cache_space(nullb, PAGE_SIZE);
=20
+		offset =3D (sector & SECTOR_MASK) << SECTOR_SHIFT;
 		t_page =3D null_insert_page(nullb, sector,
 			!null_cache_active(nullb) || is_fua);
 		if (!t_page)
 			return BLK_STS_NOSPC;
=20
-		memcpy_to_page(t_page->page, offset_in_page(pos),
-			       source + count, temp);
+		memcpy_to_page(t_page->page, offset, source + count, temp);
=20
 		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
=20
@@ -1158,33 +1156,33 @@ static blk_status_t copy_to_nullb(struct nullb *n=
ullb, void *source,
 			null_free_sector(nullb, sector, true);
=20
 		count +=3D temp;
-		pos +=3D temp;
+		sector +=3D temp >> SECTOR_SHIFT;
 	}
 	return BLK_STS_OK;
 }
=20
-static void copy_from_nullb(struct nullb *nullb, void *dest, loff_t pos,
+static void copy_from_nullb(struct nullb *nullb, void *dest, sector_t se=
ctor,
 			    size_t n)
 {
 	size_t temp, count =3D 0;
+	unsigned int offset;
 	struct nullb_page *t_page;
-	sector_t sector;
=20
 	while (count < n) {
-		temp =3D min3(nullb->dev->blocksize, n - count,
-			    PAGE_SIZE - offset_in_page(pos));
-		sector =3D pos >> SECTOR_SHIFT;
+		temp =3D min_t(size_t, nullb->dev->blocksize, n - count);
=20
+		offset =3D (sector & SECTOR_MASK) << SECTOR_SHIFT;
 		t_page =3D null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
+
 		if (t_page)
-			memcpy_from_page(dest + count, t_page->page,
-					 offset_in_page(pos), temp);
+			memcpy_from_page(dest + count, t_page->page, offset,
+					 temp);
 		else
 			memset(dest + count, 0, temp);
=20
 		count +=3D temp;
-		pos +=3D temp;
+		sector +=3D temp >> SECTOR_SHIFT;
 	}
 }
=20
@@ -1230,7 +1228,7 @@ static blk_status_t null_handle_flush(struct nullb =
*nullb)
 }
=20
 static blk_status_t null_transfer(struct nullb *nullb, struct page *page=
,
-	unsigned int len, unsigned int off, bool is_write, loff_t pos,
+	unsigned int len, unsigned int off, bool is_write, sector_t sector,
 	bool is_fua)
 {
 	struct nullb_device *dev =3D nullb->dev;
@@ -1242,10 +1240,10 @@ static blk_status_t null_transfer(struct nullb *n=
ullb, struct page *page,
 	if (!is_write) {
 		if (dev->zoned)
 			valid_len =3D null_zone_valid_read_len(nullb,
-				pos >> SECTOR_SHIFT, len);
+				sector, len);
=20
 		if (valid_len) {
-			copy_from_nullb(nullb, p, pos, valid_len);
+			copy_from_nullb(nullb, p, sector, valid_len);
 			off +=3D valid_len;
 			len -=3D valid_len;
 		}
@@ -1255,7 +1253,7 @@ static blk_status_t null_transfer(struct nullb *nul=
lb, struct page *page,
 		flush_dcache_page(page);
 	} else {
 		flush_dcache_page(page);
-		err =3D copy_to_nullb(nullb, p, pos, len, is_fua);
+		err =3D copy_to_nullb(nullb, p, sector, len, is_fua);
 	}
=20
 	kunmap_local(p);
@@ -1273,7 +1271,7 @@ static blk_status_t null_handle_data_transfer(struc=
t nullb_cmd *cmd,
 	struct nullb *nullb =3D cmd->nq->dev->nullb;
 	blk_status_t err =3D BLK_STS_OK;
 	unsigned int len;
-	loff_t pos =3D blk_rq_pos(rq) << SECTOR_SHIFT;
+	sector_t sector =3D blk_rq_pos(rq);
 	unsigned int max_bytes =3D nr_sectors << SECTOR_SHIFT;
 	unsigned int transferred_bytes =3D 0;
 	struct req_iterator iter;
@@ -1285,11 +1283,11 @@ static blk_status_t null_handle_data_transfer(str=
uct nullb_cmd *cmd,
 		if (transferred_bytes + len > max_bytes)
 			len =3D max_bytes - transferred_bytes;
 		err =3D null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(req_op(rq)), pos,
+				     op_is_write(req_op(rq)), sector,
 				     rq->cmd_flags & REQ_FUA);
 		if (err)
 			break;
-		pos +=3D len;
+		sector +=3D len >> SECTOR_SHIFT;
 		transferred_bytes +=3D len;
 		if (transferred_bytes >=3D max_bytes)
 			break;
@@ -1946,7 +1944,6 @@ static int null_add_dev(struct nullb_device *dev)
 		.logical_block_size	=3D dev->blocksize,
 		.physical_block_size	=3D dev->blocksize,
 		.max_hw_sectors		=3D dev->max_sectors,
-		.dma_alignment		=3D 1,
 	};
=20
 	struct nullb *nullb;
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
index dbf292a8eae9..6a93b12a06ff 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -242,7 +242,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 {
 	struct nullb_device *dev =3D nullb->dev;
 	struct nullb_zone *zone =3D &dev->zones[null_zone_no(dev, sector)];
-	unsigned int nr_sectors =3D DIV_ROUND_UP(len, SECTOR_SHIFT);
+	unsigned int nr_sectors =3D len >> SECTOR_SHIFT;
=20
 	/* Read must be below the write pointer position */
 	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL ||
