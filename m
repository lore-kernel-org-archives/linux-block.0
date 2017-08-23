Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 03/10] nvme: remove unused struct nvme_ns fields
Date: Wed, 23 Aug 2017 19:58:08 +0200
Message-Id: <20170823175815.3646-4-hch@lst.de>
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

And move the flags for the flags field near that field while touching
this area.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/nvme.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2c8a02be46fd..82074b68f36f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -210,13 +210,9 @@ struct nvme_ns {
 	bool ext;
 	u8 pi_type;
 	unsigned long flags;
-	u16 noiob;
-
 #define NVME_NS_REMOVING 0
 #define NVME_NS_DEAD     1
-
-	u64 mode_select_num_blocks;
-	u32 mode_select_block_len;
+	u16 noiob;
 };
 
 struct nvme_ctrl_ops {
-- 
2.11.0
