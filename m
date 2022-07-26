Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD60C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 04:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiGZE6A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 00:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiGZE56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 00:57:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE5F27B0A;
        Mon, 25 Jul 2022 21:57:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so16232177pjq.4;
        Mon, 25 Jul 2022 21:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yBYe/1OeLIDZf3DCFn7s0xzvaZcpCXWT7ebwUphe8tw=;
        b=WrvK+hf7bJrTjpWsnxBmIKbx3R6z7SZ4hQHhyRjh9TtkXxibbG2KDGa9xVknYV+k64
         4xmkv5BSNa+HMXVaMHnmLE+LU/a/y7ROfUxX/kSwl5WujrvQJJFZ6+i7ZswXbKEH2eGH
         mnR9WyobkEr8TPyWnHwK1EakwB9fj+8i0nj4IzRU9nztGAwyupEVm8GCwYz6LFYqBwje
         27tB8yLrYzAdnXbaLRAkeJ8QpOYnFshs87YijRTsrx/R3TsbUrPgo6czjwBWoN4o2ZVJ
         odfYpuxr7VH6PdkgrfoFeUXSl8G8tOnevt1iShCI3ayC79dU+FuBr8kOOFFAxlwipiZM
         5xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yBYe/1OeLIDZf3DCFn7s0xzvaZcpCXWT7ebwUphe8tw=;
        b=WI8g8Xs6t9r+3MDgeFIeCbqQoKcdmPXYZ3r8KT4gMnPPNMfV2QuQtlwGCJ3RFcbp1e
         5twEI/AzpclmRqF5Mc28AMgyLKVOmTfnwznYv9tZmH7VGw4zmFY9sHib8abpx3SsJs4E
         8E2fIv68k8jQ/Q6vR+wV5UHlvtvjPOb6/vjWp4LIx2ZoGUCH8QpD58A+RQSCgSCyVWjW
         t0a4EUlCBxYHPObqmQR7FJxdNkpwqYOl93R2i1MDxsx6PsEy01Ex4CxgeioX0+dJxBLc
         OeeWSU0wrk9g3VKXg1SWGLW/yDmWbEvey98ntfUqiMCWpEMjYTUagVHYI+7c9Z1mo2yW
         eTFQ==
X-Gm-Message-State: AJIora+kFmmZ4X8+3oVm7gulVDB3GdgqIfZFmhdtljYLP81aFrD/HGLV
        /rRIFaE7gLLfPOsjzd9X12dXLagG1HA=
X-Google-Smtp-Source: AGRyM1vV2o4wv5ser+sRjctzCoT4bOhsUv+6TkJpr/K3yexHFvd3TwvqZlgoSIY9AfbESshB79ETRg==
X-Received: by 2002:a17:90b:4d92:b0:1f1:be59:a60f with SMTP id oj18-20020a17090b4d9200b001f1be59a60fmr36176269pjb.152.1658811475063;
        Mon, 25 Jul 2022 21:57:55 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id a189-20020a624dc6000000b0052b2e8d0894sm10930894pfb.16.2022.07.25.21.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 21:57:54 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 2AD29360333; Tue, 26 Jul 2022 16:57:51 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v8 2/2] block: add overflow checks for Amiga partition support
Date:   Tue, 26 Jul 2022 16:57:47 +1200
Message-Id: <20220726045747.4779-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726045747.4779-1-schmitzmic@gmail.com>
References: <20220726045747.4779-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The Amiga partition parser module uses signed int for partition sector
address and count, which will overflow for disks larger than 1 TB.

Use u64 as type for sector address and size to allow using disks up to
2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
format allows to specify disk sizes up to 2^128 bytes (though native
OS limitations reduce this somewhat, to max 2^68 bytes), so check for
u64 overflow carefully to protect against overflowing sector_t.

Bail out if sector addresses overflow 32 bits on kernels without LBD
support.

This bug was reported originally in 2012, and the fix was created by
the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
discussed and reviewed on linux-m68k at that time but never officially
submitted (now resubmitted as separate patch).
This patch adds additional error checking and warning messages.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 block/partitions/amiga.c | 111 +++++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 22 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index f98191545d9a..7356b39cbe10 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -11,10 +11,18 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/types.h>
+#include <linux/mm_types.h>
+#include <linux/overflow.h>
 #include <linux/affs_hardblocks.h>
 
 #include "check.h"
 
+/* magic offsets in partition DosEnvVec */
+#define NR_HD	3
+#define NR_SECT	5
+#define LO_CYL	9
+#define	HI_CYL	10
+
 static __inline__ u32
 checksum_block(__be32 *m, int size)
 {
@@ -31,9 +39,12 @@ int amiga_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	sector_t start_sect, nr_sects;
-	int blk, part, res = 0;
-	int blksize = 1;	/* Multiplier for disk block size */
+	u64 start_sect, nr_sects;
+	sector_t blk, end_sect;
+	u32 cylblk;		/* rdb_CylBlocks = nr_heads*sect_per_track */
+	u32 nr_hd, nr_sect, lo_cyl, hi_cyl;
+	int part, res = 0;
+	unsigned int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 
 	for (blk = 0; ; blk++, put_dev_sector(sect)) {
@@ -41,8 +52,8 @@ int amiga_partition(struct parsed_partitions *state)
 			goto rdb_done;
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read RDB block %d\n",
-			       state->disk->disk_name, blk);
+			pr_err("Dev %s: unable to read RDB block %llu\n",
+			       state->disk->disk_name, (u64) blk);
 			res = -1;
 			goto rdb_done;
 		}
