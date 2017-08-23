Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 05/10] nvme: don't blindly overwrite identifiers on disk revalidate
Date: Wed, 23 Aug 2017 19:58:10 +0200
Message-Id: <20170823175815.3646-6-hch@lst.de>
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Instead validate that these identifiers do not change, as that is
prohibited by the specification.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 157dbb7b328d..179ade01745b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1236,6 +1236,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_id_ns *id;
+	u8 eui64[8] = { 0 }, nguid[16] = { 0 };
+	uuid_t uuid = uuid_null;
 	int ret = 0;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
@@ -1252,7 +1254,15 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
-	nvme_report_ns_ids(ctrl, ns->ns_id, id, ns->eui, ns->nguid, &ns->uuid);
+	nvme_report_ns_ids(ctrl, ns->ns_id, id, eui64, nguid, &uuid);
+	if (!uuid_equal(&ns->uuid, &uuid) ||
+	    memcmp(&ns->nguid, &nguid, sizeof(ns->nguid)) ||
+	    memcmp(&ns->eui, &eui64, sizeof(ns->eui))) {
+		dev_err(ctrl->device,
+			"identifiers changed for nsid %d\n", ns->ns_id);
+		ret = -ENODEV;
+	}
+
 out:
 	kfree(id);
 	return ret;
-- 
2.11.0
