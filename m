Return-Path: <chandan@linux.vnet.ibm.com>
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: axboe@kernel.dk, jack@suse.cz
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clean_bdev_aliases: Prevent cleaning blocks that are not in block range
Date: Sun, 25 Dec 2016 19:01:03 +0530
Message-Id: <1482672663-17122-1-git-send-email-chandan@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

The first block to be cleaned may start at a non-zero page offset. In
such a scenario clean_bdev_aliases() will end up cleaning blocks that
do not fall in the range of blocks to be cleaned. This commit fixes the
issue by skipping blocks that do not fall in valid block range.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1df2bd5..28484b3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1660,7 +1660,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 			head = page_buffers(page);
 			bh = head;
 			do {
-				if (!buffer_mapped(bh))
+				if (!buffer_mapped(bh) || (bh->b_blocknr < block))
 					goto next;
 				if (bh->b_blocknr >= block + len)
 					break;
-- 
2.5.5
