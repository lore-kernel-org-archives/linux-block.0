Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87721184F
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539175; cv=none; b=tkiDphjIN09FMWbrFQclYx2qEUUv3+xG3SQfWRXvIFFIHKUwvnR0BZF9wwpisQcV7FNohSp3gswl8Blu436cGYynLunD588djG7zay58cznEN5lKJfWP1X8I/mDgs/CoQClNYiZgkkJ5gp//1i8DTBmZ5A6w+6Mg1/nR08KDj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539175; c=relaxed/simple;
	bh=f7C82pz/hMK6jDwsB6wE+30ON0421Ax+A3toq3HUqiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqHtzy/UV447a735D5/zj2zLf4lRwWeGShpLRJigM8CkxnW7YofXXqizpOiwsMELC+VVQatB0scijl5jqMSekfDcMi6rR9qLwPXMwi+5qGnL36wKdWB5DiyQNuvr41Yh3SOch3yF3SghUePig95oPMUGwpn28rfTs3dS+xb6IEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uvmx42QE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uvmx42QE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L3jpxX032051;
	Fri, 21 Mar 2025 06:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FNoGskl4zFR2AHdSb
	h0nJA6b59iDEsGXJMzaMLt3RSU=; b=Uvmx42QE0mlZ5tSG4hs66SlN8H46zYG4X
	w9pWuNeyxj7Cvwxs9CMktR/IMvV/9lr67jLgKdzhs1ruaesx6vACy12JzifVWrte
	6CSpZllP/s1oY4De7RIdEE+nfLx6Vv0ZhzRSQc2AUQdBmr8V4EACXfieVmP40J5+
	DqGpAm1ydnlwqHm+1x7gTjVahB5SP2oBwerzvpKPSw/Tg3FU2g+3i89yur5RTh+V
	j0ZGu6EpemW5vRFgXeoi5xwWo4TrwMnQ9d4OASvpHq7A67tovdtoRRu9SwjR72el
	dhckxDWh1iL/X1KcG799I/vKiSq+jLlYHn39XoT/EleQkR7ZxI8lw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45h0g9rkm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 06:39:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52L5FpHI005579;
	Fri, 21 Mar 2025 06:39:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm90c759-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 06:39:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52L6dAL729426396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 06:39:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17B3E20049;
	Fri, 21 Mar 2025 06:39:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E25520040;
	Fri, 21 Mar 2025 06:39:07 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.80.43])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Mar 2025 06:39:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of the multipath head node
Date: Fri, 21 Mar 2025 12:07:22 +0530
Message-ID: <20250321063901.747605-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321063901.747605-1-nilay@linux.ibm.com>
References: <20250321063901.747605-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 40OZgJNV5tLF8oFsU6NQZByw34PIuUkQ
X-Proofpoint-GUID: 40OZgJNV5tLF8oFsU6NQZByw34PIuUkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_02,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503210045

Currently, the multipath head node of a PCIe NVMe disk is removed
immediately as soon as all paths of the disk are removed. However,
this can cause issues in scenarios where:

- The disk hot-removal followed by re-addition.
- Transient PCIe link failures that trigger re-enumeration,
  temporarily removing and then restoring the disk.

In these cases, removing the head node prematurely may lead to a head
disk node name change upon re-addition, requiring applications to
reopen their handles if they were performing I/O during the failure.

To address this, introduce a delayed removal mechanism of head disk
node. During transient failure, instead of immediate removal of head
disk node, the system waits for a configurable timeout, allowing the
disk to recover. Additionally, please note that the head disk node is
now always created for all types of NVMe disks (single-ported or multi-
ported), unless the multipath module parameter is explicitly set to
false or CONFIG_NVME_MULTIPATH is disabled.

During transient disk failure, if application sends any IO then we
queue it instead of failing such IO immediately. If the disk comes back
online within the timeout, the queued IOs are resubmitted to the disk
ensuring seamless operation. In case disk couldn't recover from the
failure then queued IOs are failed to its completion and application
receives the error.

So this way, if disk comes back online within the configured period,
the head node remains unchanged, ensuring uninterrupted workloads
without requiring applications to reopen device handles.

A new sysfs attribute, named "delayed_shutdown_sec" is added for user
who wish to configure time for the delayed removal of head disk node.
The default value of this attribute is set to 0 seconds ensuring no
behavior change unless explicitly configured.

Link: https://lore.kernel.org/linux-nvme/Y9oGTKCFlOscbPc2@infradead.org/
Link: https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/
Suggested-by: Keith Busch <kbusch@kernel.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
[nilay: reworked based on the original idea/POC from Christoph and Keith]
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  18 +++---
 drivers/nvme/host/multipath.c | 118 +++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |   4 ++
 drivers/nvme/host/sysfs.c     |  13 ++++
 4 files changed, 127 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 870314c52107..e798809a8325 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3562,7 +3562,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		 */
 		if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
 			continue;
-		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
+		if (nvme_tryget_ns_head(h))
 			return h;
 	}
 
@@ -3690,6 +3690,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
+#ifdef CONFIG_NVME_MULTIPATH
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		set_bit(NVME_NSHEAD_FABRICS, &head->flags);
+#endif
 
 	if (head->ids.csi) {
 		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
@@ -3806,7 +3810,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		}
 	} else {
 		ret = -EINVAL;
-		if (!info->is_shared || !head->shared) {
+		if ((!info->is_shared || !head->shared) &&
+		    !list_empty(&head->list)) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n",
 				info->nsid);
@@ -3988,8 +3993,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	bool last_path = false;
-
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -4009,10 +4012,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list)) {
-		list_del_init(&ns->head->entry);
-		last_path = true;
-	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	/* guarantee not available in head->list */
@@ -4030,8 +4029,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->namespaces_lock);
 	synchronize_srcu(&ns->ctrl->srcu);
 
