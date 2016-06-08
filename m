Return-Path: <BATV+10e0b2ba6b8830823af0+4672+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@lightbits.io,
	ming.l@ssi.samsung.com
Subject: [PATCH 11/11] nvme-fabrics: pass non-blocking flag to connect request allocation
Date: Wed,  8 Jun 2016 14:31:06 +0200
Message-Id: <1465389066-19119-12-git-send-email-hch@lst.de>
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fabrics.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee4b7f1..225a732 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -378,11 +378,10 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &cqe,
 			data, sizeof(*data), 0, NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
-		nvmf_log_connect_error(ctrl,
-					 ret, le32_to_cpu(cqe.result),
-					 &cmd, data);
+		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(cqe.result),
+				       &cmd, data);
 		goto out_free_data;
 	}
 
@@ -437,12 +436,12 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &cqe,
-			data, sizeof(*data), 0, qid, 1, BLK_MQ_REQ_RESERVED);
-	if (ret)
-		nvmf_log_connect_error(ctrl,
-					 ret, le32_to_cpu(cqe.result),
-					 &cmd, data);
-
+			data, sizeof(*data), 0, qid, 1,
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	if (ret) {
+		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(cqe.result),
+				       &cmd, data);
+	}
 	kfree(data);
 	return ret;
 }
-- 
2.1.4
