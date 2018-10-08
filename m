Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Shenghui Wang <shhuiw@foxmail.com>,
	Coly Li <colyli@suse.de>
Subject: [PATCH 01/15] bcache: account size of buckets used in uuid write to ca->meta_sectors_written
Date: Mon,  8 Oct 2018 20:41:07 +0800
Message-Id: <20181008124121.20192-2-colyli@suse.de>
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
References: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Shenghui Wang <shhuiw@foxmail.com>

UUIDs are considered as metadata. __uuid_write should add the number
of buckets (in sectors) written to disk to ca->meta_sectors_written.
Currently only 1 bucket is used in uuid write.

Steps to test:
1) create a fresh backing device and a fresh cache device separately.
   The backing device didn't attach to any cache set.
2) cd /sys/block/<cache device>/bcache
   cat metadata_written      // record the output value
   cat bucket_size
3) attach the backing device to cache set
4) cat metadata_written
   The output value is almost the same as the value in step 2
   before the change.
   After the change, the value is bigger about 1 bucket size.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Reviewed-by: Tang Junhui <tang.junhui.linux@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 94c756c66bd7..448e531e8c2d 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -417,6 +417,7 @@ static int __uuid_write(struct cache_set *c)
 {
 	BKEY_PADDED(key) k;
 	struct closure cl;
+	struct cache *ca;
 
 	closure_init_stack(&cl);
 	lockdep_assert_held(&bch_register_lock);
@@ -428,6 +429,10 @@ static int __uuid_write(struct cache_set *c)
 	uuid_io(c, REQ_OP_WRITE, 0, &k.key, &cl);
 	closure_sync(&cl);
 
+	/* Only one bucket used for uuid write */
+	ca = PTR_CACHE(c, &k.key, 0);
+	atomic_long_add(ca->sb.bucket_size, &ca->meta_sectors_written);
+
 	bkey_copy(&c->uuid_bucket, &k.key);
 	bkey_put(c, &k.key);
 	return 0;
-- 
2.19.0