@@ -58,13 +69,13 @@ int amiga_partition(struct parsed_partitions *state)
 		*(__be32 *)(data+0xdc) = 0;
 		if (checksum_block((__be32 *)data,
 				be32_to_cpu(rdb->rdb_SummedLongs) & 0x7F)==0) {
-			pr_err("Trashed word at 0xd0 in block %d ignored in checksum calculation\n",
-			       blk);
+			pr_err("Trashed word at 0xd0 in block %llu ignored in checksum calculation\n",
+			       (u64) blk);
 			break;
 		}
 
-		pr_err("Dev %s: RDB in block %d has bad checksum\n",
-		       state->disk->disk_name, blk);
+		pr_err("Dev %s: RDB in block %llu has bad checksum\n",
+		       state->disk->disk_name, (u64) blk);
 	}
 
 	/* blksize is blocks per 512 byte standard block */
@@ -80,11 +91,16 @@ int amiga_partition(struct parsed_partitions *state)
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
 	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
-		blk *= blksize;	/* Read in terms partition table understands */
+		/* Read in terms partition table understands */
+		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
+			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
+				state->disk->disk_name, (u64) blk, part);
+			break;
+		}
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read partition block %d\n",
-			       state->disk->disk_name, blk);
+			pr_err("Dev %s: unable to read partition block %llu\n",
+			       state->disk->disk_name, (u64) blk);
 			res = -1;
 			goto rdb_done;
 		}
@@ -95,19 +111,70 @@ int amiga_partition(struct parsed_partitions *state)
 		if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
 			continue;
 
-		/* Tell Kernel about it */
+		/* RDB gives us more than enough rope to hang ourselves with,
+		 * many times over (2^128 bytes if all fields max out).
+		 * Some careful checks are in order, so check for potential
+		 * overflows.
+		 * We are multiplying four 32 bit numbers to one sector_t!
+		 */
+
+		nr_hd   = be32_to_cpu(pb->pb_Environment[NR_HD]);
+		nr_sect = be32_to_cpu(pb->pb_Environment[NR_SECT]);
+
+		/* CylBlocks is total number of blocks per cylinder */
+		if (check_mul_overflow(nr_hd, nr_sect, &cylblk)) {
+			pr_err("Dev %s: heads*sects %u overflows u32, skipping partition!\n",
+				state->disk->disk_name, cylblk);
+			continue;
+		}
+
+		/* check for consistency with RDB defined CylBlocks */
+		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
+			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
+				state->disk->disk_name, cylblk,
+				be32_to_cpu(rdb->rdb_CylBlocks));
+		}
+
+		/* RDB allows for variable logical block size -
+		 * normalize to 512 byte blocks and check result.
+		 */
+
+		if (check_mul_overflow(cylblk, blksize, &cylblk)) {
+			pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
+				state->disk->disk_name, part);
+			continue;
+		}
+
+		/* Calculate partition start and end. Limit of 32 bit on cylblk
+		 * guarantees no overflow occurs if LBD support is enabled.
+		 */
+
+		lo_cyl = be32_to_cpu(pb->pb_Environment[LO_CYL]);
+		start_sect = ((u64) lo_cyl * cylblk);
+
+		hi_cyl = be32_to_cpu(pb->pb_Environment[HI_CYL]);
+		nr_sects = (((u64) hi_cyl - lo_cyl + 1) * cylblk);
 
-		nr_sects = ((sector_t) be32_to_cpu(pb->pb_Environment[10])
-			   + 1 - be32_to_cpu(pb->pb_Environment[9])) *
-			   be32_to_cpu(pb->pb_Environment[3]) *
-			   be32_to_cpu(pb->pb_Environment[5]) *
-			   blksize;
 		if (!nr_sects)
 			continue;
-		start_sect = (sector_t) be32_to_cpu(pb->pb_Environment[9]) *
-			     be32_to_cpu(pb->pb_Environment[3]) *
-			     be32_to_cpu(pb->pb_Environment[5]) *
-			     blksize;
+
+		/* Warn user if partition end overflows u32 (AmigaDOS limit) */
+
+		if ((start_sect + nr_sects) > UINT_MAX) {
+			pr_warn("Dev %s: partition %u (%llu-%llu) needs 64 bit device support!\n",
+				state->disk->disk_name, part,
+				start_sect, start_sect + nr_sects);
+		}
+
+		if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
+			pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
+				state->disk->disk_name, part,
+				start_sect, (u64) end_sect);
+			continue;
+		}
+
+		/* Tell Kernel about it */
+
 		put_partition(state,slot++,start_sect,nr_sects);
 		{
 			/* Be even more informative to aid mounting */
-- 
2.17.1

