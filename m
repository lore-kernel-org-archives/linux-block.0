Return-Path: <BATV+efe86d5870596b20d79e+5139+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 6/9] nvme: track subsystems
Date: Mon, 18 Sep 2017 16:14:50 -0700
Message-Id: <20170918231453.27128-7-hch@lst.de>
In-Reply-To: <20170918231453.27128-1-hch@lst.de>
References: <20170918231453.27128-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This adds a new nvme_subsystem structure so that we can track multiple
controllers that belong to a single subsystem.  For now we only use it
to store the NQN, and to check that we don't have duplicate NQNs unless
the involved subsystems support multiple controllers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c    | 111 ++++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/fabrics.c |   4 +-
 drivers/nvme/host/nvme.h    |  12 ++++-
 3 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5589f67d2cd8..4291119a6bc9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -71,6 +71,9 @@ MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 struct workqueue_struct *nvme_wq;
 EXPORT_SYMBOL_GPL(nvme_wq);
 
+static LIST_HEAD(nvme_subsystems);
+static DEFINE_MUTEX(nvme_subsystems_lock);
+
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
@@ -1736,14 +1739,15 @@ static bool quirk_matches(const struct nvme_id_ctrl *id,
 		string_matches(id->fr, q->fr, sizeof(id->fr));
 }
 
-static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ctrl,
+		struct nvme_id_ctrl *id)
 {
 	size_t nqnlen;
 	int off;
 
 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strcpy(ctrl->subnqn, id->subnqn);
+		strcpy(subsys->subnqn, id->subnqn);
 		return;
 	}
 
@@ -1751,14 +1755,91 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
-	off = snprintf(ctrl->subnqn, NVMF_NQN_SIZE,
+	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
 			"nqn.2014.08.org.nvmexpress:%4x%4x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
-	memcpy(ctrl->subnqn + off, id->sn, sizeof(id->sn));
+	memcpy(subsys->subnqn + off, id->sn, sizeof(id->sn));
 	off += sizeof(id->sn);
-	memcpy(ctrl->subnqn + off, id->mn, sizeof(id->mn));
+	memcpy(subsys->subnqn + off, id->mn, sizeof(id->mn));
 	off += sizeof(id->mn);
-	memset(ctrl->subnqn + off, 0, sizeof(ctrl->subnqn) - off);
+	memset(subsys->subnqn + off, 0, sizeof(subsys->subnqn) - off);
+}
+
+static void nvme_destroy_subsystem(struct kref *ref)
+{
+	struct nvme_subsystem *subsys =
+			container_of(ref, struct nvme_subsystem, ref);
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_del(&subsys->entry);
+	mutex_unlock(&nvme_subsystems_lock);
+
+	kfree(subsys);
+}
+
+static void nvme_put_subsystem(struct nvme_subsystem *subsys)
+{
+	kref_put(&subsys->ref, nvme_destroy_subsystem);
+}
+
+static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
+{
+	struct nvme_subsystem *subsys;
+
+	lockdep_assert_held(&nvme_subsystems_lock);
+
+	list_for_each_entry(subsys, &nvme_subsystems, entry) {
+		if (strcmp(subsys->subnqn, subsysnqn))
+			continue;
+		if (!kref_get_unless_zero(&subsys->ref))
+			continue;
+		return subsys;
+	}
+
+	return NULL;
+}
+
+static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+{
+	struct nvme_subsystem *subsys, *found;
+
+	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
+	if (!subsys)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&subsys->ctrls);
+	kref_init(&subsys->ref);
+	nvme_init_subnqn(subsys, ctrl, id);
+	mutex_init(&subsys->lock);
+
+	mutex_lock(&nvme_subsystems_lock);
+	found = __nvme_find_get_subsystem(subsys->subnqn);
+	if (found) {
+		/*
+		 * Verify that the subsystem actually supports multiple
+		 * controllers, else bail out.
+		 */
+		kfree(subsys);
+		if (!(id->cmic & (1 << 1))) {
+			dev_err(ctrl->device,
+				"ignoring ctrl due to duplicate subnqn (%s).\n",
+				found->subnqn);
+			mutex_unlock(&nvme_subsystems_lock);
+			return -EINVAL;
+		}
+
+		subsys = found;
+	} else {
+		list_add_tail(&subsys->entry, &nvme_subsystems);
+	}
+
+	ctrl->subsys = subsys;
+	mutex_unlock(&nvme_subsystems_lock);
+
+	mutex_lock(&subsys->lock);
+	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
+	mutex_unlock(&subsys->lock);
+
+	return 0;
 }
 
 /*
@@ -1796,7 +1877,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
-	nvme_init_subnqn(ctrl, id);
+	ret = nvme_init_subsystem(ctrl, id);
+	if (ret) {
+		kfree(id);
+		return ret;
+	}
 
 	if (!ctrl->identified) {
 		/*
@@ -2230,7 +2315,7 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subnqn);
+	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subsys->subnqn);
 }
 static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
 
@@ -2770,12 +2855,22 @@ EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 static void nvme_free_ctrl(struct kref *kref)
 {
 	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
+	struct nvme_subsystem *subsys = ctrl->subsys;
 
 	put_device(ctrl->device);
 	nvme_release_instance(ctrl);
 	ida_destroy(&ctrl->ns_ida);
 
+	if (subsys) {
+		mutex_lock(&subsys->lock);
+		list_del(&ctrl->subsys_entry);
+		mutex_unlock(&subsys->lock);
+	}
+
 	ctrl->ops->free_ctrl(ctrl);
+
+	if (subsys)
+		nvme_put_subsystem(subsys);
 }
 
 void nvme_put_ctrl(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 47307752dc65..ec443dcb289b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -874,10 +874,10 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		goto out_unlock;
 	}
 
-	if (strcmp(ctrl->subnqn, opts->subsysnqn)) {
+	if (strcmp(ctrl->subsys->subnqn, opts->subsysnqn)) {
 		dev_warn(ctrl->device,
 			"controller returned incorrect NQN: \"%s\".\n",
-			ctrl->subnqn);
+			ctrl->subsys->subnqn);
 		up_read(&nvmf_transports_rwsem);
 		ctrl->ops->delete_ctrl(ctrl);
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d3f3c4447515..b96aeaf93dc1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -138,13 +138,15 @@ struct nvme_ctrl {
 	struct ida ns_ida;
 	struct work_struct reset_work;
 
+	struct nvme_subsystem *subsys;
+	struct list_head subsys_entry;
+
 	struct opal_dev *opal_dev;
 
 	char name[12];
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
-	char subnqn[NVMF_NQN_SIZE];
 	u16 cntlid;
 
 	u32 ctrl_config;
@@ -197,6 +199,14 @@ struct nvme_ctrl {
 	struct nvmf_ctrl_options *opts;
 };
 
+struct nvme_subsystem {
+	struct list_head	entry;
+	struct mutex		lock;
+	struct list_head	ctrls;
+	struct kref		ref;
+	char			subnqn[NVMF_NQN_SIZE];
+};
+
 struct nvme_ns {
 	struct list_head list;
 
-- 
2.14.1
