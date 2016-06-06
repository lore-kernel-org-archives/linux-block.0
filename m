Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] nvme.h: add AER constants
Date: Mon,  6 Jun 2016 23:20:46 +0200
Message-Id: <1465248052-17811-5-git-send-email-hch@lst.de>
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Jay Freyensee <james.p.freyensee@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Ming Lin <ming.l@ssi.samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9807d98..a9b8c7b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -284,6 +284,12 @@ struct nvme_reservation_status {
 	} regctl_ds[];
 };
 
+enum nvme_async_event_type {
+	NVME_AER_TYPE_ERROR	= 0,
+	NVME_AER_TYPE_SMART	= 1,
+	NVME_AER_TYPE_NOTICE	= 2,
+};
+
 /* I/O commands */
 
 enum nvme_opcode {
-- 
2.1.4
