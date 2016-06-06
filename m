Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Armen Baloyan <armenx.baloyan@intel.com>
Subject: [PATCH 02/10] nvme.h: Add get_log_page command strucure
Date: Mon,  6 Jun 2016 23:20:44 +0200
Message-Id: <1465248052-17811-3-git-send-email-hch@lst.de>
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Armen Baloyan <armenx.baloyan@intel.com>

Add get_log_page command structure and a corresponding entry in
nvme_command union

Signed-off-by: Armen Baloyan <armenx.baloyan@intel.com>
Reviewed-by: Jay Freyensee <james.p.freyensee@intel.com>
Reviewed--by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ff5ebc3..9925b85 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -519,6 +519,24 @@ struct nvme_format_cmd {
 	__u32			rsvd11[5];
 };
 
+struct nvme_get_log_page_command {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	__le64			prp1;
+	__le64			prp2;
+	__u8			lid;
+	__u8			rsvd10;
+	__le16			numdl;
+	__le16			numdu;
+	__u16			rsvd11;
+	__le32			lpol;
+	__le32			lpou;
+	__u32			rsvd14[2];
+};
+
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -532,6 +550,7 @@ struct nvme_command {
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
 		struct nvme_abort_cmd abort;
+		struct nvme_get_log_page_command get_log_page;
 	};
 };
 
-- 
2.1.4
