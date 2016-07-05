Return-Path: <krisman@linux.vnet.ibm.com>
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Subject: [PATCH] block: atari: Return early for unsupported sector size
Date: Tue,  5 Jul 2016 13:38:32 -0300
Message-Id: <1467736712-11825-1-git-send-email-krisman@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

For 4K LBA or very large disks, atari_partition can easily get tricked
into thinking it has found an Atari partition table.  Depending on the
data in the disk, it ends up creating partitions with awkward lengths.

We saw logs like this while playing with fio.

[5.625867] nvme2n1: AHDI p2
[5.625872] nvme2n1: p2 size 2910030523 extends beyond EOD, truncated

People has had issues with misinterpreted AHDI partition tables for a long
time, see this BSD thread from 1995, for example.

https://mail-index.netbsd.org/port-atari/1995/11/19/0001.html

Since the atari partition, according to the spec, doesn't even support
sector sizes with more than 512, a quick sanity check is reasonable to
just bail out early, before even attempting to read sector 0.

Signed-off-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
---
 block/partitions/atari.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/partitions/atari.c b/block/partitions/atari.c
index 9875b05..ff1fb93 100644
--- a/block/partitions/atari.c
+++ b/block/partitions/atari.c
@@ -42,6 +42,13 @@ int atari_partition(struct parsed_partitions *state)
 	int part_fmt = 0; /* 0:unknown, 1:AHDI, 2:ICD/Supra */
 #endif
 
+	/*
+	 * ATARI partition scheme supports 512 lba only.  If this is not
+	 * the case, bail early to avoid miscalculating hd_size.
+	 */
+	if (bdev_logical_block_size(state->bdev) != 512)
+		return 0;
+
 	rs = read_part_sector(state, 0, &sect);
 	if (!rs)
 		return -1;
-- 
2.1.0
