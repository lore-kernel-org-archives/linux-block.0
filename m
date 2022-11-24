Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D68BC433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 03:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKXDGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiKXDGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 22:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21BEC5623
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669259115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1G7NamoQddPnuyXF2DsBdqfeJ4GuyoyTcP4JPgDPLQ=;
        b=eXhaJRE7M2xHdZW1agNCMKvO5E8wir2p2uR17uOCoqWmLUelKVDicV46T+7arSvvulZqEN
        MUD8nR4dxpfROtfXRAKwzAP3PAJmD/BTI4/y//RQ5A1BxbZIknb2wW3iMn/ebV75CVm1qv
        x5NEDn7DwtoaxcOUGitnq4jsLHoNaM8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-nBqCc8bDMMW4gti70qaCEA-1; Wed, 23 Nov 2022 22:05:12 -0500
X-MC-Unique: nBqCc8bDMMW4gti70qaCEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 564F8296A62B;
        Thu, 24 Nov 2022 03:05:12 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 032184EA4E;
        Thu, 24 Nov 2022 03:05:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Dan Carpenter <error27@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/6] ublk_drv: don't probe partitions if the ubq daemon isn't trusted
Date:   Thu, 24 Nov 2022 11:04:50 +0800
Message-Id: <20221124030454.476152-3-ming.lei@redhat.com>
In-Reply-To: <20221124030454.476152-1-ming.lei@redhat.com>
References: <20221124030454.476152-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If any ubq daemon is unprivileged, the ublk char device is allowed
for unprivileged user actually, and we can't trust the current user,
so not probe partitions.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
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

