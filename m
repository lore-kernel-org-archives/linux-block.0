Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3E15B999;
	Tue,  9 Jul 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530270; cv=none; b=MRuPI44NvsXSiqpZ6HEIhDw3UoUy/bNlR6rHRY33i2w87SEWMm7jAWDhPJI3sXvO/64Gc1csaFR2vZ2AAmCJRMX4uZkJgYw3ydOfvDmStEI1pc62HJ+DCDXj4RKE+ojnt7GnukKZ0wHyKOvdogBoVeI9rVrEYCGzmWpnudxTXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530270; c=relaxed/simple;
	bh=MXB9GSup0Po66C8x47QE/E0pNqzsIqspqUtvXFptV3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GjIlgVaZ9jiWJl8fmsGbAku+KVsSbZtV5koUX6NNPExiyqX0Xv8mOW3J0MZ+W2mLw8wS1n/ujuZy0bqo66TIrdopiEmrwPEkg0RKQwzNR51euDkkZKpyrEbh5iPGp2q6gf4Vphwv3gBJRvlsisTySPD4nrrKX68TS287O3fT/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xCzrjzcF; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xCzrjzcF"
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720530266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0FkqXu9BeDc2usX+K3ZVx5UWH0yJAYfqo6PPwB3+6I=;
	b=xCzrjzcF8/q6ycFrCBtNoJ6Ba1FKuJ/f/qWAEZK0w11+vPK2NJGQ3sTRxHmwpTDtY+w/6p
	se1SBB/mkyLGbgajAAU+csafUdp4Rw0oSAqL2XQWKh0jfndCBwcBFSssv/9xGxkRUyjFjJ
	vBPF/tpdMKbhy4iTNMD0vm3pmveMcqY=
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
Subject: [PATCH v1 6/7] cbd: introduce cbd_backend
Date: Tue,  9 Jul 2024 13:03:42 +0000
Message-Id: <20240709130343.858363-7-dongsheng.yang@linux.dev>
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

The "cbd_backend" is responsible for exposing a local block device (such
as "/dev/sda") through the "cbd_transport" to other hosts.

Any host that registers this transport can map this backend to a local
"cbd device"(such as "/dev/cbd0"). All reads and writes to "cbd0" are
transmitted through the channel inside the transport to the backend. The handler
inside the backend is responsible for processing these read and write
requests, converting them into read and write requests corresponding to
"sda".

Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
---
 drivers/block/cbd/cbd_backend.c | 296 ++++++++++++++++++++++++++++++++
 drivers/block/cbd/cbd_handler.c | 263 ++++++++++++++++++++++++++++
 2 files changed, 559 insertions(+)
 create mode 100644 drivers/block/cbd/cbd_backend.c
 create mode 100644 drivers/block/cbd/cbd_handler.c

