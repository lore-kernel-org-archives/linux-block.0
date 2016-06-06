Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] nvme: factor out a add nvme_is_write helper
Date: Mon,  6 Jun 2016 23:20:49 +0200
Message-Id: <1465248052-17811-8-git-send-email-hch@lst.de>
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Centralize the check if a given NVMe command reads or writes data.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Jay Freyensee <james.p.freyensee@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 5 ++---
 include/linux/nvme.h     | 5 +++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b582c11..ffd9910 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -176,10 +176,9 @@ EXPORT_SYMBOL_GPL(nvme_requeue_req);
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags)
 {
-	bool write = cmd->common.opcode & 1;
 	struct request *req;
 
-	req = blk_mq_alloc_request(q, write, flags);
+	req = blk_mq_alloc_request(q, nvme_is_write(cmd), flags);
 	if (IS_ERR(req))
 		return req;
 
@@ -344,7 +343,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
 		u32 *result, unsigned timeout)
 {
-	bool write = cmd->common.opcode & 1;
+	bool write = nvme_is_write(cmd);
 	struct nvme_completion cqe;
 	struct nvme_ns *ns = q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2b82f05..dc815cc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -590,6 +590,11 @@ struct nvme_command {
 	};
 };
 
+static inline bool nvme_is_write(struct nvme_command *cmd)
+{
+	return cmd->common.opcode & 1;
+}
+
 enum {
 	NVME_SC_SUCCESS			= 0x0,
 	NVME_SC_INVALID_OPCODE		= 0x1,
-- 
2.1.4
