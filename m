Return-Path: <scott.bauer@intel.com>
From: Scott Bauer <scott.bauer@intel.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	dan.carpenter@oracle.com,
	linux-block@vger.kernel.org,
	Scott Bauer <scott.bauer@intel.com>,
	Scott Bauer <sbauer@plzdonthack.me>,
	stable@vger.kernel.org
Subject: [PATCH] cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status
Date: Thu, 26 Apr 2018 11:51:08 -0600
Message-Id: <20180426175108.29280-1-scott.bauer@intel.com>
List-ID: <linux-block@vger.kernel.org>

Like d88b6d04: "cdrom: information leak in cdrom_ioctl_media_changed()"

There is another cast from unsigned long to int which causes
a bounds check to fail with specially crafted input. The value is
then used as an index in the slot array in cdrom_slot_status().

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Scott Bauer <sbauer@plzdonthack.me>
Cc: stable@vger.kernel.org
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index bfc566d3f31a..8cfa10ab7abc 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2542,7 +2542,7 @@ static int cdrom_ioctl_drive_status(struct cdrom_device_info *cdi,
 	if (!CDROM_CAN(CDC_SELECT_DISC) ||
 	    (arg == CDSL_CURRENT || arg == CDSL_NONE))
 		return cdi->ops->drive_status(cdi, CDSL_CURRENT);
-	if (((int)arg >= cdi->capacity))
+	if (arg >= cdi->capacity)
 		return -EINVAL;
 	return cdrom_slot_status(cdi, arg);
 }
-- 
2.14.1
