Return-Path: <schmitzmic@gmail.com>
Subject: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
From: schmitzmic@gmail.com
CC: <geert@linux-m68k.org-r>,<jdow@earthlink.net>,<martin@lichtvoll.de>,<linux-m68k@lists.linux-m68k.org>,<linux-block@vger.kernel.org>
To: <schmitzmic@gmail.com>,<axboe@kernel.dk>
Message-Id: <20180627012421.80B8F24E094@nmr-admin>
Date: Wed, 27 Jun 2018 13:24:21 +1200 (NZST)
List-ID: <linux-block@vger.kernel.org>

>From 5299e0e64dfb33ac3a1f3137b42178734ce20087 Mon Sep 17 00:00:00 2001

The Amiga RDB partition parser module uses int for partition sector
address and count, which will overflow for disks 2 TB and larger.

Use sector_t as type for sector address and size (as expected by
put_partition) to allow using such disks without danger of data
corruption.

This bug was reported originally in 2012 by Martin Steigerwald
<Martin@lichtvoll.de>, and the fix was created by the RDB author,
Joanne Dow <jdow@earthlink.net>. The patch had been discussed and
reviewed on linux-m68k at that time but never officially submitted.

Following a stern warning by Joanne, a warning is printed if any
partition is found to overflow the old 32 bit calculations, on the
grounds that such a partition would be misparses on legacy 32 bit
systems (other than Linux).

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
---
 block/partitions/amiga.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 5609366..42c3f38 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -32,7 +32,8 @@ int amiga_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	int start_sect, nr_sects, blk, part, res = 0;
+	sector_t start_sect, nr_sects;
+	int blk, part, res = 0;
 	int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 	char b[BDEVNAME_SIZE];
@@ -111,6 +112,16 @@ int amiga_partition(struct parsed_partitions *state)
 			     be32_to_cpu(pb->pb_Environment[3]) *
 			     be32_to_cpu(pb->pb_Environment[5]) *
 			     blksize;
+		if (start_sect > INT_MAX || nr_sects > INT_MAX
+			|| (start_sect + nr_sects) > INT_MAX) {
+			pr_err("%s: Warning: RDB partition overflow!\n",
+				bdevname(state->bdev, b));
+			pr_err("%s: start 0x%llX size 0x%llX\n",
+				bdevname(state->bdev, b), start_sect,
+				nr_sects);
+			pr_err("%s: partition incompatible with 32 bit OS\n",
+				bdevname(state->bdev, b));
+		}
 		put_partition(state,slot++,start_sect,nr_sects);
 		{
 			/* Be even more informative to aid mounting */
-- 
1.9.1
