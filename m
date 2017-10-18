Return-Path: <BATV+33c0a560d8cf4f6c9bdc+5169+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 13/17] nvme: track subsystems
Date: Wed, 18 Oct 2017 18:52:54 +0200
Message-Id: <20171018165258.23212-14-hch@lst.de>
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This adds a new nvme_subsystem structure so that we can track multiple
controllers that belong to a single subsystem.  For now we only use it
to store the NQN, and to check that we don't have duplicate NQNs unless
the involved subsystems support multiple controllers.

Includes code originally from Hannes Reinecke to expose the subsystems
in sysfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c    | 179 +++++++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/fabrics.c |   4 +-
 drivers/nvme/host/nvme.h    |  20 +++--
 3 files changed, 167 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d490abd0195c..88f67deabf7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -68,9 +68,13 @@ MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 struct workqueue_struct *nvme_wq;
 EXPORT_SYMBOL_GPL(nvme_wq);
 
+static LIST_HEAD(nvme_subsystems);
+static DEFINE_MUTEX(nvme_subsystems_lock);
+
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_chr_devt;
 static struct class *nvme_class;
+static struct class *nvme_subsys_class;
 
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
 {
@@ -1694,14 +1698,15 @@ static bool quirk_matches(const struct nvme_id_ctrl *id,
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
 
@@ -1709,14 +1714,112 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
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
+static void nvme_free_subsystem(struct device *dev)
+{
+	struct nvme_subsystem *subsys =
+			container_of(dev, struct nvme_subsystem, dev);
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
+	put_device(&subsys->dev);
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
+		if (!kobject_get_unless_zero(&subsys->dev.kobj))
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
+	int ret;
+
+	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
+	if (!subsys)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&subsys->ctrls);
+	nvme_init_subnqn(subsys, ctrl, id);
+	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
+	memcpy(subsys->model, id->mn, sizeof(subsys->model));
+	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
+	subsys->vendor_id = le16_to_cpu(id->vid);
+	mutex_init(&subsys->lock);
+
+	subsys->dev.class = nvme_subsys_class;
+	subsys->dev.release = nvme_free_subsystem;
+	dev_set_name(&subsys->dev, subsys->subnqn);
+	device_initialize(&subsys->dev);
+
+	mutex_lock(&nvme_subsystems_lock);
+	found = __nvme_find_get_subsystem(subsys->subnqn);
+	if (found) {
+		/*
+		 * Verify that the subsystem actually supports multiple
+		 * controllers, else bail out.
+		 */
+		if (!(id->cmic & (1 << 1))) {
+			dev_err(ctrl->device,
+				"ignoring ctrl due to duplicate subnqn (%s).\n",
+				found->subnqn);
+			nvme_put_subsystem(found);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		kfree(subsys);
+		subsys = found;
+	} else {
+		ret = device_add(&subsys->dev);
+		if (ret) {
+			dev_err(ctrl->device,
+				"failed to register subsystem device.\n");
+			goto out_unlock;
+		}
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
+
+out_unlock:
+	mutex_unlock(&nvme_subsystems_lock);
+	kfree(subsys);
+	return ret;
 }
 
 /*
@@ -1754,9 +1857,13 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
-	nvme_init_subnqn(ctrl, id);
-
 	if (!ctrl->identified) {
+		int i;
+
+		ret = nvme_init_subsystem(ctrl, id);
+		if (ret)
+			goto out_free;
+
 		/*
 		 * Check for quirks.  Quirk can depend on firmware version,
 		 * so, in principle, the set of quirks present can change
@@ -1765,9 +1872,6 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		 * the device, but we'd have to make sure that the driver
 		 * behaves intelligently if the quirks change.
 		 */
-
-		int i;
-
 		for (i = 0; i < ARRAY_SIZE(core_quirks); i++) {
 			if (quirk_matches(id, &core_quirks[i]))
 				ctrl->quirks |= core_quirks[i].quirks;
@@ -1780,14 +1884,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	ctrl->oacs = le16_to_cpu(id->oacs);
-	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	ctrl->cntlid = le16_to_cpup(&id->cntlid);
-	memcpy(ctrl->serial, id->sn, sizeof(id->sn));
-	memcpy(ctrl->model, id->mn, sizeof(id->mn));
-	memcpy(ctrl->firmware_rev, id->fr, sizeof(id->fr));
 	if (id->mdts)
 		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
 	else
@@ -1990,9 +2090,9 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	struct nvme_ctrl *ctrl = ns->ctrl;
-	int serial_len = sizeof(ctrl->serial);
-	int model_len = sizeof(ctrl->model);
+	struct nvme_subsystem *subsys = ns->ctrl->subsys;
+	int serial_len = sizeof(subsys->serial);
+	int model_len = sizeof(subsys->model);
 
 	if (!uuid_is_null(&ns->uuid))
 		return sprintf(buf, "uuid.%pU\n", &ns->uuid);
@@ -2003,15 +2103,16 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
 		return sprintf(buf, "eui.%8phN\n", ns->eui);
 
-	while (serial_len > 0 && (ctrl->serial[serial_len - 1] == ' ' ||
-				  ctrl->serial[serial_len - 1] == '\0'))
+	while (serial_len > 0 && (subsys->serial[serial_len - 1] == ' ' ||
+				  subsys->serial[serial_len - 1] == '\0'))
 		serial_len--;
-	while (model_len > 0 && (ctrl->model[model_len - 1] == ' ' ||
-				 ctrl->model[model_len - 1] == '\0'))
+	while (model_len > 0 && (subsys->model[model_len - 1] == ' ' ||
+				 subsys->model[model_len - 1] == '\0'))
 		model_len--;
 
-	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", ctrl->vid,
-		serial_len, ctrl->serial, model_len, ctrl->model, ns->ns_id);
+	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
+		serial_len, subsys->serial, model_len, subsys->model,
+		ns->ns_id);
 }
 static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
 
@@ -2097,10 +2198,15 @@ static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
 {										\
         struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sprintf(buf, "%.*s\n", (int)sizeof(ctrl->field), ctrl->field);	\
+        return sprintf(buf, "%.*s\n",						\
+		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);		\
 }										\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 
+nvme_show_str_function(model);
+nvme_show_str_function(serial);
+nvme_show_str_function(firmware_rev);
+
 #define nvme_show_int_function(field)						\
 static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
@@ -2110,9 +2216,6 @@ static ssize_t  field##_show(struct device *dev,				\
 }										\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 
