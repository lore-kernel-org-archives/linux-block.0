Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BEB19D8A7
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577242; cv=none; b=YvTWjSKm0DlEBU32+mE73s/AXsmtRCmcE8Da920Qk2Xnbp8kyLH6uevlR4ItGuwz7+5vGMUy5OLhOU8FD1j0oEkhEa3iLxdtNkzuh2ohru8UYvNOBPR2VAOxTWF/BCCDOKHZ9vdx4Zf63oOKWauQT3swEVFF6+fX62LYkh2idTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577242; c=relaxed/simple;
	bh=vOg1w1bfdJxjCjgWjOm90o/ZVH17RqFXlboUi2SB4S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fld6hMn04f03P6MSPk5UdSBNwr3t+eBUdoJlhxO6NtDcYba6qdBExgOkh0quyereKR6JAcJGa3SgpDTqyVt9Lfl6+LS7JBW04zUFoPsxEzhx+mCCh7ymIr97UOTfvSTyLt7LSxI/HzNL7DzuxSikzzggjYuA+fNIn1QKKEwdunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TOVDi8yP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TOVDi8yP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8BOj6023585;
	Fri, 25 Apr 2025 10:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7pFzRnJiEU0xCg0J2
	cfbd3MR8Avp3RNWpuH9UseBap4=; b=TOVDi8yPQj1tCG6+AxBTc5TVDRsWK/QMs
	1LArnbPdw85PAAVdKdak9NagEe8SnWUNQ1gPbtPSskHS3ILLre/yNbghRaAsnrET
	EZHuCVbyoOC/JZAVyscWub7+UyJmjDXHZQB+FDSI+m6NzWoGlF0692QlTNwk1Y2g
	vOBSIe4UoEnkZVa4N96/t4P6t9My9tU7BzcPtchl3CwT3F0TPv8ZA/jbgZ9OMxiW
	OQFVdi6u+asIO1zoBfq60Nl3loWyf9f373NdSJaJz7L4qgKHl69KbUVnevUnoGZn
	gOdChTJ8mWMKnb+c2RV8hifAPI2+3H91ZJPjxGUZlWfBPJpNNVJFA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467krswsek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8E5rQ000973;
	Fri, 25 Apr 2025 10:33:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy4sds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PAXS0d30605612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:33:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BBED20043;
	Fri, 25 Apr 2025 10:33:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20E6A20040;
	Fri, 25 Apr 2025 10:33:25 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 10:33:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv2 1/3] nvme-multipath: introduce delayed removal of the multipath head node
Date: Fri, 25 Apr 2025 16:03:08 +0530
Message-ID: <20250425103319.1185884-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425103319.1185884-1-nilay@linux.ibm.com>
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX4YOHG8m1XCgX TIcidunC/a6pQjzGUDpFH1gyrPv/4UAWOoyDSIvU9ywY2qjo/67MKH4e9JUfWus4GXrSw8iG7gr yqP5Kmvy/K6zSQbm4icAgDwERbZiG6DKVM0r890XB7H+k0E7jOyE+fjFDjZUqpBsXG+KTu14tCr
 qVdZHjSkMPHU0/9l8MQnWYKEKzXbkj7r1/Nc80muC/I4PnlWspEsMl9kBqZ7C35IgfSl/jTQwuf VfTMKhg9ONYlkqMRpTuZ/o1GNJ7jA3yHaNqTQfCM+niSH17njgfy/LtojjMbBtMkdQvDehzkltR nTDQtCM/TgX9YaZMdjAD0fzf7KRZguxLwJG8oBNbPWBfXb/hyAKAcwsU0LsSqWdyP3cZAd7Uhhp
 xHj7owgGwsEHNo4JBTFcS6rtI1bLSHNRMoe2Mrstj8tLDwB9j7dqSbUscKv2xU9mHetWRsyn
X-Proofpoint-GUID: Qh1aVyoHQYumjNeZuXGYLm1rjHO_BoFr
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=680b64fb cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=9r6QK0OtAAAA:8 a=VnNF1IyMAAAA:8 a=m8i3lSHGKz98L6CpTF4A:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=TxIH8fH_K59pr5-VUUuU:22
X-Proofpoint-ORIG-GUID: Qh1aVyoHQYumjNeZuXGYLm1rjHO_BoFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250073

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
disk to recover.

During transient disk failure, if application sends any IO then we
queue it instead of failing such IO immediately. If the disk comes back
online within the timeout, the queued IOs are resubmitted to the disk
ensuring seamless operation. In case disk couldn't recover from the
failure then queued IOs are failed to its completion and application
receives the error.

So this way, if disk comes back online within the configured period,
the head node remains unchanged, ensuring uninterrupted workloads
without requiring applications to reopen device handles.

A new sysfs attribute, named "delayed_removal_secs" is added under head
disk blkdev for user who wish to configure time for the delayed removal
of head disk node. The default value of this attribute is set to zero
second ensuring no behavior change unless explicitly configured.

