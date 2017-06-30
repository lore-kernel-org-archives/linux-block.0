Return-Path: <bcache@lists.ewheeler.net>
From: bcache@lists.ewheeler.net
To: linux-block@vger.kernel.org
Cc: linux-bcache@vger.kernel.org,
	hch@infradead.org,
	axboe@kernel.dk,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH 01/19] bcache: Fix leak of bdev reference
Date: Fri, 30 Jun 2017 13:42:50 -0700
Message-Id: <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net>
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
List-ID: <linux-block@vger.kernel.org>

From: Jan Kara <jack@suse.cz>

If blkdev_get_by_path() in register_bcache() fails, we try to lookup the
block device using lookup_bdev() to detect which situation we are in to
properly report error. However we never drop the reference returned to
us from lookup_bdev(). Fix that.

Signed-off-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 8352fad..9a2c190 100644
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
1.8.3.1
