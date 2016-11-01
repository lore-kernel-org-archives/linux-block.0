Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/16] btrfs: use op_is_sync to check for synchronous requests
Date: Tue,  1 Nov 2016 07:40:06 -0600
Message-Id: <1478007617-18715-6-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/volumes.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3a57f99..c8454a8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -930,7 +930,7 @@ int btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct inode *inode,
 
 	atomic_inc(&fs_info->nr_async_submits);
 
-	if (bio->bi_opf & REQ_SYNC)
+	if (op_is_sync(bio->bi_opf))
 		btrfs_set_work_high_priority(&async->work);
 
 	btrfs_queue_work(fs_info->workers, &async->work);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 71a60cc..deda46cf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6100,7 +6100,7 @@ static noinline void btrfs_schedule_bio(struct btrfs_root *root,
 	bio->bi_next = NULL;
 
 	spin_lock(&device->io_lock);
-	if (bio->bi_opf & REQ_SYNC)
+	if (op_is_sync(bio->bi_opf))
 		pending_bios = &device->pending_sync_bios;
 	else
 		pending_bios = &device->pending_bios;
-- 
2.1.4

