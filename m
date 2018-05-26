Return-Path: <BATV+7138d8dfc060164c836f+5389+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 04/14] nvme.h: add the changed namespace list log
Date: Sat, 26 May 2018 12:27:25 +0200
Message-Id: <20180526102735.31404-5-hch@lst.de>
In-Reply-To: <20180526102735.31404-1-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c37103a4ad38..7ce0f3cf4409 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -751,6 +751,7 @@ enum {
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
+	NVME_LOG_CHANGED_NS	= 0x04,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
@@ -759,6 +760,8 @@ enum {
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
+#define NVME_MAX_CHANGED_NAMESPACES	1024
+
 struct nvme_identify {
 	__u8			opcode;
 	__u8			flags;
-- 
2.17.0
