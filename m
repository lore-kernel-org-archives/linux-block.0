Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-block@vger.kernel.org
Cc: linux-m68k@vger.kernel.org,
	axboe@kernel.dk,
	geert@linux-m68k.org,
	jdow@earthlink.net,
	martin@lichtvoll.de,
	jongk@linux-m68k.org,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v2] block: fix Amiga partition support for disks >= 1 TB
Date: Tue,  3 Jul 2018 19:19:12 +1200
Message-Id: <1530602352-29004-1-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
References: <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
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
submitted. This patch adds additional error checking and warning messages.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Martin Steigerwald <Martin@lichtvoll.de>

---

Changes from RFC:

- use u64 instead of sector_t, since that may be u32 without LBD support
- check multiplication overflows each step - 3 u32 values may exceed u64!
- warn against use on AmigaDOS if partition data overflow u32 sector count.
- warn if partition CylBlocks larger than what's stored in the RDSK header.
- bail out if we were to overflow sector_t (32 or 64 bit).

Changes from v1:

Kars de Jong:
- use defines for magic offsets in DosEnVec struct

Geert Uytterhoeven:
- use u64 cast for multiplications of u32 numbers
- use array3_size for overflow checks
- change pr_err to pr_warn
- discontinue use of pr_cont
- reword log messages
- drop redundant nr_sects overflow test
- warn against 32 bit overflow for each affected partition
- skip partitions that overflow sector_t size instead of aborting scan
---
 block/partitions/amiga.c |   91 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 5609366..7277ebb 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -11,11 +11,20 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/types.h>
+#include <linux/types.h>
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
@@ -32,7 +41,9 @@ int amiga_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	int start_sect, nr_sects, blk, part, res = 0;
+	u64 start_sect, nr_sects;
+	u64 cylblk;		/* rdb_CylBlocks = nr_heads*sect_per_track */
+	int blk, part, res = 0;
 	int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 	char b[BDEVNAME_SIZE];
@@ -98,19 +109,79 @@ int amiga_partition(struct parsed_partitions *state)
 		if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
 			continue;
 
+		/* RDB gives us more than enough rope to hang ourselves with,
+		 * many times over (2^128 bytes if all fields max out).
+		 * Some careful checks are in order.
+		 */
+
+		/* CylBlocks is total number of blocks per cylinder */
+		cylblk = be32_to_cpu(pb->pb_Environment[NR_HD]) *
+			 be32_to_cpu(pb->pb_Environment[NR_SECT]);
+
+		/* check for consistency with RDB defined CylBlocks */
+		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
+			pr_warn("Dev %s: cylblk %llu > rdb_CylBlocks 0x%x!\n",
+				bdevname(state->bdev, b), cylblk,
+				be32_to_cpu(rdb->rdb_CylBlocks));
+		}
+
+		/* check for potential overflows - we are going to multiply
+		 * three 32 bit numbers to one 64 bit result later!
+		 * Condition 1: nr_heads * sects_per_track must fit u32!
+		 * NB: This is a HARD limit for AmigaDOS. We just warn.
+		 */
+
+		if (cylblk > UINT_MAX) {
+			pr_warn("Dev %s: heads*sects %llu > UINT_MAX!\n",
+				bdevname(state->bdev, b), cylblk);
+		}
+
+		/* Condition 2: even if CylBlocks did not overflow, the end
+		 * result must still fit u64!
+		 */
+
+		if (array3_size(be32_to_cpu(pb->pb_Environment[LO_CYL]),
+			cylblk, blksize) == SIZE_MAX) {
+			pr_err("Dev %s: partition %u start overflows u64, skipping partition!\n",
+				bdevname(state->bdev, b), part);
+			continue;
+		}
+
+		if (array3_size(be32_to_cpu(pb->pb_Environment[HI_CYL]),
+			cylblk, blksize) == SIZE_MAX) {
+			pr_err("Dev %s: partition %u end overflows u64, skipping partition!\n",
+				bdevname(state->bdev, b), part);
+			continue;
+		}
+
 		/* Tell Kernel about it */
 
-		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
-			    be32_to_cpu(pb->pb_Environment[9])) *
-			   be32_to_cpu(pb->pb_Environment[3]) *
-			   be32_to_cpu(pb->pb_Environment[5]) *
-			   blksize;
+		nr_sects = (u64)((be32_to_cpu(pb->pb_Environment[HI_CYL]) + 1 -
+			    be32_to_cpu(pb->pb_Environment[LO_CYL])) *
+			   be32_to_cpu(pb->pb_Environment[NR_HD]) *
+			   be32_to_cpu(pb->pb_Environment[NR_SECT]) *
+			   blksize);
 		if (!nr_sects)
 			continue;
-		start_sect = be32_to_cpu(pb->pb_Environment[9]) *
-			     be32_to_cpu(pb->pb_Environment[3]) *
-			     be32_to_cpu(pb->pb_Environment[5]) *
-			     blksize;
+		start_sect = (u64)(be32_to_cpu(pb->pb_Environment[LO_CYL]) *
+			     be32_to_cpu(pb->pb_Environment[NR_HD]) *
+			     be32_to_cpu(pb->pb_Environment[NR_SECT]) *
+			     blksize);
+
+		/* Warn user if start_sect or nr_sects overflow u32 */
+		if (start_sect > UINT_MAX ||
+		    (start_sect + nr_sects) > UINT_MAX) {
+			pr_warn("Dev %s: partition %u (%llu-%llu) needs 64 bit device support!\n",
+				bdevname(state->bdev, b), part,
+				start_sect, nr_sects);
+			/* Without LBD support, better bail out */
+			if (!IS_ENABLED(CONFIG_LBDAF)) {
+				pr_err("Dev %s: no LBD support, skipping partition %u!",
+					bdevname(state->bdev, b), part);
+				continue;
+			}
+		}
+
 		put_partition(state,slot++,start_sect,nr_sects);
 		{
 			/* Be even more informative to aid mounting */
-- 
1.7.0.4
