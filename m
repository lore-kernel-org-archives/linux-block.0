Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 23/25] fs: Remove SB_I_DYNBDI flag
Date: Wed, 12 Apr 2017 12:24:47 +0200
Message-Id: <20170412102449.16901-24-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Now that all bdi structures filesystems use are properly refcounted, we
can remove the SB_I_DYNBDI flag.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/mtd/mtdsuper.c | 1 -
 fs/gfs2/ops_fstype.c   | 1 -
 fs/nfs/super.c         | 1 -
 fs/nilfs2/super.c      | 1 -
 fs/super.c             | 5 +----
 include/linux/fs.h     | 3 ---
 6 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index e69e7855e31f..e43fea896d1e 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -53,7 +53,6 @@ static int get_sb_mtd_set(struct super_block *sb, void *_mtd)
 	sb->s_mtd = mtd;
 	sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
 	sb->s_bdi = bdi_get(mtd_bdi);
-	sb->s_iflags |= SB_I_DYNBDI;
 
 	return 0;
 }
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e6b6f97d0fc1..ed67548b286c 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1224,7 +1224,6 @@ static int set_gfs2_super(struct super_block *s, void *data)
 	s->s_bdev = data;
 	s->s_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
-	s->s_iflags |= SB_I_DYNBDI;
 	return 0;
 }
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 8d97aa70407e..dc69314d455e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2379,7 +2379,6 @@ int nfs_clone_super(struct super_block *sb, struct nfs_mount_info *mount_info)
  	nfs_initialise_sb(sb);
 
 	sb->s_bdi = bdi_get(old_sb->s_bdi);
-	sb->s_iflags |= SB_I_DYNBDI;
 
 	return 0;
 }
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index feb796a38b8d..926682981d61 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1069,7 +1069,6 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_max_links = NILFS_LINK_MAX;
 
 	sb->s_bdi = bdi_get(sb->s_bdev->bd_bdi);
-	sb->s_iflags |= SB_I_DYNBDI;
 
 	err = load_nilfs(nilfs, sb);
 	if (err)
diff --git a/fs/super.c b/fs/super.c
index e267d3a00144..8444d26926ef 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -446,10 +446,9 @@ void generic_shutdown_super(struct super_block *sb)
 	hlist_del_init(&sb->s_instances);
 	spin_unlock(&sb_lock);
 	up_write(&sb->s_umount);
-	if (sb->s_iflags & SB_I_DYNBDI) {
+	if (sb->s_bdi != &noop_backing_dev_info) {
 		bdi_put(sb->s_bdi);
 		sb->s_bdi = &noop_backing_dev_info;
-		sb->s_iflags &= ~SB_I_DYNBDI;
 	}
 }
 
@@ -1055,7 +1054,6 @@ static int set_bdev_super(struct super_block *s, void *data)
 	s->s_bdev = data;
 	s->s_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
-	s->s_iflags |= SB_I_DYNBDI;
 
 	return 0;
 }
@@ -1282,7 +1280,6 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	}
 	WARN_ON(sb->s_bdi != &noop_backing_dev_info);
 	sb->s_bdi = bdi;
-	sb->s_iflags |= SB_I_DYNBDI;
 
 	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98cf14ea78c0..30e5c14bd743 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1272,9 +1272,6 @@ struct mm_struct;
 /* sb->s_iflags to limit user namespace mounts */
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
 
-/* Temporary flag until all filesystems are converted to dynamic bdis */
-#define SB_I_DYNBDI	0x00000100
-
 /* Possible states of 'frozen' field */
 enum {
 	SB_UNFROZEN = 0,		/* FS is unfrozen */
-- 
2.12.0
