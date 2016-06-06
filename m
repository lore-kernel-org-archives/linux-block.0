Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH 05/10] nvme.h: add constants for PSDT and FUSE values
Date: Mon,  6 Jun 2016 23:20:47 +0200
Message-Id: <1465248052-17811-6-git-send-email-hch@lst.de>
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: James Smart <james.smart@broadcom.com>

Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a9b8c7b..2b82f05 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -306,6 +306,29 @@ enum nvme_opcode {
 	nvme_cmd_resv_release	= 0x15,
 };
 
+/*
+ * Lowest two bits of our flags field (FUSE field in the spec):
+ *
+ * @NVME_CMD_FUSE_FIRST:   Fused Operation, first command
+ * @NVME_CMD_FUSE_SECOND:  Fused Operation, second command
+ *
+ * Highest two bits in our flags field (PSDT field in the spec):
+ *
+ * @NVME_CMD_PSDT_SGL_METABUF:	Use SGLS for this transfer,
+ *	If used, MPTR contains addr of single physical buffer (byte aligned).
+ * @NVME_CMD_PSDT_SGL_METASEG:	Use SGLS for this transfer,
+ *	If used, MPTR contains an address of an SGL segment containing
+ *	exactly 1 SGL descriptor (qword aligned).
+ */
+enum {
+	NVME_CMD_FUSE_FIRST	= (1 << 0),
+	NVME_CMD_FUSE_SECOND	= (1 << 1),
+
+	NVME_CMD_SGL_METABUF	= (1 << 6),
+	NVME_CMD_SGL_METASEG	= (1 << 7),
+	NVME_CMD_SGL_ALL	= NVME_CMD_SGL_METABUF | NVME_CMD_SGL_METASEG,
+};
+
 struct nvme_common_command {
 	__u8			opcode;
 	__u8			flags;
-- 
2.1.4
