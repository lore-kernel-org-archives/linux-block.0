Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 02/10] nvme: allow calling nvme_change_ctrl_state from irq context
Date: Wed, 23 Aug 2017 19:58:07 +0200
Message-Id: <20170823175815.3646-3-hch@lst.de>
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b8ecd155be19..f91c649c9ca5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -176,9 +176,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
 	enum nvme_ctrl_state old_state;
+	unsigned long flags;
 	bool changed = false;
 
-	spin_lock_irq(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 
 	old_state = ctrl->state;
 	switch (new_state) {
@@ -239,7 +240,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	if (changed)
 		ctrl->state = new_state;
 
-	spin_unlock_irq(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	return changed;
 }
-- 
2.11.0
