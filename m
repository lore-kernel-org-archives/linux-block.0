Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ED0C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 03:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354C52080D
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 03:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ECgIELVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLJDBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:01:54 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:8171 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLJDBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 22:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575946913; x=1607482913;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=9FikzcEIKro6g9Y4AA6EZXnXzUOSF+Qic1B8e6GSfpE=;
  b=ECgIELVP90dCmN7TNZPVqlpvkNmaeFMfuuMo6yAGOU+KxEEzKNPjezzg
   8OUUloraOgqdhHT4eAfYKgPGfe34yfZ3LweFyYvDPdDbgG41FaY14WBXz
   NhSazsn2bNhxk1q8SkpzApG5P+dT4w8EvbWtGlxZQex+Gylou+d8hGTTu
   M=;
IronPort-SDR: PqyHjMR8XmdRa8HGbPhd/WoSlriDaaxfeGPcP+BjSdln+gMW8dNPWCy98H7913cwvTACeXp/cK
 poLxp3q7OzpA==
X-IronPort-AV: E=Sophos;i="5.69,297,1571702400"; 
   d="scan'208";a="12573217"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Dec 2019 03:01:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id D7AEDA29E6;
        Tue, 10 Dec 2019 03:01:38 +0000 (UTC)
Received: from EX13D11UWC003.ant.amazon.com (10.43.162.162) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 03:01:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWC003.ant.amazon.com (10.43.162.162) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 03:01:37 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 10 Dec 2019 03:01:36 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <axboe@kernel.dk>,
        <mst@redhat.com>, <jejb@linux.ibm.com>, <hch@lst.de>,
        <linux-nvme@lists.infradead.org>,
        "Balbir Singh" <sblbir@amazon.com>,
        Someswarudu Sangaraju <ssomesh@amazon.com>
Subject: [RFC PATCH] block/genhd: Notify udev about capacity change
Date:   Tue, 10 Dec 2019 03:01:31 +0000
Message-ID: <20191210030131.4198-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow block/genhd to notify user space (via udev) about disk size changes
using a new helper disk_set_capacity(), which is a wrapper on top
of set_capacity(). disk_set_capacity() will only notify via udev if
the current capacity or the target capacity is not zero.

disk_set_capacity() is not enabled for all devices, just virtio block,
xen-blockfront, nvme and sd. Owners of other block disk devices can
easily move over by changing set_capacity() to disk_set_capacity()

Background:

As a part of a patch to allow sending the RESIZE event on disk capacity
change, Christoph (hch@lst.de) requested that the patch be made generic
and the hacks for virtio block and xen block devices be removed and
merged via a generic helper.

Testing:
1. I did some basic testing with an NVME device, by resizing it in
the backend and ensured that udevd received the event.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
---
 block/genhd.c                | 19 +++++++++++++++++++
 drivers/block/virtio_blk.c   |  4 +---
 drivers/block/xen-blkfront.c |  5 +----
 drivers/nvme/host/core.c     |  2 +-
 drivers/scsi/sd.c            |  2 +-
 include/linux/genhd.h        |  1 +
 6 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..94faec98607b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,6 +46,25 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
+/*
+ * Set disk capacity and notify if the size is not currently
+ * zero and will not be set to zero
+ */
+void disk_set_capacity(struct gendisk *disk, sector_t size)
+{
+	sector_t capacity = get_capacity(disk);
+
+	set_capacity(disk, size);
+	if (capacity != 0 && size != 0) {
+		char *envp[] = { "RESIZE=1", NULL };
+
+		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	}
+}
+
+EXPORT_SYMBOL_GPL(disk_set_capacity);
+
+
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7ffd719d89de..869cd3c31529 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -476,18 +476,16 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity(vblk->disk, capacity);
+	disk_set_capacity(vblk->disk, capacity);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
 {
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
-	char *envp[] = { "RESIZE=1", NULL };
 
 	virtblk_update_capacity(vblk, true);
 	revalidate_disk(vblk->disk);
-	kobject_uevent_env(&disk_to_dev(vblk->disk)->kobj, KOBJ_CHANGE, envp);
 }
 
 static void virtblk_config_changed(struct virtio_device *vdev)
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a74d03913822..8077c070fe18 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2337,7 +2337,6 @@ static void blkfront_connect(struct blkfront_info *info)
 	unsigned long sector_size;
 	unsigned int physical_sector_size;
 	unsigned int binfo;
-	char *envp[] = { "RESIZE=1", NULL };
 	int err, i;
 
 	switch (info->connected) {
@@ -2352,10 +2351,8 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity(info->gd, sectors);
+		disk_set_capacity(info->gd, sectors);
 		revalidate_disk(info->gd);
-		kobject_uevent_env(&disk_to_dev(info->gd)->kobj,
-				   KOBJ_CHANGE, envp);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfe37a525f3a..f1ad70aab721 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1806,7 +1806,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
-	set_capacity(disk, capacity);
+	disk_set_capacity(disk, capacity);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cea625906440..afeae847dca6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3196,7 +3196,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
+	disk_set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8bb63027e4d6..d5e87d7cc357 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -449,6 +449,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
+extern void disk_set_capacity(struct gendisk *disk, sector_t size);
 extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
-- 
2.16.5

