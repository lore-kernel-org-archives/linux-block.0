Return-Path: <BATV+10e0b2ba6b8830823af0+4672+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@lightbits.io,
	ming.l@ssi.samsung.com
Subject: [PATCH 07/11] nvmet: fix 64-bit division in nvmet_set_features
Date: Wed,  8 Jun 2016 14:31:02 +0200
Message-Id: <1465389066-19119-8-git-send-email-hch@lst.de>
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

As it makes 32-bit builds unhappy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 240e323..2fac17a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -298,6 +298,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
 	u64 val;
+	u32 val32;
 	u16 status = 0;
 
 	switch (cdw10 & 0xf) {
@@ -307,7 +308,8 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_KATO:
 		val = le64_to_cpu(req->cmd->prop_set.value);
-		req->sq->ctrl->kato = (u32)DIV_ROUND_UP(val & 0xffff, 1000);
+		val32 = val & 0xffff;
+		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 		nvmet_set_result(req, req->sq->ctrl->kato);
 		break;
 	default:
-- 
2.1.4
