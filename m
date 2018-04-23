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
	Logan Gunthorpe <logang@deltatee.com>,
	Steve Wise <swise@opengridcomputing.com>
Date: Mon, 23 Apr 2018 17:30:46 -0600
Message-Id: <20180423233046.21476-15-logang@deltatee.com>
In-Reply-To: <20180423233046.21476-1-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v4 14/14] nvmet: Optionally use PCI P2P memory
List-ID: <linux-block@vger.kernel.org>

We create a configfs attribute in each nvme-fabrics target port to
enable p2p memory use. When enabled, the port will only then use the
p2p memory if a p2p memory device can be found which is behind the
same switch heirarchy as the RDMA port and all the block devices in
use. If the user enabled it and no devices are found, then the system
will silently fall back on using regular memory.

If appropriate, that port will allocate memory for the RDMA buffers
for queues from the p2pmem device falling back to system memory should
anything fail.

Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
save an extra PCI transfer as the NVME card could just take the data
out of it's own memory. However, at this time, only a limited number
of cards with CMB buffers seem to be available.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
[hch: partial rewrite of the initial code]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/configfs.c |  67 ++++++++++++++++++++++
 drivers/nvme/target/core.c     | 127 ++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/target/io-cmd.c   |   3 +
 drivers/nvme/target/nvmet.h    |  13 +++++
 drivers/nvme/target/rdma.c     |   2 +
 5 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad9ff27234b5..5efe0dae0ee7 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/ctype.h>
+#include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 
 #include "nvmet.h"
 
@@ -864,12 +866,77 @@ static void nvmet_port_release(struct config_item *item)
 	kfree(port);
 }
 
+#ifdef CONFIG_PCI_P2PDMA
+static ssize_t nvmet_p2pmem_show(struct config_item *item, char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	if (!port->use_p2pmem)
+		return sprintf(page, "none\n");
+
+	if (!port->p2p_dev)
+		return sprintf(page, "auto\n");
+
+	return sprintf(page, "%s\n", pci_name(port->p2p_dev));
+}
+
+static ssize_t nvmet_p2pmem_store(struct config_item *item,
+				  const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	struct device *dev;
+	struct pci_dev *p2p_dev = NULL;
+	bool use_p2pmem;
+
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, page);
+	if (dev) {
+		use_p2pmem = true;
+		p2p_dev = to_pci_dev(dev);
+
+		if (!pci_has_p2pmem(p2p_dev)) {
+			pr_err("PCI device has no peer-to-peer memory: %s\n",
+			       page);
+			pci_dev_put(p2p_dev);
+			return -ENODEV;
+		}
+	} else if (sysfs_streq(page, "auto")) {
+		use_p2pmem = 1;
+	} else if ((page[0] == '0' || page[0] == '1') && !iscntrl(page[1])) {
+		/*
+		 * If the user enters a PCI device that  doesn't exist
+		 * like "0000:01:00.1", we don't want strtobool to think
+		 * it's a '0' when it's clearly not what the user wanted.
+		 * So we require 0's and 1's to be exactly one character.
+		 */
+		goto no_such_pci_device;
+	} else if (strtobool(page, &use_p2pmem)) {
+		goto no_such_pci_device;
+	}
+
+	down_write(&nvmet_config_sem);
+	port->use_p2pmem = use_p2pmem;
+	pci_dev_put(port->p2p_dev);
+	port->p2p_dev = p2p_dev;
+	up_write(&nvmet_config_sem);
+
+	return count;
+
+no_such_pci_device:
+	pr_err("No such PCI device: %s\n", page);
+	return -ENODEV;
+}
+CONFIGFS_ATTR(nvmet_, p2pmem);
+#endif /* CONFIG_PCI_P2PDMA */
+
 static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_adrfam,
 	&nvmet_attr_addr_treq,
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+#ifdef CONFIG_PCI_P2PDMA
+	&nvmet_attr_p2pmem,
+#endif
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 75d44bc3e8d3..b2b62cd36f6c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
+#include <linux/pci-p2pdma.h>
 
 #include "nvmet.h"
 
@@ -271,6 +272,25 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+static int nvmet_p2pdma_add_client(struct nvmet_ctrl *ctrl,
+				   struct nvmet_ns *ns)
+{
+	int ret;
+
+	if (!blk_queue_pci_p2pdma(ns->bdev->bd_queue)) {
+		pr_err("peer-to-peer DMA is not supported by %s\n",
+		       ns->device_path);
+		return -EINVAL;
+	}
+
+	ret = pci_p2pdma_add_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
+	if (ret)
+		pr_err("failed to add peer-to-peer DMA client %s: %d\n",
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
+			ret = nvmet_p2pdma_add_client(ctrl, ns);
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
+		pci_p2pdma_remove_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
 out_blkdev_put:
 	blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
 	ns->bdev = NULL;
@@ -363,8 +394,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	percpu_ref_exit(&ns->ref);
 
 	mutex_lock(&subsys->lock);
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		pci_p2pdma_remove_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
+	}
 
 	if (ns->bdev)
 		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
@@ -577,6 +610,21 @@ EXPORT_SYMBOL_GPL(nvmet_req_execute);
 
 int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq)
 {
+	struct pci_dev *p2p_dev = NULL;
+
+	if (sq->ctrl)
+		p2p_dev = sq->ctrl->p2p_dev;
+
+	req->p2p_dev = NULL;
+	if (sq->qid && p2p_dev) {
+		req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt,
+					       req->transfer_len);
+		if (req->sg) {
+			req->p2p_dev = p2p_dev;
+			return 0;
+		}
+	}
+
 	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
 	if (!req->sg)
 		return -ENOMEM;
