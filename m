Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFE33F385
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174980; cv=none; b=B23ih4vJb3wvEFDPNyqqadcKooHxdwcuqBPpOt9AzZBSY9OqxW5W0AlCiReAquI6KEc9gKcziAHvgnpgF67y7Mc/wHxi4DT/a60Or3zM/1NUfkrMTM577Kd2rRi2cbYZD246FwiCZvPveTpYSva3X65ZFYOIYt8CbdEq+QQMgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174980; c=relaxed/simple;
	bh=hJ6Wd5UdHxQ7JlXBVBf96oHo4OCVe4ElVnMwlaHDaEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qceXl69AHAnRQ7itqf+cs17E8R/MqkaqTet4aBM7i2bSX1FrrT8a7gXVqkajMfBIGCEiuGonYn+/tCxHM9MQAB/1ptcsSK3ZmUUf8ApLciJSgEVRk+j//BCrz1YJqtRmuhAtvtckG51JVRAwZi9tpxT3PnPlyGRZRZVXseCRa8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuJxgBbs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuJxgBbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764174977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7acRfl4IkuQFx8mKPn8HoH4mgf78BRMNYKMfEK8ccQ=;
	b=LuJxgBbsWWxFRoyGD1XukaknBRXcE83nptNenvj0vJ7HXA/O0OJM33fenoF79INYWKg9/c
	T/2hVGIcWYnCEyVU1gGCmPxqSk6wPn4hm7IiXm58cDrBx6cIrvtITEl4tpfh61vmTGuX1G
	d32nIjsh4xrAyr7Twvl3RyMCFKU16o0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-wVtkfr5wO-2CEH1AYylILQ-1; Wed,
 26 Nov 2025 11:36:14 -0500
X-MC-Unique: wVtkfr5wO-2CEH1AYylILQ-1
X-Mimecast-MFC-AGG-ID: wVtkfr5wO-2CEH1AYylILQ_1764174972
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37F20195606B;
	Wed, 26 Nov 2025 16:36:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB99118004A3;
	Wed, 26 Nov 2025 16:36:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/4] block: add IOC_PR_READ_KEYS ioctl
Date: Wed, 26 Nov 2025 11:35:59 -0500
Message-ID: <20251126163600.583036-4-stefanha@redhat.com>
In-Reply-To: <20251126163600.583036-1-stefanha@redhat.com>
References: <20251126163600.583036-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a Persistent Reservations ioctl to read the list of currently
registered reservation keys. This calls the pr_ops->read_keys() function
that was previously added in commit c787f1baa503 ("block: Add PR
callouts for read keys and reservation") but was only used by the
in-kernel SCSI target so far.

The IOC_PR_READ_KEYS ioctl is necessary so that userspace applications
that rely on Persistent Reservations ioctls have a way of inspecting the
current state. Cluster managers and validation tests need this
functionality.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/uapi/linux/pr.h |  7 ++++++
 block/ioctl.c           | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/pr.h b/include/uapi/linux/pr.h
index d8126415966f3..fcb74eab92c80 100644
--- a/include/uapi/linux/pr.h
+++ b/include/uapi/linux/pr.h
@@ -56,6 +56,12 @@ struct pr_clear {
 	__u32	__pad;
 };
 
+struct pr_read_keys {
+	__u32	generation;
+	__u32	num_keys;
+	__u64	keys_ptr;
+};
+
 #define PR_FL_IGNORE_KEY	(1 << 0)	/* ignore existing key */
 
 #define IOC_PR_REGISTER		_IOW('p', 200, struct pr_registration)
@@ -64,5 +70,6 @@ struct pr_clear {
 #define IOC_PR_PREEMPT		_IOW('p', 203, struct pr_preempt)
 #define IOC_PR_PREEMPT_ABORT	_IOW('p', 204, struct pr_preempt)
 #define IOC_PR_CLEAR		_IOW('p', 205, struct pr_clear)
+#define IOC_PR_READ_KEYS	_IOWR('p', 206, struct pr_read_keys)
 
 #endif /* _UAPI_PR_H */
diff --git a/block/ioctl.c b/block/ioctl.c
index d7489a56b33c3..e87c424c15ae9 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/capability.h>
+#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
@@ -423,6 +424,54 @@ static int blkdev_pr_clear(struct block_device *bdev, blk_mode_t mode,
 	return ops->pr_clear(bdev, c.key);
 }
 
+static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
+		struct pr_read_keys __user *arg)
+{
+	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	struct pr_keys *keys_info __free(kfree) = NULL;
+	struct pr_read_keys inout;
+	int ret;
+
+	if (!blkdev_pr_allowed(bdev, mode))
+		return -EPERM;
+	if (!ops || !ops->pr_read_keys)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&inout, arg, sizeof(inout)))
+		return -EFAULT;
+
+	if (inout.num_keys > -sizeof(*keys_info) / sizeof(keys_info->keys[0]))
+		return -EINVAL;
+
+	size_t keys_info_len = struct_size(keys_info, keys, inout.num_keys);
+
+	keys_info = kzalloc(keys_info_len, GFP_KERNEL);
+	if (!keys_info)
+		return -ENOMEM;
+
+	keys_info->num_keys = inout.num_keys;
+
+	ret = ops->pr_read_keys(bdev, keys_info);
+	if (ret)
+		return ret;
+
+	/* Copy out individual keys */
+	u64 __user *keys_ptr = u64_to_user_ptr(inout.keys_ptr);
+	u32 num_copy_keys = min(inout.num_keys, keys_info->num_keys);
+	size_t keys_copy_len = num_copy_keys * sizeof(keys_info->keys[0]);
+
+	if (copy_to_user(keys_ptr, keys_info->keys, keys_copy_len))
+		return -EFAULT;
+
+	/* Copy out the arg struct */
+	inout.generation = keys_info->generation;
+	inout.num_keys = keys_info->num_keys;
+
+	if (copy_to_user(arg, &inout, sizeof(inout)))
+		return -EFAULT;
+	return ret;
+}
+
 static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 		unsigned long arg)
 {
@@ -644,6 +693,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_preempt(bdev, mode, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, mode, argp);
+	case IOC_PR_READ_KEYS:
+		return blkdev_pr_read_keys(bdev, mode, argp);
 	default:
 		return blk_get_meta_cap(bdev, cmd, argp);
 	}
-- 
2.52.0

