Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDF8C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 08:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGVIqu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiGVIq2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 04:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 796145F7D
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658479575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PV77zNIZ4IWn4AkzreWyXPlBQefYqc+FX1UyfyLDqw=;
        b=grKbOVI5fl4nta2EG3EQiad7/PDpKv+pM24EGC4S+6ibntTdA8lgGwivdIfCsZ9I2mZpxu
        xwFTHZzXXTEJEYJm2vJCJcvF67iLUXk8YjB4bzYnmrg1Ksy3VIRQeIa/Pn2ajA58o2smpy
        LPEht9b7wE0kWNcYxFGTDQjHJXrfSwQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-gGd635EOPs-FdzNvpmbztw-1; Fri, 22 Jul 2022 04:46:11 -0400
X-MC-Unique: gGd635EOPs-FdzNvpmbztw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10CFD1857F0E;
        Fri, 22 Jul 2022 08:46:11 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20F8AC28100;
        Fri, 22 Jul 2022 08:46:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/2] ublk_drv: make sure that correct flags(features) returned to userspace
Date:   Fri, 22 Jul 2022 16:45:16 +0800
Message-Id: <20220722084516.624457-3-ming.lei@redhat.com>
In-Reply-To: <20220722084516.624457-1-ming.lei@redhat.com>
References: <20220722084516.624457-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Userspace may support more features or new added flags, but the driver
side can be old, so make sure correct flags(features) returned to
userpsace, then userspace can work as expected.

Also mark the 2nd flags as reversed, just use the 1st one. When we run
out of flags, the reserved one can be handled at that time.

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 14 +++++++++++---
 include/uapi/linux/ublk_cmd.h | 11 ++++++++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 67f91a80a7ab..670790c0abf7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -953,7 +953,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	void *ptr;
 	int size;
 
-	ubq->flags = ub->dev_info.flags[0];
+	ubq->flags = ub->dev_info.flags;
 	ubq->q_id = q_id;
 	ubq->q_depth = ub->dev_info.queue_depth;
 	size = ublk_queue_cmd_buf_size(ub, q_id);
@@ -1246,7 +1246,7 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 {
 	pr_devel("%s: dev id %d flags %llx\n", __func__,
-			info->dev_id, info->flags[0]);
+			info->dev_id, info->flags);
 	pr_devel("\t nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
 			info->nr_hw_queues, info->queue_depth,
 			info->block_size, info->dev_blocks);
@@ -1299,7 +1299,15 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	ub->dev_info.dev_id = ub->ub_number;
 
 	/* We are not ready to support zero copy */
-	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
+	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
+
+	/*
+	 * 64bit flags will be copied back to userspace as feature
+	 * negotiation result, so have to clear flags which driver
+	 * doesn't support yet, then userspace can get correct flags
+	 * (features) to handle.
+	 */
+	ub->dev_info.flags &= UBLK_F_ALL;
 
 	ub->bs_shift = ilog2(ub->dev_info.block_size);
 	ub->dev_info.nr_hw_queues = min_t(unsigned int,
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 917580b34198..8b749271bba7 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -42,17 +42,21 @@
 /* tag bit is 12bit, so at most 4096 IOs for each queue */
 #define UBLK_MAX_QUEUE_DEPTH	4096
 
+
 /*
  * zero copy requires 4k block size, and can remap ublk driver's io
  * request into ublksrv's vm space
  */
-#define UBLK_F_SUPPORT_ZERO_COPY	(1UL << 0)
+#define UBLK_F_SUPPORT_ZERO_COPY	(1ULL << 0)
 
 /*
  * Force to complete io cmd via io_uring_cmd_complete_in_task so that
  * performance comparison is done easily with using task_work_add
  */
-#define UBLK_F_URING_CMD_COMP_IN_TASK	(1UL << 1)
+#define UBLK_F_URING_CMD_COMP_IN_TASK	(1ULL << 1)
+
+/* All UBLK_F_* have to be included into UBLK_F_ALL */
+#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_URING_CMD_COMP_IN_TASK)
 
 /* device state */
 #define UBLK_S_DEV_DEAD	0
@@ -88,7 +92,8 @@ struct ublksrv_ctrl_dev_info {
 
 	__s32	ublksrv_pid;
 	__s32	reserved0;
-	__u64	flags[2];
+	__u64	flags;
+	__u64	flags_reserved;
 
 	/* For ublksrv internal use, invisible to ublk driver */
 	__u64	ublksrv_flags;
-- 
2.31.1

