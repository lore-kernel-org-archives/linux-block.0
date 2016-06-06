Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] nvme: allow for size limitations from transport drivers
Date: Mon,  6 Jun 2016 23:20:48 +0200
Message-Id: <1465248052-17811-7-git-send-email-hch@lst.de>
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Some transport drivers may have a lower transfer size than
the controller. So allow the transport to set it in the
controller max_hw_sectors.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a51584..b582c11 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1088,6 +1088,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	struct nvme_id_ctrl *id;
 	u64 cap;
 	int ret, page_shift;
+	u32 max_hw_sectors;
 
 	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
 	if (ret) {
@@ -1120,9 +1121,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	memcpy(ctrl->model, id->mn, sizeof(id->mn));
 	memcpy(ctrl->firmware_rev, id->fr, sizeof(id->fr));
 	if (id->mdts)
-		ctrl->max_hw_sectors = 1 << (id->mdts + page_shift - 9);
+		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
 	else
-		ctrl->max_hw_sectors = UINT_MAX;
+		max_hw_sectors = UINT_MAX;
+	ctrl->max_hw_sectors =
+		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
 	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) && id->vs[3]) {
 		unsigned int max_hw_sectors;
-- 
2.1.4
