Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E9C4708E
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 12:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLGMeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLGMeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 07:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF9D45A14
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 04:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670416406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLgFpP3hfh28O9qR++OExKExno2Ywz45fDtlipPmWEA=;
        b=U2fIEkwNcu7EyW60kgI3GKM/xnlDbL3T2y1bPLwwMxzMKl7MhUqon/bZbeoggRUxttBlsD
        NgCOZFB1O9NF57DdvMh6vNDC8gGFrendA3elaIw7pETLFVH4N+RNziMBPV2Ge1RZWGbOCV
        O+N0SmkkMn2AGsvucPjSOw1AkttAUIM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-H7NUm1DeM0iKkAU0QuuEew-1; Wed, 07 Dec 2022 07:33:25 -0500
X-MC-Unique: H7NUm1DeM0iKkAU0QuuEew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56B401C08981;
        Wed,  7 Dec 2022 12:33:25 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79594C15BA4;
        Wed,  7 Dec 2022 12:33:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/6] ublk_drv: don't probe partitions if the ubq daemon isn't trusted
Date:   Wed,  7 Dec 2022 20:33:01 +0800
Message-Id: <20221207123305.937678-3-ming.lei@redhat.com>
In-Reply-To: <20221207123305.937678-1-ming.lei@redhat.com>
References: <20221207123305.937678-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If any ubq daemon is unprivileged, the ublk char device is allowed
for unprivileged user actually, and we can't trust the current user,
so not probe partitions.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 30db5e5edac4..a3d776a1c2f5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -159,6 +159,7 @@ struct ublk_device {
 
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
+	unsigned int		nr_privileged_daemon;
 
 	/*
 	 * Our ubq->daemon may be killed without any notification, so
@@ -1178,6 +1179,9 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 		ubq->ubq_daemon = current;
 		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
+
+		if (capable(CAP_SYS_ADMIN))
+			ub->nr_privileged_daemon++;
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
@@ -1534,6 +1538,10 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	if (ret)
 		goto out_put_disk;
 
+	/* don't probe partitions if any one ubq daemon is un-trusted */
+	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
+		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
@@ -1935,6 +1943,7 @@ static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
 	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
+	ub->nr_privileged_daemon = 0;
 	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
-- 
2.31.1