@@ -587,7 +635,11 @@ EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
 
 void nvmet_req_free_sgl(struct nvmet_req *req)
 {
-	sgl_free(req->sg);
+	if (req->p2p_dev)
+		pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
+	else
+		sgl_free(req->sg);
+
 	req->sg = NULL;
 	req->sg_cnt = 0;
 }
@@ -782,6 +834,74 @@ bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
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
+	if (!req->port->use_p2pmem || !req->p2p_client)
+		return;
+
+	mutex_lock(&ctrl->subsys->lock);
+
+	ret = pci_p2pdma_add_client(&ctrl->p2p_clients, req->p2p_client);
+	if (ret) {
+		pr_err("failed adding peer-to-peer DMA client %s: %d\n",
+		       dev_name(req->p2p_client), ret);
+		goto free_devices;
+	}
+
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		ret = nvmet_p2pdma_add_client(ctrl, ns);
+		if (ret)
+			goto free_devices;
+	}
+
+	if (req->port->p2p_dev) {
+		if (!pci_p2pdma_assign_provider(req->port->p2p_dev,
+						&ctrl->p2p_clients)) {
+			pr_info("peer-to-peer memory on %s is not supported\n",
+				pci_name(req->port->p2p_dev));
+			goto free_devices;
+		}
+		ctrl->p2p_dev = pci_dev_get(req->port->p2p_dev);
+	} else {
+		ctrl->p2p_dev = pci_p2pmem_find(&ctrl->p2p_clients);
+		if (!ctrl->p2p_dev) {
+			pr_info("no supported peer-to-peer memory devices found\n");
+			goto free_devices;
+		}
+	}
+
+	mutex_unlock(&ctrl->subsys->lock);
+
+	pr_info("using peer-to-peer memory on %s\n", pci_name(ctrl->p2p_dev));
+	return;
+
+free_devices:
+	pci_p2pdma_client_list_free(&ctrl->p2p_clients);
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
+	pci_p2pdma_client_list_free(&ctrl->p2p_clients);
+	pci_dev_put(ctrl->p2p_dev);
+	ctrl->p2p_dev = NULL;
+
+	mutex_unlock(&ctrl->subsys->lock);
+}
+
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
 {
@@ -821,6 +941,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
+	INIT_LIST_HEAD(&ctrl->p2p_clients);
 
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
@@ -876,6 +997,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		ctrl->kato = DIV_ROUND_UP(kato, 1000);
 	}
 	nvmet_start_keep_alive_timer(ctrl);
+	nvmet_setup_p2pmem(ctrl, req);
 
 	mutex_lock(&subsys->lock);
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
@@ -912,6 +1034,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
+	nvmet_release_p2pmem(ctrl);
 	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 
 	kfree(ctrl->sqs);
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd2344179673..39bd37f1f312 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -56,6 +56,9 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 		op = REQ_OP_READ;
 	}
 
+	if (is_pci_p2pdma_page(sg_page(req->sg)))
+		op_flags |= REQ_PCI_P2PDMA;
+
 	sector = le64_to_cpu(req->cmd->rw.slba);
 	sector <<= (req->ns->blksize_shift - 9);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 10b162615a5e..f192fefe61d9 100644
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
@@ -98,6 +103,8 @@ struct nvmet_port {
 	struct list_head		referrals;
 	void				*priv;
 	bool				enabled;
+	bool				use_p2pmem;
+	struct pci_dev			*p2p_dev;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -132,6 +139,9 @@ struct nvmet_ctrl {
 
 	const struct nvmet_fabrics_ops *ops;
 
+	struct pci_dev		*p2p_dev;
+	struct list_head	p2p_clients;
+
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
 };
@@ -234,6 +244,9 @@ struct nvmet_req {
 
 	void (*execute)(struct nvmet_req *req);
 	const struct nvmet_fabrics_ops *ops;
+
+	struct pci_dev *p2p_dev;
+	struct device *p2p_client;
 };
 
 static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f7a3459d618f..27a6d8ea1b56 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -661,6 +661,8 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		cmd->send_sge.addr, cmd->send_sge.length,
 		DMA_TO_DEVICE);
 
+	cmd->req.p2p_client = &queue->dev->device->dev;
+
 	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
 			&queue->nvme_sq, &nvmet_rdma_ops))
 		return;
-- 
2.11.0
