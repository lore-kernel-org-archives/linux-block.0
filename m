Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34109 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdIUOt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 10:49:29 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: axboe@kernel.de, linux-block@vger.kernel.org
Subject: [PATCH] block: drop "sending ioctl to a partition" message
Date: Thu, 21 Sep 2017 16:49:22 +0200
Message-Id: <1506005362-13429-1-git-send-email-pbonzini@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

After the first few months, the message has not led to many bug reports.
It's been almost five years now, and in practice the main source of
it seems to be MTIOCGET that someone is using to detect tape devices.
While we could whitelist it just like CDROM_GET_CAPABILITY, this patch
just removes the message altogether.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/scsi_ioctl.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 7440de44dd85..eafcd67e2480 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -707,24 +707,10 @@ int scsi_verify_blk_ioctl(struct block_device *bd, unsigned int cmd)
 	case SG_SET_RESERVED_SIZE:
 	case SG_EMULATED_HOST:
 		return 0;
-	case CDROM_GET_CAPABILITY:
-		/* Keep this until we remove the printk below.  udev sends it
-		 * and we do not want to spam dmesg about it.   CD-ROMs do
-		 * not have partitions, so we get here only for disks.
-		 */
-		return -ENOIOCTLCMD;
 	default:
-		break;
+		/* In particular, rule out all resets and host-specific ioctls.  */
+		return capable(CAP_SYS_RAWIO) ? 0 : -ENOIOCTLCMD;
 	}
-
-	if (capable(CAP_SYS_RAWIO))
-		return 0;
-
-	/* In particular, rule out all resets and host-specific ioctls.  */
-	printk_ratelimited(KERN_WARNING
-			   "%s: sending ioctl %x to a partition!\n", current->comm, cmd);
-
-	return -ENOIOCTLCMD;
 }
 EXPORT_SYMBOL(scsi_verify_blk_ioctl);
 
-- 
1.8.3.1
