Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D76CC04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 09:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiG3J26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 05:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiG3J25 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 05:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F244D41D1E
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659173336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zAY7rf3e+TIKgHeyfrUHfnS97dxLhcLqPgvcWfz0rc=;
        b=MThwAQ3Vn5Vw4VL9MIsSYguANJaf5E8TCa/RIRrOLl0WYJsS4ksA0T4uN4CeLqXfnT847I
        tyuqdHZkoZsC9KOuRQ189FrTSu0gWSkEezRdoAVeFdEYCI9JbvAh2ndM47jw6BEzvLrmSf
        KyuoFYs7m85fVz5b2TilUSm+haVa+xo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-HOgbO-rsPXuiTSwfxOFiWw-1; Sat, 30 Jul 2022 05:28:52 -0400
X-MC-Unique: HOgbO-rsPXuiTSwfxOFiWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11C853C025AD;
        Sat, 30 Jul 2022 09:28:52 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2757B2026D64;
        Sat, 30 Jul 2022 09:28:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 4/4] ublk_drv: cleanup ublksrv_ctrl_dev_info
Date:   Sat, 30 Jul 2022 17:27:50 +0800
Message-Id: <20220730092750.1118167-5-ming.lei@redhat.com>
In-Reply-To: <20220730092750.1118167-1-ming.lei@redhat.com>
References: <20220730092750.1118167-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
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
 drivers/block/ublk_drv.c      | 18 +++++++-----------
 include/uapi/linux/ublk_cmd.h | 15 ++++++++-------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 20ad83b25318..2b3cd671a653 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -122,7 +122,6 @@ struct ublk_device {
 	char	*__queues;
 
 	unsigned short  queue_size;
-	unsigned short  bs_shift;
 	struct ublksrv_ctrl_dev_info	dev_info;
 
 	struct blk_mq_tag_set	tag_set;
@@ -223,8 +222,7 @@ static int ublk_validate_params(const struct ublk_device *ub)
 		if (p->logical_bs_shift > p->physical_bs_shift)
 			return -EINVAL;
 
-		if (p->max_sectors > (ub->dev_info.rq_max_blocks <<
-					(ub->bs_shift - 9)))
+		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
 			return -EINVAL;
 	} else
 		return -EINVAL;
@@ -1185,13 +1183,13 @@ static void ublk_stop_work_fn(struct work_struct *work)
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
@@ -1348,9 +1346,8 @@ static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
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
@@ -1410,7 +1407,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
-	ub->bs_shift = ilog2(ub->dev_info.block_size);
 	ub->dev_info.nr_hw_queues = min_t(unsigned int,
 			ub->dev_info.nr_hw_queues, nr_cpu_ids);
 	ublk_align_max_io_size(ub);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 54d065426f06..57d86d0e8c5b 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -80,22 +80,23 @@ struct ublksrv_ctrl_cmd {
 struct ublksrv_ctrl_dev_info {
 	__u16	nr_hw_queues;
 	__u16	queue_depth;
-	__u16	block_size;
 	__u16	state;
+	__u16	pad0;
 
-	__u32	rq_max_blocks;
+	__u32	max_io_buf_bytes;
 	__u32	dev_id;
 
-	__u64   dev_blocks;
-
 	__s32	ublksrv_pid;
-	__s32	reserved0;
+	__u32	pad1;
+
 	__u64	flags;
-	__u64	flags_reserved;
 
 	/* For ublksrv internal use, invisible to ublk driver */
 	__u64	ublksrv_flags;
-	__u64	reserved1[9];
+
+	__u64	reserved0;
+	__u64	reserved1;
+	__u64   reserved2;
 };
 
 #define		UBLK_IO_OP_READ		0
-- 
2.31.1

