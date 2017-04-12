Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Boaz Harrosh <ooo@electrozaur.com>,
	Benny Halevy <bhalevy@primarydata.com>
Subject: [PATCH 15/25] exofs: Convert to separately allocated bdi
Date: Wed, 12 Apr 2017 12:24:39 +0200
Message-Id: <20170412102449.16901-16-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: Boaz Harrosh <ooo@electrozaur.com>
CC: Benny Halevy <bhalevy@primarydata.com>
Acked-by: Boaz Harrosh <ooo@electrozaur.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/exofs/exofs.h |  1 -
 fs/exofs/super.c | 17 ++++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/exofs/exofs.h b/fs/exofs/exofs.h
index 2e86086bc940..5dc392404559 100644
--- a/fs/exofs/exofs.h
+++ b/fs/exofs/exofs.h
@@ -64,7 +64,6 @@ struct exofs_dev {
  * our extension to the in-memory superblock
  */
 struct exofs_sb_info {
-	struct backing_dev_info bdi;		/* register our bdi with VFS  */
 	struct exofs_sb_stats s_ess;		/* Written often, pre-allocate*/
 	int		s_timeout;		/* timeout for OSD operations */
 	uint64_t	s_nextid;		/* highest object ID used     */
diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index 1076a4233b39..819624cfc8da 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -464,7 +464,6 @@ static void exofs_put_super(struct super_block *sb)
 			    sbi->one_comp.obj.partition);
 
 	exofs_sysfs_sb_del(sbi);
-	bdi_destroy(&sbi->bdi);
 	exofs_free_sbi(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -809,8 +808,12 @@ static int exofs_fill_super(struct super_block *sb, void *data, int silent)
 	__sbi_read_stats(sbi);
 
 	/* set up operation vectors */
-	sbi->bdi.ra_pages = __ra_pages(&sbi->layout);
-	sb->s_bdi = &sbi->bdi;
+	ret = super_setup_bdi(sb);
+	if (ret) {
+		EXOFS_DBGMSG("Failed to super_setup_bdi\n");
+		goto free_sbi;
+	}
+	sb->s_bdi->ra_pages = __ra_pages(&sbi->layout);
 	sb->s_fs_info = sbi;
 	sb->s_op = &exofs_sops;
 	sb->s_export_op = &exofs_export_ops;
@@ -836,14 +839,6 @@ static int exofs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_sbi;
 	}
 
-	ret = bdi_setup_and_register(&sbi->bdi, "exofs");
-	if (ret) {
-		EXOFS_DBGMSG("Failed to bdi_setup_and_register\n");
-		dput(sb->s_root);
-		sb->s_root = NULL;
-		goto free_sbi;
-	}
-
 	exofs_sysfs_dbg_print();
 	_exofs_print_device("Mounting", opts->dev_name,
 			    ore_comp_dev(&sbi->oc, 0),
-- 
2.12.0
