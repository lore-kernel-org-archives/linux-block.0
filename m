Return-Path: <BATV+e774f35f755d74bf45df+5174+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 12/17] nvme: check for a live controller in nvme_dev_open
Date: Mon, 23 Oct 2017 16:51:21 +0200
Message-Id: <20171023145126.2471-13-hch@lst.de>
In-Reply-To: <20171023145126.2471-1-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This is a much more sensible check than just the admin queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@rimbeg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a56a1e0432e7..df525ab42fcd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1891,7 +1891,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
-	if (!ctrl->admin_q)
+	if (ctrl->state != NVME_CTRL_LIVE)
 		return -EWOULDBLOCK;
 	file->private_data = ctrl;
 	return 0;
-- 
2.14.2
