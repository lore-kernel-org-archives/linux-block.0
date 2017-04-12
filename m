Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 22/25] ubifs: Convert to separately allocated bdi
Date: Wed, 12 Apr 2017 12:24:46 +0200
Message-Id: <20170412102449.16901-23-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: Richard Weinberger <richard@nod.at>
CC: Artem Bityutskiy <dedekind1@gmail.com>
CC: Adrian Hunter <adrian.hunter@intel.com>
CC: linux-mtd@lists.infradead.org
Acked-by: Richard Weinberger <richard@nod.at>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ubifs/super.c | 25 +++++++++----------------
 fs/ubifs/ubifs.h |  3 ---
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b73811bd7676..cf4cc99b75b5 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1827,7 +1827,6 @@ static void ubifs_put_super(struct super_block *sb)
 	}
 
 	ubifs_umount(c);
-	bdi_destroy(&c->bdi);
 	ubi_close_volume(c->ubi);
 	mutex_unlock(&c->umount_mutex);
 }
@@ -2019,29 +2018,25 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out;
 	}
 
+	err = ubifs_parse_options(c, data, 0);
+	if (err)
+		goto out_close;
+
 	/*
 	 * UBIFS provides 'backing_dev_info' in order to disable read-ahead. For
 	 * UBIFS, I/O is not deferred, it is done immediately in readpage,
 	 * which means the user would have to wait not just for their own I/O
 	 * but the read-ahead I/O as well i.e. completely pointless.
 	 *
-	 * Read-ahead will be disabled because @c->bdi.ra_pages is 0.
+	 * Read-ahead will be disabled because @sb->s_bdi->ra_pages is 0. Also
+	 * @sb->s_bdi->capabilities are initialized to 0 so there won't be any
+	 * writeback happening.
 	 */
-	c->bdi.name = "ubifs",
-	c->bdi.capabilities = 0;
-	err  = bdi_init(&c->bdi);
+	err = super_setup_bdi_name(sb, "ubifs_%d_%d", c->vi.ubi_num,
+				   c->vi.vol_id);
 	if (err)
 		goto out_close;
-	err = bdi_register(&c->bdi, NULL, "ubifs_%d_%d",
-			   c->vi.ubi_num, c->vi.vol_id);
-	if (err)
-		goto out_bdi;
-
-	err = ubifs_parse_options(c, data, 0);
-	if (err)
-		goto out_bdi;
 
-	sb->s_bdi = &c->bdi;
 	sb->s_fs_info = c;
 	sb->s_magic = UBIFS_SUPER_MAGIC;
 	sb->s_blocksize = UBIFS_BLOCK_SIZE;
@@ -2080,8 +2075,6 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 	ubifs_umount(c);
 out_unlock:
 	mutex_unlock(&c->umount_mutex);
-out_bdi:
-	bdi_destroy(&c->bdi);
 out_close:
 	ubi_close_volume(c->ubi);
 out:
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 4d57e488038e..4da10a6d702a 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -972,7 +972,6 @@ struct ubifs_debug_info;
  * struct ubifs_info - UBIFS file-system description data structure
  * (per-superblock).
  * @vfs_sb: VFS @struct super_block object
- * @bdi: backing device info object to make VFS happy and disable read-ahead
  *
  * @highest_inum: highest used inode number
  * @max_sqnum: current global sequence number
@@ -1220,7 +1219,6 @@ struct ubifs_debug_info;
  */
 struct ubifs_info {
 	struct super_block *vfs_sb;
-	struct backing_dev_info bdi;
 
 	ino_t highest_inum;
 	unsigned long long max_sqnum;
@@ -1461,7 +1459,6 @@ extern const struct inode_operations ubifs_file_inode_operations;
 extern const struct file_operations ubifs_dir_operations;
 extern const struct inode_operations ubifs_dir_inode_operations;
 extern const struct inode_operations ubifs_symlink_inode_operations;
-extern struct backing_dev_info ubifs_backing_dev_info;
 extern struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
 
 /* io.c */
-- 
2.12.0
