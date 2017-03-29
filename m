Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 05/25] fs: Get proper reference for s_bdi
Date: Wed, 29 Mar 2017 12:56:03 +0200
Message-Id: <20170329105623.18241-6-jack@suse.cz>
In-Reply-To: <20170329105623.18241-1-jack@suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

So far we just relied on block device to hold a bdi reference for us
while the filesystem is mounted. While that works perfectly fine, it is
a bit awkward that we have a pointer to a refcounted structure in the
superblock without proper reference. So make s_bdi hold a proper
reference to block device's BDI. No filesystem using mount_bdev()
actually changes s_bdi so this is safe and will make bdev filesystems
work the same way as filesystems needing to set up their private bdi.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 0f51a437c269..e267d3a00144 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1054,12 +1054,9 @@ static int set_bdev_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
 	s->s_dev = s->s_bdev->bd_dev;
+	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
+	s->s_iflags |= SB_I_DYNBDI;
 
-	/*
-	 * We set the bdi here to the queue backing, file systems can
-	 * overwrite this in ->fill_super()
-	 */
-	s->s_bdi = bdev_get_queue(s->s_bdev)->backing_dev_info;
 	return 0;
 }
 
-- 
2.10.2
