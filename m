Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 16/25] fuse: Convert to separately allocated bdi
Date: Wed, 12 Apr 2017 12:24:40 +0200
Message-Id: <20170412102449.16901-17-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: Miklos Szeredi <miklos@szeredi.hu>
CC: linux-fsdevel@vger.kernel.org
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fuse/dev.c    |  8 ++++----
 fs/fuse/fuse_i.h |  3 ---
 fs/fuse/inode.c  | 42 +++++++++++++-----------------------------
 3 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b681b43c766e..78887f68ee6a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -383,8 +383,8 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 
 		if (fc->num_background == fc->congestion_threshold &&
 		    fc->connected && fc->bdi_initialized) {
-			clear_bdi_congested(&fc->bdi, BLK_RW_SYNC);
-			clear_bdi_congested(&fc->bdi, BLK_RW_ASYNC);
+			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_SYNC);
+			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_ASYNC);
 		}
 		fc->num_background--;
 		fc->active_background--;
@@ -575,8 +575,8 @@ void fuse_request_send_background_locked(struct fuse_conn *fc,
 		fc->blocked = 1;
 	if (fc->num_background == fc->congestion_threshold &&
 	    fc->bdi_initialized) {
-		set_bdi_congested(&fc->bdi, BLK_RW_SYNC);
-		set_bdi_congested(&fc->bdi, BLK_RW_ASYNC);
+		set_bdi_congested(fc->sb->s_bdi, BLK_RW_SYNC);
+		set_bdi_congested(fc->sb->s_bdi, BLK_RW_ASYNC);
 	}
 	list_add_tail(&req->list, &fc->bg_queue);
 	flush_bg_queue(fc);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 32ac2c9b09c0..0e7c79a390e0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -631,9 +631,6 @@ struct fuse_conn {
 	/** Negotiated minor version */
 	unsigned minor;
 
-	/** Backing dev info */
-	struct backing_dev_info bdi;
-
 	/** Entry on the fuse_conn_list */
 	struct list_head entry;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6fe6a88ecb4a..90bacbc87fb3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -386,12 +386,6 @@ static void fuse_send_destroy(struct fuse_conn *fc)
 	}
 }
 
-static void fuse_bdi_destroy(struct fuse_conn *fc)
-{
-	if (fc->bdi_initialized)
-		bdi_destroy(&fc->bdi);
-}
-
 static void fuse_put_super(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
@@ -403,7 +397,6 @@ static void fuse_put_super(struct super_block *sb)
 	list_del(&fc->entry);
 	fuse_ctl_remove_conn(fc);
 	mutex_unlock(&fuse_mutex);
-	fuse_bdi_destroy(fc);
 
 	fuse_conn_put(fc);
 }
@@ -928,7 +921,8 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 			fc->no_flock = 1;
 		}
 
-		fc->bdi.ra_pages = min(fc->bdi.ra_pages, ra_pages);
+		fc->sb->s_bdi->ra_pages =
+				min(fc->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
 		fc->max_write = max_t(unsigned, 4096, fc->max_write);
@@ -944,7 +938,7 @@ static void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 
 	arg->major = FUSE_KERNEL_VERSION;
 	arg->minor = FUSE_KERNEL_MINOR_VERSION;
-	arg->max_readahead = fc->bdi.ra_pages * PAGE_SIZE;
+	arg->max_readahead = fc->sb->s_bdi->ra_pages * PAGE_SIZE;
 	arg->flags |= FUSE_ASYNC_READ | FUSE_POSIX_LOCKS | FUSE_ATOMIC_O_TRUNC |
 		FUSE_EXPORT_SUPPORT | FUSE_BIG_WRITES | FUSE_DONT_MASK |
 		FUSE_SPLICE_WRITE | FUSE_SPLICE_MOVE | FUSE_SPLICE_READ |
@@ -976,27 +970,20 @@ static void fuse_free_conn(struct fuse_conn *fc)
 static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 {
 	int err;
+	char *suffix = "";
 
-	fc->bdi.name = "fuse";
-	fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
-	/* fuse does it's own writeback accounting */
-	fc->bdi.capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
-
-	err = bdi_init(&fc->bdi);
+	if (sb->s_bdev)
+		suffix = "-fuseblk";
+	err = super_setup_bdi_name(sb, "%u:%u%s", MAJOR(fc->dev),
+				   MINOR(fc->dev), suffix);
 	if (err)
 		return err;
 
-	fc->bdi_initialized = 1;
-
-	if (sb->s_bdev) {
-		err =  bdi_register(&fc->bdi, NULL, "%u:%u-fuseblk",
-				    MAJOR(fc->dev), MINOR(fc->dev));
-	} else {
-		err = bdi_register_dev(&fc->bdi, fc->dev);
-	}
+	sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
+	/* fuse does it's own writeback accounting */
+	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
 
-	if (err)
-		return err;
+	fc->bdi_initialized = 1;
 
 	/*
 	 * For a single fuse filesystem use max 1% of dirty +
@@ -1010,7 +997,7 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	 *
 	 *    /sys/class/bdi/<bdi>/max_ratio
 	 */
-	bdi_set_max_ratio(&fc->bdi, 1);
+	bdi_set_max_ratio(sb->s_bdi, 1);
 
 	return 0;
 }
@@ -1113,8 +1100,6 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto err_dev_free;
 
-	sb->s_bdi = &fc->bdi;
-
 	/* Handle umasking inside the fuse code */
 	if (sb->s_flags & MS_POSIXACL)
 		fc->dont_mask = 1;
@@ -1182,7 +1167,6 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
  err_dev_free:
 	fuse_dev_free(fud);
  err_put_conn:
-	fuse_bdi_destroy(fc);
 	fuse_conn_put(fc);
  err_fput:
 	fput(file);
-- 
2.12.0
