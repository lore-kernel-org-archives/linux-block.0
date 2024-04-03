Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1C14900C
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153891; cv=none; b=dtbUB4pkVHfgvW7fYLghekl+O0RntxdcfGpYtAoBMKwXJOtjyX2s1DXuzwvqOEu5XCU3tGesP5EANvSdjBp724kgJua71DEC6BIi2f/tGGOPT0BlcjnFf65KBzncVlVYBipjt5OURYt/9T2x4NhqIkyyY8HuR0ry30IQZIxfjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153891; c=relaxed/simple;
	bh=w1EEgdIPZxfZ8fVd55Jr20R155i9uV1D12DOeG3OFus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YxcWnX9Dae6Pv5l/e78bx5LDN/oESXrZy4Uy6Qy8C1EsCMlbJ4NQWA5QkomuvvEKuXbYJMwlz3OSrsTRG9q+JVXiIjEzb0PIvChOgLhhnDJ3HByhFEsLqmXV6I7avFN4gEmv314LfDbImOFfgqRZc2Oe8bXYHzVN4jGWT5U4MmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHqfGWS4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHqfGWS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E887C43601;
	Wed,  3 Apr 2024 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153891;
	bh=w1EEgdIPZxfZ8fVd55Jr20R155i9uV1D12DOeG3OFus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHqfGWS4mQ9Ykusg/R01L/tijnufZFRdRSEMkkaZ1A+UxBSZNPsI4O/ySDW9C+JMS
	 clMwkjfaVyigVme/mkSiMBUggAu9vO/xdJZpaUWL2hwsbqImln7dmfYFdztJ+WbdKb
	 HrUAsD0XlyMmuTjWehtQLROCvJ/J+V0vJXZZz+/K3rLmmH6pmWZvEx/jLeMDs+lirY
	 UwLwA3KZkG5H8mSpHi0M+Ff51xs4wrp2brmnxmC/UkojOJRQ3H9gQ8c74hWqjsamSb
	 vB5fII4t5UJTRiij0nB1kb3uHlYkSpH4z6Mck4YlLrEnUkuIbzQQjsvcq8XoGqALs5
	 RO9Fpx1smYqjQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvme: add 'latency' iopolicy
Date: Wed,  3 Apr 2024 16:17:56 +0200
Message-Id: <20240403141756.88233-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240403141756.88233-1-hare@kernel.org>
References: <20240403141756.88233-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a latency-based I/O policy for multipathing. It uses the blk-nodelat
latency tracker to provide latencies for each node, and schedules
I/O on the path with the least latency for the submitting node.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 57 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5397fb428b24..18e7fe45c2c1 100644
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
 
@@ -40,6 +45,28 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
 }
 
+static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
+{
+	struct nvme_ns_head *h;
+	struct nvme_ns *ns;
+	bool enable = iopolicy == NVME_IOPOLICY_LAT;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(h, &subsys->nsheads, entry) {
+		list_for_each_entry_rcu(ns, &h->list, siblings) {
+			if (enable) {
+				ret = blk_nlat_enable(ns->disk);
+				if (ret)
+					break;
+			} else
+				blk_nlat_disable(ns->disk);
+		}
+	}
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
@@ -242,13 +269,16 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
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
+			distance = blk_nlat_latency(ns->disk, node);
 		else
 			distance = LOCAL_DISTANCE;
 
@@ -339,15 +369,17 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
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
@@ -803,15 +835,18 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 {
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
-	int i;
+	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
-			return count;
+			ret = nvme_activate_iopolicy(subsys, i);
+			if (!ret) {
+				WRITE_ONCE(subsys->iopolicy, i);
+				return count;
+			}
+			return ret;
 		}
 	}
-
 	return -EINVAL;
 }
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
@@ -847,6 +882,14 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
+	if (!blk_nlat_init(ns->disk) &&
+	    READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_LAT) {
+		int ret = blk_nlat_enable(ns->disk);
+		if (unlikely(ret))
+			pr_warn("%s: Failed to enable latency tracking, error %d\n",
+				ns->disk->disk_name, ret);
+	}
+
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
 			.grpid = anagrpid,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 27397f8404d6..b07afb1aa5bb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -402,6 +402,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_LAT,
 };
 
 struct nvme_subsystem {
-- 
2.35.3

