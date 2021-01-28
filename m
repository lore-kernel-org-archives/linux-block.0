Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E94C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 06:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2630B64D99
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 06:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhA1Gh3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:37:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26758 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhA1Gh2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 01:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611815847; x=1643351847;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4ZrXdb+AXvrv1OR1AmmN20ATlpTNbKQ0VEYPSo13gTA=;
  b=rKmKlqAc3M+kUoUEo4yAP/Z1U5jAU7yXBleLha/6bjVz4UaPj7YC0NG2
   6MdVZCvlCTeIAfz3EH2+ButiU8aGcPr2CyLnr7uwuiYN8evxttcZavpgJ
   PmRnuVL5KiV04q34RLhLLD+67E4EJtb9qJ5ZIcBLXNNPnFKx3BdG1sjva
   M4M9d0vfLkLyNzTcIwa6Xe9UFYoGWdTdflIS40hZinsQttFRMrG80Wdmx
   VWtbi2JIsQJZWMBGExIE6o9601PM91JweoZKGKyJth4XeZxyOedqvt8Yu
   WYVbTOt2zWG/BAaMZkIuk69WpuYGZbh1MTVp8C3f+mfNojZJZOW22NPTA
   g==;
IronPort-SDR: xAH0mPRvVq8GTTFl/8dTEMTy4w/J/HpGG5FJR2fQhD8WRh1w3MeLC0Zj45T57vzi4Ap2tox+Z1
 Aaw8uQ2hXwfiF2wwfuu8/QmwWz2pLa5q9CXPYS0jc621WM7e6P1IkHkX04OuLOQuYIdDG3ocF2
 zPx7HM4ybln/t5fqi+t/2xngCLEFiroi4oU31v9rPsx/ZauOcgchU0/jBZThrqPP//0eYGO+e7
 PSaznNLpoCWaB8uBQVu1VvyZNsxGmW0CUfZF+zIVRdd46fYS/sOiqHguhw5JrL39o9P695bDUJ
 7F4=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="162961024"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 14:36:20 +0800
IronPort-SDR: ajAUHKDI1steEp1jx1FhzGhk81OYQmVutldkjqGGtSfqqjjB7DSXN81H7sWQEpY+aWC+WmDEKn
 oLoDBnr/KY1F+OeCPb/U5YgS9tj38n4hC15N+DzAvnAd7AAqdxzI4FwYYa9nwOFn4tB93F+Evp
 bwAXx/RnwKVkRQXdV77jSx+5Cxv2xuMe5CdX0lK4Hw/+hnE3AFT2Kd8T9/mOwqU5ju8YHWpeM8
 Lkq7+EA+kzkvW3VpUoPDTMfuRKE+/SEt28VG6AV/f8c44jQDgAjAvro/4GzMo2xSzbADd/hSH6
 ePhXpvCcC21ryhRGr9KCallY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:20:40 -0800
IronPort-SDR: IveD7X91LdoADkIeMJ5RnCMj998J92HVsZlb3rWbNqPrDOC/ret/yxCC7AjtdH/EryawCiIKhR
 5eAQgPrGjQ0HPAqdxs6quWTtNpJJer7KgSa0miJayVs4PsLD6BT8+/lTQQwt+2XYuVybMAPAZM
 8bhLnnehCBODES/wqlgfMWg0ncGrFVP2rBXRdfIGWyDS4LYtcGxhHpa5X2ejobaEBTlBpkQdJ0
 QFsVfuTsmZac7uKTmKZCcSiS1O8qklzEStbMXNyvbhr95utNF92CyprfLJk2Mb6WELHylyPo9s
 vnA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 22:36:21 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix bd_size_lock use
Date:   Thu, 28 Jan 2021 15:36:19 +0900
Message-Id: <20210128063619.570177-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some block device drivers, e.g. the skd driver, call set_capacity() with
IRQ disabled. This results in lockdep ito complain about inconsistent
lock states ("inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage")
because set_capacity takes a block device bd_size_lock using the
functions spin_lock() and spin_unlock(). Ensure a consistent locking
state by replacing these calls with spin_lock_irqsave() and
spin_lock_irqrestore(). The same applies to bdev_set_nr_sectors().
With this fix, all lockdep complaints are resolved.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/genhd.c           | 5 +++--
 block/partitions/core.c | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index d3ef29fbc536..f795bd56012f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -45,10 +45,11 @@ static void disk_release_events(struct gendisk *disk);
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
 	struct block_device *bdev = disk->part0;
+	unsigned long flags;
 
-	spin_lock(&bdev->bd_size_lock);
+	spin_lock_irqsave(&bdev->bd_size_lock, flags);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	spin_unlock(&bdev->bd_size_lock);
+	spin_unlock_irqrestore(&bdev->bd_size_lock, flags);
 }
 EXPORT_SYMBOL(set_capacity);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index d6094203116a..301518bdc403 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -88,9 +88,11 @@ static int (*check_part[])(struct parsed_partitions *) = {
 
 static void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
-	spin_lock(&bdev->bd_size_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bdev->bd_size_lock, flags);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	spin_unlock(&bdev->bd_size_lock);
+	spin_unlock_irqrestore(&bdev->bd_size_lock, flags);
 }
 
 static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
-- 
2.29.2

