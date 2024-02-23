Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7F156DD
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674998; cv=none; b=abm39ACoPSvw8jn9tugWRdVykBbzoBI+rOoyE5EovjOqTdByFc1UmTUs91doyVxztUwuok4HG5HKWvy54JyCIb4qaDeOhIcGkCyZNobWtLqarS7rK1Q4ucWX4WxHA8KkgLrbKwnhAvyOE2uQTxy/fJduF4Yr6dySkdZogWEm2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674998; c=relaxed/simple;
	bh=DDHYQdz8iakjLZShubyNdtgBYiBE8xzNcHGrbSFarbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3vi6EfxFLExhnUchtuWqi53ldEmdbtEC0sj4klnZ8bpBNX3ITbh7CbpWRWr9QgYaPF+xGQUuPMncfoAwcH3MXI/9HObi5r0H9l3NnWBdOIjJ21aQCDZ1GVH3y6E9UndLsC1LNRAQ4DQJ3l9gRR5nvJDVZ1JeO+psij/fHNGVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJqfPk6w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJqfPk6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708674995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbeGcKVi7bb+SKZKL11lpTztCVimsoVmN2lzTs6j6uI=;
	b=WJqfPk6wg2hk4YQSfUDLEjzJIhXVz5rFWDW2/fwfCZ9zySm42dL3dho69k6ZGKrpj9IK83
	Croc0vnlYIdJks5YGwzEFbiziSIBe9ux2dENSlZ3R2/p6xfkZYkw8ZzQEb2eH1WoB5eng7
	yF3Fj82RW0yji2v0mR2EO/8WB+7PSI4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-w-B4_7dyN_mzWgPbhkkjtg-1; Fri,
 23 Feb 2024 02:56:34 -0500
X-MC-Unique: w-B4_7dyN_mzWgPbhkkjtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E94F93C0C4B1;
	Fri, 23 Feb 2024 07:56:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.79])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 038748CED;
	Fri, 23 Feb 2024 07:56:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] ublk: add UBLK_CMD_DEL_DEV_ASYNC
Date: Fri, 23 Feb 2024 15:55:39 +0800
Message-ID: <20240223075539.89945-3-ming.lei@redhat.com>
In-Reply-To: <20240223075539.89945-1-ming.lei@redhat.com>
References: <20240223075539.89945-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The current command UBLK_CMD_DEL_DEV won't return until the device is
released, this way looks more reliable, but makes userspace more
difficult to implement, especially about orders: unmap command
buffer(which holds one ublkc reference), ublkc close,
io_uring_file_unregister, ublkb close.

Add UBLK_CMD_DEL_DEV_ASYNC so that device deletion won't wait release,
then userspace needn't worry about the above order. Actually both loop
and nbd is deleted in this async way.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 9 ++++++---
 include/uapi/linux/ublk_cmd.h | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 06d88d2008ba..bea3d5cf8a83 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2468,7 +2468,7 @@ static inline bool ublk_idr_freed(int id)
 	return ptr == NULL;
 }
 
-static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
+static int ublk_ctrl_del_dev(struct ublk_device **p_ub, bool wait)
 {
 	struct ublk_device *ub = *p_ub;
 	int idx = ub->ub_number;
@@ -2502,7 +2502,7 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
 	 * - the device number is freed already, we will not find this
 	 *   device via ublk_get_device_from_id()
 	 */
-	if (wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx)))
+	if (wait && wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx)))
 		return -EINTR;
 	return 0;
 }
@@ -2901,7 +2901,10 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_add_dev(cmd);
 		break;
 	case UBLK_CMD_DEL_DEV:
-		ret = ublk_ctrl_del_dev(&ub);
+		ret = ublk_ctrl_del_dev(&ub, true);
+		break;
+	case UBLK_U_CMD_DEL_DEV_ASYNC:
+		ret = ublk_ctrl_del_dev(&ub, false);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 		ret = ublk_ctrl_get_queue_affinity(ub, cmd);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index b9cfc5c96268..c8dc5f8ea699 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -49,6 +49,8 @@
 	_IOR('u', UBLK_CMD_GET_DEV_INFO2, struct ublksrv_ctrl_cmd)
 #define UBLK_U_CMD_GET_FEATURES	\
 	_IOR('u', 0x13, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_DEL_DEV_ASYNC	\
+	_IOR('u', 0x14, struct ublksrv_ctrl_cmd)
 
 /*
  * 64bits are enough now, and it should be easy to extend in case of
-- 
2.41.0

