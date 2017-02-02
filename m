Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752216AbdBBRgB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 12:36:01 -0500
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH 13/24] orangefs: Remove orangefs_backing_dev_info
Date: Thu,  2 Feb 2017 18:34:11 +0100
Message-Id: <20170202173422.3240-14-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It is not used anywhere.

CC: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/orangefs/inode.c           |  6 ------
 fs/orangefs/orangefs-kernel.h |  1 -
 fs/orangefs/orangefs-mod.c    | 12 +-----------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 551bc74ed2b8..5cd617980fbf 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -136,12 +136,6 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 	return -EINVAL;
 }
 
-struct backing_dev_info orangefs_backing_dev_info = {
-	.name = "orangefs",
-	.ra_pages = 0,
-	.capabilities = BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
-};
-
 /** ORANGEFS2 implementation of address space operations */
 const struct address_space_operations orangefs_address_operations = {
 	.readpage = orangefs_readpage,
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 3bf803d732c5..70355a9a2596 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -529,7 +529,6 @@ extern spinlock_t orangefs_htable_ops_in_progress_lock;
 extern int hash_table_size;
 
 extern const struct address_space_operations orangefs_address_operations;
-extern struct backing_dev_info orangefs_backing_dev_info;
 extern const struct inode_operations orangefs_file_inode_operations;
 extern const struct file_operations orangefs_file_operations;
 extern const struct inode_operations orangefs_symlink_inode_operations;
diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
index 4113eb0495bf..c1b5174cb5a9 100644
--- a/fs/orangefs/orangefs-mod.c
+++ b/fs/orangefs/orangefs-mod.c
@@ -80,11 +80,6 @@ static int __init orangefs_init(void)
 	int ret = -1;
 	__u32 i = 0;
 
-	ret = bdi_init(&orangefs_backing_dev_info);
-
-	if (ret)
-		return ret;
-
 	if (op_timeout_secs < 0)
 		op_timeout_secs = 0;
 
@@ -94,7 +89,7 @@ static int __init orangefs_init(void)
 	/* initialize global book keeping data structures */
 	ret = op_cache_initialize();
 	if (ret < 0)
-		goto err;
+		goto out;
 
 	ret = orangefs_inode_cache_initialize();
 	if (ret < 0)
@@ -181,9 +176,6 @@ static int __init orangefs_init(void)
 cleanup_op:
 	op_cache_finalize();
 
-err:
-	bdi_destroy(&orangefs_backing_dev_info);
-
 out:
 	return ret;
 }
@@ -207,8 +199,6 @@ static void __exit orangefs_exit(void)
 
 	kfree(orangefs_htable_ops_in_progress);
 
-	bdi_destroy(&orangefs_backing_dev_info);
-
 	pr_info("orangefs: module version %s unloaded\n", ORANGEFS_VERSION);
 }
 
-- 
2.10.2

