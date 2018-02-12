Return-Path: <prvs=5743cbe84=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"David S . Miller" <davem@davemloft.net>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] block: Move SECTOR_SIZE and SECTOR_SHIFT definitions into <linux/blkdev.h>
Date: Mon, 12 Feb 2018 11:05:35 -0800
Message-Id: <20180212190535.30057-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

It happens often while I'm preparing a patch for a block driver that
I'm wondering: is a definition of SECTOR_SIZE and/or SECTOR_SHIFT
available for this driver? Do I have to introduce definitions of these
constants before I can use these constants? To avoid this confusion,
move the existing definitions of SECTOR_SIZE and SECTOR_SHIFT into the
<linux/blkdev.h> header file such that these become available for all
block drivers.

An enum has been used to define these constants to avoid that the
remaining SECTOR_SIZE / SECTOR_SHIFT definitions would conflict with
the definitions from <linux/blkdev.h>.

Note: the SECTOR_SIZE / SECTOR_SHIFT / SECTOR_BITS definitions have
not been removed from uapi header files nor from NAND drivers in
which these constants are used for another purpose than converting
block layer offsets and sizes into a number of sectors.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
---
 arch/xtensa/platforms/iss/simdisk.c |  1 -
 drivers/block/brd.c                 |  1 -
 drivers/block/null_blk.c            |  2 --
 drivers/block/zram/zram_drv.h       |  1 -
 drivers/ide/ide-cd.c                |  8 ++++----
 drivers/ide/ide-cd.h                |  6 +-----
 drivers/nvdimm/nd.h                 |  1 -
 drivers/scsi/gdth.h                 |  3 ---
 include/linux/blkdev.h              | 40 +++++++++++++++++++++++++++----------
 include/linux/device-mapper.h       |  2 --
 include/linux/ide.h                 |  1 -
 11 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 1b6418407467..026211e7ab09 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -21,7 +21,6 @@
 #include <platform/simcall.h>
 
 #define SIMDISK_MAJOR 240
-#define SECTOR_SHIFT 9
 #define SIMDISK_MINORS 1
 #define MAX_SIMDISK_COUNT 10
 
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 8028a3a7e7fd..39a7fac9cb1a 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -24,7 +24,6 @@
 
 #include <linux/uaccess.h>
 
-#define SECTOR_SHIFT		9
 #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 2079d08ffcfc..dcebbf29a292 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -16,10 +16,8 @@
 #include <linux/badblocks.h>
 #include <linux/fault-inject.h>
 
-#define SECTOR_SHIFT		9
 #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
-#define SECTOR_SIZE		(1 << SECTOR_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
 #define FREE_BATCH		16
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 31762db861e3..1e9bf65c0bfb 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -37,7 +37,6 @@ static const size_t max_zpage_size = PAGE_SIZE / 4 * 3;
 
 /*-- End of configurable params */
 
-#define SECTOR_SHIFT		9
 #define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
 #define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
 #define ZRAM_LOGICAL_BLOCK_SHIFT 12
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 7c3ed7c9af77..9bf8de69ce79 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -712,7 +712,7 @@ static ide_startstop_t cdrom_start_rw(ide_drive_t *drive, struct request *rq)
 	struct request_queue *q = drive->queue;
 	int write = rq_data_dir(rq) == WRITE;
 	unsigned short sectors_per_frame =
-		queue_logical_block_size(q) >> SECTOR_BITS;
+		queue_logical_block_size(q) >> SECTOR_SHIFT;
 
 	ide_debug_log(IDE_DBG_RQ, "rq->cmd[0]: 0x%x, rq->cmd_flags: 0x%x, "
 				  "secs_per_frame: %u",
@@ -919,7 +919,7 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 	 * end up being bogus.
 	 */
 	blocklen = be32_to_cpu(capbuf.blocklen);
-	blocklen = (blocklen >> SECTOR_BITS) << SECTOR_BITS;
+	blocklen = (blocklen >> SECTOR_SHIFT) << SECTOR_SHIFT;
 	switch (blocklen) {
 	case 512:
 	case 1024:
@@ -935,7 +935,7 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 	}
 
 	*capacity = 1 + be32_to_cpu(capbuf.lba);
-	*sectors_per_frame = blocklen >> SECTOR_BITS;
+	*sectors_per_frame = blocklen >> SECTOR_SHIFT;
 
 	ide_debug_log(IDE_DBG_PROBE, "cap: %lu, sectors_per_frame: %lu",
 				     *capacity, *sectors_per_frame);
@@ -1012,7 +1012,7 @@ int ide_cd_read_toc(ide_drive_t *drive, struct request_sense *sense)
 	drive->probed_capacity = toc->capacity * sectors_per_frame;
 
 	blk_queue_logical_block_size(drive->queue,
-				     sectors_per_frame << SECTOR_BITS);
+				     sectors_per_frame << SECTOR_SHIFT);
 
 	/* first read just the header, so we know how long the TOC is */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 264e822eba58..04f0f310a856 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -21,11 +21,7 @@
 
 /************************************************************************/
 
-#define SECTOR_BITS 		9
-#ifndef SECTOR_SIZE
-#define SECTOR_SIZE		(1 << SECTOR_BITS)
-#endif
-#define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
+#define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_SHIFT)
 #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
 
 /* Capabilities Page size including 8 bytes of Mode Page Header */
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 8d6375ee0fda..184e070d50a2 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -29,7 +29,6 @@ enum {
 	 * BTT instance
 	 */
 	ND_MAX_LANES = 256,
-	SECTOR_SHIFT = 9,
 	INT_LBASIZE_ALIGNMENT = 64,
 	NVDIMM_IO_ATOMIC = 1,
 };
