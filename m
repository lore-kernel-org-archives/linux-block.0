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
	Logan Gunthorpe <logang@deltatee.com>,
	Steve Wise <swise@opengridcomputing.com>
Date: Thu,  4 Jan 2018 12:01:37 -0700
Message-Id: <20180104190137.7654-13-logang@deltatee.com>
In-Reply-To: <20180104190137.7654-1-logang@deltatee.com>
References: <20180104190137.7654-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 12/12] nvmet: Optionally use PCI P2P memory
List-ID: <linux-block@vger.kernel.org>

We create a configfs attribute in each nvme-fabrics target port to
enable p2p memory use. When enabled, the port will only then use the
p2p memory if a p2p memory device can be found which is behind the
same switch as the RDMA port and all the block devices in use. If
the user enabled it an no devices are found, then the system will
silently fall back on using regular memory.

If appropriate, that port will allocate memory for the RDMA buffers
for queues from the p2pmem device falling back to system memory should
anything fail.

Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
save an extra PCI transfer as the NVME card could just take the data
out of it's own memory. However, at this time, cards with CMB buffers
don't seem to be available.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
[hch: partial rewrite of the initial code]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/configfs.c | 29 +++++++++++++
 drivers/nvme/target/core.c     | 95 +++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/target/io-cmd.c   |  3 ++
 drivers/nvme/target/nvmet.h    | 10 +++++
 drivers/nvme/target/rdma.c     | 39 ++++++++++++++---
 5 files changed, 169 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e6b2d2af81b6..12933ca39e62 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -867,12 +867,41 @@ static void nvmet_port_release(struct config_item *item)
 	kfree(port);
 }
 
+#ifdef CONFIG_PCI_P2P
+static ssize_t nvmet_allow_p2pmem_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_port(item)->allow_p2pmem);
+}
+
+static ssize_t nvmet_allow_p2pmem_store(struct config_item *item,
+					const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	bool allow;
+	int ret;
+
+	ret = strtobool(page, &allow);
+	if (ret)
+		return ret;
+
+	down_write(&nvmet_config_sem);
+	port->allow_p2pmem = allow;
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_, allow_p2pmem);
+#endif /* CONFIG_PCI_P2P */
+
 static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_adrfam,
 	&nvmet_attr_addr_treq,
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+#ifdef CONFIG_PCI_P2P
+	&nvmet_attr_allow_p2pmem,
+#endif
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b54748ad5f48..77d1975388da 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
+#include <linux/pci-p2p.h>
 
 #include "nvmet.h"
 
@@ -271,6 +272,25 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+static int nvmet_p2pmem_add_client(struct nvmet_ctrl *ctrl,
+				   struct nvmet_ns *ns)
+{
+	int ret;
+
+	if (!blk_queue_pci_p2p(ns->bdev->bd_queue)) {
+		pr_err("p2p is not supported by %s\n",
+		       ns->device_path);
+		return -EINVAL;
+	}
+
+	ret = pci_p2pmem_add_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
+	if (ret)
+		pr_err("failed to add p2pmem client %s: %d\n",
+		       ns->device_path, ret);
+
+	return ret;
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -299,6 +319,14 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ret)
 		goto out_blkdev_put;
 
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->p2p_dev) {
+			ret = nvmet_p2pmem_add_client(ctrl, ns);
+			if (ret)
+				goto out_remove_clients;
+		}
+	}
+
 	if (ns->nsid > subsys->max_nsid)
 		subsys->max_nsid = ns->nsid;
 
@@ -328,6 +356,9 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
+out_remove_clients:
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		pci_p2pmem_remove_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
 out_blkdev_put:
 	blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
 	ns->bdev = NULL;
@@ -363,8 +394,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	percpu_ref_exit(&ns->ref);
 
 	mutex_lock(&subsys->lock);
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		pci_p2pmem_remove_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
+	}
 
 	if (ns->bdev)
 		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
