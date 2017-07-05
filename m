Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	markus@trippelsdorf.de,
	linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	dsterba@suse.com,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] btrfs: Correct assignment of pos
Date: Tue,  4 Jul 2017 19:02:09 -0500
Message-Id: <20170705000209.11391-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Assigning pos for usage early messes up in append mode, where
the pos is re-assigned in generic_write_checks(). Re-assign
pos to get the correct position to write from iocb->ki_pos.

Fixes: edf064e7c6fe ("btrfs: nowait aio support")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Tested-by: Markus Trippelsdorf <markus@trippelsdorf.de>
---
 fs/btrfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 59e2dccdf75b..7947781229e5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1931,6 +1931,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	 */
 	update_time_for_write(inode);
 
+	pos = iocb->ki_pos;
 	start_pos = round_down(pos, fs_info->sectorsize);
 	oldsize = i_size_read(inode);
 	if (start_pos > oldsize) {
-- 
2.12.0
