Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH 12/24] afs: Convert to separately allocated bdi
Date: Thu,  2 Feb 2017 18:34:10 +0100
Message-Id: <20170202173422.3240-13-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: David Howells <dhowells@redhat.com>
CC: linux-afs@lists.infradead.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/afs/internal.h | 1 -
 fs/afs/super.c    | 4 +++-
 fs/afs/volume.c   | 7 -------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 535a38d2c1d0..f8d52c36e6ec 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -310,7 +310,6 @@ struct afs_volume {
 	unsigned short		rjservers;	/* number of servers discarded due to -ENOMEDIUM */
 	struct afs_server	*servers[8];	/* servers on which volume resides (ordered) */
 	struct rw_semaphore	server_sem;	/* lock for accessing current server */
-	struct backing_dev_info	bdi;
 };
 
 /*
diff --git a/fs/afs/super.c b/fs/afs/super.c
index fbdb022b75a2..3bae29cd277f 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -319,7 +319,9 @@ static int afs_fill_super(struct super_block *sb,
 	sb->s_blocksize_bits	= PAGE_SHIFT;
 	sb->s_magic		= AFS_FS_MAGIC;
 	sb->s_op		= &afs_super_ops;
-	sb->s_bdi		= &as->volume->bdi;
+	ret = super_setup_bdi(sb);
+	if (ret)
+		return ret;
 	strlcpy(sb->s_id, as->volume->vlocation->vldb.name, sizeof(sb->s_id));
 
 	/* allocate the root inode and dentry */
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index d142a2449e65..db73d6dad02b 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -106,10 +106,6 @@ struct afs_volume *afs_volume_lookup(struct afs_mount_params *params)
 	volume->cell		= params->cell;
 	volume->vid		= vlocation->vldb.vid[params->type];
 
-	ret = bdi_setup_and_register(&volume->bdi, "afs");
-	if (ret)
-		goto error_bdi;
-
 	init_rwsem(&volume->server_sem);
 
 	/* look up all the applicable server records */
@@ -155,8 +151,6 @@ struct afs_volume *afs_volume_lookup(struct afs_mount_params *params)
 	return ERR_PTR(ret);
 
 error_discard:
-	bdi_destroy(&volume->bdi);
-error_bdi:
 	up_write(&params->cell->vl_sem);
 
 	for (loop = volume->nservers - 1; loop >= 0; loop--)
@@ -206,7 +200,6 @@ void afs_put_volume(struct afs_volume *volume)
 	for (loop = volume->nservers - 1; loop >= 0; loop--)
 		afs_put_server(volume->servers[loop]);
 
-	bdi_destroy(&volume->bdi);
 	kfree(volume);
 
 	_leave(" [destroyed]");
-- 
2.10.2
