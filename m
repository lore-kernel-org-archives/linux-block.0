Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v6 2/2] block: add overflow checks for Amiga partition support
Date: Sun, 14 Oct 2018 17:48:35 +1300
Message-Id: <1539492515-1782-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1539492515-1782-1-git-send-email-schmitzmic@gmail.com>
References: <1539492515-1782-1-git-send-email-schmitzmic@gmail.com>
List-ID: <linux-block@vger.kernel.org>

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

---

Changes from RFC:

- use u64 instead of sector_t, since that may be u32 without LBD support
- check multiplication overflows each step - 3 u32 values may exceed u64!
- warn against use on AmigaDOS if partition data overflow u32 sector count.
- warn if partition CylBlocks larger than what's stored in the RDSK header.
- bail out if we were to overflow sector_t (32 or 64 bit).

Changes from v1:

Kars de Jong:
- use defines for magic offsets in DosEnvec struct

Geert Uytterhoeven:
- use u64 cast for multiplications of u32 numbers
- use array3_size for overflow checks
- change pr_err to pr_warn
- discontinue use of pr_cont
- reword log messages
- drop redundant nr_sects overflow test
- warn against 32 bit overflow for each affected partition
- skip partitions that overflow sector_t size instead of aborting scan

Changes from v2:

- further trim 32 bit overflow test
- correct duplicate types.h inclusion introduced in v2

Changes from v3:

- split off sector address type fix for independent review
- change blksize to unsigned
- use check_mul_overflow() instead of array3_size()
- rewrite checks to avoid 64 bit divisions in check_mul_overflow()

Changes from v5:

Geert Uytterhoeven:
- correct ineffective u64 cast to avoid 32 bit mult. overflow
- fix mult. overflow in partition block address calculation
---
 block/partitions/amiga.c | 112 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 22 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 7ea9540..24d4138 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -11,11 +11,19 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/types.h>
+#include <linux/mm_types.h>
+#include <linux/overflow.h>
 #include <linux/affs_hardblocks.h>
 
 #include "check.h"
 #include "amiga.h"
 
+/* magic offsets in partition DosEnvVec */
+#define NR_HD	3
+#define NR_SECT	5
+#define LO_CYL	9
+#define	HI_CYL	10
+
 static __inline__ u32
 checksum_block(__be32 *m, int size)
 {
@@ -32,9 +40,12 @@ int amiga_partition(struct parsed_partitions *state)
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
 	char b[BDEVNAME_SIZE];
 
@@ -44,8 +55,8 @@ int amiga_partition(struct parsed_partitions *state)
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
 			if (warn_no_part)
-				pr_err("Dev %s: unable to read RDB block %d\n",
-				       bdevname(state->bdev, b), blk);
+				pr_err("Dev %s: unable to read RDB block %llu\n",
+				       bdevname(state->bdev, b), (u64) blk);
 			res = -1;
 			goto rdb_done;
 		}
@@ -61,13 +72,13 @@ int amiga_partition(struct parsed_partitions *state)
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
-		       bdevname(state->bdev, b), blk);
+		pr_err("Dev %s: RDB in block %llu has bad checksum\n",
+		       bdevname(state->bdev, b), (u64) blk);
 	}
 
 	/* blksize is blocks per 512 byte standard block */
@@ -83,12 +94,18 @@ int amiga_partition(struct parsed_partitions *state)
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
 	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
-		blk *= blksize;	/* Read in terms partition table understands */
+		/* Read in terms partition table understands */
+		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
+			pr_err("Dev %s: overflow calculating partition block %llu!\n",
+				bdevname(state->bdev, b), (u64) blk);
+			res = -1;
+			goto rdb_done;
+		}
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
 			if (warn_no_part)
-				pr_err("Dev %s: unable to read partition block %d\n",
-				       bdevname(state->bdev, b), blk);
+				pr_err("Dev %s: unable to read partition block %llu\n",
+				       bdevname(state->bdev, b), (u64) blk);
 			res = -1;
 			goto rdb_done;
 		}
@@ -99,19 +116,70 @@ int amiga_partition(struct parsed_partitions *state)
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
+				bdevname(state->bdev, b), cylblk);
+			continue;
+		}
+
+		/* check for consistency with RDB defined CylBlocks */
+		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
+			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
+				bdevname(state->bdev, b), cylblk,
+				be32_to_cpu(rdb->rdb_CylBlocks));
+		}
+
+		/* RDB allows for variable logical block size -
+		 * normalize to 512 byte blocks and check result.
+		 */
+
+		if (check_mul_overflow(cylblk, blksize, &cylblk)) {
+			pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
+				bdevname(state->bdev, b), part);
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
+				bdevname(state->bdev, b), part,
+				start_sect, start_sect + nr_sects);
+		}
+
+		if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
+			pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
+				bdevname(state->bdev, b), part,
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
1.9.1
