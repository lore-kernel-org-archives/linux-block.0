Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3640DFA3
	for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705774; cv=none; b=NeFyXNTqBbvFXMWz0CKrgMkqT0W0ws0EKeSAuGUJtBNa/Tig3G9lyktuSgyF5m2Mu8WgMZMJ1anV7Hjb9Eh/IHMoOcOWx1K3v8756dGicCCVkUdafEar7UM8UqKPTnZ4KWIX2zOBJS/Yv4SZM77NG2PQR17fDse9snaAvZZt0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705774; c=relaxed/simple;
	bh=V+Hfw02luJXfA6lg9AUCOzSBe2rAK9f3V3arY6jZ9ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgC62sJRKt2fiRfahU2V2DczFztiZV9X+pMFVMAa/NUBE7El8uup/pYWZU9tRAdv+5qJZ63IGeH7er8OWwPy+Fg2A/zkjoYWMqJQ+rWT4tndbOkGRk0RcZl0L6xs6m+disQMmP8UUyZA3ZxCua5FTvn3yGsjUMo7MUBw0D79TcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVLvvVTI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVLvvVTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774705772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6V4tM/2v/zq2/naoNtkQmJWeGh3aWmFq7q35Q6dl3g=;
	b=fVLvvVTIBo48KH0jgDuzrY66oEmfstZlxTFJs871cNsCdah7l6cWp7BT2uVmnByuJy/cj9
	2wOvYTnREQzDj+KwrHS3poQ0RVtdohn2SfDP4lsjqpfY+fcfrAdmsQIsHUeTZGtxdqNMJj
	U+MFNg629N9UnhVNcQFSrSXW99pysK4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-DP1j1BJWMQOkP4pbnQQU_A-1; Sat,
 28 Mar 2026 09:49:30 -0400
X-MC-Unique: DP1j1BJWMQOkP4pbnQQU_A-1
X-Mimecast-MFC-AGG-ID: DP1j1BJWMQOkP4pbnQQU_A_1774705769
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A95A180034F;
	Sat, 28 Mar 2026 13:49:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.100])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE11C180035F;
	Sat, 28 Mar 2026 13:49:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/8] ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
Date: Sat, 28 Mar 2026 21:48:56 +0800
Message-ID: <20260328134909.3207377-2-ming.lei@redhat.com>
In-Reply-To: <20260328134909.3207377-1-ming.lei@redhat.com>
References: <20260328134909.3207377-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add control commands for registering and unregistering shared memory
buffers for zero-copy I/O:

- UBLK_U_CMD_REG_BUF (0x18): pins pages from userspace, inserts PFN
  ranges into a per-device maple tree for O(log n) lookup during I/O.
  Buffer pointers are tracked in a per-device xarray. Returns the
  assigned buffer index.

- UBLK_U_CMD_UNREG_BUF (0x19): removes PFN entries and unpins pages.

Queue freeze/unfreeze is handled internally so userspace need not
quiesce the device during registration.

Also adds:
- UBLK_IO_F_SHMEM_ZC flag and addr encoding helpers in UAPI header
  (16-bit buffer index supporting up to 65536 buffers)
- Data structures (ublk_buf, ublk_buf_range) and xarray/maple tree
- __ublk_ctrl_reg_buf() helper for PFN insertion with error unwinding
- __ublk_ctrl_unreg_buf() helper for cleanup reuse
- ublk_support_shmem_zc() / ublk_dev_support_shmem_zc() stubs
  (returning false — feature not enabled yet)

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 287 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  68 ++++++++
 2 files changed, 355 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 71c7c56b38ca..3a4b6eb6b5f7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -46,6 +46,8 @@
 #include <linux/kref.h>
 #include <linux/kfifo.h>
 #include <linux/blk-integrity.h>
+#include <linux/maple_tree.h>
+#include <linux/xarray.h>
 #include <uapi/linux/fs.h>
 #include <uapi/linux/ublk_cmd.h>
 
@@ -58,6 +60,8 @@
 #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
 #define UBLK_CMD_QUIESCE_DEV	_IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
 #define UBLK_CMD_TRY_STOP_DEV	_IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
+#define UBLK_CMD_REG_BUF	_IOC_NR(UBLK_U_CMD_REG_BUF)
+#define UBLK_CMD_UNREG_BUF	_IOC_NR(UBLK_U_CMD_UNREG_BUF)
 
 #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
 #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
@@ -289,6 +293,19 @@ struct ublk_queue {
 	struct ublk_io ios[] __counted_by(q_depth);
 };
 
