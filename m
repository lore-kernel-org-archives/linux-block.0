Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        ceph-devel@vger.kernel.org
Subject: [PATCH 09/25] ceph: Convert to separately allocated bdi
Date: Wed, 12 Apr 2017 12:24:33 +0200
Message-Id: <20170412102449.16901-10-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside client structure. This unifies handling of bdi among users.

CC: Ilya Dryomov <idryomov@gmail.com>
CC: "Yan, Zheng" <zyan@redhat.com>
CC: Sage Weil <sage@redhat.com>
CC: ceph-devel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ceph/addr.c    |  6 +++---
 fs/ceph/debugfs.c |  2 +-
 fs/ceph/super.c   | 35 +++++++++++++----------------------
 fs/ceph/super.h   |  2 --
 4 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1a3e1b40799a..9ecb2fd348cb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -578,7 +578,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	writeback_stat = atomic_long_inc_return(&fsc->writeback_count);
 	if (writeback_stat >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
-		set_bdi_congested(&fsc->backing_dev_info, BLK_RW_ASYNC);
+		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
 
 	set_page_writeback(page);
 	err = ceph_osdc_writepages(osdc, ceph_vino(inode),
@@ -700,7 +700,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 			if (atomic_long_dec_return(&fsc->writeback_count) <
 			     CONGESTION_OFF_THRESH(
 					fsc->mount_options->congestion_kb))
-				clear_bdi_congested(&fsc->backing_dev_info,
+				clear_bdi_congested(inode_to_bdi(inode),
 						    BLK_RW_ASYNC);
 
 			if (rc < 0)
@@ -979,7 +979,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			if (atomic_long_inc_return(&fsc->writeback_count) >
 			    CONGESTION_ON_THRESH(
 				    fsc->mount_options->congestion_kb)) {
-				set_bdi_congested(&fsc->backing_dev_info,
+				set_bdi_congested(inode_to_bdi(inode),
 						  BLK_RW_ASYNC);
 			}
 
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index f2ae393e2c31..3ef11bc8d728 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -251,7 +251,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 		goto out;
 
 	snprintf(name, sizeof(name), "../../bdi/%s",
-		 dev_name(fsc->backing_dev_info.dev));
+		 dev_name(fsc->sb->s_bdi->dev));
 	fsc->debugfs_bdi =
 		debugfs_create_symlink("bdi",
 				       fsc->client->debugfs_dir,
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 0ec8d0114e57..a8c81b2052ca 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -579,10 +579,6 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 
 	atomic_long_set(&fsc->writeback_count, 0);
 
-	err = bdi_init(&fsc->backing_dev_info);
-	if (err < 0)
-		goto fail_client;
-
 	err = -ENOMEM;
 	/*
 	 * The number of concurrent works can be high but they don't need
@@ -590,7 +586,7 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	 */
 	fsc->wb_wq = alloc_workqueue("ceph-writeback", 0, 1);
 	if (fsc->wb_wq == NULL)
-		goto fail_bdi;
+		goto fail_client;
 	fsc->pg_inv_wq = alloc_workqueue("ceph-pg-invalid", 0, 1);
 	if (fsc->pg_inv_wq == NULL)
 		goto fail_wb_wq;
@@ -624,8 +620,6 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	destroy_workqueue(fsc->pg_inv_wq);
 fail_wb_wq:
 	destroy_workqueue(fsc->wb_wq);
-fail_bdi:
-	bdi_destroy(&fsc->backing_dev_info);
 fail_client:
 	ceph_destroy_client(fsc->client);
 fail:
@@ -643,8 +637,6 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 	destroy_workqueue(fsc->pg_inv_wq);
 	destroy_workqueue(fsc->trunc_wq);
 
-	bdi_destroy(&fsc->backing_dev_info);
-
 	mempool_destroy(fsc->wb_pagevec_pool);
 
 	destroy_mount_options(fsc->mount_options);
@@ -937,33 +929,32 @@ static int ceph_compare_super(struct super_block *sb, void *data)
  */
 static atomic_long_t bdi_seq = ATOMIC_LONG_INIT(0);
 
-static int ceph_register_bdi(struct super_block *sb,
-			     struct ceph_fs_client *fsc)
+static int ceph_setup_bdi(struct super_block *sb, struct ceph_fs_client *fsc)
 {
 	int err;
 
+	err = super_setup_bdi_name(sb, "ceph-%ld",
+				   atomic_long_inc_return(&bdi_seq));
+	if (err)
+		return err;
+
 	/* set ra_pages based on rasize mount option? */
 	if (fsc->mount_options->rasize >= PAGE_SIZE)
-		fsc->backing_dev_info.ra_pages =
+		sb->s_bdi->ra_pages =
 			(fsc->mount_options->rasize + PAGE_SIZE - 1)
 			>> PAGE_SHIFT;
 	else
-		fsc->backing_dev_info.ra_pages =
-			VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
+		sb->s_bdi->ra_pages = VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
 
 	if (fsc->mount_options->rsize > fsc->mount_options->rasize &&
 	    fsc->mount_options->rsize >= PAGE_SIZE)
-		fsc->backing_dev_info.io_pages =
+		sb->s_bdi->io_pages =
 			(fsc->mount_options->rsize + PAGE_SIZE - 1)
 			>> PAGE_SHIFT;
 	else if (fsc->mount_options->rsize == 0)
-		fsc->backing_dev_info.io_pages = ULONG_MAX;
+		sb->s_bdi->io_pages = ULONG_MAX;
 
-	err = bdi_register(&fsc->backing_dev_info, NULL, "ceph-%ld",
-			   atomic_long_inc_return(&bdi_seq));
-	if (!err)
-		sb->s_bdi = &fsc->backing_dev_info;
-	return err;
+	return 0;
 }
 
 static struct dentry *ceph_mount(struct file_system_type *fs_type,
@@ -1018,7 +1009,7 @@ static struct dentry *ceph_mount(struct file_system_type *fs_type,
 		dout("get_sb got existing client %p\n", fsc);
 	} else {
 		dout("get_sb using new client %p\n", fsc);
-		err = ceph_register_bdi(sb, fsc);
+		err = ceph_setup_bdi(sb, fsc);
 		if (err < 0) {
 			res = ERR_PTR(err);
 			goto out_splat;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index fe6b9cfc4013..176186b12457 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -92,8 +92,6 @@ struct ceph_fs_client {
 	struct workqueue_struct *trunc_wq;
 	atomic_long_t writeback_count;
 
-	struct backing_dev_info backing_dev_info;
-
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dentry_lru, *debugfs_caps;
 	struct dentry *debugfs_congestion_kb;
-- 
2.12.0
