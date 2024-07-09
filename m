Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B487161911
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530267; cv=none; b=qdMPPfu7N0Pmgl71bVTVpt3/eQSKHDrSrQbAwg2TRJNLvyaW4QdouWGSQw5kzUcaDRUy1yHMbP4DSQjiB6qjVujHdnXT2onkqQqIo+P1M9VtGcfvxFE0zmTf9Z3amLNF50lXfBGedU6wkWGiImz4OawnSuSYrkbulpqieThYO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530267; c=relaxed/simple;
	bh=zc/KAmxy13giZQtEex9x65KbZebxxJMdDndCjoQ3t7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0qJ98whWYxODIrekcGc1H0Hp0sibkHpO5mnGycljto9exBl+nYsuqcrAGGWRb2QkHLyv8+urSOkhha9Mc/OCNbaDX5zwEhsCz79dypRDomDRGqj7uDvBL+K81lPQjkc9CGnhJkY0gt7QpbXoUxzcNiUb0agg220jM3+zGmg6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZxChNhYJ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZxChNhYJ"
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720530261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5etsdL58pRrV5oUuZuogHAQdMkjp4TD7dOqJ02N/3OA=;
	b=ZxChNhYJdHfbx+xfqIRadoyyV0TYngdfjRDro9H04X35PbUBpLIdFSsD9osSjju22Yh5oz
	Lb+4h2QCkAYWgybWEvNYIjgrad+yUw3jjoOtIW1Ja9Je/atH1jJy4I8y2PTbqHF5SyESXE
	pxrDNmoNWIQ0HSJC+oCQBAH7VrHS8jg=
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: gregory.price@memverge.com
X-Envelope-To: john@groves.net
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: bbhushan2@marvell.com
X-Envelope-To: chaitanyak@nvidia.com
X-Envelope-To: rdunlap@infradead.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: dongsheng.yang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: axboe@kernel.dk,
	dan.j.williams@intel.com,
	gregory.price@memverge.com,
	John@groves.net,
	Jonathan.Cameron@Huawei.com,
	bbhushan2@marvell.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH v1 5/7] cbd: introduce cbd_blkdev
Date: Tue,  9 Jul 2024 13:03:41 +0000
Message-Id: <20240709130343.858363-6-dongsheng.yang@linux.dev>
In-Reply-To: <20240709130343.858363-1-dongsheng.yang@linux.dev>
References: <20240709130343.858363-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "cbd_blkdev" represents a virtual block device named "/dev/cbdX". It
corresponds to a backend. The "blkdev" interacts with upper-layer users
and accepts IO requests from them. A "blkdev" includes multiple
"cbd_queues", each of which requires a "cbd_channel" to
interact with the backend's handler. The "cbd_queue" forwards IO
requests from the upper layer to the backend's handler through the
channel.

cbd_blkdev allow user to force stop a /dev/cbdX, even if backend is not
responsible.

Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
---
 drivers/block/cbd/cbd_blkdev.c | 417 ++++++++++++++++++++++++++
 drivers/block/cbd/cbd_queue.c  | 526 +++++++++++++++++++++++++++++++++
 2 files changed, 943 insertions(+)
 create mode 100644 drivers/block/cbd/cbd_blkdev.c
 create mode 100644 drivers/block/cbd/cbd_queue.c

