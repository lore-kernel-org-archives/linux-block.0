Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v3 16/17] bcache: remove unnecessary space before ioctl function pointer arguments
Date: Sat, 11 Aug 2018 13:19:59 +0800
Message-Id: <20180811052000.103680-17-colyli@suse.de>
In-Reply-To: <20180811052000.103680-1-colyli@suse.de>
References: <20180811052000.103680-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

This is warned by checkpatch.pl, this patch removes the extra space.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/bcache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 66e6d5639b38..83504dd8100a 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -275,8 +275,8 @@ struct bcache_device {
 
 	int (*cache_miss)(struct btree *b, struct search *s,
 			  struct bio *bio, unsigned int sectors);
-	int (*ioctl) (struct bcache_device *d, fmode_t mode,
-		      unsigned int cmd, unsigned long arg);
+	int (*ioctl)(struct bcache_device *d, fmode_t mode,
+		     unsigned int cmd, unsigned long arg);
 };
 
 struct io {
-- 
2.18.0
