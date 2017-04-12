Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Tyler Hicks <tyhicks@canonical.com>,
	ecryptfs@vger.kernel.org
Subject: [PATCH 11/25] ecryptfs: Convert to separately allocated bdi
Date: Wed, 12 Apr 2017 12:24:35 +0200
Message-Id: <20170412102449.16901-12-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: Tyler Hicks <tyhicks@canonical.com>
CC: ecryptfs@vger.kernel.org
Acked-by: Tyler Hicks <tyhicks@canonical.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ecryptfs/ecryptfs_kernel.h | 1 -
 fs/ecryptfs/main.c            | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 95c1c8d34539..9c351bf757b2 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -349,7 +349,6 @@ struct ecryptfs_mount_crypt_stat {
 struct ecryptfs_sb_info {
 	struct super_block *wsi_sb;
 	struct ecryptfs_mount_crypt_stat mount_crypt_stat;
-	struct backing_dev_info bdi;
 };
 
 /* file private data. */
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 151872dcc1f4..9014479d0160 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -519,12 +519,11 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 		goto out;
 	}
 
-	rc = bdi_setup_and_register(&sbi->bdi, "ecryptfs");
+	rc = super_setup_bdi(s);
 	if (rc)
 		goto out1;
 
 	ecryptfs_set_superblock_private(s, sbi);
-	s->s_bdi = &sbi->bdi;
 
 	/* ->kill_sb() will take care of sbi after that point */
 	sbi = NULL;
@@ -633,7 +632,6 @@ static void ecryptfs_kill_block_super(struct super_block *sb)
 	if (!sb_info)
 		return;
 	ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
-	bdi_destroy(&sb_info->bdi);
 	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
 }
 
-- 
2.12.0
