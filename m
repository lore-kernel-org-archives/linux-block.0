Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 7/8] nvme.h: Add keep-alive opcode and identify controller attribute
Date: Mon,  6 Jun 2016 23:21:58 +0200
Message-Id: <1465248119-17875-8-git-send-email-hch@lst.de>
In-Reply-To: <1465248119-17875-1-git-send-email-hch@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Sagi Grimberg <sagi@grimberg.me>

KAS: keep-alive support and granularity of kato in units of 100 ms
nvme_admin_keep_alive opcode: 0x18

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7525030..d8b37ba 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -202,7 +202,9 @@ struct nvme_id_ctrl {
 	__u8			apsta;
 	__le16			wctemp;
 	__le16			cctemp;
-	__u8			rsvd270[242];
+	__u8			rsvd270[50];
+	__le16			kas;
+	__u8			rsvd322[190];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -556,6 +558,7 @@ enum nvme_admin_opcode {
 	nvme_admin_async_event		= 0x0c,
 	nvme_admin_activate_fw		= 0x10,
 	nvme_admin_download_fw		= 0x11,
+	nvme_admin_keep_alive		= 0x18,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
@@ -580,6 +583,7 @@ enum {
 	NVME_FEAT_WRITE_ATOMIC	= 0x0a,
 	NVME_FEAT_ASYNC_EVENT	= 0x0b,
 	NVME_FEAT_AUTO_PST	= 0x0c,
+	NVME_FEAT_KATO		= 0x0f,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
-- 
2.1.4
