Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, codalist@coda.cs.cmu.edu
Subject: [PATCH 15/24] coda: Convert to separately allocated bdi
Date: Thu,  2 Feb 2017 18:34:13 +0100
Message-Id: <20170202173422.3240-16-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: Jan Harkes <jaharkes@cs.cmu.edu>
CC: coda@cs.cmu.edu
CC: codalist@coda.cs.cmu.edu
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/coda/inode.c            | 11 ++++-------
 include/linux/coda_psdev.h |  1 -
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 71dbe7e287ce..b72eb96f3f96 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -183,10 +183,6 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 		goto unlock_out;
 	}
 
-	error = bdi_setup_and_register(&vc->bdi, "coda");
-	if (error)
-		goto unlock_out;
-
 	vc->vc_sb = sb;
 	mutex_unlock(&vc->vc_mutex);
 
@@ -197,7 +193,10 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_magic = CODA_SUPER_MAGIC;
 	sb->s_op = &coda_super_operations;
 	sb->s_d_op = &coda_dentry_operations;
-	sb->s_bdi = &vc->bdi;
+
+	error = super_setup_bdi(sb);
+	if (error)
+		goto error;
 
 	/* get root fid from Venus: this needs the root inode */
 	error = venus_rootfid(sb, &fid);
@@ -228,7 +227,6 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 
 error:
 	mutex_lock(&vc->vc_mutex);
-	bdi_destroy(&vc->bdi);
 	vc->vc_sb = NULL;
 	sb->s_fs_info = NULL;
 unlock_out:
@@ -240,7 +238,6 @@ static void coda_put_super(struct super_block *sb)
 {
 	struct venus_comm *vcp = coda_vcp(sb);
 	mutex_lock(&vcp->vc_mutex);
-	bdi_destroy(&vcp->bdi);
 	vcp->vc_sb = NULL;
 	sb->s_fs_info = NULL;
 	mutex_unlock(&vcp->vc_mutex);
diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
index 5b8721efa948..31e4e1f1547c 100644
--- a/include/linux/coda_psdev.h
+++ b/include/linux/coda_psdev.h
@@ -15,7 +15,6 @@ struct venus_comm {
 	struct list_head    vc_processing;
 	int                 vc_inuse;
 	struct super_block *vc_sb;
-	struct backing_dev_info bdi;
 	struct mutex	    vc_mutex;
 };
 
-- 
2.10.2
