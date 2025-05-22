Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC52512D8
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931749; cv=none; b=LyhgkbA32oxjxs0ZQ91GfCamBgtl4Fnq3JObeZ0sz2DoXe4N+U5msTkdS58Q/KPE+25Ymnj8xeApZobZlgIDR3jKvOSnWkcPkREn+AYA6XGdquy+bZNK5nC1cbrDGDWxzGUBXdpoJ31cML3x/0vw6t3LjPbXSOWag8qtqNct3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931749; c=relaxed/simple;
	bh=Ax87NrsVXsgG4cUlFDtXvIux19cfFN6NwXnsjEAWyz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL6hVtMvThLcrHZi24ILM6MVTQ0D0ZWxhQmGZuLJ3Sipkawz+/t+kfJ0mXoMit6hHIYaqwmEyt2pNdFscEqcQLC0A2VBhEgvFoRH5jtknK3NjExYuppX8uLSWJpIvykLwfv6wVp7SoY3TDChYqmy6aPMYPAoCwAFAs+Ry/Ej2yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhHvlxqV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhHvlxqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747931746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4N1AqCsjR3HBa2i4NId9LcQJewLiyNvGgmMCtgad5hg=;
	b=YhHvlxqVQSXk2pvBw+XeOZeq+W42mGbqALDLzLXnt5gUtVDydMkWTX22dW7eQO417iCBLl
	ZNxKf2tKsuSMHz2Lc1AaBKiXqYnTlvbryPqZ8XyMc+T0pkT9iD8xGfnsTyUE+CXTZoOSpe
	UUQeO8gx3U/x3a+IvrFmOMBrXjCEbKg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-Y6yl3hxuPSWgHqb4voMdQA-1; Thu,
 22 May 2025 12:35:41 -0400
X-MC-Unique: Y6yl3hxuPSWgHqb4voMdQA-1
X-Mimecast-MFC-AGG-ID: Y6yl3hxuPSWgHqb4voMdQA_1747931740
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F40711800876;
	Thu, 22 May 2025 16:35:39 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E63161800DB9;
	Thu, 22 May 2025 16:35:38 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Date: Fri, 23 May 2025 00:35:20 +0800
Message-ID: <20250522163523.406289-3-ming.lei@redhat.com>
In-Reply-To: <20250522163523.406289-1-ming.lei@redhat.com>
References: <20250522163523.406289-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add feature UBLK_F_QUIESCE, which adds control command `UBLK_U_CMD_QUIESCE_DEV`
for quiescing device, then device state can become `UBLK_S_DEV_QUIESCED`
or `UBLK_S_DEV_FAIL_IO` finally from ublk_ch_release() with ublk server
cooperation.

This feature can help to support to upgrade ublk server application by
shutting down ublk server gracefully, meantime keep ublk block device
persistent during the upgrading period.

The feature is only available for UBLK_F_USER_RECOVERY.

Suggested-by: Yoav Cohen <yoav@nvidia.com>
Link: https://lore.kernel.org/linux-block/DM4PR12MB632807AB7CDCE77D1E5AB7D0A9B92@DM4PR12MB6328.namprd12.prod.outlook.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 124 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  19 ++++++
 2 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fbd075807525..6f51072776f1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -51,6 +51,7 @@
 /* private ioctl command mirror */
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
 #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
+#define UBLK_CMD_QUIESCE_DEV	_IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
 
 #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
 #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
@@ -67,7 +68,8 @@
 		| UBLK_F_ZONED \
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
 		| UBLK_F_UPDATE_SIZE \
-		| UBLK_F_AUTO_BUF_REG)
+		| UBLK_F_AUTO_BUF_REG \
+		| UBLK_F_QUIESCE)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -2841,6 +2843,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		return -EINVAL;
 	}
 