-	if (last_path)
-		nvme_mpath_shutdown_disk(ns->head);
+	nvme_mpath_shutdown_disk(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6b12ca80aa27..0f54889bd483 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -421,7 +421,6 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 		return nvme_numa_path(head);
 	}
 }
-
 static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
@@ -429,6 +428,16 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
 		return NULL;
 
+	/*
+	 * For non-fabric controllers we support delayed removal of head disk
+	 * node. If we reached up to here then it means that head disk is still
+	 * alive and so we assume here that even if there's no path available
+	 * maybe due to the transient link failure, we could queue up the IO
+	 * and later when path becomes ready we re-submit queued IO.
+	 */
+	if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
+		return true;
+
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
@@ -444,7 +453,6 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	}
 	return false;
 }
-
 static void nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
@@ -617,6 +625,40 @@ static void nvme_requeue_work(struct work_struct *work)
 	}
 }
 
+static void nvme_remove_head(struct nvme_ns_head *head)
+{
+	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+		/*
+		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
+		 * to allow multipath to fail all I/O.
+		 */
+		kblockd_schedule_work(&head->requeue_work);
+
+		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		synchronize_srcu(&head->srcu);
+		del_gendisk(head->disk);
+		nvme_put_ns_head(head);
+	}
+}
+
+static void nvme_remove_head_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head = container_of(to_delayed_work(work),
+			struct nvme_ns_head, remove_work);
+	bool shutdown = false;
+
+	mutex_lock(&head->subsys->lock);
+	if (list_empty(&head->list)) {
+		list_del_init(&head->entry);
+		shutdown = true;
+	}
+	mutex_unlock(&head->subsys->lock);
+	if (shutdown)
+		nvme_remove_head(head);
+
+	module_put(THIS_MODULE);
+}
+
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 {
 	struct queue_limits lim;
@@ -626,14 +668,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
+	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
+	head->delayed_shutdown_sec = 0;
 
 	/*
-	 * Add a multipath node if the subsystems supports multiple controllers.
-	 * We also do this for private namespaces as the namespace sharing flag
-	 * could change after a rescan.
+	 * A head disk node is always created for all types of NVMe disks
+	 * (single-ported and multi-ported), unless the multipath module
+	 * parameter is explicitly set to false.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
+	if (!multipath)
 		return 0;
 
 	blk_set_stacking_limits(&lim);
@@ -659,6 +702,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
+	nvme_tryget_ns_head(head);
 	return 0;
 }
 
@@ -1015,6 +1059,40 @@ static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr
 }
 DEVICE_ATTR_RO(numa_nodes);
 
+static ssize_t delayed_shutdown_sec_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	int ret;
+
+	mutex_lock(&head->subsys->lock);
+	ret = sysfs_emit(buf, "%u\n", head->delayed_shutdown_sec);
+	mutex_unlock(&head->subsys->lock);
+	return ret;
+}
+
+static ssize_t delayed_shutdown_sec_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	unsigned int sec;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &sec);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&head->subsys->lock);
+	head->delayed_shutdown_sec = sec;
+	mutex_unlock(&head->subsys->lock);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(delayed_shutdown_sec);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
@@ -1138,18 +1216,26 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 {
-	if (!head->disk)
-		return;
-	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
-		nvme_cdev_del(&head->cdev, &head->cdev_device);
+	mutex_lock(&head->subsys->lock);
+
+	if (!list_empty(&head->list) || !head->disk)
+		goto out;
+
+	if (head->delayed_shutdown_sec) {
 		/*
-		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
-		 * to allow multipath to fail all I/O.
+		 * Ensure that no one could remove this module while the head
+		 * remove work is pending.
 		 */
-		synchronize_srcu(&head->srcu);
-		kblockd_schedule_work(&head->requeue_work);
-		del_gendisk(head->disk);
+		if (!try_module_get(THIS_MODULE))
+			goto out;
+		queue_delayed_work(nvme_wq, &head->remove_work,
+				head->delayed_shutdown_sec * HZ);
+	} else {
+		list_del_init(&head->entry);
+		nvme_remove_head(head);
 	}
+out:
+	mutex_unlock(&head->subsys->lock);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..4375357b8cd7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,7 +503,10 @@ struct nvme_ns_head {
 	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
+	struct delayed_work	remove_work;
+	unsigned int		delayed_shutdown_sec;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_FABRICS	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -986,6 +989,7 @@ extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
+extern struct device_attribute dev_attr_delayed_shutdown_sec;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d31226f7a4f..170897349093 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -260,6 +260,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_state.attr,
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
+	&dev_attr_delayed_shutdown_sec.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -296,6 +297,18 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_delayed_shutdown_sec.attr) {
+		struct nvme_ns_head *head = dev_to_ns_head(dev);
+		struct gendisk *disk = dev_to_disk(dev);
+
+		/*
+		 * This attribute is only valid for head node and non-fabric
+		 * controllers.
+		 */
+		if (!nvme_disk_is_ns_head(disk) ||
+				test_bit(NVME_NSHEAD_FABRICS, &head->flags))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.47.1

