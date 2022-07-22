Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C79C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 05:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiGVFJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGVFJv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 01:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB48E51409
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658466590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9n4lNAV9865k/C4GeYUwivFvAlN7nSfdL6tdKnwr58=;
        b=A5zz0/eSpVrVHBhZzKTLRgCo/VDWBTGgUtRYJNwVO8ZT8WlGA4MiYcm48kxX26EUXa5MlV
        4niEpeYEzyeHQFj7BhWlItXrhE3v4z5a1aKxADTh+oHUiOBKnkky/z9KGEmv+yz1G3d22M
        B+MqgPHi7mof96jimYmXQ7/u/ImDQ6w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-K2cemKvxPC2zHWgYQ3uFtw-1; Fri, 22 Jul 2022 01:09:45 -0400
X-MC-Unique: K2cemKvxPC2zHWgYQ3uFtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F6B92932492;
        Fri, 22 Jul 2022 05:09:45 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C93902166B26;
        Fri, 22 Jul 2022 05:09:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/2] ublk_drv: make sure that correct flags(features) returned to userspace
Date:   Fri, 22 Jul 2022 13:09:30 +0800
Message-Id: <20220722050930.611232-3-ming.lei@redhat.com>
In-Reply-To: <20220722050930.611232-1-ming.lei@redhat.com>
References: <20220722050930.611232-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Userspace may support more features or new added flags, but the driver
side can be old, so make sure correct flags(features) returned to
userpsace, then userspace can work as expected.

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 21 +++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h | 11 +++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a427f020527d..a3ba642a5e43 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1092,13 +1092,28 @@ static void ublk_align_max_io_size(struct ublk_device *ub)
 		round_down(max_rq_bytes, PAGE_SIZE) >> ub->bs_shift;
 }
 
+static void ublk_negotiate_features(struct ublk_device *ub)
+{
+	unsigned long *map = (unsigned long *)&ub->dev_info.flags[0];
+
+	/* We are not ready to support zero copy */
+	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
+
+	/*
+	 * 128bit flags will be copied back to userspace as feature
+	 * negotiation result, so have to clear flags which driver
+	 * doesn't support yet, then userspace can get correct flags
+	 * (features) to handle.
+	 */
+	bitmap_clear(map, __UBLK_F_NR_BITS, 128 - __UBLK_F_NR_BITS);
+}
+
 /* add tag_set & cdev, cleanup everything in case of failure */
 static int ublk_add_tagset(struct ublk_device *ub)
 {
 	int err = -ENOMEM;
 
-	/* We are not ready to support zero copy */
-	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
+	ublk_negotiate_features(ub);
 
 	ub->bs_shift = ilog2(ub->dev_info.block_size);
 	ub->dev_info.nr_hw_queues = min_t(unsigned int,
@@ -1499,6 +1514,8 @@ static int __init ublk_init(void)
 {
 	int ret;
 
+	BUILD_BUG_ON(__UBLK_F_NR_BITS > 128);
+
 	init_waitqueue_head(&ublk_idr_wq);
 
 	ret = misc_register(&ublk_misc);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 917580b34198..49e4950a9181 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -42,17 +42,24 @@
 /* tag bit is 12bit, so at most 4096 IOs for each queue */
 #define UBLK_MAX_QUEUE_DEPTH	4096
 
+
+enum ublk_flag_bits {
+	__UBLK_F_SUPPORT_ZERO_COPY,
+	__UBLK_F_URING_CMD_COMP_IN_TASK,
+	__UBLK_F_NR_BITS,
+};
+
 /*
  * zero copy requires 4k block size, and can remap ublk driver's io
  * request into ublksrv's vm space
  */
-#define UBLK_F_SUPPORT_ZERO_COPY	(1UL << 0)
+#define UBLK_F_SUPPORT_ZERO_COPY	(1ULL << __UBLK_F_SUPPORT_ZERO_COPY)
 
 /*
  * Force to complete io cmd via io_uring_cmd_complete_in_task so that
  * performance comparison is done easily with using task_work_add
  */
-#define UBLK_F_URING_CMD_COMP_IN_TASK	(1UL << 1)
+#define UBLK_F_URING_CMD_COMP_IN_TASK	(1ULL << __UBLK_F_URING_CMD_COMP_IN_TASK)
 
 /* device state */
 #define UBLK_S_DEV_DEAD	0
-- 
2.31.1

