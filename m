Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 12/12] nvme: limit warnings from nvme_identify_ns
Date: Wed, 30 May 2018 18:46:00 +0200
Message-Id: <20180530164600.26856-13-hch@lst.de>
In-Reply-To: <20180530164600.26856-1-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

When rescanning namespaces after an AEN we will issue Identify Namespace
comands to namespaces that have gone away, so don't warn for this specific
case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1ae77428a1a5..7ad3cfc9d4e1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -984,7 +984,9 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 
 	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
 	if (error) {
-		dev_warn(ctrl->device, "Identify namespace failed\n");
+		/* don't warn on a namespace that has gone away */
+		if (error < 0 || ((error & ~NVME_SC_DNR) != NVME_SC_INVALID_NS))
+			dev_warn(ctrl->device, "Identify namespace failed\n");
 		kfree(id);
 		return NULL;
 	}
-- 
2.17.0
