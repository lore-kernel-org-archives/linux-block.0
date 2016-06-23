Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@fb.com>
Cc: "Nicholas A . Bellinger" <nab@linux-iscsi.org>,
	Mike Christie <mchristi@redhat.com>,
	Andy Grover <agrover@redhat.com>,
	Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/3] block: provide helpers for reading block count
Date: Thu, 23 Jun 2016 15:30:14 +0200
Message-Id: <20160623133016.3781907-1-arnd@arndb.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Several drivers use an expensive do_div() to compute the number
of logical or physical blocks in a blockdev, which can be done
more efficiently using a shift, since the blocksize is always
a power of two number.

Let's introduce bdev_logical_block_count() and bdev_physical_block_count()
helper functions mirroring the bdev_logical_block_size() and
bdev_physical_block_size() interfaces for the block size.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 include/linux/blkdev.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9d1e0a4650dc..ae8c408f6c22 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1226,6 +1226,13 @@ static inline unsigned short bdev_logical_block_size(struct block_device *bdev)
 	return queue_logical_block_size(bdev_get_queue(bdev));
 }
 
+static inline sector_t bdev_logical_block_count(struct block_device *bdev)
+{
+	unsigned int block_shift = ilog2(bdev_logical_block_size(bdev));
+
+	return bdev->bd_inode->i_size >> block_shift;
+}
+
 static inline unsigned int queue_physical_block_size(struct request_queue *q)
 {
 	return q->limits.physical_block_size;
@@ -1236,6 +1243,13 @@ static inline unsigned int bdev_physical_block_size(struct block_device *bdev)
 	return queue_physical_block_size(bdev_get_queue(bdev));
 }
 
+static inline sector_t bdev_physical_block_count(struct block_device *bdev)
+{
+	unsigned int block_shift = ilog2(bdev_physical_block_size(bdev));
+
+	return bdev->bd_inode->i_size >> block_shift;
+}
+
 static inline unsigned int queue_io_min(struct request_queue *q)
 {
 	return q->limits.io_min;
-- 
2.9.0

