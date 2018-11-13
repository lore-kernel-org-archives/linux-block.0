Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292EBC43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 06:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47832245E
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 06:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCN8d7ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47832245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbeKMPqW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730805AbeKMPqV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 10:46:21 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B105622507;
        Tue, 13 Nov 2018 05:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088193;
        bh=XT3u7JQ5fxdfizeCMv6duT7LCiHvaRUtEVjHvZbgKps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCN8d7ysqR1LsM6y+l4wS5VIQW0EziAacaaWKEqVKxPVU+HBpL8V8q+ElsH/MpMhX
         qv/BrmWkA44zvjT+WYaDKfoIvUx8qVVlAENIPqiHm2TEkh8gKS+7BkAdxoYnHmJymm
         7wuvWnv4s2ND5gY5uTyj2V8tCkvWQJB87RT49JJ0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/44] block: brd: associate with queue until adding disk
Date:   Tue, 13 Nov 2018 00:49:12 -0500
Message-Id: <20181113054950.77898-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 153fcd5f6d93b8e1e4040b1337f564a10f8d93af ]

brd_free() may be called in failure path on one brd instance which
disk isn't added yet, so release handler of gendisk may free the
associated request_queue early and causes the following use-after-free[1].

This patch fixes this issue by associating gendisk with request_queue
just before adding disk.

[1] KASAN: use-after-free Read in del_timer_syncNon-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
usbcore: registered new interface driver udl
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x36d9/0x4c20
kernel/locking/lockdep.c:3218
Read of size 8 at addr ffff8801d1b6b540 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x36d9/0x4c20 kernel/locking/lockdep.c:3218
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  del_timer_sync+0xb7/0x270 kernel/time/timer.c:1283
  blk_cleanup_queue+0x413/0x710 block/blk-core.c:809
  brd_free+0x5d/0x71 drivers/block/brd.c:422
  brd_init+0x2eb/0x393 drivers/block/brd.c:518
  do_one_initcall+0x145/0x957 init/main.c:890
  do_initcall_level init/main.c:958 [inline]
  do_initcalls init/main.c:966 [inline]
  do_basic_setup init/main.c:984 [inline]
  kernel_init_freeable+0x5c6/0x6b9 init/main.c:1148
  kernel_init+0x11/0x1ae init/main.c:1068
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350

Reported-by: syzbot+3701447012fe951dabb2@syzkaller.appspotmail.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/brd.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index df8103dd40ac..c18586fccb6f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -396,15 +396,14 @@ static struct brd_device *brd_alloc(int i)
 	disk->first_minor	= i * max_part;
 	disk->fops		= &brd_fops;
 	disk->private_data	= brd;
-	disk->queue		= brd->brd_queue;
 	disk->flags		= GENHD_FL_EXT_DEVT;
 	sprintf(disk->disk_name, "ram%d", i);
 	set_capacity(disk, rd_size * 2);
-	disk->queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
+	brd->brd_queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
 
 	/* Tell the block layer that this is not a rotational device */
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
-	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, brd->brd_queue);
+	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, brd->brd_queue);
 
 	return brd;
 
@@ -436,6 +435,7 @@ static struct brd_device *brd_init_one(int i, bool *new)
 
 	brd = brd_alloc(i);
 	if (brd) {
+		brd->brd_disk->queue = brd->brd_queue;
 		add_disk(brd->brd_disk);
 		list_add_tail(&brd->brd_list, &brd_devices);
 	}
@@ -503,8 +503,14 @@ static int __init brd_init(void)
 
 	/* point of no return */
 
-	list_for_each_entry(brd, &brd_devices, brd_list)
+	list_for_each_entry(brd, &brd_devices, brd_list) {
+		/*
+		 * associate with queue just before adding disk for
+		 * avoiding to mess up failure path
+		 */
+		brd->brd_disk->queue = brd->brd_queue;
 		add_disk(brd->brd_disk);
+	}
 
 	blk_register_region(MKDEV(RAMDISK_MAJOR, 0), 1UL << MINORBITS,
 				  THIS_MODULE, brd_probe, NULL, NULL);
-- 
2.17.1

