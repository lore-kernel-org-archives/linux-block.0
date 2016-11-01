Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/16] block, fs: move submit_bio to bio.h
Date: Tue,  1 Nov 2016 07:40:12 -0600
Message-Id: <1478007617-18715-12-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

This is where all the other bio operations live, so users must include
bio.h anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 2 ++
 include/linux/fs.h  | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index fe9a170..5c604b49 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -404,6 +404,8 @@ static inline struct bio *bio_clone_kmalloc(struct bio *bio, gfp_t gfp_mask)
 
 }
 
+extern blk_qc_t submit_bio(struct bio *);
+
 extern void bio_endio(struct bio *);
 
 static inline void bio_io_error(struct bio *bio)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0ad36e0..5b0a9b7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2717,7 +2717,6 @@ static inline void remove_inode_hash(struct inode *inode)
 extern void inode_sb_list_add(struct inode *inode);
 
 #ifdef CONFIG_BLOCK
-extern blk_qc_t submit_bio(struct bio *);
 extern int bdev_read_only(struct block_device *);
 #endif
 extern int set_blocksize(struct block_device *, int);
-- 
2.1.4

