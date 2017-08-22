Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33233 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdHVRdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 13:33:15 -0400
Received: by mail-pg0-f43.google.com with SMTP id t3so89572355pgt.0
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2017 10:33:15 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH v3 2/4] loop: set discard and write zeroes limits in 512 byte sectors
Date: Tue, 22 Aug 2017 10:32:59 -0700
Message-Id: <de779f09f7c7f38268967572eeeddbd071ab6533.1503422996.git.osandov@fb.com>
In-Reply-To: <cover.1503422996.git.osandov@fb.com>
References: <cover.1503422996.git.osandov@fb.com>
In-Reply-To: <cover.1503422996.git.osandov@fb.com>
References: <cover.1503422996.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

max_discard_sectors and max_write_zeroes_sectors are in 512 byte
sectors, not device sectors.

Fixes: f2c6df7dbf9a ("loop: support 4k physical blocksize")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 26548e07bc31..a444dc2d5977 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -820,7 +820,6 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
-	int lo_bits = 9;
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -840,11 +839,8 @@ static void loop_config_discard(struct loop_device *lo)
 
 	q->limits.discard_granularity = inode->i_sb->s_blocksize;
 	q->limits.discard_alignment = 0;
-	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE)
-		lo_bits = blksize_bits(lo->lo_logical_blocksize);
-
-	blk_queue_max_discard_sectors(q, UINT_MAX >> lo_bits);
-	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> lo_bits);
+	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
+	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
 }
 
-- 
2.14.1
