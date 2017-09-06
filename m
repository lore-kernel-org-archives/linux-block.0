Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk
Cc: bcache@lists.ewheeler.net,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH 01/12] bcache: Fix leak of bdev reference
Date: Wed,  6 Sep 2017 14:25:51 +0800
Message-Id: <20170906062602.50497-2-colyli@suse.de>
In-Reply-To: <20170906062602.50497-1-colyli@suse.de>
References: <20170906062602.50497-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Jan Kara <jack@suse.cz>

If blkdev_get_by_path() in register_bcache() fails, we try to lookup the
block device using lookup_bdev() to detect which situation we are in to
properly report error. However we never drop the reference returned to
us from lookup_bdev(). Fix that.

Signed-off-by: Jan Kara <jack@suse.cz>
Acked-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 8352fad765f6..9a2c190745b6 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1964,6 +1964,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			else
 				err = "device busy";
 			mutex_unlock(&bch_register_lock);
+			if (!IS_ERR(bdev))
+				bdput(bdev);
 			if (attr == &ksysfs_register_quiet)
 				goto out;
 		}
-- 
2.13.5
