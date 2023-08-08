Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB376C04FDF
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjHHR5Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjHHR4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591FBBF578
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D30B76258A
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 13:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3EDC433C7;
        Tue,  8 Aug 2023 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691503026;
        bh=tekpDzIIoVtpZfhdGaJlEA0RE3MJMMI24t/ChXijMOs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GOWHYn1ICH7NtEP+pxwA+p4wmMWLphy8QKQp4E0Z+VyqcqRPzy7S6aQLDQenMMC9q
         /UFPCxCuLBQjv3BB8aN0S6sEmS3xSXePZYOnkepRWP1JKB2Gb/qwEtmcpGtSeS7yHR
         8KgmEIi2nBulSjk68brSbvmz+0/DL387nmISbpNkIWt2lWLVaxe7KHFZWLJIN1hnOU
         S1tPja8iYfqCtSz6d0mzUsA4vBKuaNK+GxjAhZ2nfGtlAAIA+gUByg1RZ1ciLVsTh0
         Djh4QwRZdhF5mRGuyOruUjJEvNHinaLTnTNAtuxTBgzKILAcqmVMdjvZjzcXHIXaga
         is/rVkeN6Bl/Q==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 3/5] block: use pr_xxx() instead of printk() in partition code
Date:   Tue,  8 Aug 2023 22:57:00 +0900
Message-ID: <20230808135702.628588-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808135702.628588-1-dlemoal@kernel.org>
References: <20230808135702.628588-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace calls to printk() in the core, atari, efi and sun partition
code with the equivalent pr_info(), pr_err() etc calls. For each
partition type, the pr_fmt message prefix is defined as "partition: xxx:
" where "xxx" is the partition type name.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/partitions/atari.c | 11 +++++++----
 block/partitions/check.h |  1 +
 block/partitions/core.c  | 33 ++++++++++++++++-----------------
 block/partitions/sgi.c   |  7 +++++--
 block/partitions/sun.c   |  5 ++++-
 5 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/block/partitions/atari.c b/block/partitions/atari.c
index 9655c728262a..e48eec5b9fd0 100644
--- a/block/partitions/atari.c
+++ b/block/partitions/atari.c
@@ -12,6 +12,9 @@
 #include "check.h"
 #include "atari.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "partition: atari: " fmt
+
 /* ++guenther: this should be settable by the user ("make config")?.
  */
 #define ICD_PARTS
@@ -94,14 +97,14 @@ int atari_partition(struct parsed_partitions *state)
 		while (1) {
 			xrs = read_part_sector(state, partsect, &sect2);
 			if (!xrs) {
-				printk (" block %ld read failed\n", partsect);
+				pr_err(" block %ld read failed\n", partsect);
 				put_dev_sector(sect);
 				return -1;
 			}
 
 			/* ++roman: sanity check: bit 0 of flg field must be set */
 			if (!(xrs->part[0].flg & 1)) {
-				printk( "\nFirst sub-partition in extended partition is not valid!\n" );
+				pr_err("\nFirst sub-partition in extended partition is not valid!\n");
 				put_dev_sector(sect2);
 				break;
 			}
@@ -116,7 +119,7 @@ int atari_partition(struct parsed_partitions *state)
 				break;
 			}
 			if (memcmp( xrs->part[1].id, "XGM", 3 ) != 0) {
-				printk("\nID of extended partition is not XGM!\n");
+				pr_err("\nID of extended partition is not XGM!\n");
 				put_dev_sector(sect2);
 				break;
 			}
@@ -124,7 +127,7 @@ int atari_partition(struct parsed_partitions *state)
 			partsect = be32_to_cpu(xrs->part[1].st) + extensect;
 			put_dev_sector(sect2);
 			if (++slot == state->limit) {
-				printk( "\nMaximum number of partitions reached!\n" );
+				pr_err("\nMaximum number of partitions reached!\n");
 				break;
 			}
 		}
