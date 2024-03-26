Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CAD13D24B
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467350; cv=none; b=PJdzSFD0oO+xyt0WX+mdINoQWosSvbXVd5Lmvg/44D2hXD8/38aq8Mkj2WYXM7MSOudYY2eectPT9tDJKUoPqNlv4JrvJYtBASJoYLtdibNR1FSJ1wHvGk21RRMBk8qAxUQCI5DnL9aKhWlJ8DjX/O9MjWx7SqX/tR0U++ayVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467350; c=relaxed/simple;
	bh=Kv3YRl9LzbqPnD2/oDibTM2oci8Eutg/qoRbtzgs828=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCMYqKDyf+WZIL2io1I7vgA69rqTAmgJ9x2nCZjgFphLW4WxDJ83uM4zO04Cl1FIRngvM7Qhxxf5VvPb0MGDfPKuHVLFpYB2wzO5JExq5kCSh7mmD2kRHXF2A6icfAPOg4DOEM9/XBmT2D2wEK5AlCbQHx08LjmsCjHJzbWf0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsJrxt9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsJrxt9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1047C433A6;
	Tue, 26 Mar 2024 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467349;
	bh=Kv3YRl9LzbqPnD2/oDibTM2oci8Eutg/qoRbtzgs828=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZsJrxt9i2hYTM70fk9u7DQLbMHqTRZZSu8c2ZaI5y/5Rb9se05rzO76XQ8eYkjiO7
	 VGU0j0KHCq27NO36QiLDYX5FkuwC2oiDZtS+sB3YeoaGrBSq63e9oAY7GDvohmEJRm
	 4KT4m86fF5OEztFbueLf3Z/wymNLzvUFqaowU4LUnRyQ/WXGXCOWU6LGe0bydQerNu
	 OINXv+hdOrtUCbAy5dWgADmfrAc4mlcI76/fu/K8F8nSyQQxAHE2HSEJ9jvT8uK6kY
	 yzRe2P63UgQ0mAs4I4IZT4hFRC61g+kQuWXa+8HG3UiJiv5WvEd64qFKxcInEYVCvk
	 kZWb8+UDis7uw==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme: add 'latency' iopolicy
Date: Tue, 26 Mar 2024 16:35:29 +0100
Message-Id: <20240326153529.75989-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326153529.75989-1-hare@kernel.org>
References: <20240326153529.75989-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

Add a latency-based I/O policy for multipathing. It uses the blk-nodelat
latency tracker to provide latencies for each node, and schedules
I/O on the path with the least latency for the submitting node.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 46 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  2 ++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5397fb428b24..fd3bda6f8543 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
+	[NVME_IOPOLICY_LAT]	= "latency",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -29,6 +30,10 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_NUMA;
 	else if (!strncmp(val, "round-robin", 11))
 		iopolicy = NVME_IOPOLICY_RR;
+#ifdef CONFIG_BLK_NODE_LATENCY
+	else if (!strncmp(val, "latency", 7))
+		iopolicy = NVME_IOPOLICY_LAT;
+#endif
 	else
 		return -EINVAL;
 
@@ -40,6 +45,26 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
 }
 
+static void nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
+{
+	struct nvme_ns_head *h;
+	struct nvme_ns *ns;
+	bool enable = iopolicy == NVME_IOPOLICY_LAT;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(h, &subsys->nsheads, entry) {
+		list_for_each_entry_rcu(ns, &h->list, siblings) {
+			if (!test_bit(NVME_NS_NLAT, &ns->flags))
+				continue;
+			if (enable)
+				blk_nodelat_enable(ns->queue);
+			else
+				blk_nodelat_disable(ns->queue);
+		}
+	}
+	mutex_unlock(&subsys->lock);
+}
+
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
@@ -242,13 +267,16 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (iopolicy == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
+		else if (iopolicy == NVME_IOPOLICY_LAT)
+			distance = blk_nodelat_latency(ns->queue, node);
 		else
 			distance = LOCAL_DISTANCE;
 
@@ -339,15 +367,17 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
 	int node = numa_node_id();
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 	struct nvme_ns *ns;
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
 
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+	if (iopolicy == NVME_IOPOLICY_RR)
 		return nvme_round_robin_path(head, node, ns);
-	if (unlikely(!nvme_path_is_optimized(ns)))
+	if (iopolicy == NVME_IOPOLICY_LAT ||
+	    unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
 }
@@ -808,10 +838,10 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
 			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_activate_iopolicy(subsys, i);
 			return count;
 		}
 	}
-
 	return -EINVAL;
 }
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
@@ -847,6 +877,14 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
+	if (!blk_nodelat_init(ns->disk)) {
+		int iopolicy = READ_ONCE(ns->head->subsys->iopolicy);
+
+		set_bit(NVME_NS_NLAT, &ns->flags);
+		if (iopolicy == NVME_IOPOLICY_LAT)
+			blk_nodelat_enable(ns->queue);
+	}
+
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
 			.grpid = anagrpid,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 27397f8404d6..83c3870d5ed0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -402,6 +402,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_LAT,
 };
 
 struct nvme_subsystem {
@@ -519,6 +520,7 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
+#define NVME_NS_NLAT		5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.35.3