diff --git a/drivers/block/cbd/cbd_blkdev.c b/drivers/block/cbd/cbd_blkdev.c
new file mode 100644
index 000000000000..96676813f2d3
--- /dev/null
+++ b/drivers/block/cbd/cbd_blkdev.c
@@ -0,0 +1,417 @@
+#include "cbd_internal.h"
+
+static ssize_t blkdev_backend_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_blkdev_device *blkdev;
+	struct cbd_blkdev_info *blkdev_info;
+
+	blkdev = container_of(dev, struct cbd_blkdev_device, dev);
+	blkdev_info = blkdev->blkdev_info;
+
+	if (blkdev_info->state == cbd_blkdev_state_none)
+		return 0;
+
+	return sprintf(buf, "%u\n", blkdev_info->backend_id);
+}
+
+static DEVICE_ATTR(backend_id, 0400, blkdev_backend_id_show, NULL);
+
+static ssize_t blkdev_host_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_blkdev_device *blkdev;
+	struct cbd_blkdev_info *blkdev_info;
+
+	blkdev = container_of(dev, struct cbd_blkdev_device, dev);
+	blkdev_info = blkdev->blkdev_info;
+
+	if (blkdev_info->state == cbd_blkdev_state_none)
+		return 0;
+
+	return sprintf(buf, "%u\n", blkdev_info->host_id);
+}
+
+static DEVICE_ATTR(host_id, 0400, blkdev_host_id_show, NULL);
+
+static ssize_t blkdev_mapped_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_blkdev_device *blkdev;
+	struct cbd_blkdev_info *blkdev_info;
+
+	blkdev = container_of(dev, struct cbd_blkdev_device, dev);
+	blkdev_info = blkdev->blkdev_info;
+
+	if (blkdev_info->state == cbd_blkdev_state_none)
+		return 0;
+
+	return sprintf(buf, "%u\n", blkdev_info->mapped_id);
+}
+
+static DEVICE_ATTR(mapped_id, 0400, blkdev_mapped_id_show, NULL);
+
+CBD_OBJ_HEARTBEAT(blkdev);
+
+static struct attribute *cbd_blkdev_attrs[] = {
+	&dev_attr_mapped_id.attr,
+	&dev_attr_host_id.attr,
+	&dev_attr_backend_id.attr,
+	&dev_attr_alive.attr,
+	NULL
+};
+
+static struct attribute_group cbd_blkdev_attr_group = {
+	.attrs = cbd_blkdev_attrs,
+};
+
+static const struct attribute_group *cbd_blkdev_attr_groups[] = {
+	&cbd_blkdev_attr_group,
+	NULL
+};
+
+static void cbd_blkdev_release(struct device *dev)
+{
+}
+
+const struct device_type cbd_blkdev_type = {
+	.name		= "cbd_blkdev",
+	.groups		= cbd_blkdev_attr_groups,
+	.release	= cbd_blkdev_release,
+};
+
+const struct device_type cbd_blkdevs_type = {
+	.name		= "cbd_blkdevs",
+	.release	= cbd_blkdev_release,
+};
+
+
+static int cbd_major;
+static DEFINE_IDA(cbd_mapped_id_ida);
+
+static int minor_to_cbd_mapped_id(int minor)
+{
+	return minor >> CBD_PART_SHIFT;
+}
+
+
+static int cbd_open(struct gendisk *disk, blk_mode_t mode)
+{
+	struct cbd_blkdev *cbd_blkdev = disk->private_data;
+
+	mutex_lock(&cbd_blkdev->lock);
+	cbd_blkdev->open_count++;
+	mutex_unlock(&cbd_blkdev->lock);
+
+	return 0;
+}
+
+static void cbd_release(struct gendisk *disk)
+{
+	struct cbd_blkdev *cbd_blkdev = disk->private_data;
+
+	mutex_lock(&cbd_blkdev->lock);
+	cbd_blkdev->open_count--;
+	mutex_unlock(&cbd_blkdev->lock);
+}
+
+static const struct block_device_operations cbd_bd_ops = {
+	.owner			= THIS_MODULE,
+	.open			= cbd_open,
+	.release		= cbd_release,
+};
+
+static void cbd_blkdev_stop_queues(struct cbd_blkdev *cbd_blkdev)
+{
+	int i;
+
+	for (i = 0; i < cbd_blkdev->num_queues; i++)
+		cbd_queue_stop(&cbd_blkdev->queues[i]);
+}
+
+static void cbd_blkdev_destroy_queues(struct cbd_blkdev *cbd_blkdev)
+{
+	cbd_blkdev_stop_queues(cbd_blkdev);
+	kfree(cbd_blkdev->queues);
+}
+
+static int cbd_blkdev_create_queues(struct cbd_blkdev *cbd_blkdev)
+{
+	int i;
+	int ret;
+	struct cbd_queue *cbdq;
+
+	cbd_blkdev->queues = kcalloc(cbd_blkdev->num_queues, sizeof(struct cbd_queue), GFP_KERNEL);
+	if (!cbd_blkdev->queues)
+		return -ENOMEM;
+
+	for (i = 0; i < cbd_blkdev->num_queues; i++) {
+		cbdq = &cbd_blkdev->queues[i];
+		cbdq->cbd_blkdev = cbd_blkdev;
+		cbdq->index = i;
+		ret = cbd_queue_start(cbdq);
+		if (ret)
+			goto err;
+
+	}
+
+	return 0;
+err:
+	cbd_blkdev_destroy_queues(cbd_blkdev);
+	return ret;
+}
+
+static int disk_start(struct cbd_blkdev *cbd_blkdev)
+{
+	int ret;
+	struct gendisk *disk;
+
+	memset(&cbd_blkdev->tag_set, 0, sizeof(cbd_blkdev->tag_set));
+	cbd_blkdev->tag_set.ops = &cbd_mq_ops;
+	cbd_blkdev->tag_set.queue_depth = 128;
+	cbd_blkdev->tag_set.numa_node = NUMA_NO_NODE;
+	cbd_blkdev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED;
+	cbd_blkdev->tag_set.nr_hw_queues = cbd_blkdev->num_queues;
+	cbd_blkdev->tag_set.cmd_size = sizeof(struct cbd_request);
+	cbd_blkdev->tag_set.timeout = 0;
+	cbd_blkdev->tag_set.driver_data = cbd_blkdev;
+
+	ret = blk_mq_alloc_tag_set(&cbd_blkdev->tag_set);
+	if (ret) {
+		cbd_blk_err(cbd_blkdev, "failed to alloc tag set %d", ret);
+		goto err;
+	}
+
+	disk = blk_mq_alloc_disk(&cbd_blkdev->tag_set, NULL, cbd_blkdev);
+	if (IS_ERR(disk)) {
+		ret = PTR_ERR(disk);
+		cbd_blk_err(cbd_blkdev, "failed to alloc disk");
+		goto out_tag_set;
+	}
+
+	snprintf(disk->disk_name, sizeof(disk->disk_name), "cbd%d",
+		 cbd_blkdev->mapped_id);
+
+	disk->major = cbd_major;
+	disk->first_minor = cbd_blkdev->mapped_id << CBD_PART_SHIFT;
+	disk->minors = (1 << CBD_PART_SHIFT);
+
+	disk->fops = &cbd_bd_ops;
+	disk->private_data = cbd_blkdev;
+
+	/* Tell the block layer that this is not a rotational device */
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, disk->queue);
+
+	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
+	blk_queue_max_hw_sectors(disk->queue, 128);
+	blk_queue_max_segments(disk->queue, USHRT_MAX);
+	blk_queue_max_segment_size(disk->queue, UINT_MAX);
+	blk_queue_io_min(disk->queue, 4096);
+	blk_queue_io_opt(disk->queue, 4096);
+
+	disk->queue->limits.max_sectors = queue_max_hw_sectors(disk->queue);
+	/* TODO support discard */
+	disk->queue->limits.discard_granularity = 0;
+	blk_queue_max_discard_sectors(disk->queue, 0);
+	blk_queue_max_write_zeroes_sectors(disk->queue, 0);
+
+	cbd_blkdev->disk = disk;
+
+	cbdt_add_blkdev(cbd_blkdev->cbdt, cbd_blkdev);
+	cbd_blkdev->blkdev_info->mapped_id = cbd_blkdev->blkdev_id;
+	cbd_blkdev->blkdev_info->state = cbd_blkdev_state_running;
+
+	set_capacity(cbd_blkdev->disk, cbd_blkdev->dev_size);
+
+	set_disk_ro(cbd_blkdev->disk, false);
+	blk_queue_write_cache(cbd_blkdev->disk->queue, false, false);
+
+	ret = add_disk(cbd_blkdev->disk);
+	if (ret)
+		goto put_disk;
+
+	ret = sysfs_create_link(&disk_to_dev(cbd_blkdev->disk)->kobj,
+				&cbd_blkdev->blkdev_dev->dev.kobj, "cbd_blkdev");
+	if (ret)
+		goto del_disk;
+
+	return 0;
+
+del_disk:
+	del_gendisk(cbd_blkdev->disk);
+put_disk:
+	put_disk(cbd_blkdev->disk);
+out_tag_set:
+	blk_mq_free_tag_set(&cbd_blkdev->tag_set);
+err:
+	return ret;
+}
+
+int cbd_blkdev_start(struct cbd_transport *cbdt, u32 backend_id, u32 queues)
+{
+	struct cbd_blkdev *cbd_blkdev;
+	struct cbd_backend_info *backend_info;
+	u64 dev_size;
+	int ret;
+
+	backend_info = cbdt_get_backend_info(cbdt, backend_id);
+	if (backend_info->blkdev_count == CBDB_BLKDEV_COUNT_MAX)
+		return -EBUSY;
+
+	if (!cbd_backend_info_is_alive(backend_info)) {
+		cbdt_err(cbdt, "backend %u is not alive\n", backend_id);
+		return -EINVAL;
+	}
+
+	dev_size = backend_info->dev_size;
+
+	cbd_blkdev = kzalloc(sizeof(struct cbd_blkdev), GFP_KERNEL);
+	if (!cbd_blkdev)
+		return -ENOMEM;
+
+	mutex_init(&cbd_blkdev->lock);
+	atomic_set(&cbd_blkdev->state, cbd_blkdev_state_none);
+
+	ret = cbdt_get_empty_blkdev_id(cbdt, &cbd_blkdev->blkdev_id);
+	if (ret < 0)
+		goto blkdev_free;
+
+	cbd_blkdev->mapped_id = ida_simple_get(&cbd_mapped_id_ida, 0,
+					 minor_to_cbd_mapped_id(1 << MINORBITS),
+					 GFP_KERNEL);
+	if (cbd_blkdev->mapped_id < 0) {
+		ret = -ENOENT;
+		goto blkdev_free;
+	}
+
+	cbd_blkdev->task_wq = alloc_workqueue("cbdt%d-d%u",  WQ_UNBOUND | WQ_MEM_RECLAIM,
+					0, cbdt->id, cbd_blkdev->mapped_id);
+	if (!cbd_blkdev->task_wq) {
+		ret = -ENOMEM;
+		goto ida_remove;
+	}
+
+	INIT_LIST_HEAD(&cbd_blkdev->node);
+	cbd_blkdev->cbdt = cbdt;
+	cbd_blkdev->backend_id = backend_id;
+	cbd_blkdev->num_queues = queues;
+	cbd_blkdev->dev_size = dev_size;
+	cbd_blkdev->blkdev_info = cbdt_get_blkdev_info(cbdt, cbd_blkdev->blkdev_id);
+	cbd_blkdev->blkdev_dev = &cbdt->cbd_blkdevs_dev->blkdev_devs[cbd_blkdev->blkdev_id];
+
+	cbd_blkdev->blkdev_info->backend_id = backend_id;
+	cbd_blkdev->blkdev_info->host_id = cbdt->host->host_id;
+	cbd_blkdev->blkdev_info->state = cbd_blkdev_state_running;
+
+	ret = cbd_blkdev_create_queues(cbd_blkdev);
+	if (ret < 0)
+		goto destroy_wq;
+
+	INIT_DELAYED_WORK(&cbd_blkdev->hb_work, blkdev_hb_workfn);
+	queue_delayed_work(cbd_wq, &cbd_blkdev->hb_work, 0);
+
+	ret = disk_start(cbd_blkdev);
+	if (ret < 0)
+		goto destroy_queues;
+
+	backend_info->blkdev_count++;
+
+	atomic_set(&cbd_blkdev->state, cbd_blkdev_state_running);
+
+	return 0;
+
+destroy_queues:
+	cbd_blkdev_destroy_queues(cbd_blkdev);
+destroy_wq:
+	cancel_delayed_work_sync(&cbd_blkdev->hb_work);
+	cbd_blkdev->blkdev_info->state = cbd_blkdev_state_none;
+	destroy_workqueue(cbd_blkdev->task_wq);
+ida_remove:
+	ida_simple_remove(&cbd_mapped_id_ida, cbd_blkdev->mapped_id);
+blkdev_free:
+	kfree(cbd_blkdev);
+	return ret;
+}
+
+static void disk_stop(struct cbd_blkdev *cbd_blkdev)
+{
+	sysfs_remove_link(&disk_to_dev(cbd_blkdev->disk)->kobj, "cbd_blkdev");
+	del_gendisk(cbd_blkdev->disk);
+	put_disk(cbd_blkdev->disk);
+	blk_mq_free_tag_set(&cbd_blkdev->tag_set);
+}
+
+int cbd_blkdev_stop(struct cbd_transport *cbdt, u32 devid, bool force)
+{
+	struct cbd_blkdev *cbd_blkdev;
+	struct cbd_backend_info *backend_info;
+
+	cbd_blkdev = cbdt_get_blkdev(cbdt, devid);
+	if (!cbd_blkdev)
+		return -EINVAL;
+
+	mutex_lock(&cbd_blkdev->lock);
+	if (cbd_blkdev->open_count > 0 && !force) {
+		mutex_unlock(&cbd_blkdev->lock);
+		return -EBUSY;
+	}
+
+	cbdt_del_blkdev(cbdt, cbd_blkdev);
+	atomic_set(&cbd_blkdev->state, cbd_blkdev_state_removing);
+	mutex_unlock(&cbd_blkdev->lock);
+
+	cbd_blkdev_stop_queues(cbd_blkdev);
+	disk_stop(cbd_blkdev);
+	kfree(cbd_blkdev->queues);
+
+	cancel_delayed_work_sync(&cbd_blkdev->hb_work);
+	cbd_blkdev->blkdev_info->state = cbd_blkdev_state_none;
+
+	drain_workqueue(cbd_blkdev->task_wq);
+	destroy_workqueue(cbd_blkdev->task_wq);
+	ida_simple_remove(&cbd_mapped_id_ida, cbd_blkdev->mapped_id);
+	backend_info = cbdt_get_backend_info(cbdt, cbd_blkdev->backend_id);
+
+	kfree(cbd_blkdev);
+
+	backend_info->blkdev_count--;
+
+	return 0;
+}
+
+int cbd_blkdev_clear(struct cbd_transport *cbdt, u32 devid)
+{
+	struct cbd_blkdev_info *blkdev_info;
+
+	blkdev_info = cbdt_get_blkdev_info(cbdt, devid);
+	if (cbd_blkdev_info_is_alive(blkdev_info)) {
+		cbdt_err(cbdt, "blkdev %u is still alive\n", devid);
+		return -EBUSY;
+	}
+
+	if (blkdev_info->state == cbd_blkdev_state_none)
+		return 0;
+
+	blkdev_info->state = cbd_blkdev_state_none;
+
+	return 0;
+}
+
+int cbd_blkdev_init(void)
+{
+	cbd_major = register_blkdev(0, "cbd");
+	if (cbd_major < 0)
+		return cbd_major;
+
+	return 0;
+}
+
+void cbd_blkdev_exit(void)
+{
+	unregister_blkdev(cbd_major, "cbd");
+}
diff --git a/drivers/block/cbd/cbd_queue.c b/drivers/block/cbd/cbd_queue.c
new file mode 100644
index 000000000000..69a92738a4f6
--- /dev/null
+++ b/drivers/block/cbd/cbd_queue.c
@@ -0,0 +1,526 @@
+#include "cbd_internal.h"
+
+static inline struct cbd_se *get_submit_entry(struct cbd_queue *cbdq)
+{
+	return (struct cbd_se *)(cbdq->channel.submr + cbdq->channel_info->submr_head);
+}
+
+static inline struct cbd_se *get_oldest_se(struct cbd_queue *cbdq)
+{
+	if (cbdq->channel_info->submr_tail == cbdq->channel_info->submr_head)
+		return NULL;
+
+	return (struct cbd_se *)(cbdq->channel.submr + cbdq->channel_info->submr_tail);
+}
+
+static inline struct cbd_ce *get_complete_entry(struct cbd_queue *cbdq)
+{
+	if (cbdq->channel_info->compr_tail == cbdq->channel_info->compr_head)
+		return NULL;
+
+	return (struct cbd_ce *)(cbdq->channel.compr + cbdq->channel_info->compr_tail);
+}
+
+static void cbd_req_init(struct cbd_queue *cbdq, enum cbd_op op, struct request *rq)
+{
+	struct cbd_request *cbd_req = blk_mq_rq_to_pdu(rq);
+
+	cbd_req->req = rq;
+	cbd_req->cbdq = cbdq;
+	cbd_req->op = op;
+}
+
+static bool cbd_req_nodata(struct cbd_request *cbd_req)
+{
+	switch (cbd_req->op) {
+	case CBD_OP_WRITE:
+	case CBD_OP_READ:
+		return false;
+	case CBD_OP_DISCARD:
+	case CBD_OP_WRITE_ZEROS:
+	case CBD_OP_FLUSH:
+		return true;
+	default:
+		BUG();
+	}
+}
+
+static void queue_req_se_init(struct cbd_request *cbd_req)
+{
+	struct cbd_se	*se;
+	u64 offset = (u64)blk_rq_pos(cbd_req->req) << SECTOR_SHIFT;
+	u64 length = blk_rq_bytes(cbd_req->req);
+
+	se = get_submit_entry(cbd_req->cbdq);
+	memset(se, 0, sizeof(struct cbd_se));
+	se->op = cbd_req->op;
+
+	se->req_tid = cbd_req->req_tid;
+	se->offset = offset;
+	se->len = length;
+
+	if (req_op(cbd_req->req) == REQ_OP_READ || req_op(cbd_req->req) == REQ_OP_WRITE) {
+		se->data_off = cbd_req->cbdq->channel.data_head;
+		se->data_len = length;
+	}
+
+	cbd_req->se = se;
+}
+
+static bool data_space_enough(struct cbd_queue *cbdq, struct cbd_request *cbd_req)
+{
+	struct cbd_channel *channel = &cbdq->channel;
+	u64 space_available = channel->data_size;
+	u32 space_needed;
+
+	if (channel->data_head > channel->data_tail) {
+		space_available = channel->data_size - channel->data_head;
+		space_available += channel->data_tail;
+	} else if (channel->data_head < channel->data_tail) {
+		space_available = channel->data_tail - channel->data_head;
+	}
+
+	space_needed = round_up(cbd_req->data_len, CBDC_DATA_ALIGH);
+
+	if (space_available - CBDC_DATA_RESERVED < space_needed) {
+		cbd_queue_err(cbdq, "data space is not enough: availaible: %llu needed: %u",
+			      space_available, space_needed);
+		return false;
+	}
+
+	return true;
+}
+
+static bool submit_ring_full(struct cbd_queue *cbdq)
+{
+	u64 space_available = cbdq->channel_info->submr_size;
+	struct cbd_channel_info *info = cbdq->channel_info;
+
+	if (info->submr_head > info->submr_tail) {
+		space_available = info->submr_size - info->submr_head;
+		space_available += info->submr_tail;
+	} else if (info->submr_head < info->submr_tail) {
+		space_available = info->submr_tail - info->submr_head;
+	}
+
+	/* There is a SUBMR_RESERVED we dont use to prevent the ring to be used up */
+	if (space_available - CBDC_SUBMR_RESERVED < sizeof(struct cbd_se))
+		return true;
+
+	return false;
+}
+
+static void queue_req_data_init(struct cbd_request *cbd_req)
+{
+	struct cbd_queue *cbdq = cbd_req->cbdq;
+	struct bio *bio = cbd_req->req->bio;
+
+	if (cbd_req->op == CBD_OP_READ)
+		goto advance_data_head;
+
+	cbdc_copy_from_bio(&cbdq->channel, cbd_req->data_off, cbd_req->data_len, bio);
+
+advance_data_head:
+	cbdq->channel.data_head = round_up(cbdq->channel.data_head + cbd_req->data_len, PAGE_SIZE);
+	cbdq->channel.data_head %= cbdq->channel.data_size;
+}
+
+#ifdef CONFIG_CBD_CRC
+static void cbd_req_crc_init(struct cbd_request *cbd_req)
+{
+	struct cbd_queue *cbdq = cbd_req->cbdq;
+	struct cbd_se *se = cbd_req->se;
+
+	if (cbd_req->op == CBD_OP_WRITE)
+		se->data_crc = cbd_channel_crc(&cbdq->channel,
+					       cbd_req->data_off,
+					       cbd_req->data_len);
+
+	se->se_crc = cbd_se_crc(se);
+}
+#endif
+
+static void complete_inflight_req(struct cbd_queue *cbdq, struct cbd_request *cbd_req, int ret);
+static void cbd_queue_workfn(struct work_struct *work)
+{
+	struct cbd_request *cbd_req =
+		container_of(work, struct cbd_request, work);
+	struct cbd_queue *cbdq = cbd_req->cbdq;
+	int ret = 0;
+	size_t command_size;
+
+	spin_lock(&cbdq->inflight_reqs_lock);
+	if (atomic_read(&cbdq->state) == cbd_queue_state_removing) {
+		spin_unlock(&cbdq->inflight_reqs_lock);
+		ret = -EIO;
+		goto end_request;
+	}
+	list_add_tail(&cbd_req->inflight_reqs_node, &cbdq->inflight_reqs);
+	spin_unlock(&cbdq->inflight_reqs_lock);
+
+	command_size = sizeof(struct cbd_se);
+
+	spin_lock(&cbdq->channel.submr_lock);
+	if (req_op(cbd_req->req) == REQ_OP_WRITE || req_op(cbd_req->req) == REQ_OP_READ) {
+		cbd_req->data_off = cbdq->channel.data_head;
+		cbd_req->data_len = blk_rq_bytes(cbd_req->req);
+	} else {
+		cbd_req->data_off = -1;
+		cbd_req->data_len = 0;
+	}
+
+	if (submit_ring_full(cbdq) ||
+			!data_space_enough(cbdq, cbd_req)) {
+		spin_unlock(&cbdq->channel.submr_lock);
+
+		/* remove request from inflight_reqs */
+		spin_lock(&cbdq->inflight_reqs_lock);
+		list_del_init(&cbd_req->inflight_reqs_node);
+		spin_unlock(&cbdq->inflight_reqs_lock);
+
+		cbd_blk_debug(cbdq->cbd_blkdev, "transport space is not enough");
+		ret = -ENOMEM;
+		goto end_request;
+	}
+
+	cbd_req->req_tid = ++cbdq->req_tid;
+	queue_req_se_init(cbd_req);
+
+	if (!cbd_req_nodata(cbd_req))
+		queue_req_data_init(cbd_req);
+
+#ifdef CONFIG_CBD_CRC
+	cbd_req_crc_init(cbd_req);
+#endif
+	queue_delayed_work(cbdq->cbd_blkdev->task_wq, &cbdq->complete_work, 0);
+
+	CBDC_UPDATE_SUBMR_HEAD(cbdq->channel_info->submr_head,
+			sizeof(struct cbd_se),
+			cbdq->channel_info->submr_size);
+	spin_unlock(&cbdq->channel.submr_lock);
+
+	return;
+
+end_request:
+	if (ret == -ENOMEM || ret == -EBUSY)
+		blk_mq_requeue_request(cbd_req->req, true);
+	else
+		blk_mq_end_request(cbd_req->req, errno_to_blk_status(ret));
+}
+
+static void advance_subm_ring(struct cbd_queue *cbdq)
+{
+	struct cbd_se *se;
+again:
+	se = get_oldest_se(cbdq);
+	if (!se)
+		goto out;
+
+	if (cbd_se_flags_test(se, CBD_SE_FLAGS_DONE)) {
+		CBDC_UPDATE_SUBMR_TAIL(cbdq->channel_info->submr_tail,
+				sizeof(struct cbd_se),
+				cbdq->channel_info->submr_size);
+		goto again;
+	}
+out:
+	return;
+}
+
+static bool __advance_data_tail(struct cbd_queue *cbdq, u64 data_off, u32 data_len)
+{
+	if (data_off == cbdq->channel.data_tail) {
+		cbdq->released_extents[data_off / PAGE_SIZE] = 0;
+		cbdq->channel.data_tail += data_len;
+		if (cbdq->channel.data_tail >= cbdq->channel.data_size)
+			cbdq->channel.data_tail %= cbdq->channel.data_size;
+		return true;
+	}
+
+	return false;
+}
+
+static void advance_data_tail(struct cbd_queue *cbdq, u64 data_off, u32 data_len)
+{
+	cbdq->released_extents[data_off / PAGE_SIZE] = data_len;
+
+	while (__advance_data_tail(cbdq, data_off, data_len)) {
+		data_off += data_len;
+		data_len = cbdq->released_extents[data_off / PAGE_SIZE];
+		if (!data_len)
+			break;
+	}
+}
+
+static inline void complete_inflight_req(struct cbd_queue *cbdq, struct cbd_request *cbd_req, int ret)
+{
+	u64 data_off;
+	u32 data_len;
+	bool advance_data = false;
+
+	spin_lock(&cbdq->inflight_reqs_lock);
+	list_del_init(&cbd_req->inflight_reqs_node);
+	spin_unlock(&cbdq->inflight_reqs_lock);
+
+	cbd_se_flags_set(cbd_req->se, CBD_SE_FLAGS_DONE);
+	data_off = cbd_req->data_off;
+	data_len = cbd_req->data_len;
+	advance_data = (!cbd_req_nodata(cbd_req));
+
+	blk_mq_end_request(cbd_req->req, errno_to_blk_status(ret));
+
+	spin_lock(&cbdq->channel.submr_lock);
+	advance_subm_ring(cbdq);
+	if (advance_data)
+		advance_data_tail(cbdq, data_off, round_up(data_len, PAGE_SIZE));
+	spin_unlock(&cbdq->channel.submr_lock);
+}
+
+static struct cbd_request *find_inflight_req(struct cbd_queue *cbdq, u64 req_tid)
+{
+	struct cbd_request *req;
+	bool found = false;
+
+	list_for_each_entry(req, &cbdq->inflight_reqs, inflight_reqs_node) {
+		if (req->req_tid == req_tid) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found)
+		return req;
+
+	return NULL;
+}
+
+static void copy_data_from_cbdteq(struct cbd_request *cbd_req)
+{
+	struct bio *bio = cbd_req->req->bio;
+	struct cbd_queue *cbdq = cbd_req->cbdq;
+
+	cbdc_copy_to_bio(&cbdq->channel, cbd_req->data_off, cbd_req->data_len, bio);
+}
+
+static void complete_work_fn(struct work_struct *work)
+{
+	struct cbd_queue *cbdq = container_of(work, struct cbd_queue, complete_work.work);
+	struct cbd_ce *ce;
+	struct cbd_request *cbd_req;
+
+	if (atomic_read(&cbdq->state) == cbd_queue_state_removing)
+		return;
+
+again:
+	/* compr_head would be updated by backend handler */
+	spin_lock(&cbdq->channel.compr_lock);
+	ce = get_complete_entry(cbdq);
+	spin_unlock(&cbdq->channel.compr_lock);
+	if (!ce)
+		goto miss;
+
+	spin_lock(&cbdq->inflight_reqs_lock);
+	cbd_req = find_inflight_req(cbdq, ce->req_tid);
+	spin_unlock(&cbdq->inflight_reqs_lock);
+	if (!cbd_req) {
+		cbd_queue_err(cbdq, "inflight request not found: %llu.", ce->req_tid);
+		goto miss;
+	}
+
+#ifdef CONFIG_CBD_CRC
+	if (ce->ce_crc != cbd_ce_crc(ce)) {
+		cbd_queue_err(cbdq, "ce crc bad 0x%x != 0x%x(expected)",
+				cbd_ce_crc(ce), ce->ce_crc);
+		goto miss;
+	}
+
+	if (cbd_req->op == CBD_OP_READ &&
+		ce->data_crc != cbd_channel_crc(&cbdq->channel,
+					       cbd_req->data_off,
+					       cbd_req->data_len)) {
+		cbd_queue_err(cbdq, "ce data_crc bad 0x%x != 0x%x(expected)",
+				cbd_channel_crc(&cbdq->channel,
+						cbd_req->data_off,
+						cbd_req->data_len),
+				ce->data_crc);
+		goto miss;
+	}
+#endif
+
+	cbdwc_hit(&cbdq->complete_worker_cfg);
+	CBDC_UPDATE_COMPR_TAIL(cbdq->channel_info->compr_tail,
+			       sizeof(struct cbd_ce),
+			       cbdq->channel_info->compr_size);
+
+	if (req_op(cbd_req->req) == REQ_OP_READ) {
+		spin_lock(&cbdq->channel.submr_lock);
+		copy_data_from_cbdteq(cbd_req);
+		spin_unlock(&cbdq->channel.submr_lock);
+	}
+
+	complete_inflight_req(cbdq, cbd_req, ce->result);
+
+	goto again;
+
+miss:
+	if (cbdwc_need_retry(&cbdq->complete_worker_cfg))
+		goto again;
+
+	spin_lock(&cbdq->inflight_reqs_lock);
+	if (list_empty(&cbdq->inflight_reqs)) {
+		spin_unlock(&cbdq->inflight_reqs_lock);
+		cbdwc_init(&cbdq->complete_worker_cfg);
+		return;
+	}
+	spin_unlock(&cbdq->inflight_reqs_lock);
+
+	cbdwc_miss(&cbdq->complete_worker_cfg);
+
+	queue_delayed_work(cbdq->cbd_blkdev->task_wq, &cbdq->complete_work, 0);
+}
+
+static blk_status_t cbd_queue_rq(struct blk_mq_hw_ctx *hctx,
+		const struct blk_mq_queue_data *bd)
+{
+	struct request *req = bd->rq;
+	struct cbd_queue *cbdq = hctx->driver_data;
+	struct cbd_request *cbd_req = blk_mq_rq_to_pdu(bd->rq);
+
+	memset(cbd_req, 0, sizeof(struct cbd_request));
+	INIT_LIST_HEAD(&cbd_req->inflight_reqs_node);
+
+	blk_mq_start_request(bd->rq);
+
+	switch (req_op(bd->rq)) {
+	case REQ_OP_FLUSH:
+		cbd_req_init(cbdq, CBD_OP_FLUSH, req);
+		break;
+	case REQ_OP_DISCARD:
+		cbd_req_init(cbdq, CBD_OP_DISCARD, req);
+		break;
+	case REQ_OP_WRITE_ZEROES:
+		cbd_req_init(cbdq, CBD_OP_WRITE_ZEROS, req);
+		break;
+	case REQ_OP_WRITE:
+		cbd_req_init(cbdq, CBD_OP_WRITE, req);
+		break;
+	case REQ_OP_READ:
+		cbd_req_init(cbdq, CBD_OP_READ, req);
+		break;
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	INIT_WORK(&cbd_req->work, cbd_queue_workfn);
+	queue_work(cbdq->cbd_blkdev->task_wq, &cbd_req->work);
+
+	return BLK_STS_OK;
+}
+
+static int cbd_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
+			unsigned int hctx_idx)
+{
+	struct cbd_blkdev *cbd_blkdev = driver_data;
+	struct cbd_queue *cbdq;
+
+	cbdq = &cbd_blkdev->queues[hctx_idx];
+	hctx->driver_data = cbdq;
+
+	return 0;
+}
+
+const struct blk_mq_ops cbd_mq_ops = {
+	.queue_rq	= cbd_queue_rq,
+	.init_hctx	= cbd_init_hctx,
+};
+
+static int cbd_queue_channel_init(struct cbd_queue *cbdq, u32 channel_id)
+{
+	struct cbd_blkdev *cbd_blkdev = cbdq->cbd_blkdev;
+	struct cbd_transport *cbdt = cbd_blkdev->cbdt;
+
+	cbd_channel_init(&cbdq->channel, cbdt, channel_id);
+	cbdq->channel_info = cbdq->channel.channel_info;
+
+	cbdq->channel.data_head = cbdq->channel.data_tail = 0;
+	cbdq->channel_info->submr_tail = cbdq->channel_info->submr_head = 0;
+	cbdq->channel_info->compr_tail = cbdq->channel_info->compr_head = 0;
+
+	/* Initialise the channel_info of the ring buffer */
+	cbdq->channel_info->submr_off = CBDC_SUBMR_OFF;
+	cbdq->channel_info->submr_size = rounddown(CBDC_SUBMR_SIZE, sizeof(struct cbd_se));
+	cbdq->channel_info->compr_off = CBDC_COMPR_OFF;
+	cbdq->channel_info->compr_size = rounddown(CBDC_COMPR_SIZE, sizeof(struct cbd_ce));
+
+	cbdq->channel_info->backend_id = cbd_blkdev->backend_id;
+	cbdq->channel_info->blkdev_id = cbd_blkdev->blkdev_id;
+	cbdq->channel_info->blkdev_state = cbdc_blkdev_state_running;
+
+	return 0;
+}
+
+int cbd_queue_start(struct cbd_queue *cbdq)
+{
+	struct cbd_transport *cbdt = cbdq->cbd_blkdev->cbdt;
+	u32 channel_id;
+	int ret;
+
+	ret = cbd_get_empty_channel_id(cbdt, &channel_id);
+	if (ret < 0) {
+		cbdt_err(cbdt, "failed find available channel_id.\n");
+		goto err;
+	}
+
+	ret = cbd_queue_channel_init(cbdq, channel_id);
+	if (ret) {
+		cbd_queue_err(cbdq, "failed to init dev channel_info: %d.", ret);
+		goto err;
+	}
+
+	INIT_LIST_HEAD(&cbdq->inflight_reqs);
+	spin_lock_init(&cbdq->inflight_reqs_lock);
+	cbdq->req_tid = 0;
+	INIT_DELAYED_WORK(&cbdq->complete_work, complete_work_fn);
+	cbdwc_init(&cbdq->complete_worker_cfg);
+
+	cbdq->released_extents = kzalloc(sizeof(u64) * (CBDC_DATA_SIZE >> PAGE_SHIFT), GFP_KERNEL);
+	if (!cbdq->released_extents) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	queue_delayed_work(cbdq->cbd_blkdev->task_wq, &cbdq->complete_work, 0);
+
+	atomic_set(&cbdq->state, cbd_queue_state_running);
+
+	return 0;
+err:
+	return ret;
+}
+
+void cbd_queue_stop(struct cbd_queue *cbdq)
+{
+	LIST_HEAD(tmp_list);
+	struct cbd_request *cbd_req;
+
+	if (atomic_read(&cbdq->state) != cbd_queue_state_running)
+		return;
+
+	atomic_set(&cbdq->state, cbd_queue_state_removing);
+	cancel_delayed_work_sync(&cbdq->complete_work);
+
+	spin_lock(&cbdq->inflight_reqs_lock);
+	list_splice_init(&cbdq->inflight_reqs, &tmp_list);
+	spin_unlock(&cbdq->inflight_reqs_lock);
+
+	while (!list_empty(&tmp_list)) {
+		cbd_req = list_first_entry(&tmp_list,
+				struct cbd_request, inflight_reqs_node);
+		list_del_init(&cbd_req->inflight_reqs_node);
+		cancel_work_sync(&cbd_req->work);
+		blk_mq_end_request(cbd_req->req, errno_to_blk_status(-EIO));
+	}
+
+	kfree(cbdq->released_extents);
+	cbd_channel_exit(&cbdq->channel);
+	cbdq->channel_info->blkdev_state = cbdc_blkdev_state_none;
+}
-- 
2.34.1

