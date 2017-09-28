Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.de>
Subject: [PATCH 2/2] nvme: use device_add_disk_with_groups()
Date: Thu, 28 Sep 2017 21:36:37 +0200
Message-Id: <20170928193637.24707-2-mwilck@suse.com>
In-Reply-To: <20170928193637.24707-1-mwilck@suse.com>
References: <20170928193637.24707-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

By using device_add_disk_with_groups(), we can avoid the race
condition with udev rule processing, because no udev event will
be triggered before all attributes are available.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/nvme/host/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5a14cc7f28ee..e7289a727715 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2156,6 +2156,11 @@ static const struct attribute_group nvme_ns_attr_group = {
 	.is_visible	= nvme_ns_attrs_are_visible,
 };
 
+static const struct attribute_group *nvme_ns_attr_groups[] = {
+	&nvme_ns_attr_group,
+	NULL,
+};
+
 #define nvme_show_str_function(field)						\
 static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
@@ -2405,11 +2410,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	kfree(id);
 
-	device_add_disk(ctrl->device, ns->disk);
-	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			ns->disk->disk_name);
+	device_add_disk_with_groups(ctrl->device, ns->disk,
+				    nvme_ns_attr_groups);
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
-- 
2.14.0