Link: https://lore.kernel.org/linux-nvme/Y9oGTKCFlOscbPc2@infradead.org/
Link: https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/
Suggested-by: Keith Busch <kbusch@kernel.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
[nilay: reworked based on the original idea/POC from Christoph and Keith]
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  16 ++---
 drivers/nvme/host/multipath.c | 119 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  12 ++++
 drivers/nvme/host/sysfs.c     |  13 ++++
 4 files changed, 141 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cc..5755069e6974 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3560,7 +3560,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		 */
 		if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
 			continue;
-		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
+		if (nvme_tryget_ns_head(h))
 			return h;
 	}
 
@@ -3688,6 +3688,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
+	if (ctrl->opts)
+		nvme_mpath_set_fabrics(head);
 
 	if (head->ids.csi) {
 		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
@@ -3804,7 +3806,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		}
 	} else {
 		ret = -EINVAL;
-		if (!info->is_shared || !head->shared) {
+		if ((!info->is_shared || !head->shared) &&
+		    !list_empty(&head->list)) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n",
 				info->nsid);
@@ -3986,8 +3989,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	bool last_path = false;
-
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -4007,10 +4008,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list)) {
-		list_del_init(&ns->head->entry);
-		last_path = true;
-	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	/* guarantee not available in head->list */
@@ -4028,8 +4025,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->namespaces_lock);
 	synchronize_srcu(&ns->ctrl->srcu);
 
-	if (last_path)
-		nvme_mpath_shutdown_disk(ns->head);
+	nvme_mpath_shutdown_disk(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 250f3da67cc9..68318337c275 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -442,6 +442,23 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 			break;
 		}
 	}
+
+	/*
+	 * If "head->delayed_removal_secs" is configured (i.e., non-zero), do
+	 * not immediately fail I/O. Instead, requeue the I/O for the configured
+	 * duration, anticipating that if there's a transient link failure then
+	 * it may recover within this time window. This parameter is exported to
+	 * userspace via sysfs, and its default value is zero.
+	 * Note: This option is not exposed to the users for NVMeoF connections.
+	 * In fabric-based setups, fabric link failure is managed through other
+	 * parameters such as "reconnect_delay" and "max_reconnects" which is
+	 * handled at respective fabric driver layer. Therefor, head->delayed_
+	 * removal_secs" is intended exclusively for non-fabric (e.g., PCIe)
+	 * multipath configurations.
+	 */
+	if (head->delayed_removal_secs)
+		return true;
+
 	return false;
 }
 
@@ -617,6 +634,40 @@ static void nvme_requeue_work(struct work_struct *work)
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
@@ -626,6 +677,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
+	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
+	head->delayed_removal_secs = 0;
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
@@ -659,6 +712,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
+	nvme_tryget_ns_head(head);
 	return 0;
 }
 
@@ -1015,6 +1069,40 @@ static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr
 }
 DEVICE_ATTR_RO(numa_nodes);
 
+static ssize_t delayed_removal_secs_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	int ret;
+
+	mutex_lock(&head->subsys->lock);
+	ret = sysfs_emit(buf, "%u\n", head->delayed_removal_secs);
+	mutex_unlock(&head->subsys->lock);
+	return ret;
+}
+
+static ssize_t delayed_removal_secs_store(struct device *dev,
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
+	head->delayed_removal_secs = sec;
+	mutex_unlock(&head->subsys->lock);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(delayed_removal_secs);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
@@ -1138,18 +1226,31 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 {
-	if (!head->disk)
-		return;
-	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
-		nvme_cdev_del(&head->cdev, &head->cdev_device);
+	bool shutdown = false;
+
+	mutex_lock(&head->subsys->lock);
+
+	if (!list_empty(&head->list))
+		goto out;
+
+	if (head->delayed_removal_secs) {
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
+				head->delayed_removal_secs * HZ);
+	} else {
+		list_del_init(&head->entry);
+		if (head->disk)
+			shutdown = true;
 	}
+out:
+	mutex_unlock(&head->subsys->lock);
+	if (shutdown)
+		nvme_remove_head(head);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..74cd569882ce 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,7 +503,10 @@ struct nvme_ns_head {
 	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
+	struct delayed_work	remove_work;
+	unsigned int		delayed_removal_secs;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_FABRICS	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -986,12 +989,17 @@ extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
+extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
 	return disk->fops == &nvme_ns_head_ops;
 }
+static inline void nvme_mpath_set_fabrics(struct nvme_ns_head *head)
+{
+	set_bit(NVME_NSHEAD_FABRICS, &head->flags);
+}
 #else
 #define multipath false
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
@@ -1078,6 +1086,10 @@ static inline void nvme_mpath_end_request(struct request *rq)
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
 	return false;
+}
+static inline void nvme_mpath_set_fabrics(struct nvme_ns_head *head)
+{
+
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d31226f7a4f..51633670d177 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -260,6 +260,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_state.attr,
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
+	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -296,6 +297,18 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_delayed_removal_secs.attr) {
+		struct nvme_ns_head *head = dev_to_ns_head(dev);
+		struct gendisk *disk = dev_to_disk(dev);
+
+		/*
+		 * This attribute is only valid for head node and non-fabric
+		 * setup.
+		 */
+		if (!nvme_disk_is_ns_head(disk) ||
+				test_bit(NVME_NSHEAD_FABRICS, &head->flags))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.49.0

