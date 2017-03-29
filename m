Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH 07/25] 9p: Convert to separately allocated bdi
Date: Wed, 29 Mar 2017 12:56:05 +0200
Message-Id: <20170329105623.18241-8-jack@suse.cz>
In-Reply-To: <20170329105623.18241-1-jack@suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside session. This unifies handling of bdi among users.

CC: Eric Van Hensbergen <ericvh@gmail.com>
CC: Ron Minnich <rminnich@sandia.gov>
CC: Latchesar Ionkov <lucho@ionkov.net>
CC: v9fs-developer@lists.sourceforge.net
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/9p/v9fs.c      | 10 +---------
 fs/9p/v9fs.h      |  1 -
 fs/9p/vfs_super.c | 15 ++++++++++++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index a89f3cfe3c7d..c202930086ed 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -333,10 +333,6 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 		goto err_names;
 	init_rwsem(&v9ses->rename_sem);
 
-	rc = bdi_setup_and_register(&v9ses->bdi, "9p");
-	if (rc)
-		goto err_names;
-
 	v9ses->uid = INVALID_UID;
 	v9ses->dfltuid = V9FS_DEFUID;
 	v9ses->dfltgid = V9FS_DEFGID;
@@ -345,7 +341,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 	if (IS_ERR(v9ses->clnt)) {
 		rc = PTR_ERR(v9ses->clnt);
 		p9_debug(P9_DEBUG_ERROR, "problem initializing 9p client\n");
-		goto err_bdi;
+		goto err_names;
 	}
 
 	v9ses->flags = V9FS_ACCESS_USER;
@@ -415,8 +411,6 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 
 err_clnt:
 	p9_client_destroy(v9ses->clnt);
-err_bdi:
-	bdi_destroy(&v9ses->bdi);
 err_names:
 	kfree(v9ses->uname);
 	kfree(v9ses->aname);
@@ -445,8 +439,6 @@ void v9fs_session_close(struct v9fs_session_info *v9ses)
 	kfree(v9ses->uname);
 	kfree(v9ses->aname);
 
-	bdi_destroy(&v9ses->bdi);
-
 	spin_lock(&v9fs_sessionlist_lock);
 	list_del(&v9ses->slist);
 	spin_unlock(&v9fs_sessionlist_lock);
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 443d12e02043..76eaf49abd3a 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -114,7 +114,6 @@ struct v9fs_session_info {
 	kuid_t uid;		/* if ACCESS_SINGLE, the uid that has access */
 	struct p9_client *clnt;	/* 9p client */
 	struct list_head slist; /* list of sessions registered with v9fs */
-	struct backing_dev_info bdi;
 	struct rw_semaphore rename_sem;
 };
 
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index de3ed8629196..a0965fb587a5 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -72,10 +72,12 @@ static int v9fs_set_super(struct super_block *s, void *data)
  *
  */
 
-static void
+static int
 v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 		int flags, void *data)
 {
+	int ret;
+
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
 	sb->s_blocksize = 1 << sb->s_blocksize_bits;
@@ -85,7 +87,11 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 		sb->s_xattr = v9fs_xattr_handlers;
 	} else
 		sb->s_op = &v9fs_super_ops;
-	sb->s_bdi = &v9ses->bdi;
+
+	ret = super_setup_bdi(sb);
+	if (ret)
+		return ret;
+
 	if (v9ses->cache)
 		sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024)/PAGE_SIZE;
 
@@ -99,6 +105,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 #endif
 
 	save_mount_options(sb, data);
+	return 0;
 }
 
 /**
@@ -138,7 +145,9 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 		retval = PTR_ERR(sb);
 		goto clunk_fid;
 	}
-	v9fs_fill_super(sb, v9ses, flags, data);
+	retval = v9fs_fill_super(sb, v9ses, flags, data);
+	if (retval)
+		goto release_sb;
 
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		sb->s_d_op = &v9fs_cached_dentry_operations;
-- 
2.10.2
