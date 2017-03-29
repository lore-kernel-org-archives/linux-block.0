Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 17/25] fuse: Get rid of bdi_initialized
Date: Wed, 29 Mar 2017 12:56:15 +0200
Message-Id: <20170329105623.18241-18-jack@suse.cz>
In-Reply-To: <20170329105623.18241-1-jack@suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

It is not needed anymore since bdi is initialized whenever superblock
exists.

CC: Miklos Szeredi <miklos@szeredi.hu>
CC: linux-fsdevel@vger.kernel.org
Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fuse/dev.c    | 5 ++---
 fs/fuse/fuse_i.h | 3 ---
 fs/fuse/inode.c  | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 78887f68ee6a..c2d7f3a92679 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -382,7 +382,7 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 			wake_up(&fc->blocked_waitq);
 
 		if (fc->num_background == fc->congestion_threshold &&
-		    fc->connected && fc->bdi_initialized) {
+		    fc->connected && fc->sb) {
 			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_SYNC);
 			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_ASYNC);
 		}
@@ -573,8 +573,7 @@ void fuse_request_send_background_locked(struct fuse_conn *fc,
 	fc->num_background++;
 	if (fc->num_background == fc->max_background)
 		fc->blocked = 1;
-	if (fc->num_background == fc->congestion_threshold &&
-	    fc->bdi_initialized) {
+	if (fc->num_background == fc->congestion_threshold && fc->sb) {
 		set_bdi_congested(fc->sb->s_bdi, BLK_RW_SYNC);
 		set_bdi_congested(fc->sb->s_bdi, BLK_RW_ASYNC);
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0e7c79a390e0..f33341d9501a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -527,9 +527,6 @@ struct fuse_conn {
 	/** Filesystem supports NFS exporting.  Only set in INIT */
 	unsigned export_support:1;
 
-	/** Set if bdi is valid */
-	unsigned bdi_initialized:1;
-
 	/** write-back cache policy (default is write-through) */
 	unsigned writeback_cache:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 90bacbc87fb3..73cf05135252 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -983,8 +983,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	/* fuse does it's own writeback accounting */
 	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
 
-	fc->bdi_initialized = 1;
-
 	/*
 	 * For a single fuse filesystem use max 1% of dirty +
 	 * writeback threshold.
-- 
2.10.2
