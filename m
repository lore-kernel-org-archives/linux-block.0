Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E42CC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 14:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiG0ORI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiG0ORD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 10:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 780B4625E
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658931421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE9EKJEaJa9fa2F7yPX+KoSlCHtA56UHEGBJ90fSlEo=;
        b=V7WbQAc8vQIb2gtxW9r/V86kxtDBjxFV81MG4n92vHOPCnSt1/fRpJzjIAukwRAXhIZ3wB
        ETyP5OED7FDcG6mX4BwzZrYYICphgIVJuguGsUOKcbyeReedNE04Jtow3H/pCoJ26Pr1FN
        8nGB/gdiupP0ag5iNPWBQpxznkk1qJ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-inlvEIi7PNSP0budzIk4TA-1; Wed, 27 Jul 2022 10:16:56 -0400
X-MC-Unique: inlvEIi7PNSP0budzIk4TA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AD623815D2B;
        Wed, 27 Jul 2022 14:16:55 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9BF6492C3B;
        Wed, 27 Jul 2022 14:16:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/5] ublk_drv: cleanup ublksrv_ctrl_dev_info
Date:   Wed, 27 Jul 2022 22:16:28 +0800
Message-Id: <20220727141628.985429-6-ming.lei@redhat.com>
In-Reply-To: <20220727141628.985429-1-ming.lei@redhat.com>
References: <20220727141628.985429-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove all block device related info from ublksrv_ctrl_dev_info,
meantime reduce its size into 64 bytes because:

1) ublksrv_ctrl_dev_info becomes cleaner without including any
block related info

2) generic set/get parameter command can be used to set block
related setting easily and cleanly

3) generic set/get parameter command can be used for extending
ublk without needing more info in ublksrv_ctrl_dev_info

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 17 +++++++----------
 include/uapi/linux/ublk_cmd.h | 10 +++++-----
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8188079ea185..b3c981a3c248 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -119,7 +119,6 @@ struct ublk_device {
 	char	*__queues;
 
 	unsigned short  queue_size;
-	unsigned short  bs_shift;
 	struct ublksrv_ctrl_dev_info	dev_info;
 
 	struct blk_mq_tag_set	tag_set;
@@ -184,7 +183,7 @@ static int ublk_dev_param_basic_validate(const struct ublk_device *ub,
 	if (p->logical_bs_shift > p->physical_bs_shift)
 		return -EINVAL;
 
-	if (p->max_sectors > (ub->dev_info.rq_max_blocks << (ub->bs_shift - 9)))
+	if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
 		return -EINVAL;
 
 	return 0;
@@ -1270,13 +1269,13 @@ static void ublk_stop_work_fn(struct work_struct *work)
 	ublk_stop_dev(ub);
 }
 
-/* align maximum I/O size to PAGE_SIZE */
+/* align max io buffer size with PAGE_SIZE */
 static void ublk_align_max_io_size(struct ublk_device *ub)
 {
-	unsigned int max_rq_bytes = ub->dev_info.rq_max_blocks << ub->bs_shift;
+	unsigned int max_io_bytes = ub->dev_info.max_io_buf_bytes;
 
-	ub->dev_info.rq_max_blocks =
-		round_down(max_rq_bytes, PAGE_SIZE) >> ub->bs_shift;
+	ub->dev_info.max_io_buf_bytes =
+		round_down(max_io_bytes, PAGE_SIZE);
 }
 
 static int ublk_add_tag_set(struct ublk_device *ub)
@@ -1432,9 +1431,8 @@ static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 {
 	pr_devel("%s: dev id %d flags %llx\n", __func__,
 			info->dev_id, info->flags);
-	pr_devel("\t nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
-			info->nr_hw_queues, info->queue_depth,
-			info->block_size, info->dev_blocks);
+	pr_devel("\t nr_hw_queues %d queue_depth %d\n",
+			info->nr_hw_queues, info->queue_depth);
 }
 
 static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
@@ -1495,7 +1493,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
-	ub->bs_shift = ilog2(ub->dev_info.block_size);
 	ub->dev_info.nr_hw_queues = min_t(unsigned int,
 			ub->dev_info.nr_hw_queues, nr_cpu_ids);
 	ublk_align_max_io_size(ub);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 85b61c1f7e3d..c81607a4e987 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -80,22 +80,22 @@ struct ublksrv_ctrl_cmd {
 struct ublksrv_ctrl_dev_info {
 	__u16	nr_hw_queues;
 	__u16	queue_depth;
-	__u16	block_size;
+	__u16	reserved0;
 	__u16	state;
 
-	__u32	rq_max_blocks;
+	__u32	max_io_buf_bytes;
 	__u32	dev_id;
 
-	__u64   dev_blocks;
+	__u64   reserved1;
 
 	__s32	ublksrv_pid;
-	__s32	reserved0;
+	__s32	reserved2;
 	__u64	flags;
 	__u64	flags_reserved;
 
 	/* For ublksrv internal use, invisible to ublk driver */
 	__u64	ublksrv_flags;
-	__u64	reserved1[9];
+	__u64	reserved3;
 };
 
 #define		UBLK_IO_OP_READ		0
-- 
2.31.1

