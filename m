Return-Path: <paolo.bonzini@gmail.com>
Return-Path: <paolo.bonzini@gmail.com>
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	hch@infradead.org
Subject: [PATCH v2] block: silently forbid sending any ioctl to a partition
Date: Wed, 10 Jan 2018 16:54:52 +0100
Message-Id: <20180110155452.26563-1-pbonzini@redhat.com>
List-ID: <linux-block@vger.kernel.org>

After the first few months, the message has not led to many bug reports.
It's been almost five years now, and in practice the main source of
it seems to be MTIOCGET that someone is using to detect tape devices.
While we could whitelist it just like CDROM_GET_CAPABILITY, this patch
just removes the message altogether.

The patch also removes the "safe but not very useful" ioctl whitelist,
as suggested by Christoph.  I doubt anything is using most of those
ioctls _in general_, let alone on a partition.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v1->v2: disable the legacy ioctls too, hence changing the patch subject

 block/scsi_ioctl.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index edcfff974527..07988eebb66a 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -692,38 +692,9 @@ int scsi_verify_blk_ioctl(struct block_device *bd, unsigned int cmd)
 	if (bd && bd == bd->bd_contains)
 		return 0;
 
-	/* Actually none of these is particularly useful on a partition,
-	 * but they are safe.
-	 */
-	switch (cmd) {
-	case SCSI_IOCTL_GET_IDLUN:
-	case SCSI_IOCTL_GET_BUS_NUMBER:
-	case SCSI_IOCTL_GET_PCI:
-	case SCSI_IOCTL_PROBE_HOST:
-	case SG_GET_VERSION_NUM:
-	case SG_SET_TIMEOUT:
-	case SG_GET_TIMEOUT:
-	case SG_GET_RESERVED_SIZE:
-	case SG_SET_RESERVED_SIZE:
-	case SG_EMULATED_HOST:
-		return 0;
-	case CDROM_GET_CAPABILITY:
-		/* Keep this until we remove the printk below.  udev sends it
-		 * and we do not want to spam dmesg about it.   CD-ROMs do
-		 * not have partitions, so we get here only for disks.
-		 */
-		return -ENOIOCTLCMD;
-	default:
-		break;
-	}
-
 	if (capable(CAP_SYS_RAWIO))
 		return 0;
 
-	/* In particular, rule out all resets and host-specific ioctls.  */
-	printk_ratelimited(KERN_WARNING
-			   "%s: sending ioctl %x to a partition!\n", current->comm, cmd);
-
 	return -ENOIOCTLCMD;
 }
 EXPORT_SYMBOL(scsi_verify_blk_ioctl);
-- 
2.14.3
