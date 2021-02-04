Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF4C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 08:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BDD64F5C
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 08:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhBDIqF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 03:46:05 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58567 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhBDIqC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 03:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612428363; x=1643964363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SygIa1oqH1i8inCeXLDg+5uYEDKW7cK+L8YMpSLNjzg=;
  b=DIQQcOpkPTqZMH3DYAKsE21SxN3/sScyoC5pYkRO9KdPRiJ20nbSbv+S
   FSdQbL4NIxZ5+//K40yu4ywc3bZ2dUA8yxxjhyWCO9A8Ia0ls+AfxtLnE
   NEuJk0DJ9/s344DQuFOrFtifcsZp+bLHlR5dTI+wQNZhNlBNJZ0LB+X6g
   t+/eX0VytHzntYa6a38t5xnDO4AplZY1tPFqNMBnoRfPfwCJv9EZar8K6
   hQ5fgqbCKlIVoX39EuHpBiuV8+aU/OF1Hmrj6HhMtrGFMbzY5n3J7S93H
   yLiN9owE5l0XOEQ3hF82nLC1v5q3atXDtb5IjYDuFp5cPLCR7ZtZPjYCy
   g==;
IronPort-SDR: HGkfmKHhLR12ORChScDgU1DMsan/7cpE8xIpWnUr1dCBUW7Yl6yeHfvIwJx2tXCpCVfkKp3vR/
 vfw+wvYWK81Az6aOMVp/W/qACfQrvEUrRXBPGsH60mqCSGW/Br68SSUU7B3QT6fUbiTYpx8gKu
 VSELkDKq65YYtoPCfyh/LmUpxuMXtGXF/uFSXqpVbiIBSWlJFuF9wFy16/WWCe5HTZ36CXz99Q
 0xhYiG2JdKqspIO8bwQngeZcfzyRs0UtdGnz905rk3/uQuRAJwY6P/xEvozOaXW4U5MvMoDlnw
 ia8=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="160285579"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 16:43:47 +0800
IronPort-SDR: iVkZFJrPsWDl/aSsT96DU5cF3b6ARC+uV5fLuY91U9EsQrMWbHVYZqrdRu1UuvO2bjFYdA8RU5
 dm9/hPssICsVDxRSLl1OZC6QjcB/fItOBX4cTLWd/lBWOcu04/eOsGH8ITquOWT6Nct9nyd/Aw
 eToBlUqeZj5ctUwEJRF+q1PrZkgV6icj+hDfVtoE0uEcyK9jJyC87hWj338QV2wYKtziZ64XnB
 GmNxEOxZ5pedxDYVauN5XDkMLj+BiAD0g1gauw2BIn+Mvw9n6eIFOtokCG/AMLyjyJycRcO0EP
 mhoyaqMwItuSwDA4LIWnMmxp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 00:25:50 -0800
IronPort-SDR: Z9bC4CnDleGK6N0iqlWDbnTwxehtbVwfBDwMh+sChhmwANYDCp0UYGKU6/a2EJJlxq6ohQ/wBU
 7VdxXFaHZDTyUOOts3N87S3uyxYoYlQTS1sKfjrEQku1apeVEw4GSHiS6fmn5PanKreBa7au5v
 OsBfeQLt3dGJmXSxXr+GHxh80ZYYjKfECpzNx85jYpfqHNfn20nBu6J3MRcBazMvQ+0/tmLAr9
 iJWHKVg8Vd/ZLe6LYcnHFLvNUvhYB8UrLPH9/+KSaZR5EvjDqmnve54L81xwuVRl/TDjx0cYXH
 HpI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 00:43:46 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Date:   Thu,  4 Feb 2021 17:43:43 +0900
Message-Id: <20210204084343.207847-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204084343.207847-1-damien.lemoal@wdc.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
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
index 9e741a4f351b..419548e92d82 100644
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
index 081f1df9d10d..d0745555ba16 100644
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