@@ -758,6 +791,63 @@ bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
 		return __nvmet_host_allowed(subsys, hostnqn);
 }
 
+/*
+ * If allow_p2pmem is set, we will try to use P2P memory for the SGL lists for
+ * Ι/O commands. This requires the PCI p2p device to be compatible with the
+ * backing device for every namespace on this controller.
+ */
+static void nvmet_setup_p2pmem(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
+{
+	struct nvmet_ns *ns;
+	int ret;
+
+	if (!req->port->allow_p2pmem || !req->p2p_client)
+		return;
+
+	mutex_lock(&ctrl->subsys->lock);
+
+	ret = pci_p2pmem_add_client(&ctrl->p2p_clients, req->p2p_client);
+	if (ret) {
+		pr_err("failed adding p2pmem client %s: %d\n",
+		       dev_name(req->p2p_client), ret);
+		goto free_devices;
+	}
+
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		ret = nvmet_p2pmem_add_client(ctrl, ns);
+		if (ret)
+			goto free_devices;
+	}
+
+	ctrl->p2p_dev = pci_p2pmem_find(&ctrl->p2p_clients);
+	if (!ctrl->p2p_dev) {
+		pr_info("no supported p2pmem devices found\n");
+		goto free_devices;
+	}
+	mutex_unlock(&ctrl->subsys->lock);
+
+	pr_info("using p2pmem on %s\n", pci_name(ctrl->p2p_dev));
+	return;
+
+free_devices:
+	pci_p2pmem_client_list_free(&ctrl->p2p_clients);
+	mutex_unlock(&ctrl->subsys->lock);
+}
+
+static void nvmet_release_p2pmem(struct nvmet_ctrl *ctrl)
+{
+	if (!ctrl->p2p_dev)
+		return;
+
+	mutex_lock(&ctrl->subsys->lock);
+
+	pci_p2pmem_client_list_free(&ctrl->p2p_clients);
+	pci_dev_put(ctrl->p2p_dev);
+	ctrl->p2p_dev = NULL;
+
+	mutex_unlock(&ctrl->subsys->lock);
+}
+
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
 {
@@ -797,6 +887,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
+	INIT_LIST_HEAD(&ctrl->p2p_clients);
 
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
@@ -852,6 +943,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		ctrl->kato = DIV_ROUND_UP(kato, 1000);
 	}
 	nvmet_start_keep_alive_timer(ctrl);
+	nvmet_setup_p2pmem(ctrl, req);
 
 	mutex_lock(&subsys->lock);
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
@@ -886,6 +978,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
+	nvmet_release_p2pmem(ctrl);
 	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 	nvmet_subsys_put(subsys);
 
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 0a4372a016f2..c05368c6579c 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -56,6 +56,9 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 		op = REQ_OP_READ;
 	}
 
+	if (is_pci_p2p_page(sg_page(req->sg)))
+		op_flags |= REQ_PCI_P2P;
+
 	sector = le64_to_cpu(req->cmd->rw.slba);
 	sector <<= (req->ns->blksize_shift - 9);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 417f6c0331cc..85a170914588 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -64,6 +64,11 @@ static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
 	return container_of(to_config_group(item), struct nvmet_ns, group);
 }
 
