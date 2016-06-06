Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] nvme: allow transitioning from NEW to LIVE state
Date: Mon,  6 Jun 2016 23:21:53 +0200
Message-Id: <1465248119-17875-3-git-send-email-hch@lst.de>
In-Reply-To: <1465248119-17875-1-git-send-email-hch@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

For Fabrics we're not going through an intermediate reset state
(at least for now).

Reviewed-by: Jay Freyensee <james.p.freyensee@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27cce17..025ac8f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -85,6 +85,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
+		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
-- 
2.1.4
