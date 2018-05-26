Return-Path: <BATV+7138d8dfc060164c836f+5389+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 06/14] nvmet: add a new nvmet_zero_sgl helper
Date: Sat, 26 May 2018 12:27:27 +0200
Message-Id: <20180526102735.31404-7-hch@lst.de>
In-Reply-To: <20180526102735.31404-1-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Zeroes the SGL in the payload.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/core.c  | 7 +++++++
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 800aaf96ddcd..55c4bc693aa2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -57,6 +57,13 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf, size_t len)
 	return 0;
 }
 
+u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
+{
+	if (sg_zero_buffer(req->sg, req->sg_cnt, len, off) != len)
+		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+	return 0;
+}
+
 static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
 {
 	struct nvmet_ns *ns;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2d09afcfe505..a4e14eb15d4e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -330,6 +330,7 @@ u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
 		size_t len);
 u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 		size_t len);
+u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 
-- 
2.17.0
