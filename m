Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/3] block: Export blk_poll
Date: Mon,  6 Jun 2016 23:22:55 +0200
Message-Id: <1465248177-17970-2-git-send-email-hch@lst.de>
In-Reply-To: <1465248177-17970-1-git-send-email-hch@lst.de>
References: <1465248177-17970-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Sagi Grimberg <sagi@grimberg.me>

The new NVMe over fabrics target will make use of this outside from a
module.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2475b1c7..ad5270e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3377,6 +3377,7 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(blk_poll);
 
 #ifdef CONFIG_PM
 /**
-- 
2.1.4