+/* Per-registered shared memory buffer */
+struct ublk_buf {
+	struct page **pages;
+	unsigned long nr_pages;
+};
+
+/* Maple tree value: maps a PFN range to buffer location */
+struct ublk_buf_range {
+	int buf_index;
+	unsigned long base_pfn;
+	unsigned long base_offset;	/* byte offset within buffer */
+};
+
 struct ublk_device {
 	struct gendisk		*ub_disk;
 
@@ -323,6 +340,10 @@ struct ublk_device {
 
 	bool			block_open; /* protected by open_mutex */
 
+	/* shared memory zero copy */
+	struct maple_tree	buf_tree;
+	struct xarray		bufs_xa;
+
 	struct ublk_queue       *queues[];
 };
 
@@ -334,6 +355,7 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
+static void ublk_buf_cleanup(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io);
@@ -398,6 +420,16 @@ static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
 	return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
 }
 
+static inline bool ublk_support_shmem_zc(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
+static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *ub)
+{
+	return false;
+}
+
 static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_AUTO_BUF_REG;
@@ -1460,6 +1492,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 	iod->op_flags = ublk_op | ublk_req_build_flags(req);
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
+
 	iod->addr = io->buf.addr;
 
 	return BLK_STS_OK;
@@ -1665,6 +1698,7 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 {
 	unsigned mapped_bytes = ublk_map_io(ubq, req, io);
 
+
 	/* partially mapped, update io descriptor */
 	if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
 		/*
@@ -4206,6 +4240,7 @@ static void ublk_cdev_rel(struct device *dev)
 {
 	struct ublk_device *ub = container_of(dev, struct ublk_device, cdev_dev);
 
+	ublk_buf_cleanup(ub);
 	blk_mq_free_tag_set(&ub->tag_set);
 	ublk_deinit_queues(ub);
 	ublk_free_dev_number(ub);
@@ -4625,6 +4660,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
 	mutex_init(&ub->cancel_mutex);
+	mt_init(&ub->buf_tree);
+	xa_init_flags(&ub->bufs_xa, XA_FLAGS_ALLOC);
 	INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
@@ -5168,6 +5205,248 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 	return err;
 }
 
+/*
+ * Drain inflight I/O and quiesce the queue. Freeze drains all inflight
+ * requests, quiesce_nowait marks the queue so no new requests dispatch,
+ * then unfreeze allows new submissions (which won't dispatch due to
+ * quiesce). This keeps freeze and ub->mutex non-nested.
+ */
+static void ublk_quiesce_and_release(struct gendisk *disk)
+{
+	unsigned int memflags;
+
+	memflags = blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue_nowait(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue, memflags);
+}
+
+static void ublk_unquiesce_and_resume(struct gendisk *disk)
+{
+	blk_mq_unquiesce_queue(disk->queue);
+}
+
+/*
+ * Insert PFN ranges of a registered buffer into the maple tree,
+ * coalescing consecutive PFNs into single range entries.
+ * Returns 0 on success, negative error with partial insertions unwound.
+ */
+/* Erase coalesced PFN ranges from the maple tree for pages [0, nr_pages) */
+static void ublk_buf_erase_ranges(struct ublk_device *ub,
+				  struct ublk_buf *ubuf,
+				  unsigned long nr_pages)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; ) {
+		unsigned long pfn = page_to_pfn(ubuf->pages[i]);
+		unsigned long start = i;
+
+		while (i + 1 < nr_pages &&
+		       page_to_pfn(ubuf->pages[i + 1]) == pfn + (i - start) + 1)
+			i++;
+		i++;
+		kfree(mtree_erase(&ub->buf_tree, pfn));
+	}
+}
+
+static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
+			       struct ublk_buf *ubuf, int index)
+{
+	unsigned long nr_pages = ubuf->nr_pages;
+	unsigned long i;
+	int ret;
+
+	for (i = 0; i < nr_pages; ) {
+		unsigned long pfn = page_to_pfn(ubuf->pages[i]);
+		unsigned long start = i;
+		struct ublk_buf_range *range;
+
+		/* Find run of consecutive PFNs */
+		while (i + 1 < nr_pages &&
+		       page_to_pfn(ubuf->pages[i + 1]) == pfn + (i - start) + 1)
+			i++;
+		i++;	/* past the last page in this run */
+
+		range = kzalloc(sizeof(*range), GFP_KERNEL);
+		if (!range) {
+			ret = -ENOMEM;
+			goto unwind;
+		}
+		range->buf_index = index;
+		range->base_pfn = pfn;
+		range->base_offset = start << PAGE_SHIFT;
+
+		ret = mtree_insert_range(&ub->buf_tree, pfn,
+					 pfn + (i - start) - 1,
+					 range, GFP_KERNEL);
+		if (ret) {
+			kfree(range);
+			goto unwind;
+		}
+	}
+	return 0;
+
+unwind:
+	ublk_buf_erase_ranges(ub, ubuf, i);
+	return ret;
+}
+
+/*
+ * Register a shared memory buffer for zero-copy I/O.
+ * Pins pages, builds PFN maple tree, freezes/unfreezes the queue
+ * internally. Returns buffer index (>= 0) on success.
+ */
+static int ublk_ctrl_reg_buf(struct ublk_device *ub,
+			     struct ublksrv_ctrl_cmd *header)
+{
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublk_buf_reg buf_reg;
+	unsigned long addr, size, nr_pages;
+	struct gendisk *disk;
+	struct ublk_buf *ubuf;
+	long pinned;
+	u32 index;
+	int ret;
+
+	if (!ublk_dev_support_shmem_zc(ub))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&buf_reg, argp, sizeof(buf_reg)))
+		return -EFAULT;
+
+	addr = buf_reg.addr;
+	size = buf_reg.len;
+	nr_pages = size >> PAGE_SHIFT;
+
+	if (!size || !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		return -ENODEV;
+
+	/* Pin pages before quiescing (may sleep) */
+	ubuf = kzalloc(sizeof(*ubuf), GFP_KERNEL);
+	if (!ubuf) {
+		ret = -ENOMEM;
+		goto put_disk;
+	}
+
+	ubuf->pages = kvmalloc_array(nr_pages, sizeof(*ubuf->pages),
+				     GFP_KERNEL);
+	if (!ubuf->pages) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	pinned = pin_user_pages_fast(addr, nr_pages,
+				     FOLL_LONGTERM | FOLL_WRITE,
+				     ubuf->pages);
+	if (pinned < 0) {
+		ret = pinned;
+		goto err_free_pages;
+	}
+	if (pinned != nr_pages) {
+		ret = -EFAULT;
+		goto err_unpin;
+	}
+	ubuf->nr_pages = nr_pages;
+
+	/*
+	 * Drain inflight I/O and quiesce the queue so no new requests
+	 * are dispatched while we modify the maple tree. Keep freeze
+	 * and mutex non-nested to avoid lock dependency.
+	 */
+	ublk_quiesce_and_release(disk);
+
+	mutex_lock(&ub->mutex);
+
+	ret = xa_alloc(&ub->bufs_xa, &index, ubuf, xa_limit_16b, GFP_KERNEL);
+	if (ret)
+		goto err_unlock;
+
+	ret = __ublk_ctrl_reg_buf(ub, ubuf, index);
+	if (ret) {
+		xa_erase(&ub->bufs_xa, index);
+		goto err_unlock;
+	}
+
+	mutex_unlock(&ub->mutex);
+
+	ublk_unquiesce_and_resume(disk);
+	ublk_put_disk(disk);
+	return index;
+
+err_unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_unquiesce_and_resume(disk);
+err_unpin:
+	unpin_user_pages(ubuf->pages, pinned);
+err_free_pages:
+	kvfree(ubuf->pages);
+err_free:
+	kfree(ubuf);
+put_disk:
+	ublk_put_disk(disk);
+	return ret;
+}
+
+static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
+				  struct ublk_buf *ubuf)
+{
+	ublk_buf_erase_ranges(ub, ubuf, ubuf->nr_pages);
+	unpin_user_pages(ubuf->pages, ubuf->nr_pages);
+	kvfree(ubuf->pages);
+	kfree(ubuf);
+}
+
+static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
+			       struct ublksrv_ctrl_cmd *header)
+{
+	int index = (int)header->data[0];
+	struct gendisk *disk;
+	struct ublk_buf *ubuf;
+
+	if (!ublk_dev_support_shmem_zc(ub))
+		return -EOPNOTSUPP;
+
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		return -ENODEV;
+
+	/* Drain inflight I/O before modifying the maple tree */
+	ublk_quiesce_and_release(disk);
+
+	mutex_lock(&ub->mutex);
+
+	ubuf = xa_erase(&ub->bufs_xa, index);
+	if (!ubuf) {
+		mutex_unlock(&ub->mutex);
+		ublk_unquiesce_and_resume(disk);
+		ublk_put_disk(disk);
+		return -ENOENT;
+	}
+
+	__ublk_ctrl_unreg_buf(ub, ubuf);
+
+	mutex_unlock(&ub->mutex);
+
+	ublk_unquiesce_and_resume(disk);
+	ublk_put_disk(disk);
+	return 0;
+}
+
+static void ublk_buf_cleanup(struct ublk_device *ub)
+{
+	struct ublk_buf *ubuf;
+	unsigned long index;
+
+	xa_for_each(&ub->bufs_xa, index, ubuf)
+		__ublk_ctrl_unreg_buf(ub, ubuf);
+	xa_destroy(&ub->bufs_xa);
+	mtree_destroy(&ub->buf_tree);
+}
+
 static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		u32 cmd_op, struct ublksrv_ctrl_cmd *header)
 {
@@ -5225,6 +5504,8 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_UPDATE_SIZE:
 	case UBLK_CMD_QUIESCE_DEV:
 	case UBLK_CMD_TRY_STOP_DEV:
+	case UBLK_CMD_REG_BUF:
+	case UBLK_CMD_UNREG_BUF:
 		mask = MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -5350,6 +5631,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_TRY_STOP_DEV:
 		ret = ublk_ctrl_try_stop_dev(ub);
 		break;
+	case UBLK_CMD_REG_BUF:
+		ret = ublk_ctrl_reg_buf(ub, &header);
+		break;
+	case UBLK_CMD_UNREG_BUF:
+		ret = ublk_ctrl_unreg_buf(ub, &header);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a88876756805..7d790c38456e 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -57,6 +57,40 @@
 	_IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
 #define UBLK_U_CMD_TRY_STOP_DEV		\
 	_IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
+/*
+ * Register a shared memory buffer for zero-copy I/O.
+ * Input:  ctrl_cmd.addr points to struct ublk_buf_reg (buffer VA + size)
+ *         ctrl_cmd.len  = sizeof(struct ublk_buf_reg)
+ * Result: >= 0 is the assigned buffer index, < 0 is error
+ *
+ * The kernel pins pages from the calling process's address space
+ * and inserts PFN ranges into a per-device maple tree. When a block
+ * request's pages match registered pages, the driver sets
+ * UBLK_IO_F_SHMEM_ZC and encodes the buffer index + offset in addr,
+ * allowing the server to access the data via its own mapping of the
+ * same shared memory — true zero copy.
+ *
+ * The memory can be backed by memfd, hugetlbfs, or any GUP-compatible
+ * shared mapping. Queue freeze is handled internally.
+ *
+ * The buffer VA and size are passed via a user buffer (not inline in
+ * ctrl_cmd) so that unprivileged devices can prepend the device path
+ * to ctrl_cmd.addr without corrupting the VA.
+ */
+#define UBLK_U_CMD_REG_BUF		\
+	_IOWR('u', 0x18, struct ublksrv_ctrl_cmd)
+/*
+ * Unregister a shared memory buffer.
+ * Input:  ctrl_cmd.data[0] = buffer index
+ */
+#define UBLK_U_CMD_UNREG_BUF		\
+	_IOWR('u', 0x19, struct ublksrv_ctrl_cmd)
+
+/* Parameter buffer for UBLK_U_CMD_REG_BUF, pointed to by ctrl_cmd.addr */
+struct ublk_buf_reg {
+	__u64	addr;	/* userspace virtual address of shared memory */
+	__u64	len;	/* buffer size in bytes (page-aligned) */
+};
 /*
  * 64bits are enough now, and it should be easy to extend in case of
  * running out of feature flags
@@ -370,6 +404,7 @@
 /* Disable automatic partition scanning when device is started */
 #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
 
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -469,6 +504,12 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
 /* Request has an integrity data buffer */
 #define		UBLK_IO_F_INTEGRITY		(1UL << 18)
+/*
+ * I/O buffer is in a registered shared memory buffer. When set, the addr
+ * field in ublksrv_io_desc encodes buffer index and byte offset instead
+ * of a userspace virtual address.
+ */
+#define		UBLK_IO_F_SHMEM_ZC		(1U << 19)
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
@@ -743,4 +784,31 @@ struct ublk_params {
 	struct ublk_param_integrity	integrity;
 };
 
+/*
+ * Shared memory zero-copy addr encoding for UBLK_IO_F_SHMEM_ZC.
+ *
+ * When UBLK_IO_F_SHMEM_ZC is set, ublksrv_io_desc.addr is encoded as:
+ *   bits [0:31]  = byte offset within the buffer (up to 4GB)
+ *   bits [32:47] = buffer index (up to 65536)
+ *   bits [48:63] = reserved (must be zero)
+ */
+#define UBLK_SHMEM_ZC_OFF_MASK		0xffffffffULL
+#define UBLK_SHMEM_ZC_IDX_OFF		32
+#define UBLK_SHMEM_ZC_IDX_MASK		0xffffULL
+
+static inline __u64 ublk_shmem_zc_addr(__u16 index, __u32 offset)
+{
+	return ((__u64)index << UBLK_SHMEM_ZC_IDX_OFF) | offset;
+}
+
+static inline __u16 ublk_shmem_zc_index(__u64 addr)
+{
+	return (addr >> UBLK_SHMEM_ZC_IDX_OFF) & UBLK_SHMEM_ZC_IDX_MASK;
+}
+
+static inline __u32 ublk_shmem_zc_offset(__u64 addr)
+{
+	return (__u32)(addr & UBLK_SHMEM_ZC_OFF_MASK);
+}
+
 #endif
-- 
2.53.0

