Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE51C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 10:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiGVKim (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiGVKil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 06:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2E2ABA266
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658486318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DE3xGJSFSS6qbZ8sB3xcASvELVcO7nZp5IMJjBA2izI=;
        b=UC7xBTxqCuKykwIfWRZDlVNL9DGk6PK9BSNiXpG6TGlwScVle5MzFP5mtXUqAgIBPOouS1
        ygfeiaEeenrAUfJIAGIaz3S6/6QNd+a6wFbXoZg6GxmMBKa+54LdIgX3HJk4DdydcFxGvv
        lVOwRpyekJi0J9WJ0Hg5eP0LecsXRUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-EWMccJ_MP2mBSFKHOIJcGw-1; Fri, 22 Jul 2022 06:38:33 -0400
X-MC-Unique: EWMccJ_MP2mBSFKHOIJcGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCCB4802D2C;
        Fri, 22 Jul 2022 10:38:32 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A703A90A04;
        Fri, 22 Jul 2022 10:38:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 2/2] ublk_drv: make sure that correct flags(features) returned to userspace
Date:   Fri, 22 Jul 2022 18:38:17 +0800
Message-Id: <20220722103817.631258-3-ming.lei@redhat.com>
In-Reply-To: <20220722103817.631258-1-ming.lei@redhat.com>
References: <20220722103817.631258-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Userspace may support more features or new added flags, but the driver
side can be old, so make sure correct flags(features) returned to
userpsace, then userspace can work as expected.

Also mark the 2nd flags as reversed, just use the 1st one. When we run
out of flags, the reserved one can be handled at that time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 17 ++++++++++++++---
 include/uapi/linux/ublk_cmd.h |  7 ++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 67f91a80a7ab..255b2de46a24 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -46,6 +46,9 @@
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
+/* All UBLK_F_* have to be included into UBLK_F_ALL */
+#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_URING_CMD_COMP_IN_TASK)
+
 struct ublk_rq_data {
 	struct callback_head work;
 };
@@ -953,7 +956,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	void *ptr;
 	int size;
 
-	ubq->flags = ub->dev_info.flags[0];
+	ubq->flags = ub->dev_info.flags;
 	ubq->q_id = q_id;
 	ubq->q_depth = ub->dev_info.queue_depth;
 	size = ublk_queue_cmd_buf_size(ub, q_id);
@@ -1246,7 +1249,7 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 {
 	pr_devel("%s: dev id %d flags %llx\n", __func__,
-			info->dev_id, info->flags[0]);
+			info->dev_id, info->flags);
 	pr_devel("\t nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
 			info->nr_hw_queues, info->queue_depth,
 			info->block_size, info->dev_blocks);
@@ -1298,8 +1301,16 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	/* update device id */
 	ub->dev_info.dev_id = ub->ub_number;
 
+	/*
+	 * 64bit flags will be copied back to userspace as feature
+	 * negotiation result, so have to clear flags which driver
+	 * doesn't support yet, then userspace can get correct flags
+	 * (features) to handle.
+	 */
+	ub->dev_info.flags &= UBLK_F_ALL;
+
 	/* We are not ready to support zero copy */
-	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
+	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
 	ub->bs_shift = ilog2(ub->dev_info.block_size);
 	ub->dev_info.nr_hw_queues = min_t(unsigned int,
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 917580b34198..ca33092354ab 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -46,13 +46,13 @@
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
 
 /* device state */
 #define UBLK_S_DEV_DEAD	0
@@ -88,7 +88,8 @@ struct ublksrv_ctrl_dev_info {
 
 	__s32	ublksrv_pid;
 	__s32	reserved0;
-	__u64	flags[2];
+	__u64	flags;
+	__u64	flags_reserved;
 
 	/* For ublksrv internal use, invisible to ublk driver */
 	__u64	ublksrv_flags;
-- 
2.31.1

