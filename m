Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
Subject: [PATCH 18/24] gfs2: Convert to properly refcounting bdi
Date: Thu,  2 Feb 2017 18:34:16 +0100
Message-Id: <20170202173422.3240-19-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Similarly to set_bdev_super() GFS2 just used block device reference to
bdi. Convert it to properly getting bdi reference. The reference will
get automatically dropped on superblock destruction.

CC: Steven Whitehouse <swhiteho@redhat.com>
CC: Bob Peterson <rpeterso@redhat.com>
CC: cluster-devel@redhat.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/gfs2/ops_fstype.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c0e5b9a8bf5f..fe8248f8b54b 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -23,6 +23,7 @@
 #include <linux/quotaops.h>
 #include <linux/lockdep.h>
 #include <linux/module.h>
+#include <linux/backing-dev.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -1221,12 +1222,8 @@ static int set_gfs2_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
 	s->s_dev = s->s_bdev->bd_dev;
-
-	/*
-	 * We set the bdi here to the queue backing, file systems can
-	 * overwrite this in ->fill_super()
-	 */
-	s->s_bdi = bdev_get_queue(s->s_bdev)->backing_dev_info;
+	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
+	s->s_iflags |= SB_I_DYNBDI;
 	return 0;
 }
 
-- 
2.10.2
