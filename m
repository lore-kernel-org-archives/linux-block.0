Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Damien.LeMoal@wdc.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: bgurney@redhat.com,
	Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH 2/2] block: default to deadline for host-managed SMR devices
Date: Fri, 25 May 2018 17:14:32 -0400
Message-Id: <20180525211432.20359-3-jmoyer@redhat.com>
In-Reply-To: <20180525211432.20359-1-jmoyer@redhat.com>
References: <20180525211432.20359-1-jmoyer@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Bryan Gurney reported a series of I/O errors resulting from using
CFQ with a host-managed SMR disk.  After commit 39051dd85f28 ("scsi:
sd: Remove zone write locking), which was merged in 4.16, users
should use one of the deadline I/O schedulers (unless applications
are very careful about only submitting 1 I/O per zone).  Change our
defaults to provide a working configuration.

Reported-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 block/blk-sysfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d00d1b0..ec2f29b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -908,6 +908,30 @@ int blk_register_queue(struct gendisk *disk)
 			return ret;
 		}
 	}
+
+	/*
+	 * Temporary work-around for host-managed SMR devices: right now,
+	 * the deadline I/O schedulers are the only ones that are SMR-
+	 * aware.  Use of other schedulers will almost always result
+	 * in I/O errors due to out-of-order writes to zones.  For now,
+	 * force deadline if we can.  The eventual goal is to get rid
+	 * of this in favor of a dispatch layer that would work with
+	 * all I/O schedulers.
+	 */
+	if (blk_queue_zoned_model(q) == BLK_ZONED_HM) {
+		ret = __elevator_change(q, "deadline", false);
+		if (ret == 0)
+			printk("%s: switched to deadline I/O scheduler for "
+			       "host-managed SMR device %s\n", __func__,
+			       disk->disk_name);
+		else {
+			printk("%s: warning: unable to switch to SMR-aware "
+			       "deadline I/O scheduler for host-managed SMR "
+			       "device %s\n", __func__, disk->disk_name);
+			printk("Consider building deadline and mq-deadline "
+			       "into your kernel (not as modules)\n");
+		}
+	}
 	ret = 0;
 unlock:
 	mutex_unlock(&q->sysfs_lock);
-- 
2.8.2.335.g4bb51ae
