Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 03/12] nvme.h: add AER configuration symbols
Date: Wed, 30 May 2018 18:45:51 +0200
Message-Id: <20180530164600.26856-4-hch@lst.de>
In-Reply-To: <20180530164600.26856-1-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.com>

Signed-off-by: Hannes Reinecke <hare@suse.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/linux/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7ce0f3cf4409..2950ce957656 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -446,6 +446,11 @@ enum {
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 };
 
+enum {
+	NVME_AEN_CFG_NS_ATTR		= 1 << 8,
+	NVME_AEN_CFG_FW_ACT		= 1 << 9,
+};
+
 struct nvme_lba_range_type {
 	__u8			type;
 	__u8			attributes;
-- 
2.17.0