+	if ((info.flags & UBLK_F_QUIESCE) && !(info.flags & UBLK_F_USER_RECOVERY)) {
+		pr_warn("UBLK_F_QUIESCE requires UBLK_F_USER_RECOVERY\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * unprivileged device can't be trusted, but RECOVERY and
 	 * RECOVERY_REISSUE still may hang error handling, so can't
@@ -3233,6 +3240,117 @@ static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl
 	set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
 	mutex_unlock(&ub->mutex);
 }
+
+struct count_busy {
+	const struct ublk_queue *ubq;
+	unsigned int nr_busy;
+};
+
+static bool ublk_count_busy_req(struct request *rq, void *data)
+{
+	struct count_busy *idle = data;
+
+	if (!blk_mq_request_started(rq) && rq->mq_hctx->driver_data == idle->ubq)
+		idle->nr_busy += 1;
+	return true;
+}
+
+/* uring_cmd is guaranteed to be active if the associated request is idle */
+static bool ubq_has_idle_io(const struct ublk_queue *ubq)
+{
+	struct count_busy data = {
+		.ubq = ubq,
+	};
+
+	blk_mq_tagset_busy_iter(&ubq->dev->tag_set, ublk_count_busy_req, &data);
+	return data.nr_busy < ubq->q_depth;
+}
+
+/* Wait until each hw queue has at least one idle IO */
+static int ublk_wait_for_idle_io(struct ublk_device *ub,
+				 unsigned int timeout_ms)
+{
+	unsigned int elapsed = 0;
+	int ret;
+
+	while (elapsed < timeout_ms && !signal_pending(current)) {
+		unsigned int queues_cancelable = 0;
+		int i;
+
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+			struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+			queues_cancelable += !!ubq_has_idle_io(ubq);
+		}
+
+		/*
+		 * Each queue needs at least one active command for
+		 * notifying ublk server
+		 */
+		if (queues_cancelable == ub->dev_info.nr_hw_queues)
+			break;
+
+		msleep(UBLK_REQUEUE_DELAY_MS);
+		elapsed += UBLK_REQUEUE_DELAY_MS;
+	}
+
+	if (signal_pending(current))
+		ret = -EINTR;
+	else if (elapsed >= timeout_ms)
+		ret = -EBUSY;
+	else
+		ret = 0;
+
+	return ret;
+}
+
+static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
+				 const struct ublksrv_ctrl_cmd *header)
+{
+	/* zero means wait forever */
+	u64 timeout_ms = header->data[0];
+	struct gendisk *disk;
+	int i, ret = -ENODEV;
+
+	if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&ub->mutex);
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		goto unlock;
+	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
+		goto put_disk;
+
+	ret = 0;
+	/* already in expected state */
+	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+		goto put_disk;
+
+	/* Mark all queues as canceling */
+	blk_mq_quiesce_queue(disk->queue);
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->canceling = true;
+	}
+	blk_mq_unquiesce_queue(disk->queue);
+
+	if (!timeout_ms)
+		timeout_ms = UINT_MAX;
+	ret = ublk_wait_for_idle_io(ub, timeout_ms);
+
+put_disk:
+	ublk_put_disk(disk);
+unlock:
+	mutex_unlock(&ub->mutex);
+
+	/* Cancel pending uring_cmd */
+	if (!ret)
+		ublk_cancel_dev(ub);
+	return ret;
+}
+
 /*
  * All control commands are sent via /dev/ublk-control, so we have to check
  * the destination device's permission
@@ -3319,6 +3437,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_START_USER_RECOVERY:
 	case UBLK_CMD_END_USER_RECOVERY:
 	case UBLK_CMD_UPDATE_SIZE:
+	case UBLK_CMD_QUIESCE_DEV:
 		mask = MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -3414,6 +3533,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ublk_ctrl_set_size(ub, header);
 		ret = 0;
 		break;
+	case UBLK_CMD_QUIESCE_DEV:
+		ret = ublk_ctrl_quiesce_dev(ub, header);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 1c40632cb164..56c7e3fc666f 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -53,6 +53,8 @@
 	_IOR('u', 0x14, struct ublksrv_ctrl_cmd)
 #define UBLK_U_CMD_UPDATE_SIZE		\
 	_IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_QUIESCE_DEV		\
+	_IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
 
 /*
  * 64bits are enough now, and it should be easy to extend in case of
@@ -253,6 +255,23 @@
  */
 #define UBLK_F_AUTO_BUF_REG 	(1ULL << 11)
 
+/*
+ * Control command `UBLK_U_CMD_QUIESCE_DEV` is added for quiescing device,
+ * which state can be transitioned to `UBLK_S_DEV_QUIESCED` or
+ * `UBLK_S_DEV_FAIL_IO` finally, and it needs ublk server cooperation for
+ * handling `UBLK_IO_RES_ABORT` correctly.
+ *
+ * Typical use case is for supporting to upgrade ublk server application,
+ * meantime keep ublk block device persistent during the period.
+ *
+ * This feature is only available when UBLK_F_USER_RECOVERY is enabled.
+ *
+ * Note, this command returns -EBUSY in case that all IO commands are being
+ * handled by ublk server and not completed in specified time period which
+ * is passed from the control command parameter.
+ */
+#define UBLK_F_QUIESCE		(1ULL << 12)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.47.0