-nvme_show_str_function(model);
-nvme_show_str_function(serial);
-nvme_show_str_function(firmware_rev);
 nvme_show_int_function(cntlid);
 
 static ssize_t nvme_sysfs_delete(struct device *dev,
@@ -2166,7 +2269,7 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subnqn);
+	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subsys->subnqn);
 }
 static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
 
@@ -2675,11 +2778,21 @@ static void nvme_free_ctrl(struct device *dev)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(dev, struct nvme_ctrl, ctrl_device);
+	struct nvme_subsystem *subsys = ctrl->subsys;
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
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
 
 /*
@@ -2868,8 +2981,15 @@ int __init nvme_core_init(void)
 		goto unregister_chrdev;
 	}
 
+	nvme_subsys_class = class_create(THIS_MODULE, "nvme-subsystem");
+	if (IS_ERR(nvme_subsys_class)) {
+		result = PTR_ERR(nvme_subsys_class);
+		goto destroy_class;
+	}
 	return 0;
 
+destroy_class:
+	class_destroy(nvme_class);
 unregister_chrdev:
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
 destroy_wq:
@@ -2879,6 +2999,7 @@ int __init nvme_core_init(void)
 
 void nvme_core_exit(void)
 {
+	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_wq);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8bca36a46924..dcad66e37a8f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -877,10 +877,10 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
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
index e16346048b73..c12705cf14a3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -139,13 +139,12 @@ struct nvme_ctrl {
 	struct ida ns_ida;
 	struct work_struct reset_work;
 
+	struct nvme_subsystem *subsys;
+	struct list_head subsys_entry;
+
 	struct opal_dev *opal_dev;
 
 	char name[12];
-	char serial[20];
-	char model[40];
-	char firmware_rev[8];
-	char subnqn[NVMF_NQN_SIZE];
 	u16 cntlid;
 
 	u32 ctrl_config;
@@ -156,7 +155,6 @@ struct nvme_ctrl {
 	u32 page_size;
 	u32 max_hw_sectors;
 	u16 oncs;
-	u16 vid;
 	u16 oacs;
 	u16 nssa;
 	u16 nr_streams;
@@ -198,6 +196,18 @@ struct nvme_ctrl {
 	struct nvmf_ctrl_options *opts;
 };
 
+struct nvme_subsystem {
+	struct device		dev;
+	struct list_head	entry;
+	struct mutex		lock;
+	struct list_head	ctrls;
+	char			subnqn[NVMF_NQN_SIZE];
+	char			serial[20];
+	char			model[40];
+	char			firmware_rev[8];
+	u16			vendor_id;
+};
+
 struct nvme_ns {
 	struct list_head list;
 
-- 
2.14.1
