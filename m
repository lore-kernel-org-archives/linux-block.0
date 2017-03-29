Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH 12/25] afs: Convert to separately allocated bdi
Date: Wed, 29 Mar 2017 12:56:10 +0200
Message-Id: <20170329105623.18241-13-jack@suse.cz>
In-Reply-To: <20170329105623.18241-1-jack@suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: David Howells <dhowells@redhat.com>
CC: linux-afs@lists.infradead.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/afs/internal.h | 1 -
 fs/afs/super.c    | 5 ++++-
 fs/afs/volume.c   | 8 --------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a6901360fb81..393672997cc2 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -318,7 +318,6 @@ struct afs_volume {
 	unsigned short		rjservers;	/* number of servers discarded due to -ENOMEDIUM */
 	struct afs_server	*servers[8];	/* servers on which volume resides (ordered) */
 	struct rw_semaphore	server_sem;	/* lock for accessing current server */
-	struct backing_dev_info	bdi;
 };
 
 /*
diff --git a/fs/afs/super.c b/fs/afs/super.c
index fbdb022b75a2..c79633e5cfd8 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -319,7 +319,10 @@ static int afs_fill_super(struct super_block *sb,
 	sb->s_blocksize_bits	= PAGE_SHIFT;
 	sb->s_magic		= AFS_FS_MAGIC;
 	sb->s_op		= &afs_super_ops;
-	sb->s_bdi		= &as->volume->bdi;
+	ret = super_setup_bdi(sb);
+	if (ret)
+		return ret;
+	sb->s_bdi->ra_pages	= VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
 	strlcpy(sb->s_id, as->volume->vlocation->vldb.name, sizeof(sb->s_id));
 
 	/* allocate the root inode and dentry */
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 546f9d01710b..db73d6dad02b 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -106,11 +106,6 @@ struct afs_volume *afs_volume_lookup(struct afs_mount_params *params)
 	volume->cell		= params->cell;
 	volume->vid		= vlocation->vldb.vid[params->type];
 
-	volume->bdi.ra_pages	= VM_MAX_READAHEAD*1024/PAGE_SIZE; 
-	ret = bdi_setup_and_register(&volume->bdi, "afs");
-	if (ret)
-		goto error_bdi;
-
 	init_rwsem(&volume->server_sem);
 
 	/* look up all the applicable server records */
@@ -156,8 +151,6 @@ struct afs_volume *afs_volume_lookup(struct afs_mount_params *params)
 	return ERR_PTR(ret);
 
 error_discard:
-	bdi_destroy(&volume->bdi);
-error_bdi:
 	up_write(&params->cell->vl_sem);
 
 	for (loop = volume->nservers - 1; loop >= 0; loop--)
@@ -207,7 +200,6 @@ void afs_put_volume(struct afs_volume *volume)
 	for (loop = volume->nservers - 1; loop >= 0; loop--)
 		afs_put_server(volume->servers[loop]);
 
-	bdi_destroy(&volume->bdi);
 	kfree(volume);
 
 	_leave(" [destroyed]");
-- 
2.10.2