+static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
+{
+	return disk_to_dev(ns->bdev->bd_disk);
+}
+
 struct nvmet_cq {
 	u16			qid;
 	u16			size;
@@ -98,6 +103,7 @@ struct nvmet_port {
 	struct list_head		referrals;
 	void				*priv;
 	bool				enabled;
+	bool				allow_p2pmem;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -131,6 +137,8 @@ struct nvmet_ctrl {
 	struct work_struct	fatal_err_work;
 
 	struct nvmet_fabrics_ops *ops;
+	struct pci_dev		*p2p_dev;
+	struct list_head	p2p_clients;
 
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
@@ -232,6 +240,8 @@ struct nvmet_req {
 
 	void (*execute)(struct nvmet_req *req);
 	struct nvmet_fabrics_ops *ops;
+
+	struct device *p2p_client;
 };
 
 static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index d4d0662ab071..fb4a7fa03015 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/inet.h>
+#include <linux/pci-p2p.h>
 #include <asm/unaligned.h>
 
 #include <rdma/ib_verbs.h>
@@ -68,6 +69,7 @@ struct nvmet_rdma_rsp {
 	u8			n_rdma;
 	u32			flags;
 	u32			invalidate_rkey;
+	struct pci_dev		*p2p_dev;
 
 	struct list_head	wait_list;
 	struct list_head	free_list;
@@ -480,11 +482,18 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 	if (rsp->n_rdma) {
 		rdma_rw_ctx_destroy(&rsp->rw, queue->cm_id->qp,
 				queue->cm_id->port_num, rsp->req.sg,
-				rsp->req.sg_cnt, nvmet_data_dir(&rsp->req), 0);
+				rsp->req.sg_cnt, nvmet_data_dir(&rsp->req),
+				rsp->p2p_dev ? RDMA_RW_CTX_FLAG_PCI_P2P : 0);
 	}
 
-	if (rsp->req.sg != &rsp->cmd->inline_sg)
-		nvmet_rdma_free_sgl(rsp->req.sg, rsp->req.sg_cnt);
+	if (rsp->req.sg != &rsp->cmd->inline_sg) {
+		if (rsp->p2p_dev)
+			pci_p2pmem_free_sgl(rsp->p2p_dev, rsp->req.sg,
+					    rsp->req.sg_cnt);
+		else
+			nvmet_rdma_free_sgl(rsp->req.sg, rsp->req.sg_cnt);
+
+	}
 
 	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
 		nvmet_rdma_process_wr_wait_list(queue);
@@ -620,6 +629,7 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 	u64 addr = le64_to_cpu(sgl->addr);
 	u32 len = get_unaligned_le24(sgl->length);
 	u32 key = get_unaligned_le32(sgl->key);
+	struct pci_dev *p2p_dev = NULL;
 	int ret;
 	u16 status;
 
@@ -627,14 +637,29 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 	if (!len)
 		return 0;
 
-	status = nvmet_rdma_alloc_sgl(&rsp->req.sg, &rsp->req.sg_cnt,
-			len);
+	if (rsp->queue->nvme_sq.ctrl)
+		p2p_dev = rsp->queue->nvme_sq.ctrl->p2p_dev;
+
+	rsp->p2p_dev = NULL;
+	if (rsp->queue->nvme_sq.qid && p2p_dev) {
+		status = pci_p2pmem_alloc_sgl(p2p_dev, &rsp->req.sg,
+					      &rsp->req.sg_cnt, len);
+		if (!status)
+			rsp->p2p_dev = p2p_dev;
+	}
+
+	if (!rsp->p2p_dev) {
+		status = nvmet_rdma_alloc_sgl(&rsp->req.sg, &rsp->req.sg_cnt,
+				len);
+	}
+
 	if (status)
 		return status;
 
 	ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
 			rsp->req.sg, rsp->req.sg_cnt, 0, addr, key,
-			nvmet_data_dir(&rsp->req), 0);
+			nvmet_data_dir(&rsp->req),
+			rsp->p2p_dev ? RDMA_RW_CTX_FLAG_PCI_P2P : 0);
 	if (ret < 0)
 		return NVME_SC_INTERNAL;
 	rsp->req.transfer_len += len;
@@ -713,6 +738,8 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		cmd->send_sge.addr, cmd->send_sge.length,
 		DMA_TO_DEVICE);
 
+	cmd->req.p2p_client = &queue->dev->device->dev;
+
 	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
 			&queue->nvme_sq, &nvmet_rdma_ops))
 		return;
-- 
2.11.0
