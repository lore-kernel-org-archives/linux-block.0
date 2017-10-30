Return-Path: <guanjunxiong@huawei.com>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
To: Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, Keith Busch
	<keith.busch@intel.com>, Johannes Thumshirn <jthumshirn@suse.de>, niuhaoxin
	<niuhaoxin@huawei.com>, "Shenhong (C)" <shenhong09@huawei.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com>
 <20171028063825.GA14261@lst.de> <20171028141745.GA32039@redhat.com>
 <ae4180e2-4c1b-a5f0-5c26-7cec692e6d50@suse.de>
From: Guan Junxiong <guanjunxiong@huawei.com>
Message-ID: <7cabd9cf-61e7-d53e-d0d5-6af90f2a2ce8@huawei.com>
Date: Mon, 30 Oct 2017 12:09:39 +0800
MIME-Version: 1.0
In-Reply-To: <ae4180e2-4c1b-a5f0-5c26-7cec692e6d50@suse.de>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Hi Christoph, Mike and Hannes

On 2017/10/29 18:01, Hannes Reinecke wrote:
> After all, Linux is about choice, not about forcing users to do things
> in one way only.


I have added an option CONFIG_NVME_SHOW_CTRL_BLK_DEV to show per-controller
block devices nodes.
It is tested simply that dm-multipath and nvme-mpath can coexist.

This patch, based on the Christoph V5 of nvme-mpath,  is in the following.

Does it look good for you ?

Regards
Guan

--
>From de3f446af6591d68ef84333138e744f12db4d695 Mon Sep 17 00:00:00 2001
From: Junxiong Guan <guanjunxiong@huawei.com>
Date: Mon, 30 Oct 2017 04:59:20 -0400
Subject: [PATCH] nvme: add an option to show per-controller block devices
 nodes

Signed-off-by: Junxiong Guan <guanjunxiong@huawei.com>
---
 drivers/nvme/host/Kconfig |  9 ++++++
 drivers/nvme/host/core.c  | 80 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 46d6cb1e03bd..725bff035f38 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -13,6 +13,15 @@ config BLK_DEV_NVME
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvme.

+config NVME_SHOW_CTRL_BLK_DEV
+	bool "Show per-controller block devices of NVMe"
+	depends on NVME_CORE
+	---help---
+	  This adds support to show per-controller block devices nodes in
+	  the user space.
+
+	  If unsure, say N.
+
 config NVME_FABRICS
 	tristate

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 334735db90c8..ae37e274108c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -72,6 +72,9 @@ static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);

+#ifdef CONFIG_NVME_SHOW_CTRL_BLK_DEV
+static DEFINE_SPINLOCK(dev_list_lock);
+#endif
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_chr_devt;
 static struct class *nvme_class;
@@ -357,6 +360,14 @@ static void nvme_free_ns(struct kref *kref)

 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
+
+#ifdef CONFIG_NVME_SHOW_CTRL_BLK_DEV
+	if (ns->disk) {
+		spin_lock(&dev_list_lock);
+		ns->disk->private_data = NULL;
+		spin_unlock(&dev_list_lock);
+	}
+#endif
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -1127,10 +1138,32 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	}
 }

-/* should never be called due to GENHD_FL_HIDDEN */
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
+#ifdef CONFIG_NVME_SHOW_CTRL_BLK_DEV
+	struct nvme_ns *ns;
+
+	spin_lock(&dev_list_lock);
+	ns = bdev->bd_disk->private_data;
+	if (ns) {
+		if (!kref_get_unless_zero(&ns->kref))
+			goto fail;
+		if (!try_module_get(ns->ctrl->ops->module))
+			goto fail_put_ns;
+	}
+	spin_unlock(&dev_list_lock);
+
+	return ns ? 0 : -ENXIO;
+
+fail_put_ns:
+	kref_put(&ns->kref, nvme_free_ns);
+fail:
+	spin_unlock(&dev_list_lock);
+	return -ENXIO;
+#else
+	/* should never be called due to GENHD_FL_HIDDEN */
 	return WARN_ON_ONCE(-ENXIO);
+#endif /* CONFIG_NVME_SHOW_CTRL_BLK_DEV */
 }

 static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
@@ -1392,10 +1425,15 @@ static char nvme_pr_type(enum pr_type type)
 static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 				u64 key, u64 sa_key, u8 op)
 {
+#ifdef CONFIG_NVME_SHOW_CTRL_BLK_DEV
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	struct nvme_ns_head *head = ns->head;
+#else
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
 	struct nvme_ns *ns;
-	struct nvme_command c;
 	int srcu_idx, ret;
+#endif
+	struct nvme_command c;
 	u8 data[16] = { 0, };

 	put_unaligned_le64(key, &data[0]);
@@ -1406,6 +1444,9 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	c.common.nsid = cpu_to_le32(head->ns_id);
 	c.common.cdw10[0] = cpu_to_le32(cdw10);

+#ifdef CONFIG_NVME_SHOW_CTRL_BLK_DEV
+	return nvme_submit_sync_cmd(ns->queue, &c, data, 16);
+#else
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
 	if (likely(ns))
@@ -1413,7 +1454,9 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	else
 		ret = -EWOULDBLOCK;
 	srcu_read_unlock(&head->srcu, srcu_idx);
+
 	return ret;
+#endif
 }

 static int nvme_pr_register(struct block_device *bdev, u64 old,
@@ -1492,6 +1535,34 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */

+#ifdef CONFIG_NVME_SHOW_CTRL_BLK_DEV
+static void nvme_release(struct gendisk *disk, fmode_t mode)
+{
+	struct nvme_ns *ns = disk->private_data;
+
+	module_put(ns->ctrl->ops->module);
+	nvme_put_ns(ns);
+}
+
+static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+
+	return nvme_ns_ioctl(ns, cmd, arg);
+}
+
+static const struct block_device_operations nvme_fops = {
+	.owner		= THIS_MODULE,
+	.ioctl		= nvme_ioctl,
+	.compat_ioctl	= nvme_ioctl,
+	.open		= nvme_open,
+	.release	= nvme_release,
+	.getgeo		= nvme_getgeo,
+	.revalidate_disk= nvme_revalidate_disk,
+	.pr_ops		=&nvme_pr_ops,
+};
+#else
 /*
  * While we don't expose the per-controller devices to userspace we still
  * need valid file operations for them, for one because the block layer
@@ -1503,6 +1574,7 @@ static const struct block_device_operations nvme_fops = {
 	.open		= nvme_open,
 	.revalidate_disk= nvme_revalidate_disk,
 };
+#endif /* CONFIG_NVME_SHOW_CTRL_BLK_DEV */

 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 {
@@ -2875,7 +2947,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
+#ifdef CONFIG_NVME_SHOW_CTRL_BLK_DEV
+	disk->flags = GENHD_FL_EXT_DEVT;
+#else
 	disk->flags = GENHD_FL_HIDDEN;
+#endif
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;

-- 
2.11.1
