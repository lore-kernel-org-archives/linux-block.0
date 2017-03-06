Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbdCFKYx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Mar 2017 05:24:53 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Hannes Reinecke <hare@suse.de>, yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] zram: set physical queue limits to avoid array out of bounds accesses
Date: Mon,  6 Mar 2017 11:23:35 +0100
Message-Id: <20170306102335.9180-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
the NVMe over Fabrics loopback target which potentially sends a huge bulk of
pages attached to the bio's bvec this results in a kernel panic because of
array out of bounds accesses in zram_decompress_page().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/zram/zram_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e27d89a..dceb5ed 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1189,6 +1189,8 @@ static int zram_add(void)
 	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
 	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
 	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;
+	zram->disk->queue->limits.max_sectors = SECTORS_PER_PAGE;
+	zram->disk->queue->limits.chunk_sectors = 0;
 	blk_queue_max_discard_sectors(zram->disk->queue, UINT_MAX);
 	/*
 	 * zram_bio_discard() will clear all logical blocks if logical block
-- 
1.8.5.6
