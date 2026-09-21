Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10CC276050
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979901; cv=none; b=dKFAi9FAvi3qzrYn6/BqkVHhqbSJzQ/FBHbXrR4daDkhCaVXkyJEDBjT46wSEw8sakc7rV30UYNABoIDLcSCeA1u364nBoU78wvpNofAX77B9bsDBlk1N8HA08pAuBRVdydmv8JX5vtEjE8/MsiJA6pG94OCEFgdTw2Ic5JU7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979901; c=relaxed/simple;
	bh=lo+3hYrHbOxtP+yhhzev+iunFmIbTKcxkOK8eO47HeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlJH3a+ucUyGQ/wsNACXzl0S/p5mw7QHqTsSKkI0wMblGr3TMQTTp8JBBy++fOd3i3VnuXiLTnKiKWKD3tcQZPebK6HtdkdT40J87zpI76dwKQX7Hv21v5u+mOS5qHrowX1QqnCEtG/6t0A33TU8t0I8Y2xPR2aZUuTk82ABQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lSXdiOQU; arc=none smtp.client-ip=91.218.175.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lSXdiOQU"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lo+3hYrHbOxtP+yhhzev+iunFmIbTKcxkOK8eO47HeM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979897; v=1; x=1790584697;
 b=lSXdiOQUnmMvl/VHbFJgzutIS1h8AXdoxa1RXyfLS2I2/jK2YRNtzW9DQV2sq/Qval3XEyfC
 +MMKWmGEmTpvf9cnczjdIbSDdSJkRXMHDsbhMkAV+wk/J7x9bzVneyfWm94M4AcDp3YxNT1ZbHd
 h1ilfnvY667FrgteW/qFAssk=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9969d023204782c0;
	Mon, 21 Sep 2026 08:38:17 +0000
X-Mizu-Trace-ID: 9969d023204782c0
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 3/4] nvme-multipath: clone head disk partitions to per-path disks
Date: Mon, 21 Sep 2026 09:37:51 +0100
Message-ID: <20260921083752.1154316-4-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921083752.1154316-1-john.garry@linux.dev>
References: <20260921083752.1154316-1-john.garry@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To fix diskstats per partition, it is required that the per-path disk
actually has an up-to-date partition table. This partition table would be
a clone of the head disk partition table.

At two points the partition table needs to be updated:
- when the per-path disk is added in nvme_mpath_add_disk()
- for partition table updates to the head disk, add
  nvme_ns_head_disk_changed() to clone the partition table to per-path
  disks

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/nvme/host/multipath.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..e871ad40d893 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -623,6 +623,23 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 #define nvme_ns_head_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+static void nvme_ns_head_disk_changed(struct gendisk *disk)
+{
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_ns *ns;
+	int srcu_idx;
+
+	lockdep_assert_held(&disk->open_mutex);
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
+		if (bdev_clone_partitions(head->disk, ns->disk))
+			clear_bit(NVME_NS_READY, &ns->flags);
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+}
+
 const struct block_device_operations nvme_ns_head_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= nvme_ns_head_submit_bio,
@@ -634,6 +651,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.get_unique_id	= nvme_ns_head_get_unique_id,
 	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
+	.disk_changed_notify	= nvme_ns_head_disk_changed,
 };
 
 static const struct file_operations nvme_ns_head_chr_fops = {
@@ -1360,6 +1378,20 @@ void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns)
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
+	struct nvme_ns_head *head = ns->head;
+	int ret;
+
+	if (!head->disk)
+		return;
+
+	mutex_lock(&head->disk->open_mutex);
+	ret = bdev_clone_partitions(head->disk, ns->disk);
+	mutex_unlock(&head->disk->open_mutex);
+	if (ret) {
+		clear_bit(NVME_NS_READY, &ns->flags);
+		return;
+	}
+
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
 			.grpid = anagrpid,
-- 
2.43.0

