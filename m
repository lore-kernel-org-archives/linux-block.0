Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbdDLKZM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 06:25:12 -0400
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, codalist@coda.cs.cmu.edu
Subject: [PATCH 14/25] coda: Convert to separately allocated bdi
Date: Wed, 12 Apr 2017 12:24:38 +0200
Message-Id: <20170412102449.16901-15-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: Jan Harkes <jaharkes@cs.cmu.edu>
CC: coda@cs.cmu.edu
CC: codalist@coda.cs.cmu.edu
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/coda/inode.c            | 11 ++++-------
 include/linux/coda_psdev.h |  1 -
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 2dea594da199..6058df380cc0 100644
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
2.12.0
