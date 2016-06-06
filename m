Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] nvme: add new reconnecting controller state
Date: Mon,  6 Jun 2016 23:23:32 +0200
Message-Id: <1465248215-18186-3-git-send-email-hch@lst.de>
In-Reply-To: <1465248215-18186-1-git-send-email-hch@lst.de>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The nvme fabric (RDMA, FC, etc...) can introduce port, link or node
failures that may require a reconnect to re-establish the connection.

Add a new reconnecting state that will initially be used by the RDMA
driver.

Reviewed-by: Jay Freyensee <james.p.freyensee@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6f4361b..5bd5de1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -88,6 +88,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_RECONNECTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -98,6 +99,16 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_RECONNECTING:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
+	case NVME_CTRL_RECONNECTING:
+		switch (old_state) {
+		case NVME_CTRL_LIVE:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -108,6 +119,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_RECONNECTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d25eaab..a288974 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -74,6 +74,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
 	NVME_CTRL_RESETTING,
+	NVME_CTRL_RECONNECTING,
 	NVME_CTRL_DELETING,
 	NVME_CTRL_DEAD,
 };
-- 
2.1.4