diff --git a/block/partitions/check.h b/block/partitions/check.h
index 8d70a880c372..33c065339edc 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
+#include <linux/printk.h>
 #include "../blk.h"
 
 /*
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 13a7341299a9..fcf0cf321350 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -12,6 +12,9 @@
 #include <linux/raid/detect.h>
 #include "check.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "partition: " fmt
+
 static int (*const check_part[])(struct parsed_partitions *) = {
 	/*
 	 * Probe partition formats with tables at disk address 0
@@ -147,8 +150,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 
 	}
 	if (res > 0) {
-		printk(KERN_INFO "%s", state->pp_buf);
-
+		pr_info("%s", state->pp_buf);
 		free_page((unsigned long)state->pp_buf);
 		return state;
 	}
@@ -162,7 +164,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 	if (res) {
 		strlcat(state->pp_buf,
 			" unable to read partition table\n", PAGE_SIZE);
-		printk(KERN_INFO "%s", state->pp_buf);
+		pr_info("%s", state->pp_buf);
 	}
 
 	free_page((unsigned long)state->pp_buf);
@@ -526,11 +528,11 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 {
 	if (!disk->fops->unlock_native_capacity ||
 	    test_and_set_bit(GD_NATIVE_CAPACITY, &disk->state)) {
-		printk(KERN_CONT "truncated\n");
+		pr_cont("truncated\n");
 		return false;
 	}
 
-	printk(KERN_CONT "enabling native capacity\n");
+	pr_cont("enabling native capacity\n");
 	disk->fops->unlock_native_capacity(disk);
 	return true;
 }
@@ -546,18 +548,16 @@ static bool blk_add_partition(struct gendisk *disk,
 		return true;
 
 	if (from >= get_capacity(disk)) {
-		printk(KERN_WARNING
-		       "%s: p%d start %llu is beyond EOD, ",
-		       disk->disk_name, p, (unsigned long long) from);
+		pr_warn("%s: p%d start %llu is beyond EOD, ",
+			disk->disk_name, p, (unsigned long long) from);
 		if (disk_unlock_native_capacity(disk))
 			return false;
 		return true;
 	}
 
 	if (from + size > get_capacity(disk)) {
-		printk(KERN_WARNING
-		       "%s: p%d size %llu extends beyond EOD, ",
-		       disk->disk_name, p, (unsigned long long) size);
+		pr_warn("%s: p%d size %llu extends beyond EOD, ",
+			disk->disk_name, p, (unsigned long long) size);
 
 		if (disk_unlock_native_capacity(disk))
 			return false;
@@ -573,7 +573,7 @@ static bool blk_add_partition(struct gendisk *disk,
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
 			     &state->parts[p].info);
 	if (IS_ERR(part) && PTR_ERR(part) != -ENXIO) {
-		printk(KERN_ERR " %s: p%d could not be added: %ld\n",
+		pr_err(" %s: p%d could not be added: %ld\n",
 		       disk->disk_name, p, -PTR_ERR(part));
 		return true;
 	}
@@ -605,8 +605,8 @@ static int blk_add_partitions(struct gendisk *disk)
 		 * beyond EOD, retry after unlocking the native capacity.
 		 */
 		if (PTR_ERR(state) == -ENOSPC) {
-			printk(KERN_WARNING "%s: partition table beyond EOD, ",
-			       disk->disk_name);
+			pr_warn("%s: partition table beyond EOD, ",
+				disk->disk_name);
 			if (disk_unlock_native_capacity(disk))
 				return -EAGAIN;
 		}
@@ -629,9 +629,8 @@ static int blk_add_partitions(struct gendisk *disk)
 	 * partitions.
 	 */
 	if (state->access_beyond_eod) {
-		printk(KERN_WARNING
-		       "%s: partition table partially beyond EOD, ",
-		       disk->disk_name);
+		pr_warn("%s: partition table partially beyond EOD, ",
+			disk->disk_name);
 		if (disk_unlock_native_capacity(disk))
 			goto out_free_state;
 	}
diff --git a/block/partitions/sgi.c b/block/partitions/sgi.c
index 9cc6b8c1eea4..598d3480aaeb 100644
--- a/block/partitions/sgi.c
+++ b/block/partitions/sgi.c
@@ -7,6 +7,9 @@
 
 #include "check.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "partition: sgi: " fmt
+
 #define SGI_LABEL_MAGIC 0x0be5a941
 
 enum {
@@ -61,8 +64,8 @@ int sgi_partition(struct parsed_partitions *state)
 		csum += be32_to_cpu(cs);
 	}
 	if(csum) {
-		printk(KERN_WARNING "Dev %s SGI disklabel: csum bad, label corrupted\n",
-		       state->disk->disk_name);
+		pr_warn("Dev %s SGI disklabel: csum bad, label corrupted\n",
+			state->disk->disk_name);
 		put_dev_sector(sect);
 		return 0;
 	}
diff --git a/block/partitions/sun.c b/block/partitions/sun.c
index ddf9e6def4b2..ca3e57f63938 100644
--- a/block/partitions/sun.c
+++ b/block/partitions/sun.c
@@ -10,6 +10,9 @@
 
 #include "check.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "partition: sun: " fmt
+
 #define SUN_LABEL_MAGIC          0xDABE
 #define SUN_VTOC_SANITY          0x600DDEEE
 
@@ -84,7 +87,7 @@ int sun_partition(struct parsed_partitions *state)
 	for (csum = 0; ush >= ((__be16 *) label);)
 		csum ^= *ush--;
 	if (csum) {
-		printk("Dev %s Sun disklabel: Csum bad, label corrupted\n",
+		pr_err("Dev %s Sun disklabel: Csum bad, label corrupted\n",
 		       state->disk->disk_name);
 		put_dev_sector(sect);
 		return 0;
-- 
2.41.0

