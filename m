Return-Path: <gunthorp@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 23 Apr 2018 17:30:44 -0600
Message-Id: <20180423233046.21476-13-logang@deltatee.com>
In-Reply-To: <20180423233046.21476-1-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
Subject: [PATCH v4 12/14] nvmet: Introduce helper functions to allocate and free request SGLs
List-ID: <linux-block@vger.kernel.org>

Add helpers to allocate and free the SGL in a struct nvmet_req:

int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq)
void nvmet_req_free_sgl(struct nvmet_req *req)

This will be expanded in a future patch to implement peer-to-peer
memory DMAs and should be common with all target drivers. The presently
unused 'sq' argument in the alloc function will be necessary to
decide whether to use peer-to-peer memory and obtain the correct
provider to allocate the memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c  | 18 ++++++++++++++++++
 drivers/nvme/target/nvmet.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f172fd..75d44bc3e8d3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -575,6 +575,24 @@ void nvmet_req_execute(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_execute);
 
+int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq)
+{
+	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
+	if (!req->sg)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
+
+void nvmet_req_free_sgl(struct nvmet_req *req)
+{
+	sgl_free(req->sg);
+	req->sg = NULL;
+	req->sg_cnt = 0;
+}
+EXPORT_SYMBOL_GPL(nvmet_req_free_sgl);
+
 static inline bool nvmet_cc_en(u32 cc)
 {
 	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84ab21f8..10b162615a5e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -273,6 +273,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 void nvmet_req_uninit(struct nvmet_req *req);
 void nvmet_req_execute(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
+int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq);
+void nvmet_req_free_sgl(struct nvmet_req *req);
 
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
-- 
2.11.0