diff --git a/drivers/block/cbd/cbd_backend.c b/drivers/block/cbd/cbd_backend.c
new file mode 100644
index 000000000000..42c60b1881a8
--- /dev/null
+++ b/drivers/block/cbd/cbd_backend.c
@@ -0,0 +1,296 @@
+#include "cbd_internal.h"
+
+static ssize_t backend_host_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_backend_device *backend;
+	struct cbd_backend_info *backend_info;
+
+	backend = container_of(dev, struct cbd_backend_device, dev);
+	backend_info = backend->backend_info;
+
+	if (backend_info->state == cbd_backend_state_none)
+		return 0;
+
+	return sprintf(buf, "%u\n", backend_info->host_id);
+}
+
+static DEVICE_ATTR(host_id, 0400, backend_host_id_show, NULL);
+
+static ssize_t backend_path_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_backend_device *backend;
+	struct cbd_backend_info *backend_info;
+
+	backend = container_of(dev, struct cbd_backend_device, dev);
+	backend_info = backend->backend_info;
+
+	if (backend_info->state == cbd_backend_state_none)
+		return 0;
+
+	return sprintf(buf, "%s\n", backend_info->path);
+}
+
+static DEVICE_ATTR(path, 0400, backend_path_show, NULL);
+
+CBD_OBJ_HEARTBEAT(backend);
+
+static struct attribute *cbd_backend_attrs[] = {
+	&dev_attr_path.attr,
+	&dev_attr_host_id.attr,
+	&dev_attr_alive.attr,
+	NULL
+};
+
+static struct attribute_group cbd_backend_attr_group = {
+	.attrs = cbd_backend_attrs,
+};
+
+static const struct attribute_group *cbd_backend_attr_groups[] = {
+	&cbd_backend_attr_group,
+	NULL
+};
+
+static void cbd_backend_release(struct device *dev)
+{
+}
+
+const struct device_type cbd_backend_type = {
+	.name		= "cbd_backend",
+	.groups		= cbd_backend_attr_groups,
+	.release	= cbd_backend_release,
+};
+
+const struct device_type cbd_backends_type = {
+	.name		= "cbd_backends",
+	.release	= cbd_backend_release,
+};
+
+void cbdb_add_handler(struct cbd_backend *cbdb, struct cbd_handler *handler)
+{
+	mutex_lock(&cbdb->lock);
+	list_add(&handler->handlers_node, &cbdb->handlers);
+	mutex_unlock(&cbdb->lock);
+}
+
+void cbdb_del_handler(struct cbd_backend *cbdb, struct cbd_handler *handler)
+{
+	mutex_lock(&cbdb->lock);
+	list_del_init(&handler->handlers_node);
+	mutex_unlock(&cbdb->lock);
+}
+
+static struct cbd_handler *cbdb_get_handler(struct cbd_backend *cbdb, u32 seg_id)
+{
+	struct cbd_handler *handler, *handler_next;
+	bool found = false;
+
+	mutex_lock(&cbdb->lock);
+	list_for_each_entry_safe(handler, handler_next,
+				 &cbdb->handlers, handlers_node) {
+		if (handler->channel.seg_id == seg_id) {
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&cbdb->lock);
+
+	if (found)
+		return handler;
+
+	return NULL;
+}
+
+static void state_work_fn(struct work_struct *work)
+{
+	struct cbd_backend *cbdb = container_of(work, struct cbd_backend, state_work.work);
+	struct cbd_transport *cbdt = cbdb->cbdt;
+	struct cbd_segment_info *segment_info;
+	struct cbd_channel_info *channel_info;
+	u32 blkdev_state, backend_state, backend_id;
+	int ret;
+	int i;
+
+	for (i = 0; i < cbdt->transport_info->segment_num; i++) {
+		segment_info = cbdt_get_segment_info(cbdt, i);
+		if (segment_info->type != cbds_type_channel)
+			continue;
+
+		channel_info = (struct cbd_channel_info *)segment_info;
+
+		blkdev_state = channel_info->blkdev_state;
+		backend_state = channel_info->backend_state;
+		backend_id = channel_info->backend_id;
+
+		if (blkdev_state == cbdc_blkdev_state_running &&
+				backend_state == cbdc_backend_state_none &&
+				backend_id == cbdb->backend_id) {
+
+			ret = cbd_handler_create(cbdb, i);
+			if (ret) {
+				cbdb_err(cbdb, "create handler for %u error", i);
+				continue;
+			}
+		}
+
+		if (blkdev_state == cbdc_blkdev_state_none &&
+				backend_state == cbdc_backend_state_running &&
+				backend_id == cbdb->backend_id) {
+			struct cbd_handler *handler;
+
+			handler = cbdb_get_handler(cbdb, i);
+			if (!handler)
+				continue;
+			cbd_handler_destroy(handler);
+		}
+	}
+
+	queue_delayed_work(cbd_wq, &cbdb->state_work, 1 * HZ);
+}
+
+static int cbd_backend_init(struct cbd_backend *cbdb)
+{
+	struct cbd_backend_info *b_info;
+	struct cbd_transport *cbdt = cbdb->cbdt;
+
+	b_info = cbdt_get_backend_info(cbdt, cbdb->backend_id);
+	cbdb->backend_info = b_info;
+
+	b_info->host_id = cbdb->cbdt->host->host_id;
+
+	cbdb->backend_io_cache = KMEM_CACHE(cbd_backend_io, 0);
+	if (!cbdb->backend_io_cache)
+		return -ENOMEM;
+
+	cbdb->task_wq = alloc_workqueue("cbdt%d-b%u",  WQ_UNBOUND | WQ_MEM_RECLAIM,
+					0, cbdt->id, cbdb->backend_id);
+	if (!cbdb->task_wq) {
+		kmem_cache_destroy(cbdb->backend_io_cache);
+		return -ENOMEM;
+	}
+
+	cbdb->bdev_file = bdev_file_open_by_path(cbdb->path,
+			BLK_OPEN_READ | BLK_OPEN_WRITE, cbdb, NULL);
+	if (IS_ERR(cbdb->bdev_file)) {
+		cbdt_err(cbdt, "failed to open bdev: %d", (int)PTR_ERR(cbdb->bdev_file));
+		destroy_workqueue(cbdb->task_wq);
+		kmem_cache_destroy(cbdb->backend_io_cache);
+		return PTR_ERR(cbdb->bdev_file);
+	}
+	cbdb->bdev = file_bdev(cbdb->bdev_file);
+	b_info->dev_size = bdev_nr_sectors(cbdb->bdev);
+
+	INIT_DELAYED_WORK(&cbdb->state_work, state_work_fn);
+	INIT_DELAYED_WORK(&cbdb->hb_work, backend_hb_workfn);
+	INIT_LIST_HEAD(&cbdb->handlers);
+	cbdb->backend_device = &cbdt->cbd_backends_dev->backend_devs[cbdb->backend_id];
+
+	mutex_init(&cbdb->lock);
+
+	queue_delayed_work(cbd_wq, &cbdb->state_work, 0);
+	queue_delayed_work(cbd_wq, &cbdb->hb_work, 0);
+
+	return 0;
+}
+
+int cbd_backend_start(struct cbd_transport *cbdt, char *path, u32 backend_id)
+{
+	struct cbd_backend *backend;
+	struct cbd_backend_info *backend_info;
+	int ret;
+
+	if (backend_id == U32_MAX) {
+		ret = cbdt_get_empty_backend_id(cbdt, &backend_id);
+		if (ret)
+			return ret;
+	}
+
+	backend_info = cbdt_get_backend_info(cbdt, backend_id);
+
+	backend = kzalloc(sizeof(struct cbd_backend), GFP_KERNEL);
+	if (!backend)
+		return -ENOMEM;
+
+	strscpy(backend->path, path, CBD_PATH_LEN);
+	memcpy(backend_info->path, backend->path, CBD_PATH_LEN);
+	INIT_LIST_HEAD(&backend->node);
+	backend->backend_id = backend_id;
+	backend->cbdt = cbdt;
+
+	ret = cbd_backend_init(backend);
+	if (ret)
+		goto backend_free;
+
+	backend_info->state = cbd_backend_state_running;
+
+	cbdt_add_backend(cbdt, backend);
+
+	return 0;
+
+backend_free:
+	kfree(backend);
+
+	return ret;
+}
+
+int cbd_backend_stop(struct cbd_transport *cbdt, u32 backend_id, bool force)
+{
+	struct cbd_backend *cbdb;
+	struct cbd_backend_info *backend_info;
+	struct cbd_handler *handler, *next;
+
+	cbdb = cbdt_get_backend(cbdt, backend_id);
+	if (!cbdb)
+		return -ENOENT;
+
+	mutex_lock(&cbdb->lock);
+	if (!list_empty(&cbdb->handlers) && !force) {
+		mutex_unlock(&cbdb->lock);
+		return -EBUSY;
+	}
+	cbdt_del_backend(cbdt, cbdb);
+
+	cancel_delayed_work_sync(&cbdb->hb_work);
+	cancel_delayed_work_sync(&cbdb->state_work);
+
+	mutex_unlock(&cbdb->lock);
+	list_for_each_entry_safe(handler, next, &cbdb->handlers, handlers_node) {
+		cbd_handler_destroy(handler);
+	}
+	mutex_lock(&cbdb->lock);
+
+	backend_info = cbdt_get_backend_info(cbdt, cbdb->backend_id);
+	backend_info->state = cbd_backend_state_none;
+	mutex_unlock(&cbdb->lock);
+
+	drain_workqueue(cbdb->task_wq);
+	destroy_workqueue(cbdb->task_wq);
+
+	kmem_cache_destroy(cbdb->backend_io_cache);
+
+	fput(cbdb->bdev_file);
+	kfree(cbdb);
+
+	return 0;
+}
+
+int cbd_backend_clear(struct cbd_transport *cbdt, u32 backend_id)
+{
+	struct cbd_backend_info *backend_info;
+
+	backend_info = cbdt_get_backend_info(cbdt, backend_id);
+	if (cbd_backend_info_is_alive(backend_info)) {
+		cbdt_err(cbdt, "backend %u is still alive\n", backend_id);
+		return -EBUSY;
+	}
+
+	if (backend_info->state == cbd_backend_state_none)
+		return 0;
+
+	backend_info->state = cbd_backend_state_none;
+
+	return 0;
+}
diff --git a/drivers/block/cbd/cbd_handler.c b/drivers/block/cbd/cbd_handler.c
new file mode 100644
index 000000000000..fdbfffbb09d5
--- /dev/null
+++ b/drivers/block/cbd/cbd_handler.c
@@ -0,0 +1,263 @@
+#include "cbd_internal.h"
+
+static inline struct cbd_se *get_se_head(struct cbd_handler *handler)
+{
+	return (struct cbd_se *)(handler->channel.submr + handler->channel_info->submr_head);
+}
+
+static inline struct cbd_se *get_se_to_handle(struct cbd_handler *handler)
+{
+	return (struct cbd_se *)(handler->channel.submr + handler->se_to_handle);
+}
+
+static inline struct cbd_ce *get_compr_head(struct cbd_handler *handler)
+{
+	return (struct cbd_ce *)(handler->channel.compr + handler->channel_info->compr_head);
+}
+
+static inline void complete_cmd(struct cbd_handler *handler, struct cbd_se *se, int ret)
+{
+	struct cbd_ce *ce = get_compr_head(handler);
+
+	memset(ce, 0, sizeof(*ce));
+	ce->req_tid = se->req_tid;
+	ce->result = ret;
+#ifdef CONFIG_CBD_CRC
+	if (se->op == CBD_OP_READ)
+		ce->data_crc = cbd_channel_crc(&handler->channel, se->data_off, se->data_len);
+	ce->ce_crc = cbd_ce_crc(ce);
+#endif
+	CBDC_UPDATE_COMPR_HEAD(handler->channel_info->compr_head,
+			       sizeof(struct cbd_ce),
+			       handler->channel_info->compr_size);
+}
+
+static void backend_bio_end(struct bio *bio)
+{
+	struct cbd_backend_io *backend_io = bio->bi_private;
+	struct cbd_se *se = backend_io->se;
+	struct cbd_handler *handler = backend_io->handler;
+	struct cbd_backend *cbdb = handler->cbdb;
+
+	complete_cmd(handler, se, bio->bi_status);
+
+	bio_put(bio);
+	kmem_cache_free(cbdb->backend_io_cache, backend_io);
+}
+
+static int cbd_map_pages(struct cbd_transport *cbdt, struct cbd_handler *handler,
+			 struct cbd_backend_io *io)
+{
+	struct cbd_se *se = io->se;
+	u64 off = se->data_off;
+	u32 size = se->data_len;
+	u32 done = 0;
+	struct page *page;
+	u32 page_off;
+	int ret = 0;
+	int id;
+
+	id = dax_read_lock();
+	while (size) {
+		unsigned int len = min_t(size_t, PAGE_SIZE, size);
+		u64 channel_off = off + done;
+
+		if (channel_off >= CBDC_DATA_SIZE)
+			channel_off %= CBDC_DATA_SIZE;
+		u64 transport_off = (void *)handler->channel.data -
+					(void *)cbdt->transport_info + channel_off;
+
+		page = cbdt_page(cbdt, transport_off, &page_off);
+
+		ret = bio_add_page(io->bio, page, len, 0);
+		if (unlikely(ret != len)) {
+			cbdt_err(cbdt, "failed to add page");
+			goto out;
+		}
+
+		done += len;
+		size -= len;
+	}
+
+	ret = 0;
+out:
+	dax_read_unlock(id);
+	return ret;
+}
+
+static struct cbd_backend_io *backend_prepare_io(struct cbd_handler *handler,
+						 struct cbd_se *se, blk_opf_t opf)
+{
+	struct cbd_backend_io *backend_io;
+	struct cbd_backend *cbdb = handler->cbdb;
+
+	backend_io = kmem_cache_zalloc(cbdb->backend_io_cache, GFP_KERNEL);
+	if (!backend_io)
+		return NULL;
+	backend_io->se = se;
+
+	backend_io->handler = handler;
+	backend_io->bio = bio_alloc_bioset(cbdb->bdev,
+				DIV_ROUND_UP(se->len, PAGE_SIZE),
+				opf, GFP_KERNEL, &handler->bioset);
+
+	backend_io->bio->bi_iter.bi_sector = se->offset >> SECTOR_SHIFT;
+	backend_io->bio->bi_iter.bi_size = 0;
+	backend_io->bio->bi_private = backend_io;
+	backend_io->bio->bi_end_io = backend_bio_end;
+
+	return backend_io;
+}
+
+static int handle_backend_cmd(struct cbd_handler *handler, struct cbd_se *se)
+{
+	struct cbd_backend *cbdb = handler->cbdb;
+	struct cbd_backend_io *backend_io = NULL;
+	int ret;
+
+	if (cbd_se_flags_test(se, CBD_SE_FLAGS_DONE))
+		return 0;
+
+	switch (se->op) {
+	case CBD_OP_READ:
+		backend_io = backend_prepare_io(handler, se, REQ_OP_READ);
+		break;
+	case CBD_OP_WRITE:
+		backend_io = backend_prepare_io(handler, se, REQ_OP_WRITE);
+		break;
+	case CBD_OP_DISCARD:
+		ret = blkdev_issue_discard(cbdb->bdev, se->offset >> SECTOR_SHIFT,
+				se->len, GFP_KERNEL);
+		goto complete_cmd;
+	case CBD_OP_WRITE_ZEROS:
+		ret = blkdev_issue_zeroout(cbdb->bdev, se->offset >> SECTOR_SHIFT,
+				se->len, GFP_KERNEL, 0);
+		goto complete_cmd;
+	case CBD_OP_FLUSH:
+		ret = blkdev_issue_flush(cbdb->bdev);
+		goto complete_cmd;
+	default:
+		cbd_handler_err(handler, "unrecognized op: 0x%x", se->op);
+		ret = -EIO;
+		goto complete_cmd;
+	}
+
+	if (!backend_io)
+		return -ENOMEM;
+
+	ret = cbd_map_pages(cbdb->cbdt, handler, backend_io);
+	if (ret) {
+		kmem_cache_free(cbdb->backend_io_cache, backend_io);
+		return ret;
+	}
+
+	submit_bio(backend_io->bio);
+
+	return 0;
+
+complete_cmd:
+	complete_cmd(handler, se, ret);
+	return 0;
+}
+
+static void handle_work_fn(struct work_struct *work)
+{
+	struct cbd_handler *handler = container_of(work, struct cbd_handler,
+						   handle_work.work);
+	struct cbd_se *se;
+	u64 req_tid;
+	int ret;
+again:
+	/* channel ctrl would be updated by blkdev queue */
+	se = get_se_to_handle(handler);
+	if (se == get_se_head(handler))
+		goto miss;
+
+	req_tid = se->req_tid;
+	if (handler->req_tid_expected != U64_MAX &&
+			req_tid != handler->req_tid_expected) {
+		cbd_handler_err(handler, "req_tid (%llu) is not expected (%llu)",
+				req_tid, handler->req_tid_expected);
+		goto miss;
+	}
+
+#ifdef CONFIG_CBD_CRC
+	if (se->se_crc != cbd_se_crc(se)) {
+		cbd_handler_err(handler, "se crc(0x%x) is not expected(0x%x)",
+				cbd_se_crc(se), se->se_crc);
+		goto miss;
+	}
+
+	if (se->op == CBD_OP_WRITE &&
+		se->data_crc != cbd_channel_crc(&handler->channel,
+						se->data_off,
+						se->data_len)) {
+		cbd_handler_err(handler, "data crc(0x%x) is not expected(0x%x)",
+				cbd_channel_crc(&handler->channel, se->data_off, se->data_len),
+				se->data_crc);
+		goto miss;
+	}
+#endif
+
+	cbdwc_hit(&handler->handle_worker_cfg);
+	ret = handle_backend_cmd(handler, se);
+	if (!ret) {
+		/* this se is handled */
+		handler->req_tid_expected = req_tid + 1;
+		handler->se_to_handle = (handler->se_to_handle + sizeof(struct cbd_se)) %
+							handler->channel_info->submr_size;
+	}
+
+	goto again;
+
+miss:
+	if (cbdwc_need_retry(&handler->handle_worker_cfg))
+		goto again;
+
+	cbdwc_miss(&handler->handle_worker_cfg);
+
+	queue_delayed_work(handler->cbdb->task_wq, &handler->handle_work, 0);
+}
+
+int cbd_handler_create(struct cbd_backend *cbdb, u32 channel_id)
+{
+	struct cbd_transport *cbdt = cbdb->cbdt;
+	struct cbd_handler *handler;
+
+	handler = kzalloc(sizeof(struct cbd_handler), GFP_KERNEL);
+	if (!handler)
+		return -ENOMEM;
+
+	handler->cbdb = cbdb;
+	cbd_channel_init(&handler->channel, cbdt, channel_id);
+	handler->channel_info = handler->channel.channel_info;
+
+	handler->se_to_handle = handler->channel_info->submr_tail;
+	handler->req_tid_expected = U64_MAX;
+
+	INIT_DELAYED_WORK(&handler->handle_work, handle_work_fn);
+	INIT_LIST_HEAD(&handler->handlers_node);
+
+	bioset_init(&handler->bioset, 256, 0, BIOSET_NEED_BVECS);
+	cbdwc_init(&handler->handle_worker_cfg);
+
+	cbdb_add_handler(cbdb, handler);
+	handler->channel_info->backend_state = cbdc_backend_state_running;
+
+	queue_delayed_work(cbdb->task_wq, &handler->handle_work, 0);
+
+	return 0;
+};
+
+void cbd_handler_destroy(struct cbd_handler *handler)
+{
+	cbdb_del_handler(handler->cbdb, handler);
+
+	cancel_delayed_work_sync(&handler->handle_work);
+
+	cbd_channel_exit(&handler->channel);
+	handler->channel_info->backend_state = cbdc_backend_state_none;
+
+	bioset_exit(&handler->bioset);
+	kfree(handler);
+}
-- 
2.34.1