diff --git a/drivers/scsi/gdth.h b/drivers/scsi/gdth.h
index 95fc720c1b30..e6e5ccb1e0f3 100644
--- a/drivers/scsi/gdth.h
+++ b/drivers/scsi/gdth.h
@@ -178,9 +178,6 @@
 #define MSG_SIZE        34                      /* size of message structure */
 #define MSG_REQUEST     0                       /* async. event: message */
 
-/* cacheservice defines */
-#define SECTOR_SIZE     0x200                   /* always 512 bytes per sec. */
-
 /* DPMEM constants */
 #define DPMEM_MAGIC     0xC0FFEE11
 #define IC_HEADER_BYTES 48
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ac4740cf74be..cf17626604c2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1026,14 +1026,25 @@ static inline int blk_rq_cur_bytes(const struct request *rq)
 
 extern unsigned int blk_rq_err_bytes(const struct request *rq);
 
+/*
+ * Variables of type sector_t represent an offset or size that is a multiple of
+ * 2**9 bytes. Hence these two constants.
+ */
+#ifndef SECTOR_SHIFT
+enum { SECTOR_SHIFT = 9 };
+#endif
+#ifndef SECTOR_SIZE
+enum { SECTOR_SIZE = 512 };
+#endif
+
 static inline unsigned int blk_rq_sectors(const struct request *rq)
 {
-	return blk_rq_bytes(rq) >> 9;
+	return blk_rq_bytes(rq) >> SECTOR_SHIFT;
 }
 
 static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
 {
-	return blk_rq_cur_bytes(rq) >> 9;
+	return blk_rq_cur_bytes(rq) >> SECTOR_SHIFT;
 }
 
 static inline unsigned int blk_rq_zone_no(struct request *rq)
@@ -1063,7 +1074,8 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     int op)
 {
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
-		return min(q->limits.max_discard_sectors, UINT_MAX >> 9);
+		return min(q->limits.max_discard_sectors,
+			   UINT_MAX >> SECTOR_SHIFT);
 
 	if (unlikely(op == REQ_OP_WRITE_SAME))
 		return q->limits.max_write_same_sectors;
@@ -1375,16 +1387,21 @@ extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 static inline int sb_issue_discard(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask, unsigned long flags)
 {
-	return blkdev_issue_discard(sb->s_bdev, block << (sb->s_blocksize_bits - 9),
-				    nr_blocks << (sb->s_blocksize_bits - 9),
+	return blkdev_issue_discard(sb->s_bdev,
+				    block << (sb->s_blocksize_bits -
+					      SECTOR_SHIFT),
+				    nr_blocks << (sb->s_blocksize_bits -
+						  SECTOR_SHIFT),
 				    gfp_mask, flags);
 }
 static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask)
 {
 	return blkdev_issue_zeroout(sb->s_bdev,
-				    block << (sb->s_blocksize_bits - 9),
-				    nr_blocks << (sb->s_blocksize_bits - 9),
+				    block << (sb->s_blocksize_bits -
+					      SECTOR_SHIFT),
+				    nr_blocks << (sb->s_blocksize_bits -
+						  SECTOR_SHIFT),
 				    gfp_mask, 0);
 }
 
@@ -1491,7 +1508,8 @@ static inline int queue_alignment_offset(struct request_queue *q)
 static inline int queue_limit_alignment_offset(struct queue_limits *lim, sector_t sector)
 {
 	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
-	unsigned int alignment = sector_div(sector, granularity >> 9) << 9;
+	unsigned int alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
+		<< SECTOR_SHIFT;
 
 	return (granularity + lim->alignment_offset - alignment) % granularity;
 }
@@ -1525,8 +1543,8 @@ static inline int queue_limit_discard_alignment(struct queue_limits *lim, sector
 		return 0;
 
 	/* Why are these in bytes, not sectors? */
-	alignment = lim->discard_alignment >> 9;
-	granularity = lim->discard_granularity >> 9;
+	alignment = lim->discard_alignment >> SECTOR_SHIFT;
+	granularity = lim->discard_granularity >> SECTOR_SHIFT;
 	if (!granularity)
 		return 0;
 
@@ -1537,7 +1555,7 @@ static inline int queue_limit_discard_alignment(struct queue_limits *lim, sector
 	offset = (granularity + alignment - offset) % granularity;
 
 	/* Turn it back into bytes, gaah */
-	return offset << 9;
+	return offset << SECTOR_SHIFT;
 }
 
 static inline int bdev_discard_alignment(struct block_device *bdev)
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index da83f64952e7..4384433b50e7 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -542,8 +542,6 @@ do {									\
 #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
 			  0 : scnprintf(result + sz, maxlen - sz, x))
 
-#define SECTOR_SHIFT 9
-
 /*
  * Definitions of return values from target end_io function.
  */
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 771989d25ef8..0acfa62b1d44 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -165,7 +165,6 @@ struct ide_io_ports {
  */
 #define PARTN_BITS	6	/* number of minor dev bits for partitions */
 #define MAX_DRIVES	2	/* per interface; 2 assumed by lots of code */
-#define SECTOR_SIZE	512
 
 /*
  * Timeouts for various operations:
-- 
2.16.1
