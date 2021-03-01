Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B432FC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 03:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819E064D9F
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 03:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhCADFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 22:05:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54217 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhCADFK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 22:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614567909; x=1646103909;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NHVL84jbY7PLyXc6909fwVRSLZ8BmFYLYBBAG7PCOkE=;
  b=fze6DRPOpRcC+vH0qQa1FXfl6Te5K/uTzLvf8CCuSLBdCO+rCwRMi1xS
   J4AnEQGTqJt7PooFmKOrrVlOo/ajubU7vxZa6v+Ww37YtYMfz4a4l/a/b
   KjsQZK9/DILzNyyRMCJVZIsGmVN3+SItqET/bhCt0UZPemCmk9Q9485/p
   xqV4nO0rrHZiDEd16BzUaIhJR4VR893XoDdSBKHCBr/Y2WDDeao3w27Zl
   ZcSBqvKoJ8nWBd0Nii/XNhe7bHEIa/ziKZHjQ6gSEnYfeuTqtLPSkrK2K
   PumopyOaNqT54Dby3gSeP0L/ysaW/z0tDgIbbRNTfO9PMfKOelq2sRPyb
   Q==;
IronPort-SDR: Xkuk6cCOum5UeTZwGJ7f8816GJZpNDIksfVMUttr1YoA74AyXWhadPwuAdHmCs6HFQxLG2sAoB
 /E3d4jihXfVf7nIs3WUmQ23NbCwtrvrJEcXdeRdsmQWeq5z4g/GHu0iHHLj5y0olA71bx63/uZ
 XD3L4z1jcEn5NSsK19BIqH3LhA02WzL1LeLMd9Ol6nkgaFUpGnexb5087t8rZvdvyghnbEYLAh
 Ic4CSq0sGKG3UJkbjOdWsMKTAZMPN//fLqeNjQuvVRSFH9oCAn0RoVqGLYjbR1MidSaHb8hEgc
 vec=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; 
   d="scan'208";a="161015856"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 11:04:03 +0800
IronPort-SDR: FZLg09Sr562l1M5JeA5FIEAryCs29AzV62Cn/lsqJSHu4gTmBzeaLPvVKd5VM4x7vL/xtaerWU
 qlWxWBQGa1p49GJ4pybOYkL9iwCE7j4J8Gf+aMLJlWCHFuGgKZ8BGXCL/zpJMRklXqldLTNPJc
 yl2YF8plVoiW1NBlLp9bld+2a0P1U3E9wgy6jK/nGLa72u/BxdVrRG/1Mpm9ysGWdkRTuh09GW
 FN0bNHoE+rY/d0WO/RR6RzHp9A4ZU8taXXUkd1EcoetSEJNnTqzFhCzI8podirwY++UwH8FOpc
 lxOsOIDcpFtQVCy2El6xP3X1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 18:45:21 -0800
IronPort-SDR: c1g23mMfYseKxIQF1dFAGS4dlHuSwxFOWrpTBk0S940BZedFsKPylhiH0gVbAaJWHX+YpnSKnJ
 K353zUaNLqnmpss21Z9WiS+avo1ENVwhX61nJgTrmWs2bQeNNaELAIfCyjp6MovyOsqjmdi8HB
 aFG06wHmFV4OANzVbpvzM2Spoc6D7d5gIlsUCVOMDTYdz7kTO+45+UXKmMN5LoyNphE4Sgw2Lm
 +HkNFXuPclKwi7jjskGfEiRVQkNpxPWxObTRjETNNlHxF83XRXTbnvJxrVmI/XdUmXJ1VYB8XA
 3Ds=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 19:04:03 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: revert "block: fix bd_size_lock use"
Date:   Mon,  1 Mar 2021 12:04:02 +0900
Message-Id: <20210301030402.690822-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the removal of the skd driver, using IRQ safe locking of a bdev
bd_size_lock spinlock to protect the bdev inode size is not necessary
anymore as there is no other known driver using this lock under an IRQ
disabled context (e.g. calling set_capacity() with IRQ disabled).
Revert commit 0fe37724f8e7 ("block: fix bd_size_lock use") which
introduced the IRQ safe change.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/genhd.c           | 5 ++---
 block/partitions/core.c | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index fcc530164b5a..c55e8f0fced1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -45,11 +45,10 @@ static void disk_release_events(struct gendisk *disk);
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
 	struct block_device *bdev = disk->part0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&bdev->bd_size_lock, flags);
+	spin_lock(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	spin_unlock_irqrestore(&bdev->bd_size_lock, flags);
+	spin_unlock(&bdev->bd_size_lock);
 }
 EXPORT_SYMBOL(set_capacity);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index f3d9ff2cafb6..1a7558917c47 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -88,11 +88,9 @@ static int (*check_part[])(struct parsed_partitions *) = {
 
 static void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&bdev->bd_size_lock, flags);
+	spin_lock(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	spin_unlock_irqrestore(&bdev->bd_size_lock, flags);
+	spin_unlock(&bdev->bd_size_lock);
 }
 
 static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
-- 
2.29.2

