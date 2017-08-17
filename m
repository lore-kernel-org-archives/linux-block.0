Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Omar Sandoval <osandov@fb.com>
Subject: [PATCH 05/12] blk-mq-debugfs: Declare a local symbol static
Date: Thu, 17 Aug 2017 16:23:04 -0700
Message-Id: <20170817232311.25948-6-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This was detected by sparse.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 55940ddacd96..e53b6129ca5a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -739,7 +739,7 @@ static int blk_mq_debugfs_release(struct inode *inode, struct file *file)
 		return seq_release(inode, file);
 }
 
-const struct file_operations blk_mq_debugfs_fops = {
+static const struct file_operations blk_mq_debugfs_fops = {
 	.open		= blk_mq_debugfs_open,
 	.read		= seq_read,
 	.write		= blk_mq_debugfs_write,
-- 
2.14.0
